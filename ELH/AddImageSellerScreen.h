//
//  AddImageSellerScreen.h
//  ELH
//
//  Created by odbase on 26/7/2017.
//  Copyright © 2017 Shashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "Service.h"
#import "ACFloatingTextField.h"

@interface AddImageSellerScreen : UIViewController<UIImagePickerControllerDelegate>


@property (weak, nonatomic) UIImageView *choosedImage;;

- (IBAction)backButtonMovers:(id)sender;
- (IBAction)nextBtnActn:(id)sender;
@property (strong,nonatomic) NSDictionary *addProductDict;
@property (weak, nonatomic) IBOutlet UILabel *topImageLbl;
@property (weak, nonatomic) IBOutlet UILabel *bottomImageLbl;
@property (weak, nonatomic) IBOutlet UILabel *leftImageLbl;
@property (weak, nonatomic) IBOutlet UILabel *rightImageLbl;

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImageView;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
- (IBAction)buttonAction:(UIButton*)sender;

@end
