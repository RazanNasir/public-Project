//
//  MoverScreen.h
//  ELH
//
//  Created by Shashi on 24/07/17.
//  Copyright © 2017 Shashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagesNextScreen.h"
#import "SWRevealViewController.h"

@interface MoverScreen : UIViewController <UIImagePickerControllerDelegate>


@property (weak, nonatomic) UIImageView *choosedImage;;
- (IBAction)deleteButtonAction:(id)sender;
- (IBAction)backButtonMovers:(id)sender;
- (IBAction)addImageBtnActn:(id)sender;
- (IBAction)nextBtnActn:(id)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
