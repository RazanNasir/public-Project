//
//  AddToCartScreen.h
//  ELH
//
//  Created by odbase on 16/9/2017.
//  Copyright © 2017 Shashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "Utils.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "Service.h"
#import "CategoryScreen.h"
#import "FirstViewScreen.h"
#import "productwiseScreen.h"

@interface ProductDescriptionScreen : UIViewController

@property (strong,nonatomic) NSMutableDictionary *productDescDict;

- (IBAction)back:(id)sender;

@end
