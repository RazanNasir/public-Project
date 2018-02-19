//
//  ProfileDetailsScreen.h
//  ELH
//
//  Created by Shashi on 26/09/17.
//  Copyright © 2017 Razan Nasir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACFloatingTextField.h"
#import "SellerDashboardScreen.h"
#import "Utils.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "Service.h"

@interface ProfileDetailsScreen : UIViewController

@property (weak, nonatomic) IBOutlet ACFloatingTextField *nameTF;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *emailTF;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *phoneTF;
@property (weak, nonatomic) IBOutlet UIButton *updateButton;


- (IBAction)BackButtonAction:(id)sender;
- (IBAction)updateButtonAction:(id)sender;

@end
