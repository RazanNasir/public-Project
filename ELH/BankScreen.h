//
//  BankScreen.h
//  ELH
//
//  Created by Razan Nasir on 20/02/18.
//  Copyright © 2018 Razan Nasir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

@interface BankScreen : UIViewController



@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;

- (IBAction)profileButtonAction:(id)sender;
- (IBAction)bankInfoButtonAction:(id)sender;

@end
