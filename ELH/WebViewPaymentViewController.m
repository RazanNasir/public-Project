//
//  WebViewPaymentViewController.m
//  ELH
//
//  Created by Mac on 03/02/18.
//  Copyright © 2018 Razan Nasir. All rights reserved.
//

#import "WebViewPaymentViewController.h"

@interface WebViewPaymentViewController ()<UIWebViewDelegate>
{
MBProgressHUD *hud;
NSMutableDictionary *dict,*responseDic;
}
@end

@implementation WebViewPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *fullURL = _webURL;
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    _webView.delegate = self;
    [_webView loadRequest:requestObj];
    
    
    // Do any additional setup after loading the view.
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"shouldStartLoadWithRequest");
    NSLog(@"URL %@",[request URL]);
    //http://elh.khasrabrothers.in/1/24
    
    NSArray *items = [[[request URL] absoluteString] componentsSeparatedByString:@"/"];
    NSLog(@"string to match %@",[items objectAtIndex:3]);
    
    if ([[items objectAtIndex:3] isEqualToString:@"1"]) {
        [self callWebService:[items objectAtIndex:3] :[items objectAtIndex:4]];
        
       
    }
    else if([[items objectAtIndex:3] isEqualToString:@"0"])
    {
//        [self callWebService:[items objectAtIndex:3] :[items objectAtIndex:4]];
        
        [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"BuyerSceen"] animated:YES];

    }
    if([[[request URL] absoluteString] isEqualToString:@"https://www.sandbox.paypal.com/webscr?cmd=_ap-payment&paykey=AP-99S682643F2716135&order_status=0"]) {
        return NO;
    }
    return YES;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSeguegue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backAction:(id)sender {
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"LogInDoneBuyer"] isEqualToString:@"NO"] || [[NSUserDefaults standardUserDefaults] valueForKey:@"LogInDoneBuyer"] == nil ) { //Done by me for navigation of sign page from different views
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"productwiseScreen"] animated:YES];

    }
}

-(void)callWebService :(NSString*)status :(NSString*)orderID
{
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    [hud show:YES];
    
    NSString *urlString  =  [NSString stringWithFormat:@"%@",@"http://elh.khasrabrothers.in/api/elh/pay_status"];
    NSLog(@"url string : %@",urlString);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    // you can use different serializer for response.
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    NSDictionary *parameters = @{@"order_id":orderID,@"status":status};
    
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //Sample logic to check login status
        
        responseDic=(NSMutableDictionary*)responseObject;
        
        NSLog(@"Result %@",[responseDic valueForKey:@"message"]);
        
        dict = [[NSMutableDictionary alloc]init];
        dict = [responseDic valueForKey:@"message"];
        [hud hide:YES];
        if ([[responseDic valueForKey:@"status"]boolValue] == true) {
            
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"Success!"
                                                  message:[NSString stringWithFormat:@"Your order successful your order no. is %@",orderID]
                                                  preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Continue Shopping"
                                                                  style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
                                                                      [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"BuyerSceen"] animated:YES];

                                                                      [hud hide:YES];
                                                                  }];
            [alertController addAction:firstAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
            
            //                [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"SellerDashboardScreen"] animated:YES];
            
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
@end
