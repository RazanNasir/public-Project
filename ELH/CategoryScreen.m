//
//  CategoryScreen.m
//  ELH
//
//  Created by Razan Nasir on 8/15/17.
//  Copyright © 2017 Shashi. All rights reserved.
//

#import "CategoryScreen.h"

@interface CategoryScreen ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSArray *userPhotos;
    MBProgressHUD *hud;
    NSMutableDictionary *dict;
    
}
@end

@implementation CategoryScreen
@synthesize categoryID;
- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    NSLog(@"category id %@",categoryID);
    
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection View Delegates

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
        return dict.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
        UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASE_URL,[[dict valueForKey:@"images"] objectAtIndex:indexPath.row]]]
                 placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
//        imageView.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASE_URL,[[dict valueForKey:@"images"] objectAtIndex:indexPath.row]]]]];
    UILabel *productLbl =(UILabel*)[cell viewWithTag:200];
    productLbl.text = [[dict valueForKey:@"product_name"] objectAtIndex:indexPath.row];

    ;

    
   
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    double screenHeight = [[UIScreen mainScreen] bounds].size.height;
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        NSLog(@"All iPads");
    } else if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPhone)
    {
        if(screenHeight == 480) {
            NSLog(@"iPhone 4/4S");
            return CGSizeMake(125.f, 125.f);
        } else if (screenHeight == 568) {
            NSLog(@"iPhone 5/5S/SE");
            return CGSizeMake(130.f, 130.f);
        } else if (screenHeight == 667) {
            NSLog(@"iPhone 6/6S");
            return CGSizeMake(160.f, 160.f);
        } else if (screenHeight == 736) {
            NSLog(@"iPhone 6+, 6S+");
            return CGSizeMake(180.f, 180.f);
        } else {
            NSLog(@"Others");
        }
    }
    return CGSizeMake(160.f, 160.f);
    
}
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    
        return 10.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
   
        return 10.0;
    }
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    productwiseScreen *categoryView = [[self storyboard] instantiateViewControllerWithIdentifier:@"productwiseScreen"];
    
    categoryView.productID =[[dict valueForKey:@"id"]objectAtIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:[[dict valueForKey:@"id"]objectAtIndex:indexPath.row] forKey:@"productID"];

    [self.navigationController pushViewController:categoryView animated:YES];
}
-(void)CallWebService {
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    [hud show:YES];
    
    NSString *urlString  =  [NSString stringWithFormat:@"%@%@",BASE_URL,CATEGORYWISE_PRODUCT];
    NSLog(@"url string : %@",urlString);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    // you can use different serializer for response.
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSDictionary *parameters = @{@"category_id": categoryID};

    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)logoutAction:(id)sender {
    NSString *title;
    
    if([[[NSUserDefaults standardUserDefaults]valueForKey:@"LogInDoneBuyer"]isEqualToString:@"NO"] && [[[NSUserDefaults standardUserDefaults]valueForKey:@"isComingFrom"]isEqualToString:@"firstScreenBuy"])
    {
        title = @"Logout";

    }
    else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"LogInDoneSeller"]isEqualToString:@"YES"] && [[[NSUserDefaults standardUserDefaults]valueForKey:@"isComingFrom"]isEqualToString:@"firstScreenBuy"])
    {
        title = @"Logout";

    }
    else{
        title = @"Login";

    }
    
    
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
                                       actionWithTitle:title
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action)
                                       {
                                           
                                           if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"LogInDoneBuyer"]isEqualToString:@"NO"] || [[NSUserDefaults standardUserDefaults]valueForKey:@"LogInDoneBuyer"] == nil||[[[NSUserDefaults standardUserDefaults]valueForKey:@"LogInDoneSeller"]isEqualToString:@"NO"] || [[NSUserDefaults standardUserDefaults]valueForKey:@"LogInDoneSeller"] == nil) {
                                               
                                               [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"sellerLoginScreen"] animated:YES];

                                              
                                           }
                                           else
                                           {
                                               
                                               [[NSUserDefaults standardUserDefaults]setValue:@"NO" forKey:@"LogInDoneBuyer"];
                                               [[NSUserDefaults standardUserDefaults]setValue:@"NO" forKey:@"LogInDoneSeller"];
                                               
                                               [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"FirstViewScreen"] animated:YES];
                                               
                                               
                                           }
                                           
                                       }];
    
    
    [alert addAction:cancel];
    [alert addAction:bedroomFurniture];
    
    [self presentViewController:alert animated:YES completion:nil];
}
@end
