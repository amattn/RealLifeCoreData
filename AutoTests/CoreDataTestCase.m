/******************************************************************************
 * - Created 2012/04/19 by Matt Nunogawa
 * - Copyright __MyCompanyName__ 2012. All rights reserved.
 * - License: <#LICENSE#>
 *
 * <#SUMMARY INFORMATION#>
 *
 * Created from templates: https://github.com/amattn/RealLifeXcode4Templates
 */

#import <SenTestingKit/SenTestingKit.h>
#import "RLCoreDataEnvironment.h"
#import "CDAddressManager.h"
#import "CDAuthorManager.h"
#import "CDBookManager.h"
#import "CDPublisherManager.h"

// @interface <#MyClass#> (test_only)
//
// You can declare methods here that are normally internal only by you want to 
// expose for testing
// - (id)internalProcessorMethod:(id)object;
// @end



@interface CoreDataTestCase : SenTestCase
@property (nonatomic, strong) RLCoreDataEnvironment *environment;
@end

@implementation CoreDataTestCase

@synthesize environment = _environment;

- (void)setUp;
{
    [super setUp];
    self.environment = [RLCoreDataEnvironment singleton];
    self.environment.isTestEnvironment = YES;
}

- (void)tearDown;
{
    [self.environment resetCoreData];    
    [super tearDown];
}

- (void)testEnvironment;
{
    STAssertNotNil(self.environment, @"Core Data Environment cannot be nil.");
}

- (void)testUserDefinedContexts;
{
    STAssertNotNil(self.environment.mainThreadManagedObjectContext, @"");
    STAssertNotNil([self.environment managedObjectContextForContextKey:RLCORE_DATA_BACKGROUND_CONTEXT_KEY], @"");
    STAssertEquals([[self.environment allContextKeys] count], 2u, @"");
    STAssertNotNil([self.environment managedObjectContextForContextKey:@"new user defined context"], @"");
    STAssertEquals([[self.environment allContextKeys] count], 3u, @"");
    [self.environment removeManagedObjectContextForKey:@"new user defined context"];
    STAssertEquals([[self.environment allContextKeys] count], 2u, @"");
}

- (void)stressObjectCreation:(id (^)(void))lazyLoadBlock;
{
    // In my testing, in some cases, the totalCount had to be as high as 1500 or so to reliably crash the test rig.
    // I've pushed it back down to 200 for the AutoTests.  If you are manually invoking tests, this can be much higher.
    NSUInteger totalCount = 200;
    for (int j = 0; j < totalCount; j++) {
        __block BOOL shouldCancel = NO;
        NSMutableSet *thereCanBeOnlyOneMutableSet = [NSMutableSet set];
        dispatch_semaphore_t mutableSetMutateSemaphore = dispatch_semaphore_create(1);

        dispatch_apply(16, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0),  ^(size_t i){
            if (shouldCancel == NO) {
                id someObject = lazyLoadBlock();
                STAssertNotNil(someObject, @"j:%d, i:%d", j, i);
                
                dispatch_semaphore_wait(mutableSetMutateSemaphore, DISPATCH_TIME_FOREVER);
                [thereCanBeOnlyOneMutableSet addObject:someObject];
                dispatch_semaphore_signal(mutableSetMutateSemaphore);
                
                if ([thereCanBeOnlyOneMutableSet count] != 1) {
                    STFail(@"We have erroneously created more than one object:%@, count:%d, i:%d j:%d", someObject, [thereCanBeOnlyOneMutableSet count], i, j);
                    LOG_OBJECT(thereCanBeOnlyOneMutableSet);
                    shouldCancel = YES;
                }
            }
        });
        thereCanBeOnlyOneMutableSet = nil; // destory all references, before we reset;
        
        [self.environment resetCoreData];
        self.environment.isTestEnvironment = YES;
    }
//    LOG_KIND_OF_CLASS(lazyLoadBlock());
}

- (void)testPSCCreationConcurrency;
{
    [self stressObjectCreation:^id{
        return [self.environment persistentStoreCoordinator];
    }];
}

- (void)testModelCreationConcurrency;
{
    [self stressObjectCreation:^id{
        return [self.environment managedObjectModel];
    }];
}

- (void)testBackgroundContextCreationConcurrency;
{
    [self stressObjectCreation:^id{
        return [self.environment managedObjectContextForContextKey:RLCORE_DATA_BACKGROUND_CONTEXT_KEY];
    }];
}

