//
//  AddImageSellerScreen.m
//  ELH
//
//  Created by odbase on 26/7/2017.
//  Copyright © 2017 Shashi. All rights reserved.
//

#import "AddImageSellerScreen.h"

@interface AddImageSellerScreen ()<UINavigationControllerDelegate,UITextFieldDelegate>
{
    NSMutableArray *imageArray,*captionArray;
    MBProgressHUD *hud;
    NSMutableArray *imageArrayName;
    UIImage *img1, *img2, *img3;
    UIImage *pickedImage;
    BOOL top,botttom,left,right;
    
}

@end

@implementation AddImageSellerScreen
@synthesize addProductDict;

- (void)viewDidLoad {
    [super viewDidLoad];
    imageArray =[[NSMutableArray alloc]init];
    captionArray =[[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
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
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillAppear:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillDisappear:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:(BOOL)animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Keyboard appearance/disappearance handling

- (void)keyboardWillAppear:(NSNotification *)notification
{
  
    
}
- (void)keyboardWillDisappear:(NSNotification *)notification
{
    
    
}

- (IBAction)backButtonMovers:(id)sender {
    
    [self.navigationController popViewControllerAnimated:TRUE];
    
}

- (void)addImage

{
    
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
    
    UIAlertAction *takePhoto = [UIAlertAction
                                actionWithTitle:@"Take Photo"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    UIImagePickerController *imagePickerController= [[UIImagePickerController alloc] init];
                                    imagePickerController.delegate = self;
                                    imagePickerController.allowsEditing = YES;
                                    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                                    
                                    [self presentViewController:imagePickerController animated:YES completion:^{
                                    }];
                                }];
    UIAlertAction *chooseFromLibrary = [UIAlertAction
                                        actionWithTitle:@"Choose From Library"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action)
                                        {
                                            UIImagePickerController *imagePickerController= [[UIImagePickerController alloc] init];
                                            imagePickerController.delegate = self;
                                            imagePickerController.allowsEditing = YES;
                                            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                            
                                            [self presentViewController:imagePickerController animated:YES completion:^{}];
                                        }];
    
    [alert addAction:cancel];
    [alert addAction:takePhoto];
    [alert addAction:chooseFromLibrary];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (IBAction)nextBtnActn:(id)sender {
    
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
    if (imageArray.count != 0) {
        [self creatNewAlbum:imageArray withNames:imageArrayName];

    }
    else
    {
        
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Error!"
                                          message:@"Please add images."
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"OK"
                                                          style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
//                                                              [hud hide:YES];

                                                          }];
    [alertController addAction:firstAction];
    [self presentViewController:alertController animated:YES completion:nil];
    }

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"imageCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *imageView =(UIImageView*)[cell.contentView viewWithTag:1];
    UILabel *captionLbl =(UILabel*)[cell.contentView viewWithTag:2];
    
    captionLbl.text = [captionArray objectAtIndex:indexPath.row];
    //    self.choosedImage = imageView;
    
    imageView.image =[imageArray objectAtIndex:indexPath.row];
    
    //    self.choosedImage = (UIImageView *)[cell viewWithTag:1];
//    self.imageViewCaption.hidden = NO;

    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"Selected index is : %ld", (long)indexPath.row);
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    pickedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(pickedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        if (top) {
            self.topImageLbl.text = @"Top View";
            self.topImageView.image = pickedImage;
            [captionArray addObject:self.topImageLbl.text];

        }
        else if (botttom) {
            self.bottomImageLbl.text = @"Bottom View";
            self.bottomImageView.image = pickedImage;
            [captionArray addObject:self.bottomImageLbl.text];

        }
        else if (left) {
            self.leftImageLbl.text = @"Left View";
            self.leftImageView.image = pickedImage;
            [captionArray addObject:self.leftImageLbl.text];

        }else {
            self.rightImageLbl.text = @"Right View";
            self.rightImageView.image = pickedImage;
            [captionArray addObject:self.rightImageLbl.text];

        }
    }
    else {
        if (top) {
            self.topImageLbl.text = @"Top View";
            self.topImageView.image = pickedImage;
            [captionArray addObject:self.topImageLbl.text];

        }
        else if (botttom) {
            self.bottomImageLbl.text = @"Bottom View";
            self.bottomImageView.image = pickedImage;
            [captionArray addObject:self.bottomImageLbl.text];
            
        }
        else if (left) {
            self.leftImageLbl.text = @"Left View";
            self.leftImageView.image = pickedImage;
            [captionArray addObject:self.leftImageLbl.text];
            
        }else {
            self.rightImageLbl.text = @"Right View";
            self.rightImageView.image = pickedImage;
            [captionArray addObject:self.rightImageLbl.text];
            
        }
    }
    
    [imageArray addObject:pickedImage];
    NSLog(@"picked array %@",imageArray);
    NSLog(@"caption array %@",captionArray);

    [picker dismissViewControllerAnimated:YES completion:NULL];

}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    NSLog(@"error in saving pic");
}


