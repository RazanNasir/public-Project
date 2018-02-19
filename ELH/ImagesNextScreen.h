//
//  ImagesNextScreen.h
//  ELH
//
//  Created by Shashi on 26/07/17.
//  Copyright © 2017 Shashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "Service.h"
#import "ACFloatingTextField.h"


@interface ImagesNextScreen : UIViewController

@property(weak, nonatomic) UIView *activeTextField;
@property(strong,nonatomic) NSMutableArray *imageArray;

@property (weak, nonatomic) IBOutlet UIScrollView *imageDataScroll;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *userNameTF;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *emailTF;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *phoneTF;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *movingFromTF;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *movingToTF;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *descriptionTV;

- (IBAction)backBtnActn:(id)sender;
- (IBAction)nextBtnActn:(id)sender;



@end
