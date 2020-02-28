//
//  CustomButton.m
//  SuJi
//
//  Created by beyond on 16/7/10.
//  Copyright © 2016年 beyond. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

// 定义宏,rgb颜色值
#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

- (instancetype)init
{
    if (self = [super init]) {
        [self setUp];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setUp];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    self.layer.borderWidth = 0.5;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:kColor(28, 181, 152) forState:UIControlStateHighlighted];
    [self setBackgroundImage:[SGViewTool createImageWithColor:[UIColor clearColor]] forState:UIControlStateHighlighted];
    self.showsTouchWhenHighlighted = YES;
    self.layer.borderColor = kColor(92, 150, 182).CGColor;
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
}
- (void)setHighlighted:(BOOL)highlighted
{
    // do nothing
    [super setHighlighted:highlighted];
}


- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(contentRect.origin.x, contentRect.origin.y - 1.5, contentRect.size.width, contentRect.size.height);
}
@end
