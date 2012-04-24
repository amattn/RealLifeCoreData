/******************************************************************************
 * - Created 2012/04/19 by Matt Nunogawa
 * - Copyright __MyCompanyName__ 2012. All rights reserved.
 * - License: <#LICENSE#>
 *
 * <#SUMMARY INFORMATION#>
 *
 * Created from templates: https://github.com/amattn/RealLifeXcode4Templates
 */

#import "RLBaseEntityManager.h"
#import "CDPublisher.h"

#pragma mark ** Constant Defines **

#pragma mark ** Protocols & Declarations **

@interface CDPublisherManager : RLBaseEntityManager
{
    
}
#pragma mark ** Designated Initializers **
- (id)initWithCoreDataEnvironment:(NSObject <RLCoreDataEnvironmentProtocol> *)environment;
+ (CDPublisherManager *)manager; // Manager using default RLCoreDataEnvironment singleton

#pragma mark ** Core Data Properties **

#pragma mark ** Properties **

#pragma mark ** Methods **

// add custom methods here that apply to this entity.
// For example, RLBooksManager would likely contain:
//- (NSArray *)fetchAllBooksByAuthor:(RLAuthor *)someAuthor
//                 contextIdentifier:(RLContextIdentifier)contextIdentifier;

@end
