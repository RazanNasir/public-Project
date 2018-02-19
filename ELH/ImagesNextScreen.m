//
//  ImagesNextScreen.m
//  ELH
//
//  Created by Shashi on 26/07/17.
//  Copyright © 2017 Shashi. All rights reserved.
//

#import "ImagesNextScreen.h"

@interface ImagesNextScreen () {
    
    MBProgressHUD *hud;
    BOOL isMovingFrom, isMovingTo;
    NSMutableArray *imageArrayName;
    UIImage *img1, *img2, *img3;

}

@end

@implementation ImagesNextScreen
@synthesize imageArray;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.descriptionTV.layer.borderWidth = 1.0f;
    self.descriptionTV.layer.cornerRadius = 8;
    self.descriptionTV.layer.borderColor = [[UIColor grayColor] CGColor];
    
    [self.imageDataScroll setContentSize:CGSizeMake(self.imageDataScroll.frame.size.width, self.descriptionTV.frame.origin.y + self.descriptionTV.frame.size.height + 10)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated {
    
    [self registerForKeyboardNotifications];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)doneClicked:(id)sender
{
    NSLog(@"Done Clicked....");
    [self.phoneTF resignFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
   
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return FALSE;
    }
    return TRUE;
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

- (void)textFieldDidBeginEditing:(UITextView *)textField {
    
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(doneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    
    self.phoneTF.inputAccessoryView = keyboardDoneButtonView;
    self.activeTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextView *)textField {
    
    self.activeTextField =  nil;
}

- (IBAction)backBtnActn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (IBAction)nextBtnActn:(id)sender{
    
    [self checkValidation];
}

-(void)checkValidation {
    
    if ([self.userNameTF.text isEqualToString:@""]) {
        [self.userNameTF showError];
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
                
                if ([self.movingFromTF.text isEqualToString:@""]) {
                    [self.movingFromTF showError];
                }
                else {
                    
                    if ([self.movingToTF.text isEqualToString:@""]) {
                        [self.movingToTF showError];
                    }
                    else {
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
//                            [self newWebservice];
                            imageArrayName =[[NSMutableArray alloc]init];

                            for (int i =1; i<imageArray.count+1; i++) {
                                
                                [imageArrayName addObject:[NSString stringWithFormat:@"img%d",i ]];
                            }
                            NSLog(@"images name %@",imageArrayName);
//                            img1 = [UIImage imageNamed:@"img1.png"];
//                            img2 = [UIImage imageNamed:@"img2.png"];
//                            img3 = [UIImage imageNamed:@"img3.png"];
//                            imageArray = [[NSMutableArray alloc] initWithObjects:img1,img2,img3, nil];
//                            imageArrayName = [[NSMutableArray alloc] initWithObjects:@"img1.png",@"img2.png",@"img3.png", nil];
                            // Do any additional setup after loading the view, typically from a nib.
                            [self creatNewAlbum:imageArray withNames:imageArrayName];


                        });
                    }
                }
            }
        }
    }
}

-(void)creatNewAlbum:(NSMutableArray *)arr_images withNames:(NSMutableArray *)arr_imageNames{
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"Loading";
        [hud show:YES];
    
    
    NSString *serverUrl =[NSString stringWithFormat:@"%@%@",BASE_URL,MOVERS];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:serverUrl]];
    //[NSString stringWithFormat:@"AlbumName_%@",[formatter stringFromDate:[NSDate date]]]
    
   NSMutableDictionary *dicParamsToSend = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.userNameTF.text,@"uname",self.emailTF.text,@"email",self.phoneTF.text,@"mob",self.movingFromTF.text,@"from",self.movingToTF.text,@"to",self.descriptionTV.text,@"desc", nil];
    
