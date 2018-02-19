//
//  SellerSignUpScreen.h
//  ELH
//
//  Created by Shashi on 24/07/17.
//  Copyright © 2017 Shashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACFloatingTextField.h"
#import "Utils.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "Service.h"

@interface SellerSignUpScreen : UIViewController


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
@property (weak, nonatomic) IBOutlet UIButton *sellerBtn;
@property (weak, nonatomic) IBOutlet UIButton *buyerBtn;
- (IBAction)btnAction:(UIButton*)sender;

@property(weak, nonatomic) UIView *activeTextField;
- (IBAction)backBtnActn:(id)sender;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *paypalEmailTF;
@property (weak, nonatomic) IBOutlet UIImageView *paypayImg;


- (IBAction)signUpBtnAction:(id)sender;
@end
