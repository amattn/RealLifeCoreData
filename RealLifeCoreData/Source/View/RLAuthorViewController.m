/******************************************************************************
 * - Created 2012/04/22 by Matt Nunogawa
 * - Copyright __MyCompanyName__ 2012. All rights reserved.
 * - License: <#LICENSE#>
 *
 * <#SUMMARY INFORMATION#>
 *
 * Created from templates: https://github.com/amattn/RealLifeXcode4Templates
 */

#import "RLAuthorViewController.h"
#import "CDAuthorManager.h"

#pragma mark ** Constant Defines **

#pragma mark ** Protocols & Declarations **

@interface RLAuthorViewController ()
@property (nonatomic, strong) CDAuthorManager *authorManager;
@end

@implementation RLAuthorViewController
#pragma mark ** Synthesis **

@synthesize actionBarButton = _actionBarButton;

@synthesize authorManager = _authorManager;

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
    unsigned seed = [NSDate timeIntervalSinceReferenceDate];
    srand(seed);
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
#pragma mark ** Methods that subclasses MUST implement **

- (Class)entityManagerClass;
{
    return [CDAuthorManager class];
}

- (NSString *)cellIdentifier;
{
    return @"author_cell";
}

- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    CDAuthor *author = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = author.name;
}

//*****************************************************************************
#pragma mark -
#pragma mark ** Methods that subclasses MAY implement **

- (NSString *)predicateString;
{
    return [super predicateString];
}

- (NSArray *)sortDescriptors;
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:CD_KEY_NAME ascending:YES];
    return [NSArray arrayWithObjects:sortDescriptor, nil];
}

- (BOOL)shouldUseSections;
{
    return NO;
}

//*****************************************************************************
#pragma mark -
#pragma mark ** Utilities **

//*****************************************************************************
#pragma mark -
#pragma mark ** IBActions **

- (IBAction)insertAuthors:(id)sender;
{
    UIActionSheet *sheet;
    sheet = [[UIActionSheet alloc] initWithTitle:@"Insert Authors in Background"
                                        delegate:self
                               cancelButtonTitle:@"Cancel"
                          destructiveButtonTitle:nil
                               otherButtonTitles:@"1", @"10", @"100", @"1000",nil];
    
    [sheet showFromBarButtonItem:self.actionBarButton animated:YES];
}

- (IBAction)deleteAllAuthors:(id)sender;
{
    [self.authorManager inBackgroundContextPerformBlock:^(NSString *innerContextKey) {
        NSArray *allAuthors = [self.authorManager fetchAllForContextKey:innerContextKey];
        for (CDAuthor *author in allAuthors) 
        {
            ASSERT_IS_CLASS(author, [CDAuthor class]);
            [self.authorManager deleteObject:author contextKey:innerContextKey];
        }
        [self.authorManager saveContextForContextKey:innerContextKey];
    }];
}

//*****************************************************************************
#pragma mark -
#pragma mark ** UIActionSheetDelegate **

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (actionSheet.cancelButtonIndex == buttonIndex)
        return;

    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    NSInteger numberToCreate = [buttonTitle integerValue];
    
    [self.authorManager inBackgroundContextPerformBlock:^(NSString *innerContextKey) {
        [self.authorManager inBackgroundContextPerformBlock:^(NSString *innerContextKey) {
            for (int i = 0; i < numberToCreate; i++) {
                CDAuthor *author = [self.authorManager insertNewObjectWithDefaultEntityForContextKey:innerContextKey];
                author.name = [NSString stringWithFormat:@"Bobby %.10d", rand()];
            }
            
            [self.authorManager saveContextForContextKey:innerContextKey];
        }];
    }];
    
}

//*****************************************************************************
#pragma mark -
#pragma mark ** Accesssors **

- (CDAuthorManager *)authorManager;
{
	if (_authorManager == nil) {
        _authorManager = [CDAuthorManager manager];
	}
	return _authorManager;
}

@end

