//
//  SoldProductScreen.m
//  ELH
//
//  Created by odbase on 24/9/2017.
//  Copyright © 2017 Razan Nasir. All rights reserved.
//

#import "SoldProductScreen.h"

@interface SoldProductScreen ()
{
    MBProgressHUD *hud;
    NSMutableDictionary *dict,*responseDic;
    
}
@end

@implementation SoldProductScreen

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideBarButton setTarget: self.revealViewController];
        [self.sideBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self CallWebService];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dict count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductDescriptionScreen *SellerScreen = [[self storyboard] instantiateViewControllerWithIdentifier:@"ProductDescriptionScreen"];
    SellerScreen.productDescDict = [[responseDic valueForKey:@"message"]objectAtIndex:indexPath.row] ;
    [self.navigationController pushViewController:SellerScreen animated:YES];
    
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"SellerDashBoardCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    UIImageView *image = (UIImageView*)[cell.contentView viewWithTag:1];
    
    [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASE_URL,[[dict valueForKey:@"images"]objectAtIndex:indexPath.row]]]
             placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    NSLog(@"image url %@",[NSString stringWithFormat:@"%@%@",IMAGE_BASE_URL,[[dict valueForKey:@"images"]objectAtIndex:indexPath.row]]);
    
    //    if ([[[dict valueForKey:@"images"] objectAtIndex:indexPath.row] count] == 0 ) {
    //        NSLog(@"came here");
    //    }
    //    else {
    //
    ////        image.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[[dict valueForKey:@"images"] valueForKey:@"image_url"] objectAtIndex:0]]]];
    //    }
    
    
    UILabel *productName =(UILabel*)[cell.contentView viewWithTag:2];
    productName.text =[[dict valueForKey:@"product_name"] objectAtIndex:indexPath.row];
    UILabel *description =(UILabel*)[cell.contentView viewWithTag:3];
    description.text =[[dict valueForKey:@"description"] objectAtIndex:indexPath.row];
    
    UILabel *price =(UILabel*)[cell.contentView viewWithTag:4];
    price.text =[NSString stringWithFormat:@"$ %@",[[dict valueForKey:@"price"] objectAtIndex:indexPath.row]];
    return cell;
}

-(void)CallWebService {
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    [hud show:YES];
    
    NSString *urlString  =  [NSString stringWithFormat:@"%@%@",BASE_URL,SOLD_PRODUCT];
    NSLog(@"url string : %@",urlString);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    // you can use different serializer for response.
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    NSDictionary *parameters = @{@"user_id":[[NSUserDefaults standardUserDefaults]valueForKey:@"UserID"]};
    
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //Sample logic to check login status
        
        responseDic=(NSMutableDictionary*)responseObject;
        
        NSLog(@"Result %@",[responseDic valueForKey:@"message"]);
        
        dict = [[NSMutableDictionary alloc]init];
        dict = [responseDic valueForKey:@"message"];
        [hud hide:YES];
        if ([[responseDic valueForKey:@"status"]boolValue] == true) {
            
            
            //                [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"SellerDashboardScreen"] animated:YES];
            
            [self.tableView reloadData];
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

- (IBAction)menuBtn:(id)sender {
}
- (IBAction)addProductBtnActn:(id)sender {
    
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"AddProductScreen"] animated:YES];
}

@end
