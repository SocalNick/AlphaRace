//
//  HomeViewController.m
//  IntegratingFacebookTutorial
//
//  Created by Nicholas Calugar on 7/28/12.
//
//

#import "GameLettersViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation GameLettersViewController

@synthesize headerView, headerImageView, headerNameLabel, rowDataArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Pick a Category"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"categorysel.contentempty.png"]];
    
    // @TODO - Need to figure how to drop the back navigation link
    
    // Load table header view from nib
    [[NSBundle mainBundle] loadNibNamed:@"TableHeaderView" owner:self options:nil];
    [headerNameLabel setText:@""];
    
    //    PFQuery *query = [PFQuery queryWithClassName:@"Category"];
    //    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    //        if (!error) {
    //            // The find succeeded.
    //            rowDataArray = objects;
    //            [self.tableView reloadData];
    //        } else {
    //            // Log details of the failure
    //            NSLog(@"Error: %@ %@", error, [error userInfo]);
    //        }
    //    }];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
