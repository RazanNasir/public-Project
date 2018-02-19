//
//  NewPasswordScreen.m
//  ELH
//
//  Created by Mac on 19/02/18.
//  Copyright © 2018 Razan Nasir. All rights reserved.
//

#import "NewPasswordScreen.h"

@interface NewPasswordScreen ()
{
    MBProgressHUD *hud;
    
}
@end

@implementation NewPasswordScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    [self webServiceforOTP];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webServiceforOTP
{
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    [hud show:YES];
    
    NSString *urlString  =  [NSString stringWithFormat:@"%@%@",BASE_URL,VERIFY_OTP];
    NSLog(@"url string : %@",urlString);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    // you can use different serializer for response.
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    NSDictionary *parameters = @{@"otp":self.emailTextField.text,@"email":[[NSUserDefaults standardUserDefaults]valueForKey:@"emailID"]};
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //Sample logic to check login status
        
        NSDictionary*responseDic=(NSDictionary*)responseObject;
        
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        dict = [responseDic valueForKey:@"message"];
        [hud hide:YES];
        if ([[responseDic valueForKey:@"status"]boolValue] == true) {
            NSLog(@"Result %@",[responseDic valueForKey:@"message"]);
            if ([[responseDic valueForKey:@"message"] isEqualToString:@"Verified"]) {
                [self webServiceforUpdatePassword];
            }
            else
            {
                UIAlertController *alertController = [UIAlertController
                                                      alertControllerWithTitle:@"Error!"
                                                      message:@"OTP not Matched."
                                                      preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"OK"
                                                                      style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
                                                                          [hud hide:YES];
                                                                      }];
                [alertController addAction:firstAction];
                [self presentViewController:alertController animated:YES completion:nil];
                [hud hide:YES];
            }
            
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

-(void)webServiceforUpdatePassword
{
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    [hud show:YES];
    
    NSString *urlString  =  [NSString stringWithFormat:@"%@%@",BASE_URL,UPDATE_PASSWORD];
    NSLog(@"url string : %@",urlString);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    // you can use different serializer for response.
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    NSDictionary *parameters = @{@"password":self.confirmPasswordTextField.text,@"email":[[NSUserDefaults standardUserDefaults]valueForKey:@"emailID"]};
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //Sample logic to check login status
        
        NSDictionary*responseDic=(NSDictionary*)responseObject;
        
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        dict = [responseDic valueForKey:@"message"];
        [hud hide:YES];
        if ([[responseDic valueForKey:@"status"]boolValue] == true) {
            NSLog(@"Result %@",[responseDic valueForKey:@"message"]);
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"Success!"
                                                  message:[responseDic valueForKey:@"message"]
                                                  preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"OK"
                                                                  style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
                                                                      
                                                                      [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"sellerLoginScreen"] animated:YES];

                                                                      [hud hide:YES];
                                                                  }];
            [alertController addAction:firstAction];
            [self presentViewController:alertController animated:YES completion:nil];
            [hud hide:YES];
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

- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (IBAction)submitButtonAction:(id)sender {
    [self webServiceforOTP];
}
@end