#pragma mark - add images

-(void)creatNewAlbum:(NSMutableArray *)arr_images withNames:(NSMutableArray *)arr_imageNames{
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    [hud show:YES];
    
    NSString *serverUrl =[NSString stringWithFormat:@"%@%@",BASE_URL,UPLOAD_PRODUCTS];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:serverUrl]];
    //[NSString stringWithFormat:@"AlbumName_%@",[formatter stringFromDate:[NSDate date]]]
    
    
    [addProductDict setValue:captionArray forKey:@"caption"];
    NSLog(@"addProductDict %@", addProductDict);

//    NSMutableDictionary *dicParamsToSend = [NSMutableDictionary dictionaryWithObjectsAndKeys:[addProductDict valueForKey:@"qwerty"],@"product_name",[addProductDict valueForKey:@"description"], @"description", [addProductDict valueForKey:@"price"],@"price",@"1",@"is_new",@"",@"caption",[addProductDict valueForKey:@"category_id"],@"category_id",,nil];
    
//    NSLog(@"addProductDict %@", dicParamsToSend);
    
    AFHTTPRequestOperation *op = [manager POST:@"rest.of.url" parameters:addProductDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
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
         [hud hide:YES];
        NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
        if ([[responseObject valueForKey:@"status"]boolValue] == true) {
            
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"Successfully Uploaded"
                                                  message:@"Thanks for uploading your product. You will get a confirmation within 24 hours."
                                                  preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
                [hud hide:YES];
                [self.navigationController popViewControllerAnimated:TRUE];
                [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"SellerDashboardScreen"] animated:NO];

                
            }];
            
            [alertController addAction:firstAction];
            [self presentViewController:alertController animated:YES completion:nil];
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
                                           [hud hide:YES];
                                       }];
    
    
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
- (IBAction)setBtnAction:(id)sender {
//    self.imageViewCaption.hidden = YES;
//    [captionArray addObject:self.captionTF.text];
//    [imageArray addObject:pickedImage];
//    
//    [self.collectionView reloadData];

    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)buttonAction:(UIButton*)sender {
    NSLog(@"button clicked tag %ld",sender.tag);
    switch (sender.tag) {
        case 1:
        {
            top = YES;
            botttom = NO;
            left = NO;
            right = NO;
            [self addImage];

        }
            break;
        case 2:
        {
            top = NO;
            botttom = YES;
            left = NO;
            right = NO;
            [self addImage];

            
        }
            break;
        case 3:
        {
            top = NO;
            botttom = NO;
            left = YES;
            right = NO;
            [self addImage];

            
        }
            break;
        case 4:
        {
            top = NO;
            botttom = NO;
            left = NO;
            right = YES;
            [self addImage];

            
        }
            break;

        default:
            break;
    }
}
@end