//     NSMutableDictionary *dicParamsToSend = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"himanshu",@"uname",@"himan@gmail.com",@"email",@"5464545552",@"mob",@"Noida",@"from",@"Delhi",@"to",@"my product",@"desc", nil];
    
    AFHTTPRequestOperation *op = [manager POST:@"rest.of.url" parameters:dicParamsToSend constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //do not put image inside parameters dictionary as I did, but append it!
        int i = 0;
        for(UIImage *eachImage in arr_images)
        {
            NSData *imageData = UIImageJPEGRepresentation(eachImage,1);
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"images[%d]",i ] fileName:[NSString stringWithFormat:@"%@",[arr_imageNames objectAtIndex:i]] mimeType:@"image/jpeg"];
            i++;
        }
        NSLog(@"the data to be sent is %@", formData);
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
        
        if ([[responseObject valueForKey:@"status"]boolValue] == true) {
            
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"Successfully Uploaded"
                                                  message:@"An ELH Moving Associate will call you to finalize the details."
                                                  preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
                [hud hide:YES];
                [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"FirstViewScreen"] animated:NO];
            
            }];
            
            [alertController addAction:firstAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
            [hud hide:YES];
        }
        
        else {
            
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"Error!"
                                                  message:[responseObject valueForKey:@"message"]
                                                  preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
                [hud hide:YES];
            }];
            [alertController addAction:firstAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
            [hud hide:YES];
        }
    }
                                       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                           
                                           NSLog(@"Error: %@ ***** %@", operation.responseString, error);
                                           [hud hide:YES];                                       }];
    
    
    [op setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        
        //[progressView setProgress: totalBytesWritten*1.0f / totalBytesExpectedToWrite animated: YES];
        //  NSLog(@"Sent %lld of %lld bytes and progress is %f", totalBytesWritten, totalBytesExpectedToWrite, totalBytesWritten*1.0f /  totalBytesExpectedToWrite);
        if(totalBytesWritten >= totalBytesExpectedToWrite)
        {
            //progressView.hidden = YES;
        }
    }];
    
    
    [op start];
}

//-(void)showAlertWithMessage:(NSString*)msg andTitle:(NSString *)title{
//    UIAlertController *alertController = [UIAlertController
//                                          alertControllerWithTitle:title
//                                          message:msg
//                                          preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"OK"
//                                                          style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
//                                                              [hud hide:YES];
//                                                          }];
//    [alertController addAction:firstAction];
//    [self presentViewController:alertController animated:YES completion:nil];
//}
//-(void) newWebservice{
////    
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.userNameTF.text,@"uname",self.emailTF.text,@"email",self.phoneTF.text,@"mob",self.movingFromTF.text,@"from",self.movingToTF.text,@"to",self.descriptionTV.text,@"desc",imageData,@"images", nil];
//    UIImage *image = [UIImage imageNamed:@"test.jpg"];
//    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
//
//    UIImage *image2 = [UIImage imageNamed:@"test.jpg"];
//    NSData *imageData2 = UIImageJPEGRepresentation(image2, 0.5);
//    
//    //Now add to array and also create array of images data
//    NSArray *arrImagesData = [NSArray arrayWithObjects:imageData,imageData2,nil];
//    
////    UIImage *image1 = [UIImage imageNamed:@"test.jpg"];
////    UIImage *image2 = [UIImage imageNamed:@"test.jpg"];
////    imageArray = @[image1,image2];
//    NSDictionary *aImageDic;
//    
////    NSData *imageData ;
//    for(UIImage *eachImage in imageArray)
//    {
//        imageData = UIImageJPEGRepresentation(eachImage,0.5);
//         aImageDic= [[NSDictionary alloc]initWithObjectsAndKeys:imageData,@"images", nil]; // It's contains multiple image data as value and a image name as key
//
//    }
//    
//    NSDictionary * dic ;
//    NSString *urlString  =  [NSString stringWithFormat:@"%@%@",BASE_URL,MOVERS];
//    NSLog(@"url string : %@",urlString);
//    NSString *returnString;
//    NSDictionary *aParametersDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:self.userNameTF.text,@"uname",self.emailTF.text,@"email",self.phoneTF.text,@"mob",self.movingFromTF.text,@"from",self.movingToTF.text,@"to",self.descriptionTV.text,@"desc", nil];
//    // It's contains other parameters.
////    NSString *urlString =[NSString stringWithFormat:@"%@%@",BASE_URL,MOVERS]; // an url where the request to be posted
//    
//    
//    NSURL *url = [NSURL URLWithString:urlString];
//    NSMutableURLRequest *request= [[NSMutableURLRequest alloc] initWithURL:url] ;
//    
//    [request setURL:[NSURL URLWithString:urlString]];
//    [request setHTTPMethod:@"POST"];
//    NSString *boundary = @"---------------------------14737809831466499882746641449";
//    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
//    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
//    
//    NSMutableData *postbody = [NSMutableData data];
//    NSString *postData = [self getHTTPBodyParamsFromDictionary:aParametersDic boundary:boundary];
//    [postbody appendData:[postData dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    [aImageDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        if(obj != nil)
//        {
//            [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"images\"; filetype=\"image/png\"; filename=\"%@\"\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
//            [postbody appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//            [postbody appendData:[NSData dataWithData:obj]];
//        }
//    }];
//    
//    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    [request setHTTPBody:postbody];
//    
//    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
//
//}

