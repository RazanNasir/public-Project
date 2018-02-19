//
//  WebViewPaymentViewController.h
//  ELH
//
//  Created by Mac on 03/02/18.
//  Copyright © 2018 Razan Nasir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "MBProgressHUD.h"

@interface WebViewPaymentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)backAction:(id)sender;
@property (strong,nonatomic) NSString *webURL;
@end
