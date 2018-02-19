//
//  ForgotPasswordScreen.m
//  ELH
//
//  Created by Mac on 19/02/18.
//  Copyright © 2018 Razan Nasir. All rights reserved.
//

#import "ForgotPasswordScreen.h"

@interface ForgotPasswordScreen ()

@end

@implementation ForgotPasswordScreen

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (IBAction)submitButtonAction:(id)sender {
    //Call Api and then on success move to next screen
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"NewPasswordScreen"] animated:YES];
}
@end
