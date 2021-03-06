/******************************************************************************
 * - Created 2012/04/19 by Matt Nunogawa
 * - Copyright __MyCompanyName__ 2012. All rights reserved.
 * - License: <#LICENSE#>
 *
 * NSManagedObject subclass.  Encapsulated functionality specific to a given
 * Core Data Entity
 *
 * Created from templates: https://github.com/amattn/RealLifeXcode4Templates
 */

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


#pragma mark ** Constant Defines **

#pragma mark ** Protocols & Declarations **



@protocol CDBookGeneratedAccessors
// If you need public access to the autogenerated relationship
// accessors in the .m, you can declare them here.
@end

@interface CDBook : NSManagedObject <CDBookGeneratedAccessors>
{
    
}

#pragma mark ** Custom Properties **

#pragma mark ** Methods **

#pragma mark ** Core Data Properties **

@property (nonatomic, retain) NSString * name;
@property (nonatomic) NSTimeInterval publicationDate;
@property (nonatomic, retain) NSManagedObject *publisher;
@property (nonatomic, retain) NSSet *authors;
@end

@interface CDBook (CoreDataGeneratedAccessors)

- (void)addAuthorsObject:(NSManagedObject *)value;
- (void)removeAuthorsObject:(NSManagedObject *)value;
- (void)addAuthors:(NSSet *)values;
- (void)removeAuthors:(NSSet *)values;


@end
