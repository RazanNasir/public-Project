//
//  sellerLoginScreen.m
//  ELH
//
//  Created by Shashi on 19/07/17.
//  Copyright © 2017 Shashi. All rights reserved.
//

#import "sellerLoginScreen.h"

@interface sellerLoginScreen ()
{
    MBProgressHUD *hud;

}

@end

@implementation sellerLoginScreen

- (void)viewDidLoad {
    
    [super viewDidLoad];
//    [self.emailIdTF setText:@"d1@gmail.com"];
//    [self.passwordTF setText:@"123456"];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
//                                                  forBarMetrics:UIBarMetricsDefault]; //UIImageNamed:@"transparent.png"
//    self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
}

- (IBAction)btnSignIn:(id)sender {
    
    [self checkValidation];
  //  [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"SellerDashboardScreen"] animated:YES];
}

- (IBAction)btnSignUp:(id)sender {
    
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"SellerSignUpScreen"] animated:YES];

}

-(BOOL) textFieldShouldReturn:(ACFloatingTextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

-(void)checkValidation {
    
    if ([self.emailIdTF.text isEqualToString:@""]) {
        
        [self.emailIdTF showError];
    }
    else {
        
        if ([Utils validateEmail:_emailIdTF.text]) {
            
            if ([self.passwordTF.text length] < 4 ) {
                
                [self.passwordTF showError];
            }
            else {
                
                hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeIndeterminate;
                hud.labelText = @"Loading";
                [hud show:YES];
                
                NSString *urlString  =  [NSString stringWithFormat:@"%@%@",BASE_URL,LOGIN_USER];
                NSLog(@"url string : %@",urlString);
                AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];

                manager.requestSerializer = [AFHTTPRequestSerializer serializer];
                
                // you can use different serializer for response.
                manager.responseSerializer = [AFJSONResponseSerializer serializer];

                
                NSDictionary *parameters = @{@"email": _emailIdTF.text, @"password": _passwordTF.text};
                [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                    //Sample logic to check login status
                    
                    NSDictionary*responseDic=(NSDictionary*)responseObject;
                    
                    NSLog(@"Result %@",[responseDic valueForKey:@"message"]);
                    
                    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                    [hud hide:YES];
                    if ([[responseDic valueForKey:@"status"]boolValue] == true) {
                        dict = [[responseDic valueForKey:@"message"]objectAtIndex:0];
                        [[NSUserDefaults standardUserDefaults]setValue:[dict valueForKey:@"id"] forKey:@"UserID"];
                        [[NSUserDefaults standardUserDefaults]setValue:[dict valueForKey:@"first_name"] forKey:@"UserName"];
                        [[NSUserDefaults standardUserDefaults]setValue:[dict valueForKey:@"group_id"] forKey:@"groupID"];
                        
                        if ([[dict valueForKey:@"group_id"]integerValue] == 2) {
                            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"LogInDoneSeller"];
                            if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"isComingFrom"]isEqualToString:@"firstScreen"]) {
                                [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"SellerDashboardScreen"] animated:YES];

                            }
                            else
                            {
                                [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"productwiseScreen"] animated:YES];

                            }

                        }
                        else
                        {
                        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"LogInDoneBuyer"];

                            [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"productwiseScreen"] animated:YES];

                        }
//
//                        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"LogInDoneBuyer"] isEqualToString:@"YES"]) {
//
//                            [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"productwiseScreen"] animated:NO];
//                        }
//                        else {
                        
                            
//                        }
                    }
                    else {
                        
                        UIAlertController *alertController = [UIAlertController
                                                              alertControllerWithTitle:@"Error!"
                                                              message:[responseDic valueForKey:@"message"]
                                                              preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"OK"
                                                                              style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
                                                                                  [hud hide:YES];
                                                                              }];
                        [alertController addAction:firstAction];
                        [self presentViewController:alertController animated:YES completion:nil];
                    }
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"Error: %@", error);
                    /*  UIAlertController *alertController = [UIAlertController
                     alertControllerWithTitle:@"Error!"
                     message:[error localizedDescription]
                     preferredStyle:UIAlertControllerStyleAlert];
                     UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"OK"
                     style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
                     [hud hide:YES];
                     }];
                     [alertController addAction:firstAction];
                     [self presentViewController:alertController animated:YES completion:nil];
                     [hud hide:YES];*/
                }];
            }
            
        } else{
            
            [self.emailIdTF showErrorWithText:@"Please enter valid Email Id"];
            
        }
        
    }
}
- (IBAction)backBtnActn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:TRUE];
}

@end
