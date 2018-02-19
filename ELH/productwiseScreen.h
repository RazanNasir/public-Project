//
//  productwiseScreen.h
//  ELH
//
//  Created by Razan Nasir on 8/15/17.
//  Copyright © 2017 Shashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALScrollViewPaging.h"
#import "SWRevealViewController.h"
#import "Utils.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "Service.h"
#import "productwiseScreen.h"
#import "UIImageView+WebCache.h"
#import "PayPalMobile.h"
#import "WebViewPaymentViewController.h"

#define kPayPalEnvironment PayPalEnvironmentNoNetwork


@interface productwiseScreen : UIViewController<PayPalPaymentDelegate, PayPalFuturePaymentDelegate, PayPalProfileSharingDelegate, UIPopoverControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *addToBagBtn;
@property (weak, nonatomic) IBOutlet UILabel *productNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *productPriceLbl;
@property (weak, nonatomic) IBOutlet UILabel *productDescLbl;
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;
@property (strong,nonatomic) NSString *productID;

- (IBAction)addToBagAction:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)plusAction:(id)sender;
- (IBAction)minusAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;
@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, strong, readwrite) NSString *resultText;


@end
