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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"confirmimg.contentbg.png"]];

    // @TODO - Need to figure how to drop the back navigation link

    // Load table header view from nib
    [[NSBundle mainBundle] loadNibNamed:@"TableHeaderView" owner:self options:nil];
    [headerNameLabel setText:@""];

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
