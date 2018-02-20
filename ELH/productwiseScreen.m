//
//  productwiseScreen.m
//  ELH
//
//  Created by Razan Nasir on 8/15/17.
//  Copyright © 2017 Razan. All rights reserved.
//

#import "productwiseScreen.h"

@interface productwiseScreen ()
{
    NSArray *userPhotos;
    UIImageView *imageView;
    MBProgressHUD *hud;
    NSMutableDictionary *dict;
    NSInteger quantyCount,totalprice;
}

@end

@implementation productwiseScreen
@synthesize productID;

- (void)viewDidLoad {
    [super viewDidLoad];
    [_scrollView setContentSize:(CGSizeMake(320,800))];

    NSLog(@"product ID %@",productID);
    
//    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"LogInDoneBuyer"];
    
//    if ([productID isEqual:[NSNull null]]) {
//        productID = [[NSUserDefaults standardUserDefaults] valueForKey:@"productID"];
//    }
    if ([productID intValue] == 0) {
        productID = [[NSUserDefaults standardUserDefaults] valueForKey:@"productID"];
    }
    NSLog(@"product ID %d",[productID intValue]);
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    [self CallWebService];
    
//     Set up payPalConfig
    _payPalConfig = [[PayPalConfiguration alloc] init];
    _payPalConfig.acceptCreditCards = NO;
    _payPalConfig.merchantName = @"Awesome Shirts, Inc.";
    _payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
    _payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
    
    // Setting the languageOrLocale property is optional.
    //
    // If you do not set languageOrLocale, then the PayPalPaymentViewController will present
    // its user interface according to the device's current language setting.
    //
    // Setting languageOrLocale to a particular language (e.g., @"es" for Spanish) or
    // locale (e.g., @"es_MX" for Mexican Spanish) forces the PayPalPaymentViewController
    // to use that language/locale.
    //
    // For full details, including a list of available languages and locales, see PayPalPaymentViewController.h.
    
    _payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
    
    
    // Setting the payPalShippingAddressOption property is optional.
    //
    // See PayPalConfiguration.h for details.
    
    _payPalConfig.payPalShippingAddressOption = PayPalShippingAddressOptionPayPal;
    
    // Do any additional setup after loading the view, typically from a nib.
    
    //    self.successView.hidden = YES;
    
    // use default environment, should be Production in real life
    self.environment = kPayPalEnvironment;
    
    NSLog(@"PayPal iOS SDK version: %@", [PayPalMobile libraryVersion]);
}

-(void)viewWillAppear:(BOOL)animated
{
    quantyCount = [self.quantityLabel.text integerValue];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)CallWebService {
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    [hud show:YES];
    
    NSString *urlString  =  [NSString stringWithFormat:@"%@%@",BASE_URL,PRODUCTWISE_LIST];
    NSLog(@"url string : %@",urlString);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSDictionary *parameters = @{@"product_id":productID};
    
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //Sample logic to check login status
        
        [hud hide:YES];
        
        NSDictionary*responseDic=(NSDictionary*)responseObject;
        
        NSLog(@"Result newly added %@",[[responseDic valueForKey:@"message"] objectAtIndex:0]);
        
        dict = [[NSMutableDictionary alloc]init];
        dict = [[responseDic valueForKey:@"message"] objectAtIndex:0];
        userPhotos =[[dict valueForKey:@"images"]valueForKey:@"image_url"];
        [hud hide:YES];
        if ([[responseDic valueForKey:@"status"]boolValue] == true) {
          [hud hide:YES];
            
            totalprice =[[dict valueForKey:@"price"] floatValue]*quantyCount;

            ALScrollViewPaging *scrollView = [[ALScrollViewPaging alloc] initWithFrame:CGRectMake(0,60, self.view.frame.size.width,self.view.frame.size.height/2.5)];

            NSMutableArray *views = [[NSMutableArray alloc] init];

            for (int i = 0; i < userPhotos.count; i++) {
               
                imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.frame.size.width,self.scrollView.frame.size.height/2)];
                [imageView setBackgroundColor:[UIColor whiteColor]];
                [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASE_URL,[userPhotos objectAtIndex:i]]]
                             placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
                
                [views addObject:imageView];
            }
            [scrollView addPages:views];
            
            //add scrollview to the view
            [self.scrollView addSubview:scrollView];
            [scrollView setHasPageControl:YES];

            self.productNameLbl.text =[dict valueForKey:@"product_name"];
            self.productPriceLbl.text =[NSString stringWithFormat:@"$ %@",[dict valueForKey:@"price"]];
            self.productDescLbl.text =[dict valueForKey:@"description"];
            [self.productDescLbl sizeToFit];
            [self.productNameLbl sizeToFit];

            

            
        }
        else {
            [hud hide:YES];
            
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
- (IBAction)addToBagAction:(id)sender {
    
//    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"AddToCartScreen"] animated:YES];
//
    [[NSUserDefaults standardUserDefaults]setValue:@"productScreen" forKey:@"isComingFrom"];
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"LogInDoneBuyer"] isEqualToString:@"YES"] || [[[NSUserDefaults standardUserDefaults] valueForKey:@"LogInDoneSeller"] isEqualToString:@"YES"] ) {
        [self CallWebServicePayment];
        }
    else  {
        [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"sellerLoginScreen"] animated:YES];

        }

}

