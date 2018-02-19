//
//  ForgotPasswordScreen.m
//  ELH
//
//  Created by Mac on 19/02/18.
//  Copyright © 2018 Razan Nasir. All rights reserved.
//

#import "ForgotPasswordScreen.h"

@interface ForgotPasswordScreen ()
{
    MBProgressHUD *hud;
    
}
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

- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (IBAction)submitButtonAction:(id)sender {
    //Call Api and then on success move to next screen
    [self webServiceforgotPassword];
}

-(void)webServiceforgotPassword
{
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    [hud show:YES];
    
    NSString *urlString  =  [NSString stringWithFormat:@"%@%@",BASE_URL,FORGOT_PASSWORD];
    NSLog(@"url string : %@",urlString);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    // you can use different serializer for response.
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    NSDictionary *parameters = @{@"email":self.emailtextField.text};
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //Sample logic to check login status
        
        NSDictionary*responseDic=(NSDictionary*)responseObject;
        
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        dict = [responseDic valueForKey:@"message"];
        [hud hide:YES];
        if ([[responseDic valueForKey:@"status"]boolValue] == true) {
            NSLog(@"Result %@",[responseDic valueForKey:@"message"]);
            
            [[NSUserDefaults standardUserDefaults]setObject:[responseDic valueForKey:@"message"] forKey:@"OTP"];
            [[NSUserDefaults standardUserDefaults]setObject:self.emailtextField.text forKey:@"emailID"];

            [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"NewPasswordScreen"] animated:YES];
            
        }
        else {
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Error!"
                                              message:[error localizedDescription]
                                              preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"OK"
                                                              style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
                                                                  [hud hide:YES];
                                                              }];
        [alertController addAction:firstAction];
        [self presentViewController:alertController animated:YES completion:nil];
        [hud hide:YES];
    }];
}
@end
