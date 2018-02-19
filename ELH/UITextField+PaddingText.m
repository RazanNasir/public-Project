//
//  UITextField+PaddingText.m
//  RadioHolland
//
//  Created by odbase on 3/4/2017.
//
//

#import "UITextField+PaddingText.h"

@implementation UITextField (PaddingText)
-(void) setLeftPadding:(int) paddingValue
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, paddingValue, self.frame.size.height)];
    self.leftView = paddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

-(void) setRightPadding:(int) paddingValue
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, paddingValue, self.frame.size.height)];
    self.rightView = paddingView;
    self.rightViewMode = UITextFieldViewModeAlways;
}

@end
