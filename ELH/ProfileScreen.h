//
//  ProfileScreen.h
//  ELH
//
//  Created by Shashi on 25/09/17.
//  Copyright © 2017 Razan Nasir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BankDetailsScreen.h"
#import "ProfileDetailsScreen.h"

@interface ProfileScreen : UIViewController


@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;

- (IBAction)profileButtonAction:(id)sender;
- (IBAction)bankInfoButtonAction:(id)sender;

@end
