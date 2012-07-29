//
//  GamePhotoViewController.h
//  IntegratingFacebookTutorial
//
//  Created by Nicholas Calugar on 7/28/12.
//
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CLGeocoder.h>
#import <CoreLocation/CLLocationManager.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import <CoreLocation/CLPlacemark.h>
#import "Parse/Parse.h"

@interface GamePhotoViewController : UIViewController <PF_FBRequestDelegate, NSURLConnectionDelegate, CLLocationManagerDelegate>

// UITableView header view properties
@property (nonatomic, strong) IBOutlet UIView *headerView;
@property (nonatomic, strong) IBOutlet UILabel *headerNameLabel;
@property (nonatomic, strong) IBOutlet UIImageView *headerImageView;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) UIBackgroundTaskIdentifier fileUploadBackgroundTaskId;
@property (nonatomic, assign) UIBackgroundTaskIdentifier photoPostBackgroundTaskId;

@property (nonatomic, strong) CLLocationManager *locationManager;

// UITableView row data properties
@property (nonatomic, strong) NSArray *rowDataArray;

- (id)initWithImage:(UIImage *)aImage;


@end
