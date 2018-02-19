//
//  CategoryScreen.h
//  ELH
//
//  Created by Razan Nasir on 8/15/17.
//  Copyright © 2017 Shashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "Utils.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "Service.h"
#import "productwiseScreen.h"
#import "UIImageView+WebCache.h"


@interface CategoryScreen : UIViewController


- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
- (IBAction)logoutAction:(id)sender;

@property (strong,nonatomic) NSString *categoryID;

@end
