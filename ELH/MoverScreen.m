//
//  MoverScreen.m
//  ELH
//
//  Created by Shashi on 24/07/17.
//  Copyright © 2017 Shashi. All rights reserved.
//

#import "MoverScreen.h"

@interface MoverScreen ()<UINavigationControllerDelegate>
{
    NSMutableArray *imageArray;
}
@end

@implementation MoverScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    imageArray =[[NSMutableArray alloc]init];
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
    
}

- (IBAction)deleteButtonAction:(id)sender {
    
//    self.choosedImage.image = [UIImage imageNamed:@""];
//    UIImageWriteToSavedPhotosAlbum(self.choosedImage.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);

}

- (IBAction)backButtonMovers:(id)sender {
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"CameFromMenu"] isEqualToString:@"YES"]) {
        [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"FirstViewScreen"] animated:YES];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)addImageBtnActn:(id)sender {
    
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
    
    if (imageArray != nil) {
        ImagesNextScreen *completedVC = [[self storyboard] instantiateViewControllerWithIdentifier:@"ImagesNextScreen"];
        completedVC.imageArray = imageArray;
        [self.navigationController pushViewController:completedVC animated:YES];
        
    }
    else
    {
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Error!"
                                              message:@"Please add image."
                                              preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
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
    imageView.image =[imageArray objectAtIndex:indexPath.row];
    
    
    UIButton *deleteBtn =(UIButton*)[cell.contentView viewWithTag:2];
    [deleteBtn addTarget:self action:@selector(yourButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"Selected index is : %ld", (long)indexPath.row);
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *pickedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(pickedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        
        self.choosedImage.image = pickedImage;
    }
    else {
        self.choosedImage.image = pickedImage;
    }
    
    [imageArray addObject:pickedImage];
    
    [self.collectionView reloadData];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{

    NSLog(@"error in saving pic");
}
-(void)yourButtonClicked:(UIButton*)sender
{
    
//    UITableViewCell *cell = (UITableViewCell*)[[sender superview] superview];
    
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[self.collectionView convertPoint:sender.center fromView:sender.superview]];

    
    NSLog(@"index path %ld",(long)indexPath.row);
    
    [imageArray removeObjectAtIndex:indexPath.row];
    [self.collectionView reloadData];

    
}
  
@end
