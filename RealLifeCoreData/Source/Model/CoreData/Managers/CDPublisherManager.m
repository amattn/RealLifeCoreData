/******************************************************************************
 * - Created 2012/04/19 by Matt Nunogawa
 * - Copyright __MyCompanyName__ 2012. All rights reserved.
 * - License: <#LICENSE#>
 *
 * <#SUMMARY INFORMATION#>
 *
 * Created from templates: https://github.com/amattn/RealLifeXcode4Templates
 */

#import "CDPublisherManager.h"

@interface CDPublisherManager ()

@end

@implementation CDPublisherManager

#pragma mark ** Synthesis **

#pragma mark ** Static Variables **

//*****************************************************************************
#pragma mark -
#pragma mark ** Lifecyle & Memory Management **

+ (CDPublisherManager *)manager; // Manager using default RLCoreDataEnvironment singleton
{
    return [[CDPublisherManager alloc] initWithCoreDataEnvironment:[RLCoreDataEnvironment singleton]];
}

- (id)initWithCoreDataEnvironment:(NSObject <RLCoreDataEnvironmentProtocol> *)environment;
{
    self = [super initWithCoreDataEnvironment:environment];
    if (self)
    {
        
    }
    return self;
}

- (void)dealloc
{
    
}

//*****************************************************************************
#pragma mark -
#pragma mark ** CoreDataManager Subclasses may override **

- (NSArray *)defaultSortDescriptors;
{
    // Here is an example of how to add a custom sort descriptor in addition to
    // the default sort descriptors:
    //
    // NSSortDescriptor *sorter = [NSSortDescriptor sortDescriptorWithKey:CD_KEY_TS_ADD ascending:YES];
    // NSArray *newSortDescriptors = [NSArray arrayWithObject:sorter];
    // return [newSortDescriptors arrayByAddingObjectsFromArray:super.defaultSortDescriptors];

    return super.defaultSortDescriptors;
}

//*****************************************************************************
#pragma mark -
#pragma mark ** Actions **

//*****************************************************************************
#pragma mark -
#pragma mark ** Accesssors **

@end
