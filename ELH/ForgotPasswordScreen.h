//
//  ForgotPasswordScreen.h
//  ELH
//
//  Created by Mac on 19/02/18.
//  Copyright © 2018 Razan Nasir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACFloatingTextField.h"
#import "SellerDashboardScreen.h"
#import "Utils.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "Service.h"

@interface ForgotPasswordScreen : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *emailtextField;

- (IBAction)backButtonAction:(id)sender;
- (IBAction)submitButtonAction:(id)sender;


@end
