//
//  HomeViewController.m
//  IntegratingFacebookTutorial
//
//  Created by Nicholas Calugar on 7/28/12.
//
//

#import "HomeViewController.h"
#import "UserDetailsViewController.h"
#import "CategoryPickViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation HomeViewController

@synthesize headerView, headerImageView, headerNameLabel;
@synthesize rowDataArray, imageData;

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
    [self setTitle:@"Alphabet Hood"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sugfriends.fullcontentbg.png"]];
    
    // Add logout navigation bar button
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleBordered target:self action:@selector(logoutButtonTouchHandler:)];
    [self.navigationItem setLeftBarButtonItem:logoutButton];
    
    // Add settings navigation bar button
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStyleBordered target:self action:@selector(settingsButtonTouchHandler:)];
    [self.navigationItem setRightBarButtonItem:settingsButton];
    
    UIButton *fakeLogoutButton = [UIButton buttonWithType: UIButtonTypeCustom];
    fakeLogoutButton.frame = CGRectMake(220, 25, 105, 30);
//    [fakeLogoutButton setTitle:@"Logout" forState:UIControlStateNormal];
    [fakeLogoutButton addTarget:self action:@selector(logoutButtonTouchHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.parentViewController.view addSubview:fakeLogoutButton];
    
    UIButton *playerButton = [UIButton buttonWithType: UIButtonTypeCustom];
    playerButton.frame = CGRectMake(10, 105, 300, 200);
//    [playerButton setTitle:@"LISA" forState:UIControlStateNormal];
    [playerButton addTarget:self action:@selector(playerButtonHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playerButton];
    
    // Load table header view from nib
//    [[NSBundle mainBundle] loadNibNamed:@"TableHeaderView" owner:self options:nil];
//    [self.tableView setTableHeaderView:headerView];
//    [headerNameLabel setText:@""];
    
    PFUser *currentUser = [PFUser currentUser];
    
    PFQuery *query = [PFUser query];
    [query whereKey:@"username" notEqualTo:currentUser.username];
    rowDataArray = [query findObjects];
    
//    [self.tableView reloadData];
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

#pragma mark - Player button method
- (void)playerButtonHandler:(id)sender
{
    [self.navigationController pushViewController:[[CategoryPickViewController alloc] init] animated:NO];
}

#pragma mark - Logout method

- (void)logoutButtonTouchHandler:(id)sender
{
    // Logout user, this automatically clears the cache
    [PFUser logOut];
    
    // Return to login view controller
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Settings method

- (void)settingsButtonTouchHandler:(id)sender
{
    // Go to UserDetailsViewController
    [self.navigationController pushViewController:[[UserDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return rowDataArray.count;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    if (cell == nil) {
//        // Create the cell and add the labels
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 170, 44)];
//        [titleLabel setTag:1]; // We use the tag to set it later
//        [titleLabel setTextAlignment:UITextAlignmentLeft];
//        [titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
//        [titleLabel setBackgroundColor:[UIColor clearColor]];
//        [cell.contentView addSubview:titleLabel];
//        
//        UIButton *startGameButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
//        startGameButton.titleLabel.font = [UIFont systemFontOfSize: 15];
//        startGameButton.userInteractionEnabled = NO;
//        startGameButton.titleLabel.lineBreakMode = UILineBreakModeTailTruncation;
//        startGameButton.titleLabel.shadowOffset = CGSizeMake (1.0, 0.0);
//        startGameButton.frame = CGRectMake(200, 7, 105, 30);
//        [startGameButton setTitle:@"Start Game" forState:UIControlStateNormal];
//        [startGameButton addTarget:self action:@selector(startGameButtonHandler) forControlEvents:UIControlEventTouchUpInside];
//        [startGameButton setTag:2];
//        [cell addSubview:startGameButton];
//    }
//    
//    // Cannot select these cells
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    
//    // Access components in the cell using the tag #
//    UILabel *titleLabel = (UILabel *)[cell viewWithTag:1];
//    UIButton *startGameButton = (UIButton *)[cell viewWithTag:2];
//    
//    // Display the data in the table
//    PFUser *user = [rowDataArray objectAtIndex:indexPath.row];
//    [titleLabel setText:[user objectForKey:@"displayName"]];
//
//    return cell;
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PFUser *currentUser = [PFUser currentUser];
    PFUser *user = [rowDataArray objectAtIndex:indexPath.row];
    
    NSString *gameName = [NSString stringWithFormat:@"%@/%@/%@",
        currentUser.objectId,
        user.objectId,
        [NSNumber numberWithDouble: [[NSDate date] timeIntervalSince1970]]
    ];

    PFObject *game = [PFObject objectWithClassName:@"Game"];
    [game setObject:gameName forKey:@"Name"];
    [game saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            PFRelation *currentUserRelation = [currentUser relationforKey:@"Games"];
            [currentUserRelation addObject:game];
            [currentUser saveInBackground];
            
            PFObject *gameRequest = [PFObject objectWithClassName:@"GameRequest"];
            [gameRequest setObject:game forKey:@"Game"];
            [gameRequest setObject:user forKey:@"User"];
            [gameRequest saveInBackground];
            
            [self.navigationController pushViewController:[[CategoryPickViewController alloc] init] animated:YES];
        } else {
            
        }
    }];
}


@end
