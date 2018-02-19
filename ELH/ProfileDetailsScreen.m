//
//  ProfileDetailsScreen.m
//  ELH
//
//  Created by Shashi on 26/09/17.
//  Copyright © 2017 Razan Nasir. All rights reserved.
//

#import "ProfileDetailsScreen.h"

@interface ProfileDetailsScreen ()
{
    MBProgressHUD *hud;
    
}
@end

@implementation ProfileDetailsScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    [self webServiceTogetUserData];
    
    
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

- (IBAction)updateButtonAction:(id)sender {
}

- (IBAction)BackButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];

}

-(void)webServiceTogetUserData
{
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    [hud show:YES];
    
    NSString *urlString  =  [NSString stringWithFormat:@"%@%@",BASE_URL,USER_DATA];
    NSLog(@"url string : %@",urlString);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    // you can use different serializer for response.
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    NSDictionary *parameters = @{@"user_id": [[[NSUserDefaults standardUserDefaults]valueForKey:@"UserID"]objectAtIndex:0]};
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //Sample logic to check login status
        
        NSDictionary*responseDic=(NSDictionary*)responseObject;
        
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        dict = [responseDic valueForKey:@"message"];
        [hud hide:YES];
        if ([[responseDic valueForKey:@"status"]boolValue] == true) {
            NSLog(@"Result %@",[responseDic valueForKey:@"message"]);
            self.nameTF.text =[[[responseDic valueForKey:@"message"]valueForKey:@"username"]objectAtIndex:0];
            self.emailTF.text =[[[responseDic valueForKey:@"message"]valueForKey:@"email"]objectAtIndex:0];
            self.phoneTF.text =[[[responseDic valueForKey:@"message"]valueForKey:@"phone"]objectAtIndex:0];


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
