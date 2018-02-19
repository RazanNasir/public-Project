//
//  NewPasswordScreen.h
//  ELH
//
//  Created by Mac on 19/02/18.
//  Copyright © 2018 Razan Nasir. All rights reserved.
//

#import "ACFloatingTextField.h"
#import "SellerDashboardScreen.h"
#import "Utils.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "Service.h"
#import <UIKit/UIKit.h>

@interface NewPasswordScreen : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;


- (IBAction)backButtonAction:(id)sender;
- (IBAction)submitButtonAction:(id)sender;

@end
