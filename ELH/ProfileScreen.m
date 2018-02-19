//
//  ProfileScreen.m
//  ELH
//
//  Created by Shashi on 25/09/17.
//  Copyright © 2017 Razan Nasir. All rights reserved.
//

#import "ProfileScreen.h"

@interface ProfileScreen ()

@end

@implementation ProfileScreen

- (void)viewDidLoad {
    [super viewDidLoad];
   
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideBarButton setTarget: self.revealViewController];
        [self.sideBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)profileButtonAction:(id)sender {
    
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ProfileDetailsScreen"] animated:YES];
}

- (IBAction)bankInfoButtonAction:(id)sender {
    
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"BankScreen"] animated:YES];
}
@end
