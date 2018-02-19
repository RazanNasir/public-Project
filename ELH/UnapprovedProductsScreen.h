//
//  UnapprovedProductsScreen.h
//  ELH
//
//  Created by odbase on 24/7/2017.
//  Copyright © 2017 Shashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "Utils.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "Service.h"
#import "AddProductScreen.h"
#import "UIImageView+WebCache.h"
#import "ProductDescriptionScreen.h"

@interface UnapprovedProductsScreen : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;

- (IBAction)addProductBtnActn:(id)sender;

@end
