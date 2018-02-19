//
//  FirstViewScreen.h
//  ELH
//
//  Created by Shashi on 18/07/17.
//  Copyright © 2017 Shashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayPalMobile.h"

#define kPayPalEnvironment PayPalEnvironmentNoNetwork

@interface FirstViewScreen : UIViewController <PayPalPaymentDelegate, PayPalFuturePaymentDelegate, PayPalProfileSharingDelegate, UIPopoverControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *BtnWantToBuy;
@property (weak, nonatomic) IBOutlet UIButton *BtnWantToSell;
@property (weak, nonatomic) IBOutlet UIButton *BtnWantToMove;

- (IBAction)wantTosellAction:(id)sender;
- (IBAction)wantToBuyAction:(id)sender;
- (IBAction)wantToMove:(id)sender;

@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;
@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, strong, readwrite) NSString *resultText;




@end
