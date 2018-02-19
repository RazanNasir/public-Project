//
//  BuyerSignupScreen.h
//  ELH
//
//  Created by Razan Nasir on 10/02/18.
//  Copyright © 2018 Razan Nasir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACFloatingTextField.h"
#import "Utils.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "Service.h"

@interface BuyerSignupScreen : UIViewController


@property (weak, nonatomic) IBOutlet UIScrollView *signupScrollView;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *nameTF;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *emailTF;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *phoneTF;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *streetTF;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *cityTF;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *stateTF;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *zipCodeTF;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *countryTF;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *signUpBtn;

@property(weak, nonatomic) UIView *activeTextField;
- (IBAction)backBtnActn:(id)sender;


- (IBAction)signUpBtnAction:(id)sender;


@end
