//
//  SellerDashboardScreen.h
//  ELH
//
//  Created by Shashi on 20/07/17.
//  Copyright © 2017 Shashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "Utils.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "Service.h"
#import "UIImageView+WebCache.h"
#import "ProductDescriptionScreen.h"

@interface SellerDashboardScreen : UIViewController

- (IBAction)addProductAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;
@end
