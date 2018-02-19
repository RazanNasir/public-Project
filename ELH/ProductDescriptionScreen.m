//
//  AddToCartScreen.m
//  ELH
//
//  Created by odbase on 16/9/2017.
//  Copyright © 2017 Shashi. All rights reserved.
//

#import "ProductDescriptionScreen.h"

@interface ProductDescriptionScreen ()
{
    NSMutableArray *imgURL;
}
@end

@implementation ProductDescriptionScreen
@synthesize productDescDict;
- (void)viewDidLoad {
    [super viewDidLoad];
    imgURL = [[NSMutableArray alloc]initWithObjects:@"acce.png", nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier;
    if (indexPath.row == 0) {
        cellIdentifier = @"Cell";

    }
    else if (indexPath.row == 1)
    {
        cellIdentifier = @"Cell1";

    }
    else
    {
        cellIdentifier = @"Cell2";
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    UIScrollView *scr =(UIScrollView*)[cell.contentView viewWithTag:5];
    
   
//    UIImageView *image = (UIImageView*)[cell.contentView viewWithTag:5];
    

//        image.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASE_URL,[[productDescDict valueForKey:@"images"]objectAtIndex:indexPath.row]]]]];

//    [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASE_URL,[productDescDict valueForKey:@"images"]]]
//             placeholderImage:[UIImage imageNamed:@"placeholder.png"]];

   NSArray *compArr =[[productDescDict valueForKey:@"created_on"] componentsSeparatedByString:@" "];
    
    UILabel *createdDate =(UILabel*)[cell.contentView viewWithTag:1];
    createdDate.text =[compArr objectAtIndex:0];
    
    UILabel *productName =(UILabel*)[cell.contentView viewWithTag:2];
    productName.text =[productDescDict valueForKey:@"product_name"];
    UILabel *description =(UILabel*)[cell.contentView viewWithTag:4];
    description.text =[productDescDict valueForKey:@"description"];
    
    UILabel *price =(UILabel*)[cell.contentView viewWithTag:3];
    price.text =[NSString stringWithFormat:@"$%@",[productDescDict valueForKey:@"price"]];
    
    UILabel *status =(UILabel*)[cell.contentView viewWithTag:6];
    if ([[productDescDict valueForKey:@"is_approved"]intValue] == 0 && [[productDescDict valueForKey:@"is_selled"]intValue] == 0) {
        status.text=@"Unapproved";
    }
    else if ([[productDescDict valueForKey:@"is_approved"]intValue] == 1) {
        status.text=@"Approved";
    }
    else if ([[productDescDict valueForKey:@"is_selled"]intValue] == 1)
    {
        status.text=@"Sold";

    }
    
    return cell;
}



- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:TRUE];
}

@end