- (IBAction)back:(id)sender {
    
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"BuyerSceen"] animated:YES];
}

- (IBAction)plusAction:(id)sender {
    
    int price = [[dict valueForKey:@"price"] intValue];

    if (quantyCount != 5){
        quantyCount++;
    }
    else {
        quantyCount = 5;
    }
    self.quantityLabel.text =[NSString stringWithFormat:@"%ld",(long)quantyCount];
    totalprice = [[dict valueForKey:@"price"] floatValue]*quantyCount;
    self.productPriceLbl.text =[NSString stringWithFormat:@"$ %ld",(long)totalprice];}

- (IBAction)minusAction:(id)sender {
    
    if (quantyCount != 1){
        quantyCount--;
    }
    else{
        quantyCount = 1;
    }
    self.quantityLabel.text =[NSString stringWithFormat:@"%ld",(long)quantyCount];
    totalprice = [[dict valueForKey:@"price"] floatValue]*quantyCount;
    self.productPriceLbl.text =[NSString stringWithFormat:@"$ %ld",(long)totalprice];
}

#pragma mark PayPalPaymentDelegate methods

- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
    NSLog(@"PayPal Payment Success!");
    self.resultText = [completedPayment description];
    //    [self showSuccess];?
    
    
    [self sendCompletedPaymentToServer:completedPayment]; // Payment was processed successfully; send to server for verification and fulfillment
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    NSLog(@"PayPal Payment Canceled");
    self.resultText = nil;
    //    self.successView.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Proof of payment validation

- (void)sendCompletedPaymentToServer:(PayPalPayment *)completedPayment {
    // TODO: Send completedPayment.confirmation to server
    NSLog(@"Here is your proof of payment:\n\n%@\n\nSend this to your server for confirmation and fulfillment.", completedPayment.confirmation);
}


#pragma mark - Authorize Future Payments

- (IBAction)getUserAuthorizationForFuturePayments:(id)sender {
    
    PayPalFuturePaymentViewController *futurePaymentViewController = [[PayPalFuturePaymentViewController alloc] initWithConfiguration:self.payPalConfig delegate:self];
    [self presentViewController:futurePaymentViewController animated:YES completion:nil];
}


#pragma mark PayPalFuturePaymentDelegate methods

