//
//  BankDetailsScreen.m
//  ELH
//
//  Created by Shashi on 26/09/17.
//  Copyright © 2017 Razan Nasir. All rights reserved.
//

#import "BankDetailsScreen.h"

@interface BankDetailsScreen ()

@end

@implementation BankDetailsScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)BackButtonAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (IBAction)updateButtonAction:(id)sender {
}

-(BOOL) textFieldShouldReturn:(ACFloatingTextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
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
    self.bankDetailsScrollView.contentInset = contentInsets;
    self.bankDetailsScrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, self.activeTextField.frame.origin) ) {
        [self.bankDetailsScrollView scrollRectToVisible:self.activeTextField.frame animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.bankDetailsScrollView.contentInset = contentInsets;
    self.bankDetailsScrollView.scrollIndicatorInsets = contentInsets;
    
    CGPoint scrollPoint = CGPointMake(0.0, 0.0);
    [self.bankDetailsScrollView setContentOffset:scrollPoint animated:YES];
    self.activeTextField = nil;
}

#pragma mark - Text Field Delegates
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    self.activeTextField = textField;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    self.activeTextField = nil;
}

@end
