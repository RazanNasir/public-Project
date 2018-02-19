//
//  SideMenuViewController.h
//  WorkDesk
//
//  Created by Shashi Tiwari on 01/05/17.
//  Copyright © 2017 Unicode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sellerLoginScreen.h"

@interface SideMenuViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *menuItems;
@property (weak, nonatomic) IBOutlet UILabel *userName;



@end