- (void)payPalFuturePaymentViewController:(PayPalFuturePaymentViewController *)futurePaymentViewController
                didAuthorizeFuturePayment:(NSDictionary *)futurePaymentAuthorization {
    NSLog(@"PayPal Future Payment Authorization Success!");
    self.resultText = [futurePaymentAuthorization description];
    //    [self showSuccess];
    
    [self sendFuturePaymentAuthorizationToServer:futurePaymentAuthorization];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalFuturePaymentDidCancel:(PayPalFuturePaymentViewController *)futurePaymentViewController {
    NSLog(@"PayPal Future Payment Authorization Canceled");
    //    self.successView.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendFuturePaymentAuthorizationToServer:(NSDictionary *)authorization {
    // TODO: Send authorization to server
    NSLog(@"Here is your authorization:\n\n%@\n\nSend this to your server to complete future payment setup.", authorization);
}


#pragma mark - Authorize Profile Sharing

- (IBAction)getUserAuthorizationForProfileSharing:(id)sender {
    
    NSSet *scopeValues = [NSSet setWithArray:@[kPayPalOAuth2ScopeOpenId, kPayPalOAuth2ScopeEmail, kPayPalOAuth2ScopeAddress, kPayPalOAuth2ScopePhone]];
    
    PayPalProfileSharingViewController *profileSharingPaymentViewController = [[PayPalProfileSharingViewController alloc] initWithScopeValues:scopeValues configuration:self.payPalConfig delegate:self];
    [self presentViewController:profileSharingPaymentViewController animated:YES completion:nil];
}


#pragma mark PayPalProfileSharingDelegate methods

- (void)payPalProfileSharingViewController:(PayPalProfileSharingViewController *)profileSharingViewController
             userDidLogInWithAuthorization:(NSDictionary *)profileSharingAuthorization {
    NSLog(@"PayPal Profile Sharing Authorization Success!");
    self.resultText = [profileSharingAuthorization description];
    //    [self showSuccess];
    
    [self sendProfileSharingAuthorizationToServer:profileSharingAuthorization];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"SUCCESS!"message:@"Payment done Successfully!"preferredStyle:UIAlertControllerStyleAlert];
UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"OK"style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
//    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"SellerDashboardScreen"] animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:firstAction];
//    [self presentViewController:alertController animated:YES completion:nil];
//    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)userDidCancelPayPalProfileSharingViewController:(PayPalProfileSharingViewController *)profileSharingViewController {
    NSLog(@"PayPal Profile Sharing Authorization Canceled");
    //    self.successView.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendProfileSharingAuthorizationToServer:(NSDictionary *)authorization {
    // TODO: Send authorization to server
    NSLog(@"Here is your authorization:\n\n%@\n\nSend this to your server to complete profile sharing setup.", authorization);
}


-(void)CallWebServicePayment {
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    [hud show:YES];
    
    NSString *urlString  =  [NSString stringWithFormat:@"%@%@",BASE_URL,PLACE_ORDER];
    NSLog(@"url string : %@",urlString);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    // you can use different serializer for response.
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSDictionary *parameters = @{@"customer_uid": [[NSUserDefaults standardUserDefaults]valueForKey:@"UserID"],@"seller_uid": [dict valueForKey:@"user_id"],@"product_id": [dict valueForKey:@"id"],@"quantity": @"1" ,@"pro_amount": [NSString stringWithFormat:@"%ld",(long)totalprice]};
    
    NSLog(@"parameters %@",parameters);
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //Sample logic to check login status
        [hud hide:YES];
        
        NSDictionary*responseDic=(NSDictionary*)responseObject;
        
        NSLog(@"Result newly added %@",[responseDic valueForKey:@"message"]);
        
        [hud hide:YES];
        if ([[responseDic valueForKey:@"status"]boolValue] == true) {
            
            WebViewPaymentViewController *SellerScreen = [[self storyboard] instantiateViewControllerWithIdentifier:@"WebViewPaymentViewController"];
            SellerScreen.webURL = [responseDic valueForKey:@"data"]  ;
            [self.navigationController pushViewController:SellerScreen animated:YES];
            
            
            //                [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"SellerDashboardScreen"] animated:YES];
            [hud hide:YES];
            
        }
        else {
            [hud hide:YES];
            
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
