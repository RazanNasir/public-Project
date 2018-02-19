//
//  BuyerLoginScreen.h
//  ELH
//
//  Created by Razan Nasir on 10/02/18.
//  Copyright © 2018 Razan Nasir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACFloatingTextField.h"
#import "SellerDashboardScreen.h"
#import "Utils.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "Service.h"


@interface BuyerLoginScreen : UIViewController

@property (weak, nonatomic) IBOutlet ACFloatingTextField *emailIdTF;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *passwordTF;
- (IBAction)backBtnActn:(id)sender;
- (IBAction)btnSignIn:(id)sender;
- (IBAction)btnSignUp:(id)sender;
- (IBAction)forgotPasswordAction:(id)sender;

@end
