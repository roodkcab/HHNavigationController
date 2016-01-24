//
//  HHNavigationBar.m
//  HuiHui
//
//  Created by shuoshichen on 15/12/30.
//  Copyright © 2015年 HuiHui. All rights reserved.
//

#import "HHNavigationBar.h"

@interface HHNavigationBar ()

@property (nonatomic, assign) CGFloat initY;
@property (nonatomic, strong) CALayer *colorLayer;

@end

@implementation HHNavigationBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        _initY = 20;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (!_colorLayer) {
        _colorLayer = [CALayer layer];
        _colorLayer.frame = CGRectMake(0, _initY - 20, UIScreen.mainScreen.bounds.size.width, 64);
        _colorLayer.backgroundColor = [UIColor colorWithRed:30/255.f green:50/255.f blue:200/255.f alpha:0.7].CGColor;
        _colorLayer.opacity = 0.25;
    }
    [self.colorLayer removeFromSuperlayer];
    if (![self backgroundImageForBarMetrics:UIBarMetricsDefault]) {
        [self.layer insertSublayer:_colorLayer atIndex:1];
    }
}

- (void)setBackgroundImage:(UIImage *)backgroundImage forBarMetrics:(UIBarMetrics)barMetrics
{
    [super setBackgroundImage:backgroundImage forBarMetrics:barMetrics];
    if (nil == backgroundImage) {
        [self.layer insertSublayer:self.colorLayer atIndex:1];
    } else {
        [self.colorLayer removeFromSuperlayer];
    }
}

@end
