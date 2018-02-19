//
//  FirstViewScreen.m
//  ELH
//
//  Created by Shashi on 18/07/17.
//  Copyright © 2017 Shashi. All rights reserved.
//

#import "FirstViewScreen.h"

@interface FirstViewScreen ()

@end

@implementation FirstViewScreen

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _BtnWantToBuy.layer.borderWidth = 2.0f;
    _BtnWantToBuy.layer.borderColor = [UIColor blueColor].CGColor;
    
    _BtnWantToSell.layer.borderWidth = 2.0f;
    _BtnWantToSell.layer.borderColor = [UIColor redColor].CGColor;
    
    _BtnWantToMove.layer.borderWidth = 2.0f;
    _BtnWantToMove.layer.borderColor = [UIColor whiteColor].CGColor;


}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
}

- (IBAction)wantTosellAction:(id)sender {
    
    [[NSUserDefaults standardUserDefaults]setValue:@"firstScreen" forKey:@"isComingFrom"];

    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"LogInDoneSeller"] == nil) {
          [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"sellerLoginScreen"] animated:YES];
    }
    else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"LogInDoneSeller"] isEqualToString:@"YES"])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"LogInDoneBuyer"];
         [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"SellerDashboardScreen"] animated:YES];
    }
    else
    {
        [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"sellerLoginScreen"] animated:YES];
    }
    
}

- (IBAction)wantToBuyAction:(id)sender {
    
    [[NSUserDefaults standardUserDefaults]setValue:@"firstScreenBuy" forKey:@"isComingFrom"];

    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"BuyerSceen"] animated:YES];
}

- (IBAction)wantToMove:(id)sender{
    
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"CameFromMenu"];
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"MoverScreen"] animated:YES];
    
}




@end
