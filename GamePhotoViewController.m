//
//  GamePhotoViewController.m
//  IntegratingFacebookTutorial
//
//  Created by Nicholas Calugar on 7/28/12.
//
//

#import "GamePhotoViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation GamePhotoViewController

@synthesize headerView, headerImageView, headerNameLabel, rowDataArray;

@synthesize image;
@synthesize fileUploadBackgroundTaskId;
@synthesize photoPostBackgroundTaskId;

@synthesize locationManager;

- (id)initWithImage:(UIImage *)aImage {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        if (!aImage) {
            return nil;
        }

        self.image = aImage;
        self.fileUploadBackgroundTaskId = UIBackgroundTaskInvalid;
        self.photoPostBackgroundTaskId = UIBackgroundTaskInvalid;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Pick a Category"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"confirmimg.nolocation.png"]];

    // @TODO - Need to figure how to drop the back navigation link

    // Load table header view from nib
    [[NSBundle mainBundle] loadNibNamed:@"TableHeaderView" owner:self options:nil];
    [headerNameLabel setText:@""];

    UIButton *submitButton = [UIButton buttonWithType: UIButtonTypeCustom];
    submitButton.frame = CGRectMake(10, 345, 301, 55);
//    [submitButton setTitle:@"SUBMIT" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitButtonHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];

    UIImageView *photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70, 320, 150)];
    [photoImageView setBackgroundColor:[UIColor blackColor]];
    [photoImageView setImage:self.image];
    [photoImageView setContentMode:UIViewContentModeScaleAspectFit];

    CALayer *layer = photoImageView.layer;
    layer.masksToBounds = NO;
    layer.shadowRadius = 3.0f;
    layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    layer.shadowOpacity = 0.5f;
    layer.shouldRasterize = YES;

    [self.view addSubview:photoImageView];

    locationManager = [[CLLocationManager alloc] init];

    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;

    // Set a movement threshold for new events
    locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters;

    [locationManager startUpdatingLocation];

    // Set initial location if available
    CLLocation *currentLocation = locationManager.location;
    if (currentLocation) {
        CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
        [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            for (CLPlacemark *placemark in placemarks) {
                UILabel *placemarkNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 282, 320, 44)];
                [placemarkNameLabel setText:[placemark.addressDictionary objectForKey:@"Street"]];
                [placemarkNameLabel setTag:1]; // We use the tag to set it later
                [placemarkNameLabel setTextAlignment:UITextAlignmentLeft];
                [placemarkNameLabel setFont:[UIFont boldSystemFontOfSize:14]];
                [placemarkNameLabel setBackgroundColor:[UIColor clearColor]];
                [self.view addSubview:placemarkNameLabel];

                UILabel *placemarkAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 300, 320, 44)];
                [placemarkAddressLabel setText:
                    [NSString stringWithFormat:@"%@, %@ %@",
                        [placemark.addressDictionary objectForKey:@"City"],
                        [placemark.addressDictionary objectForKey:@"State"],
                        [placemark.addressDictionary objectForKey:@"ZIP"]
                     ]
                ];
                [placemarkAddressLabel setTag:1]; // We use the tag to set it later
                [placemarkAddressLabel setTextAlignment:UITextAlignmentLeft];
                [placemarkAddressLabel setFont:[UIFont systemFontOfSize:12]];
                placemarkAddressLabel.textColor = [UIColor grayColor];
                [placemarkAddressLabel setBackgroundColor:[UIColor clearColor]];
                [self.view addSubview:placemarkAddressLabel];
            }
        }];
    }
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

-(void)submitButtonHandler:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

@end
