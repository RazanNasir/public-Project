//
//  BuyerSceen.m
//  ELH
//
//  Created by odbase on 25/7/2017.
//  Copyright © 2017 Shashi. All rights reserved.
//

#import "BuyerSceen.h"

@interface BuyerSceen ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray *userPhotos;
    MBProgressHUD *hud;
    NSMutableDictionary *dict,*dictCat;
}

@end

@implementation BuyerSceen

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    
//    [self.navigationItem.rightBarButtonItem.customView setAlpha:0.0]; //To hide navigation Bar
    
    [self.logOutButton setImage:nil];
//    [self.logOutButton setImage:[UIImage imageNamed:@"dots"]];// Uncomment to show view
    userPhotos = [[NSArray alloc]initWithObjects:@"bed",@"living",@"acce", nil];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];

//    SWRevealViewController *revealViewController = self.revealViewController;
//    if ( revealViewController )
//    {
//        [self.sideBarButton setTarget: self.revealViewController];
//        [self.sideBarButton setAction: @selector( revealToggle: )];
//        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
//    }
    // Do any additional setup after loading the view.
    [self CallWebService];
    [self CallWebServiceCategory];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection View Delegates

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.collectionViewMain) {
        return 3;
    }else
    {
    return dict.count;
    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if (collectionView == self.collectionView) {
        UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASE_URL,[[dict valueForKey:@"image_url"] objectAtIndex:indexPath.row]]]
                     placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    }
    else {
        UIImageView *imageView = (UIImageView *)[cell viewWithTag:200];
        imageView.image=[UIImage imageNamed:[userPhotos objectAtIndex:indexPath.row]];
        UILabel *productLbl =(UILabel*)[cell viewWithTag:300];
        productLbl.text = [[dictCat valueForKey:@"cat_name"] objectAtIndex:indexPath.row];
    }

    
    //    profileImageView.clipsToBounds = YES;
    //   [[dict valueForKey:@"image_url"] objectAtIndex:indexPath.row]
    //    profileImageView.layer.borderWidth = 3.0f;
    //    profileImageView.layer.borderColor = [UIColor colorWithRed:99./255. green:201./255. blue:197./255. alpha:1.0].CGColor;
//    profileImageView.image = [UIImage imageNamed:[[dict valueForKey:@"image_url"] objectAtIndex:indexPath.row]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.collectionViewMain) {

    double screenHeight = [[UIScreen mainScreen] bounds].size.height;
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        NSLog(@"All iPads");
    } else if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPhone)
    {
        if(screenHeight == 480) {
            NSLog(@"iPhone 4/4S");
            return CGSizeMake(300.f, 90.f);
        } else if (screenHeight == 568) {
            NSLog(@"iPhone 5/5S/SE");
            return CGSizeMake(320.f, 100.f);
        } else if (screenHeight == 667) {
            NSLog(@"iPhone 6/6S");
            return CGSizeMake(380.f, 125.f);
        } else if (screenHeight == 736) {
            NSLog(@"iPhone 6+, 6S+");
            return CGSizeMake(410.f, 140.f);
        } else {
            NSLog(@"Others");
        }
    }
    return CGSizeMake(160.f, 160.f);
    }
    else
    {
        double screenHeight = [[UIScreen mainScreen] bounds].size.height;
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            NSLog(@"All iPads");
        } else if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPhone)
        {
            if(screenHeight == 480) {
                NSLog(@"iPhone 4/4S");
                return CGSizeMake(60.f, 60.f);
            } else if (screenHeight == 568) {
                NSLog(@"iPhone 5/5S/SE");
                return CGSizeMake(70.f, 70.f);
            } else if (screenHeight == 667) {
                NSLog(@"iPhone 6/6S");
                return CGSizeMake(90.f, 90.f);
            } else if (screenHeight == 736) {
                NSLog(@"iPhone 6+, 6S+");
                return CGSizeMake(90.f, 90.f);
            } else {
                NSLog(@"Others");
            }
        }
        return CGSizeMake(160.f, 160.f);
    }
    }


- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    if (collectionView == self.collectionView) {
        return 5;
    }
    else
    {
    return 10.0;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (collectionView == self.collectionView) {
        return 5;
    }
    else
    {
        return 10.0;
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.collectionView) {
        
        productwiseScreen *categoryView = [[self storyboard] instantiateViewControllerWithIdentifier:@"productwiseScreen"];
        NSMutableArray *arr =[dict valueForKey:@"images"];
        NSLog(@"images arr %@",[arr objectAtIndex:indexPath.row]);
        categoryView.productID =[[[arr objectAtIndex:indexPath.row]valueForKey:@"product_id"]objectAtIndex:0];
        [self.navigationController pushViewController:categoryView animated:YES];
        
    }
    else{
        
        CategoryScreen *categoryView = [[self storyboard] instantiateViewControllerWithIdentifier:@"CategoryScreen"];
        categoryView.categoryID =[[dictCat valueForKey:@"id"]objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:categoryView animated:YES];
        
    }
}
-(void)CallWebService {
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    [hud show:YES];
    
    NSString *urlString  =  [NSString stringWithFormat:@"%@%@",BASE_URL,NEWLY_ADDED_PRODUCT];
    NSLog(@"url string : %@",urlString);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    // you can use different serializer for response.
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //Sample logic to check login status
        [hud hide:YES];

        NSDictionary*responseDic=(NSDictionary*)responseObject;
        
        NSLog(@"Result newly added %@",[responseDic valueForKey:@"message"]);
        
        dict = [[NSMutableDictionary alloc]init];
        dict = [responseDic valueForKey:@"message"];
        [hud hide:YES];
        if ([[responseDic valueForKey:@"status"]boolValue] == true) {
            
            
            //                [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"SellerDashboardScreen"] animated:YES];
            [hud hide:YES];

            [self.collectionView reloadData];
        }
        else {
            [hud hide:YES];

           /* UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"Error!"
                                                  message:[responseDic valueForKey:@"message"]
                                                  preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"OK"
                                                                  style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
                                                                      [hud hide:YES];
                                                                  }];
            [alertController addAction:firstAction];
            [self presentViewController:alertController animated:YES completion:nil];*/
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

-(void)CallWebServiceCategory {

    [hud show:YES];

    NSString *urlString  =  [NSString stringWithFormat:@"%@%@",BASE_URL,CATEGORY_LIST];
    NSLog(@"url string : %@",urlString);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];

    manager.requestSerializer = [AFHTTPRequestSerializer serializer];

    // you can use different serializer for response.
    manager.responseSerializer = [AFJSONResponseSerializer serializer];


    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        [hud hide:YES];

        //Sample logic to check login status

        NSDictionary*responseDic=(NSDictionary*)responseObject;

        NSLog(@"Result category list :%@",[responseDic valueForKey:@"message"]);

        dictCat = [[NSMutableDictionary alloc]init];
        dictCat = [responseDic valueForKey:@"message"];

        [hud hide:YES];
        if ([[responseDic valueForKey:@"status"]boolValue] == true) {
            [hud hide:YES];

            [self.collectionViewMain reloadData];

            //                [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"SellerDashboardScreen"] animated:YES];

//            [self.collectionView reloadData];
        }
        else {
            [hud hide:YES];

            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"Error!"
                                                  message:[responseDic valueForKey:@"Message"]
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

- (IBAction)back:(id)sender {

    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"CameFromMenu"] isEqualToString:@"YES"]) {
        [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"FirstViewScreen"] animated:YES];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (IBAction)logoutAction:(id)sender {
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:nil      //  Must be "nil", otherwise a blank title area will appear above our two buttons
                                message:nil
                                preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleCancel
                             handler:^(UIAlertAction * action)
                             {
                                 //  UIAlertController will automatically dismiss the
                             }];
    
    UIAlertAction *bedroomFurniture = [UIAlertAction
                                       actionWithTitle:@"Logout"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action)
                                       {
                                           [[NSUserDefaults standardUserDefaults]setValue:@"NO" forKey:@"LogInDoneBuyer"];
                                           [[NSUserDefaults standardUserDefaults]setValue:@"NO" forKey:@"LogInDoneSeller"];

                                           [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"FirstViewScreen"] animated:YES];
                                           
                                       }];
    
    
    [alert addAction:cancel];
    [alert addAction:bedroomFurniture];
    
    [self presentViewController:alert animated:YES completion:nil];
}
@end
