//
//  UITextField+ASTextField.m
//  ASTextViewDemo
//
//  Created by Adil Soomro on 4/14/14.
//  Copyright (c) 2014 Adil Soomro. All rights reserved.
//

#import "ASTextField.h"
#define kLeftPadding 40
#define kVerticalPadding 5
#define kHorizontalPadding 5

@interface ASTextField (){
    ASTextFieldType _type;
}

@end

@implementation ASTextField

- (CGRect)textRectForBounds:(CGRect)bounds {
    UIEdgeInsets edge = [self edgeInsetsForType:_type];
    
    CGFloat x = bounds.origin.x + edge.left +kLeftPadding;
    CGFloat y = bounds.origin.y + kVerticalPadding;
    return CGRectMake(0,y,bounds.size.width - kHorizontalPadding*2, bounds.size.height - kVerticalPadding*2);
    
}
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

- (void)setupTextFieldWithIconName:(NSString *)name{
    [self setupTextFieldWithType:ASTextFieldTypeDefault withIconName:name];
}
- (void)setupTextFieldWithType:(ASTextFieldType)type withIconName:(NSString *)name{
    
//    UIEdgeInsets edge = [self edgeInsetsForType:type];
//    NSString *imageName = [self backgroundImageNameForType:type];
//    UIImage *image = [UIImage imageNamed:imageName];
//    image = [image resizableImageWithCapInsets:edge];
//    [self setBackground:image];
    
    self.layer.cornerRadius = self.frame.size.height/2;
    self.clipsToBounds = YES;
    self.layer.borderColor =  [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 1.0f;
    
    CGRect imageViewFrame = [self iconImageViewRectForType:type];
    _type = type;
    
    UIImage *icon = [UIImage imageNamed:name];
    
    //make an imageview to show an icon on the left side of textfield
    UIImageView * iconImage = [[UIImageView alloc] initWithFrame:imageViewFrame];
    [iconImage setImage:icon];
    [iconImage setContentMode:UIViewContentModeCenter];
    //self.leftView = iconImage;
    //self.leftViewMode = UITextFieldViewModeAlways;
    self.rightView = iconImage;
    self.rightViewMode = UITextFieldViewModeAlways;
    
    [self setNeedsDisplay]; //force reload for updated editing rect for bound to take effect.
}
- (CGRect)iconImageViewRectForType:(ASTextFieldType) type{
    UIEdgeInsets edge = [self edgeInsetsForType:type];
    if (type == ASTextFieldTypeRound) {
        return CGRectMake(0, 0, 45, self.frame.size.height); //to put the icon inside
    }
    /*
     if (type == ASTextFieldTypeBlahBlah) {
     return 786; //whatever suits your field
     }
     */
    
    return CGRectMake(0, 0, edge.left, self.frame.size.height); // default
}
- (UIEdgeInsets)edgeInsetsForType:(ASTextFieldType) type{
    if (type == ASTextFieldTypeRound) {
        return UIEdgeInsetsMake(13, 13, 13, 13);
    }
    /*
     if (type == ASTextFieldTypeBlahBlah) {
     return UIEdgeInsetsMake(15, 15, 15, 15); //whatever suits your field
     }
     */
    
    return UIEdgeInsetsMake(10, 43, 10, 19); // default
}
- (NSString *)backgroundImageNameForType:(ASTextFieldType) type{
    if (type == ASTextFieldTypeRound) {
        return @"round_textfield.png";
    }
    /*
     if (type == ASTextFieldTypeBlahBlah) {
        return @""; // return suitable
     }
     */
    
    return @"text_field"; // default
}
- (BOOL)becomeFirstResponder {// focused
    BOOL outcome = [super becomeFirstResponder];
    if (outcome) {
        //self.layer.borderColor =  [UIColor colorWithRed:67.0f/255 green:129.0f/255 blue:255.0f/255 alpha:0.8f].CGColor;
        self.layer.borderColor =  [UIColor blueColor].CGColor;

    }
    return outcome;
}

- (BOOL)resignFirstResponder {
    BOOL outcome = [super resignFirstResponder];
    if (outcome) {
        self.layer.borderColor =  [UIColor lightGrayColor].CGColor;//normal
    }
    return outcome;
}
@end
