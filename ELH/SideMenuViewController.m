//
//  SideMenuViewController.m
//  WorkDesk
//
//  Created by Shashi Tiwari on 01/05/17.
//  Copyright © 2017 Unicode. All rights reserved.
//

#import "SideMenuViewController.h"

@interface SideMenuViewController () {
    NSArray *menuArray;
}

@end

@implementation SideMenuViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(triggerAction:) name:@"hideSuggestiveTableView" object:nil];
    
//    NSLog(@"USER ID : %@", [[[NSUserDefaults standardUserDefaults]valueForKey:@"RoleForLogin"] stringValue]);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {

menuArray=@[@"Home",@"Profile",@"SoldProducts",@"UnapprovedProducts",@"Logout",@"FAQ",@"wanttomove",@"wantToBuy"];
    self.menuItems.delegate=self;
    self.menuItems.dataSource=self;
    [self.menuItems reloadData];
    
    NSLog(@"name %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"UserName"]);
    self.userName.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"UserName"];
}

#pragma mark - Notification
-(void) triggerAction:(NSNotification *) notification
{
//    if ([[[[NSUserDefaults standardUserDefaults]valueForKey:@"RoleForLogin"] stringValue]isEqualToString:@"1"]) {
//        
//        self.adminMenuItems.hidden = NO;
//        self.rHMenuItems.hidden = YES;
//        self.memberMenuItems.hidden = YES;
//        self.accountantMenuItems.hidden = YES;
//    }
//    else if ([[[[NSUserDefaults standardUserDefaults]valueForKey:@"RoleForLogin"] stringValue]isEqualToString:@"2"])
//    {
//        self.adminMenuItems.hidden = YES;
//        self.rHMenuItems.hidden = NO;
//        self.memberMenuItems.hidden = YES;
//        self.accountantMenuItems.hidden = YES;
//        
//    }
//    else if ([[[[NSUserDefaults standardUserDefaults]valueForKey:@"RoleForLogin"] stringValue]isEqualToString:@"3"]) {
//        
//        self.adminMenuItems.hidden = YES;
//        self.rHMenuItems.hidden = YES;
//        self.memberMenuItems.hidden = NO;
//        self.accountantMenuItems.hidden = YES;
//        
//    }
//    else if ([[[[NSUserDefaults standardUserDefaults]valueForKey:@"RoleForLogin"] stringValue]isEqualToString:@"5"]) {
//        
//        self.adminMenuItems.hidden = YES;
//        self.rHMenuItems.hidden = YES;
//        self.memberMenuItems.hidden = YES;
//        self.accountantMenuItems.hidden = NO;
//
//    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [menuArray count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    UILabel *cellLabel = (UILabel*)[cell viewWithTag:1];
    UIImageView *cellImage = (UIImageView*)[cell viewWithTag:2];
    
    if (cell.selected == TRUE) {
        
        if (indexPath.row == 0) {
            
            [cellImage setImage:[UIImage imageNamed:@"browse_select"]];
            cellLabel.textColor = [UIColor redColor];
        }
        
        if (indexPath.row == 1) {
            
            [cellImage setImage:[UIImage imageNamed:@"my_profile_select"]];
            cellLabel.textColor = [UIColor redColor];
        }
        if (indexPath.row == 2) {
            
            cellImage.image = [UIImage imageNamed:@"sold_product_select"];
            cellLabel.textColor = [UIColor redColor];
        }
        if (indexPath.row == 3) {
            
            cellImage.image = [UIImage imageNamed:@"unapproved_product_select"];
            cellLabel.textColor = [UIColor redColor];
        }
        
        if (indexPath.row == 4) {
            
//            cellImage.image = [UIImage imageNamed:@"logout_select"];
//            cellLabel.textColor = [UIColor redColor];
            [[NSUserDefaults standardUserDefaults]setValue:@"NO" forKey:@"LogInDoneBuyer"];
            [[NSUserDefaults standardUserDefaults]setValue:@"NO" forKey:@"LogInDoneSeller"];

            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            sellerLoginScreen *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"FirstViewScreen"];
            
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
            [navController setViewControllers: @[rootViewController] animated: YES];
            
            [self.revealViewController setFrontViewController:navController];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        }
        if (indexPath.row == 5) {
            
            cellImage.image = [UIImage imageNamed:@"help_select"];
            cellLabel.textColor = [UIColor redColor];
        }
        if (indexPath.row == 6) {
            
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"CameFromMenu"];

            cellImage.image = [UIImage imageNamed:@"help_select"];
            cellLabel.textColor = [UIColor redColor];
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            sellerLoginScreen *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"MoverScreen"];
            
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
            [navController setViewControllers: @[rootViewController] animated: YES];
            
            [self.revealViewController setFrontViewController:navController];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
            
        }
        if (indexPath.row == 7) {
            
            [[NSUserDefaults standardUserDefaults]setValue:@"NO" forKey:@"loginSeller"];
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"CameFromMenu"];

            cellImage.image = [UIImage imageNamed:@"help_select"];
            cellLabel.textColor = [UIColor redColor];
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            sellerLoginScreen *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"BuyerSceen"];
            
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
            [navController setViewControllers: @[rootViewController] animated: YES];
            
            [self.revealViewController setFrontViewController:navController];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];

        }
    }
    else{
        cellLabel.textColor = [UIColor darkTextColor];

    }

}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //Change the selected background view of the cell.
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    UILabel *cellLabel = (UILabel*)[cell viewWithTag:1];
    UIImageView *cellImage = (UIImageView*)[cell viewWithTag:2];
    
    
    if (indexPath.row == 0) {
        
        [cellImage setImage:[UIImage imageNamed:@"browse"]];
        cellLabel.textColor = [UIColor darkGrayColor];
    }
    
    if (indexPath.row == 1) {
        
        [cellImage setImage:[UIImage imageNamed:@"my_profile"]];
        cellLabel.textColor = [UIColor darkGrayColor];
    }
    if (indexPath.row == 2) {
        
        cellImage.image = [UIImage imageNamed:@"sold_product"];
        cellLabel.textColor = [UIColor darkGrayColor];
    }
    if (indexPath.row == 3) {
        
        cellImage.image = [UIImage imageNamed:@"unapproved_product"];
        cellLabel.textColor = [UIColor darkGrayColor];
    }
    if (indexPath.row == 4) {
        
        cellImage.image = [UIImage imageNamed:@"logout"];
        cellLabel.textColor = [UIColor darkGrayColor];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        sellerLoginScreen *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"sellerLoginScreen"];
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
        [navController setViewControllers: @[rootViewController] animated: YES];
        
        [self.revealViewController setFrontViewController:navController];
        [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
    }
    if (indexPath.row == 5) {
        
        cellImage.image = [UIImage imageNamed:@"help"];
        cellLabel.textColor = [UIColor darkGrayColor];
    }
    if (indexPath.row == 6) {
        
        cellImage.image = [UIImage imageNamed:@"help"];
        cellLabel.textColor = [UIColor darkGrayColor];
    }
    if (indexPath.row == 7) {
        
        cellImage.image = [UIImage imageNamed:@"help"];
        cellLabel.textColor = [UIColor darkGrayColor];
    }

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [menuArray objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UILabel *cellLabel = (UILabel*)[cell viewWithTag:1];
    UIImageView *cellImage = (UIImageView*)[cell viewWithTag:2];

    if (indexPath.row == 0) {
        
        [cellImage setImage:[UIImage imageNamed:@"browse"]];
        cellLabel.textColor = [UIColor darkTextColor];
    }
    
    if (indexPath.row == 1) {
        
        [cellImage setImage:[UIImage imageNamed:@"my_profile"]];
        cellLabel.textColor = [UIColor darkTextColor];
    }
    if (indexPath.row == 2) {
        
        cellImage.image = [UIImage imageNamed:@"sold_product"];
        cellLabel.textColor = [UIColor darkTextColor];
    }
    if (indexPath.row == 3) {
        
        cellImage.image = [UIImage imageNamed:@"unapproved_product"];
        cellLabel.textColor = [UIColor darkTextColor];
    }
    if (indexPath.row == 4) {
        
        cellImage.image = [UIImage imageNamed:@"logout"];
        cellLabel.textColor = [UIColor darkTextColor];
        
    }
    if (indexPath.row == 5) {
        
        cellImage.image = [UIImage imageNamed:@"help"];
        cellLabel.textColor = [UIColor darkTextColor];
    }
    if (indexPath.row == 6) {
        
        cellImage.image = [UIImage imageNamed:@"help"];
        cellLabel.textColor = [UIColor darkTextColor];
    }if (indexPath.row == 7) {
        
        cellImage.image = [UIImage imageNamed:@"help"];
        cellLabel.textColor = [UIColor darkTextColor];
    }

    return cell;
    
}



@end
