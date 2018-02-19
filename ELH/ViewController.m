//
//  ViewController.m
//  ELH
//
//  Created by Shashi on 18/07/17.
//  Copyright © 2017 Shashi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
   _textLbl.alpha = 0;
    
    [UIView animateWithDuration:3.5 animations:^{
        
        _textLbl.frame = CGRectMake(_textLbl.frame.origin.x,self.logoImageView.frame.origin.y + self.logoImageView.frame.size.height + 20, _textLbl.frame.size.width, _textLbl.frame.size.height); // 200 is considered to be center
        _textLbl.alpha = 1;
        
    } completion:^(BOOL finished){
        
        [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"FirstViewScreen"] animated:NO];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];

}

- (IBAction)nextButton:(id)sender {
    
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"FirstViewScreen"] animated:YES];
}

@end