//-(NSString *) getHTTPBodyParamsFromDictionary: (NSDictionary *)params boundary:(NSString *)boundary
//{
//    NSMutableString *tempVal = [[NSMutableString alloc] init];
//    for(NSString * key in params)
//    {
//        [tempVal appendFormat:@"\r\n--%@\r\n", boundary];
//        [tempVal appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n%@",key,[params objectForKey:key]];
//    }
//    return [tempVal description];
//}


//-(void) webserviceForMovers {
//    
//    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.mode = MBProgressHUDModeIndeterminate;
//    hud.labelText = @"Loading";
//    [hud show:YES];
//    
//    NSString *urlString  =  [NSString stringWithFormat:@"%@%@",BASE_URL,MOVERS];
//    NSLog(@"url string : %@",urlString);
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//
// //   [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
////    
////    [manager.requestSerializer setValue:@"application/form-data" forHTTPHeaderField:@"Content-Type"];
//    
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//
//    // you can use different serializer for response.
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    UIImage *image1 = [UIImage imageNamed:@"test.jpg"];
//    UIImage *image2 = [UIImage imageNamed:@"test.jpg"];
//    imageArray = @[image1,image2];
//    
//    
//    NSData *imageData ;
//    for(UIImage *eachImage in imageArray)
//    {
//    imageData = UIImageJPEGRepresentation(eachImage,0.5);
//    }
//
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.userNameTF.text,@"uname",self.emailTF.text,@"email",self.phoneTF.text,@"mob",self.movingFromTF.text,@"from",self.movingToTF.text,@"to",self.descriptionTV.text,@"desc",imageData,@"images", nil];
//    
//    NSLog(@"params %@",parameters);
////    int i;
//    
////    for(i=0;i<[imageArray count];i++)
////    {
////        [parameters setObject:imageArray[i] forKey:@"images"];
////    }
////    
////    NSLog(@"params : %@", parameters);
//    
//
//    
////    NSDictionary *parameters = @{@"uname": self.userNameTF.text, @"email": self.emailTF.text, @"mob": self.phoneTF.text, @"from": self.movingFromTF.text, @"to": self.movingToTF.text, @"desc": self.descriptionTV.text:@"":NSArray arrayWithObjects:@"1",@"2",@"3",nil]};
//    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
////        
//        int i = 0;
//        for(UIImage *eachImage in imageArray)
//        {
//            [responseObject appendPartWithFileData:imageData name:@"images" fileName:[NSString stringWithFormat:@"file%d.jpg",i ] mimeType:@"image/jpeg"];
//            i++;
//        }
////
//        //        [responseObject appendPartWithFileURL:fileURL name:@"photo_url" fileName:filename mimeType:@"image/png" error:nil];
//        //
//        //        [responseObject appendPartWithFileData:data name:@"Photos[1]" fileName:@"avatar.jpg" mimeType:@"image/jpeg"];
//        //        [responseObject appendPartWithFileData:data name:@"Photos[2]" fileName:@"avatar.jpg" mimeType:@"image/jpeg"];
//        
//        
//        //Sample logic to check login status
//        
//        NSDictionary*responseDic=(NSDictionary*)responseObject;
//        
//        NSLog(@"Result movers %@",responseDic);
//        
//        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//        dict = [responseDic valueForKey:@"message"];
//        [[NSUserDefaults standardUserDefaults]setValue:[dict valueForKey:@"id"] forKey:@"UserID"];
//        [hud hide:YES];
//        if ([[responseDic valueForKey:@"status"]boolValue] == true) {
//            
//            //                [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"SellerDashboardScreen"] animated:YES];
//            //
//            
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
//        UIAlertController *alertController = [UIAlertController
//                                              alertControllerWithTitle:@"SUCCESS!"
//                                              message:@"Successfully upload!"
//                                              preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"OK"
//                                                              style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
//                                                                  [hud hide:YES];
//                                                                  [self.navigationController popViewControllerAnimated:TRUE];
//                                                              }];
//        [alertController addAction:firstAction];
//        [self presentViewController:alertController animated:YES completion:nil];
//    }];
//
// 
//    
//}

@end