- (void)launchBackgroundWrites:(NSUInteger)totalWrites
             whileNotDoneBlock:(void (^)(NSUInteger writeProgress))notDoneBlock;
{
    __block NSUInteger writeProgress = 0;
    dispatch_semaphore_t progressSemaphore = dispatch_semaphore_create(1);
    
    // launch a bunch of async processes in the background.
    dispatch_apply(totalWrites, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0),  ^(size_t i){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            CDAuthorManager *authorManager = [CDAuthorManager manager];
            
            [authorManager inBackgroundContextPerformBlock:^(NSString *innerContextKey) {
                CDAuthor *newObject = [authorManager insertNewObjectWithDefaultEntityForContextKey:innerContextKey];
                newObject.name = [NSString stringWithFormat:@"Bobby %d", (int)i];
                [authorManager saveContextForContextKey:innerContextKey];
                
                dispatch_semaphore_wait(progressSemaphore, DISPATCH_TIME_FOREVER);                
                writeProgress++;
                dispatch_semaphore_signal(progressSemaphore);
//                if (writeProgress % 20 == 0) {LOG_INT32(writeProgress);}
            }];
        });
    });    
    
    // in the foreground, wait for them to be done.
    while (writeProgress < totalWrites)
    {
        notDoneBlock(writeProgress);
    }
}

- (void)testCoreDataConcurrencyWriteReadStressTest;
{
    // Background Writing, Main Thread reading
    __block int readProgress = 0;
    
    NSUInteger totalCount = 400;
    [self launchBackgroundWrites:totalCount
               whileNotDoneBlock:^(NSUInteger writeProgress) {
                   CDAuthorManager *authorManager = [CDAuthorManager manager];
                   // simulate a read from core data.  In a real app, we would have done something with the return value.
                   [authorManager fetchAllForContextKey:nil];    
                   
                   readProgress++;
//                   if (readProgress % 20 == 0) {LOG_INT32(readProgress);}
                   // If the reads are unbounded, on my 2010 MPB, I got roughly equal number of reads and write.
                   // by sleeping for 100 usecs, I was able to get the ratio to about 2:1 w:r
                   //        usleep(100);
               }];
    
    
    CDAuthorManager *authorManager = [CDAuthorManager manager];
    NSArray *authors = [authorManager fetchAllForContextKey:nil];

    // Basically we just want to not crash.  this is just a sanity check.
    STAssertEquals([authors count], totalCount, @"bad author count");
}

- (void)testCoreDataConcurrencyWriteWriteStressTest;
{
    // Background Writing, Main Thread writing
    NSUInteger totalBackgroundWrites = 400;
    NSUInteger totalMainThreadWrites = 150;
    __block NSUInteger mainThreadWriteProgress = 0;

    [self launchBackgroundWrites:totalBackgroundWrites
               whileNotDoneBlock:^(NSUInteger writeProgress) {
//                   if (writeProgress % 20 == 0) {LOG_INT32(writeProgress);}

                   CDAuthorManager *authorManager = [CDAuthorManager manager];
                   
                   if (mainThreadWriteProgress < totalMainThreadWrites) {
                       [authorManager inMainThreadContextPerformBlockAndWait:^(NSString *innerContextKey) {
                           CDAuthor *newObject = [authorManager insertNewObjectWithDefaultEntityForContextKey:innerContextKey];
                           newObject.name = [NSString stringWithFormat:@"Mabel %d", mainThreadWriteProgress];
                           [authorManager saveContextForContextKey:innerContextKey];
                           mainThreadWriteProgress++;
//                           if (mainThreadWriteProgress % 20 == 0) {LOG_UINTEGER(mainThreadWriteProgress);}
                       }];
                   }
               }];
    
    
    CDAuthorManager *authorManager = [CDAuthorManager manager];
    NSArray *authors = [authorManager fetchAllForContextKey:nil];
    
    // Basically we just want to not crash.  this is just a sanity check.
    STAssertEquals([authors count], totalBackgroundWrites + totalMainThreadWrites, @"bad author count");    
}

- (void)testTestFramework;
{
//    STFail(@"uncomment to verify unit tests are being run");

    NSString *string1 = @"test";
    NSString *string2 = @"test";
    // Shouldn't use colons (:) in the STAssert... function messages.
    // Xcode will strip out everything before the colon.
    STAssertEqualObjects(string1, string2, @"FAILURE- %@ does not equal %@ ", string1, string2);

    NSUInteger uint_1 = 4;
    NSUInteger uint_2 = 4;
    STAssertEquals(uint_1, uint_2, @"FAILURE- %d does not equal %d", uint_1, uint_2);

}

@end
