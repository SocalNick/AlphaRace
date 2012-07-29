//
//  CategoryPickViewController.h
//  IntegratingFacebookTutorial
//
//  Created by Nicholas Calugar on 7/28/12.
//
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

@interface GameMainViewController : UIViewController <PF_FBRequestDelegate, NSURLConnectionDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate>

// UITableView header view properties
@property (nonatomic, strong) IBOutlet UIView *headerView;
@property (nonatomic, strong) IBOutlet UILabel *headerNameLabel;
@property (nonatomic, strong) IBOutlet UIImageView *headerImageView;

// UITableView row data properties
@property (nonatomic, strong) NSArray *rowDataArray;


@end
