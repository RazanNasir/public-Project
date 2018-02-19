//
//  SellerSignUpScreen.m
//  ELH
//
//  Created by Shashi on 24/07/17.
//  Copyright © 2017 Shashi. All rights reserved.
//

#import "SellerSignUpScreen.h"

@interface SellerSignUpScreen () {
    
    MBProgressHUD *hud;
    NSString *grpID;

}

@end

@implementation SellerSignUpScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
//                                                  forBarMetrics:UIBarMetricsDefault]; //UIImageNamed:@"transparent.png"
//    self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    [_buyerBtn setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
    [_sellerBtn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    self.paypayImg.hidden = YES;
    [self.paypalEmailTF setHidden:true];
    grpID = @"3";
    
    // Do any additional setup after loading the view.
    
    [self.signupScrollView setContentSize:CGSizeMake(self.signupScrollView.frame.size.width, self.signUpBtn.frame.origin.y + self.signUpBtn.frame.size.height + 10)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated {
    
    [self registerForKeyboardNotifications];
}

- (IBAction)signUpBtnAction:(id)sender {
    
    [self checkValidation];
//    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"sellerLoginScreen"] animated:YES];

}

-(void)checkValidation {
    
    if ([self.nameTF.text isEqualToString:@""]) {
        
        [self.nameTF showError];
    }
    else {
        
        if ([self.emailTF.text isEqualToString:@""]) {
            
            [self.emailTF showError];
        }
        else {
            
            if ([self.phoneTF.text isEqualToString:@""]) {
                
                [self.phoneTF showError];
            }
            else {
                
                if ([self.streetTF.text isEqualToString:@""]) {
                    
                    [self.streetTF showError];
                }
                else {
                    
                    if ([self.cityTF.text isEqualToString:@""]) {
                        
                        [self.cityTF showError];
                    }
                    else {
                        
                        if ([self.stateTF.text isEqualToString:@""]) {
                            
                            [self.stateTF showError];
                        }
                        else {
                            
                            if ([self.zipCodeTF.text isEqualToString:@""]) {
                                
                                [self.zipCodeTF showError];
                            }
                            else {
                               
                                if ([self.streetTF.text isEqualToString:@""]) {
                                    
                                    [self.streetTF showError];
                                }
                                else {
                                    
                                    if ([self.countryTF.text isEqualToString:@""]) {
                                        
                                        [self.countryTF showError];
                                    }
                                    else {
                                        
                                        if ([self.passwordTF.text isEqualToString:@""]) {
                                            
                                            [self.passwordTF showError];
                                        }
                                       /* else {
                                            
                                            if ([self.paypalEmailTF.text isEqualToString:@""]) {
                                                
                                                [self.paypalEmailTF showError];
                                            }*/
                                        else {
                                            
                                            [self webserviceForSignUp];
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
}

-(void)webserviceForSignUp {
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    [hud show:YES];
    
    NSString *urlString  =  [NSString stringWithFormat:@"%@%@",BASE_URL,SIGNUP_USER];
    NSLog(@"url string : %@",urlString);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    // you can use different serializer for response.
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    NSDictionary *parameters = @{@"name": self.nameTF.text, @"email": self.emailTF.text, @"phone": self.phoneTF.text, @"password": self.passwordTF.text, @"street": self.streetTF.text, @"city": self.cityTF.text, @"state":@"", @"country": @"", @"zip": self.zipCodeTF.text,@"paypal_email":_paypalEmailTF.text,@"group_id": grpID};
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //Sample logic to check login status
        
        NSDictionary*responseDic=(NSDictionary*)responseObject;
        
        NSLog(@"Result %@",[responseDic valueForKey:@"message"]);
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        dict = [[responseDic valueForKey:@"message"]objectAtIndex:0];
        [hud hide:YES];
        if ([[responseDic valueForKey:@"status"]boolValue] == true) {
            

            [[NSUserDefaults standardUserDefaults]setValue:[dict valueForKey:@"id"] forKey:@"UserID"];
            [[NSUserDefaults standardUserDefaults]setValue:[dict valueForKey:@"first_name"] forKey:@"UserName"];
            if ([grpID isEqualToString:@"2"]) {
                [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"LogInDoneSeller"];
                [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"LogInDoneBuyer"];
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
                [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"productwiseScreen"] animated:YES];
                [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"LogInDoneSeller"];
                [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"LogInDoneBuyer"];


            }
            [[NSUserDefaults standardUserDefaults]setValue:grpID forKey:@"groupID"];

        }
        else {
            
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"Alert!"
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


-(BOOL) textFieldShouldReturn:(ACFloatingTextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Keyboard methods

// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.signupScrollView.contentInset = contentInsets;
    self.signupScrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, self.activeTextField.frame.origin) ) {
        [self.signupScrollView scrollRectToVisible:self.activeTextField.frame animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.signupScrollView.contentInset = contentInsets;
    self.signupScrollView.scrollIndicatorInsets = contentInsets;
    
    CGPoint scrollPoint = CGPointMake(0.0, 0.0);
    [self.signupScrollView setContentOffset:scrollPoint animated:YES];
    self.activeTextField = nil;
}

#pragma mark - Text Field Delegates
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    self.activeTextField = textField;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    self.activeTextField = nil;
}

- (IBAction)backBtnActn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (IBAction)btnAction:(UIButton*)sender {
    
    switch (sender.tag) {
        case 1:
        {
            [_buyerBtn setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
            [_sellerBtn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
            self.paypayImg.hidden = YES;
            [self.paypalEmailTF setHidden:true];
            grpID = @"3";

        }

            break;
        case 2:
        {
            [_buyerBtn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
            [_sellerBtn setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
            self.paypayImg.hidden = NO;
            [self.paypalEmailTF setHidden:false];
            grpID = @"2";


        }
            
            break;
        default:
            break;
    }

}
@end
