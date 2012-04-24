/******************************************************************************
 * - Created 2012/04/19 by Matt Nunogawa
 * - Copyright __MyCompanyName__ 2012. All rights reserved.
 * - License: <#LICENSE#>
 *
 * <#SUMMARY INFORMATION#>
 *
 * Created from templates: https://github.com/amattn/RealLifeXcode4Templates
 */

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "RLCoreDataEnvironmentProtocol.h"

#pragma mark ** Constant Defines **

#define RLCORE_DATA_FILE_NAME @"com.amattn.RLCoreDataEnvironment.sqlite"
// The default name is Model.  This should match the actual name of your XXX.xcdatamodeld file
#define RLCORE_DATA_MOMD_FILENAME @"Model"
// This should match the identifier of your UnitTest Bundle
#define RLCORE_DATA_UNIT_TEST_BUNDLE_IDENFIER @"com.amattn.AutoTests"

#pragma mark ** Protocols & Declarations **

typedef void (^RLCoreDataErrorHandlerType)(NSError *error, SEL selectorWithError, BOOL isFatal);

@interface RLCoreDataEnvironment : NSObject <RLCoreDataEnvironmentProtocol>
{

}

#pragma mark ** Singleton Accessor **
+ (RLCoreDataEnvironment *)singleton;

#pragma mark ** Properties & Accessors **
@property(atomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property(atomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

// NSManagedObjectContexts
@property(atomic, strong, readonly) NSManagedObjectContext *mainThreadManagedObjectContext;
@property(atomic, strong, readonly) NSArray *allContextKeys;
- (NSManagedObjectContext *)managedObjectContextForContextKey:(NSString *)contextKey;
- (void)removeManagedObjectContextForKey:(NSString *)contextKey;

// Error handling
@property(nonatomic, copy) RLCoreDataErrorHandlerType errorHandlerBlock;

//Typically only changed for test or debug...
@property(nonatomic, assign) BOOL isTestEnvironment;
@property(nonatomic, strong, readonly) NSString *storeType;    //Default is NSSQLiteStoreType.
@property(nonatomic, strong, readonly) NSBundle *modelBundle;  //Default is [NSBundle mainBundle]

#pragma mark ** Helpers **

//Get NSManagedObject from an NSManagedObjectID
- (NSManagedObject *)objectForObjectID:(NSManagedObjectID *)objectID forContextKey:(NSString *)contextKey;

//get NSManagedObject form an objectIDString
- (NSManagedObject *)objectForObjectIDString:(NSString *)objectIDString forContextKey:(NSString *)contextKey;

//Get NSManagedObject from an NSManagedObject of an unknown/different context
- (NSManagedObject *)convertManagedObjectOfUnknownContext:(NSManagedObject *)unknownContextManagedObject toContextKey:(NSString *)contextKey;

//Save the specified context
- (NSError *)saveContextForContextKey:(NSString *)contextKey;

//Delete all core data items
- (void)resetCoreData;

@end
