//
//  PayPalScreen.m
//  ELH
//
//  Created by Razan Nasir on 20/02/18.
//  Copyright © 2018 Razan Nasir. All rights reserved.
//

#import "PayPalScreen.h"

@interface PayPalScreen ()

@end

@implementation PayPalScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)BackButtonAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (IBAction)updateButtonAction:(id)sender {
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
