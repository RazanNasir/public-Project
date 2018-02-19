//
//  BankDetailsScreen.h
//  ELH
//
//  Created by Shashi on 26/09/17.
//  Copyright © 2017 Razan Nasir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACFloatingTextField.h"

@interface BankDetailsScreen : UIViewController

- (IBAction)BackButtonAction:(id)sender;
- (IBAction)updateButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *bankDetailsScrollView;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *accountHolderTF;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *accountNoTF;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *IBANTF;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *bankNameTF;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *bankAddressTF;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *sortCodeTF;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *swiftTF;
@property (weak, nonatomic) IBOutlet UIButton *updateButton;

@property(weak, nonatomic) UIView *activeTextField;

@end
