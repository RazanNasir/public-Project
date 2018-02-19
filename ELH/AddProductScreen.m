//
//  AddProductScreen.m
//  ELH
//
//  Created by odbase on 26/7/2017.
//  Copyright © 2017 Shashi. All rights reserved.
//

#import "AddProductScreen.h"

@interface AddProductScreen () {
    MBProgressHUD *hud;
    NSMutableDictionary *dict;
    NSString *categoryId;
}

@end

@implementation AddProductScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.descriptionTV.layer.borderWidth = 1.0f;
    self.descriptionTV.layer.cornerRadius = 8;
    self.descriptionTV.layer.borderColor = [[UIColor grayColor] CGColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
//    [self CallWebService];
}
-(void) viewWillAppear:(BOOL)animated {
    
    [self registerForKeyboardNotifications];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return FALSE;
    }
    return TRUE;
}

- (void)textFieldDidBeginEditing:(UITextView *)textField {
    
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(doneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    
    self.priceTF.inputAccessoryView = keyboardDoneButtonView;
    self.activeTextField = textField;
}

- (IBAction)doneClicked:(id)sender
{
    NSLog(@"Done Clicked....");
    [self.priceTF resignFirstResponder];
}


- (void)textFieldDidEndEditing:(UITextView *)textField {
    
    self.activeTextField =  nil;
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
    self.imageDataScroll.contentInset = contentInsets;
    self.imageDataScroll.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, self.activeTextField.frame.origin) ) {
        [self.imageDataScroll scrollRectToVisible:self.activeTextField.frame animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.imageDataScroll.contentInset = contentInsets;
    self.imageDataScroll.scrollIndicatorInsets = contentInsets;
    
    CGPoint scrollPoint = CGPointMake(0.0, 0.0);
    [self.imageDataScroll setContentOffset:scrollPoint animated:YES];
    self.activeTextField = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectProductAction:(id)sender {
    
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:nil      //  Must be "nil", otherwise a blank title area will appear above our two buttons
                                message:nil
                                preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleCancel
                             handler:^(UIAlertAction * action)
                             {
                                 //  UIAlertController will automatically dismiss the view
                             }];
    
    UIAlertAction *bedroomFurniture = [UIAlertAction
                             actionWithTitle:@"Bedroom Furniture"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 self.bedroomFurnitureTF.text = @"Bedroom Furniture";
                                 categoryId = @"1";
                             }];
    
    UIAlertAction *livingRoomFurniture = [UIAlertAction
                                actionWithTitle:@"Living Room Furniture"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    self.bedroomFurnitureTF.text = @"Living Room Furniture";
                                    categoryId = @"2";

                                }];
    UIAlertAction *accessoriesFurniture = [UIAlertAction
                                        actionWithTitle:@"Accessories Furniture"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action)
                                        {
                                            self.bedroomFurnitureTF.text = @"Accessories Furniture";
                                            categoryId = @"3";

                                        }];
    
    [alert addAction:cancel];
    [alert addAction:bedroomFurniture];
    [alert addAction:livingRoomFurniture];
    [alert addAction:accessoriesFurniture];

    [self presentViewController:alert animated:YES completion:nil];
    
}
- (IBAction)nextBtnActn:(id)sender{

    NSArray *captionArray =[[NSArray alloc]init];
    NSString *userID =[[NSUserDefaults standardUserDefaults]valueForKey:@"UserID"];
    NSMutableDictionary *dicParamsToSend = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.productTF.text,@"product_name",self.priceTF.text,@"price",self.descriptionTV.text,@"description", categoryId,@"category_id",@"1",@"is_new",captionArray,@"caption",userID,@"user_id",@"2",@"years_old", nil];
    NSLog(@"dicParamsToSend %@", dicParamsToSend);
    
   AddImageSellerScreen *SellerScreen = [[self storyboard] instantiateViewControllerWithIdentifier:@"AddImageSellerScreen"];
    SellerScreen.addProductDict = dicParamsToSend ;
    [self.navigationController pushViewController:SellerScreen animated:YES];

}
- (IBAction)backBtnActn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:TRUE];
}


//-(void)CallWebService {
//    
//    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.mode = MBProgressHUDModeIndeterminate;
//    hud.labelText = @"Loading";
//    [hud show:YES];
//    
//    NSString *urlString  =  [NSString stringWithFormat:@"%@%@",BASE_URL,CATEGORY_LIST];
//    NSLog(@"url string : %@",urlString);
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
//    
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    
//    // you can use different serializer for response.
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    
//    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        //Sample logic to check login status
//        
//        NSDictionary*responseDic=(NSDictionary*)responseObject;
//        
//        NSLog(@"Result category list :%@",[responseDic valueForKey:@"message"]);
//        
//        dict = [[NSMutableDictionary alloc]init];
//        dict = [responseDic valueForKey:@"message"];
//        [hud hide:YES];
//        if ([[responseDic valueForKey:@"status"]boolValue] == true) {
//            
//            
//            //                [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"SellerDashboardScreen"] animated:YES];
//            
////            [self.collectionView reloadData];
//        }
//        else {
//            
//            UIAlertController *alertController = [UIAlertController
//                                                  alertControllerWithTitle:@"Error!"
//                                                  message:[responseDic valueForKey:@"Message"]
//                                                  preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"OK"
//                                                                  style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
//                                                                      [hud hide:YES];
//                                                                  }];
//            [alertController addAction:firstAction];
//            [self presentViewController:alertController animated:YES completion:nil];
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//        [hud hide:YES];
//    }];
//}


@end
