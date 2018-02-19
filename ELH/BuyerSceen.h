//
//  BuyerSceen.h
//  ELH
//
//  Created by odbase on 25/7/2017.
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

@interface BuyerSceen : UIViewController

- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewMain;
- (IBAction)logoutAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logOutButton;

@end
