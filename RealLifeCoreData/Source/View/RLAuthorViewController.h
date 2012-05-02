/******************************************************************************
 * - Created 2012/04/22 by Matt Nunogawa
 * - Copyright __MyCompanyName__ 2012. All rights reserved.
 * - License: <#LICENSE#>
 *
 * <#SUMMARY INFORMATION#>
 *
 * Created from templates: https://github.com/amattn/RealLifeXcode4Templates
 */

#import "RLFetchedResultsViewController.h"

#pragma mark ** Constant Defines **

#pragma mark ** Protocols & Declarations **

@interface RLAuthorViewController : RLFetchedResultsViewController <UIActionSheetDelegate>
{

}

#pragma mark ** Designated Initializer **

#pragma mark ** Properties **

@property (nonatomic, weak) IBOutlet UIBarButtonItem *actionBarButton;

#pragma mark ** Methods **

- (IBAction)insertAuthors:(id)sender;
- (IBAction)deleteAllAuthors:(id)sender;

@end