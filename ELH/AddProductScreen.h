//
//  AddProductScreen.h
//  ELH
//
//  Created by odbase on 26/7/2017.
//  Copyright © 2017 Shashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "Service.h"
#import "AddImageSellerScreen.h"


@interface AddProductScreen : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *imageDataScroll;
@property (weak, nonatomic) IBOutlet UITextField *bedroomFurnitureTF;
@property (weak, nonatomic) IBOutlet UITextField *productTF;
@property (weak, nonatomic) IBOutlet UITextField *priceTF;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTV;
@property (weak, nonatomic) IBOutlet UIView *imageDataView;
@property(weak, nonatomic) UIView *activeTextField;

- (IBAction)selectProductAction:(id)sender;
- (IBAction)backBtnActn:(id)sender;
- (IBAction)nextBtnActn:(id)sender;

@end
