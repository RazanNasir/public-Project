//
//  sellerLoginScreen.h
//  ELH
//
//  Created by Shashi on 19/07/17.
//  Copyright © 2017 Shashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACFloatingTextField.h"
#import "SellerDashboardScreen.h"
#import "Utils.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "Service.h"


@interface sellerLoginScreen : UIViewController

@property (weak, nonatomic) IBOutlet ACFloatingTextField *emailIdTF;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *passwordTF;
- (IBAction)backBtnActn:(id)sender;
- (IBAction)btnSignIn:(id)sender;
- (IBAction)btnSignUp:(id)sender;

@end
