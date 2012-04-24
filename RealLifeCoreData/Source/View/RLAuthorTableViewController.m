/******************************************************************************
 * - Created 2012/04/22 by Matt Nunogawa
 * - Copyright __MyCompanyName__ 2012. All rights reserved.
 * - License: <#LICENSE#>
 *
 * <#SUMMARY INFORMATION#>
 *
 * Created from templates: https://github.com/amattn/RealLifeXcode4Templates
 */

#import "RLAuthorTableViewController.h"
#import "CDAuthorManager.h"

#pragma mark ** Constant Defines **

#pragma mark ** Protocols & Declarations **

@interface RLAuthorTableViewController ()

@end

@implementation RLAuthorTableViewController
#pragma mark ** Synthesis **
#pragma mark ** Static Variables **

//*****************************************************************************
#pragma mark -
#pragma mark ** Lifecycle & Memory Management **

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}
 */

- (void)dealloc;
{
    
}

- (void)didReceiveMemoryWarning;
{
    [super didReceiveMemoryWarning];
    // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

//*****************************************************************************
#pragma mark -
#pragma mark ** UIView Lifecycle **

- (void)viewDidLoad;
{
    [super viewDidLoad];
}

- (void)viewDidUnload;
{
    [super viewDidUnload];
}

/*
- (void)viewWillAppear:(BOOL)animated;
{
    [super viewWillAppear:animated];
}
 */
/*
- (void)viewDidAppear:(BOOL)animated;
{
    [super viewDidAppear:animated];
}
 */
/*
- (void)viewWillDisappear:(BOOL)animated;
{
    [super viewWillDisappear:animated];
}
 */
/*
- (void)viewDidDisappear:(BOOL)animated;
{
    [super viewDidDisappear:animated];
}
 */

//*****************************************************************************
#pragma mark -
#pragma mark ** UIView Methods **

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES; //support all orientations
}
 */

//*****************************************************************************
#pragma mark -
#pragma mark ** UITableViewData Helper Methods **

- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (cell == nil)
        return;
}

//*****************************************************************************
#pragma mark -
#pragma mark ** UITableViewDataSource **

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //Typically each section has its own identifier.  If you are using storyboards, this must match the identifier for the cell prototype
    NSString *cellIdentifier = @"author_cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        if (self.storyboard)
        {
            // storyboard style, dequeueReusableCellWithIdentifier: should always return a cell.  If it is, check that cellIdentifier matches the value in the storyboard.
            NSAssert(NO, @"cell should not be nil");
        }
        else
        {
            // xib style, create the cell when we can't deque
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            // Configuration of cell attributes that never change can go here.  
            // For example:
            // cell.textLabel.textColor = <#UIColor *someColor#>      
        }
    }
    
    // You may need to configure cell attrirbutes that differ based on the row 
    // from different places.  Thus, configureCell:forRowAtIndexPath: is
    // factored out into its own helper method.
    [self configureCell:cell forRowAtIndexPath:indexPath];

    return cell;
}

//*****************************************************************************
#pragma mark -
#pragma mark ** UITableViewDelegate **

/*
// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    // Navigation logic may go here -- for example, create and push another view controller.
    // AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
    // [self.navigationController pushViewController:anotherViewController animated:YES];
    // [anotherViewController release];
}
 */

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
 */

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
 */

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath;
{

}
 */

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
 */

//*****************************************************************************
#pragma mark -
#pragma mark ** Utilities **

//*****************************************************************************
#pragma mark -
#pragma mark ** IBActions **

//*****************************************************************************
#pragma mark -
#pragma mark ** Accesssors **

@end

