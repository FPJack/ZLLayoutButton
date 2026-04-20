//
//  ZLViewController.m
//  ZLLayoutButton
//
//  Created by fanpeng on 04/20/2026.
//  Copyright (c) 2026 fanpeng. All rights reserved.
//

#import "ZLViewController.h"
#import <ZLLayoutButton/ZLLayoutButton.h>

@interface ZLViewController ()
@end

@implementation ZLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat startY = 100;
    CGFloat spacing = 70;
    
    // 1. 默认水平排列：图片在左，文字在右
    ZLLayoutButton *btn1 = [self makeButton];
    btn1.layoutAxis = ZLLayoutButtonAxisHorizontal;
    btn1.layoutOrder = ZLLayoutButtonOrderImageFirst;
    btn1.layoutSpacing = 8;
    btn1.frame = CGRectMake(0, startY, 0, 0);
    [btn1 sizeToFit];
    btn1.center = CGPointMake(self.view.center.x, btn1.center.y);
    [self.view addSubview:btn1];
    [self addLabel:@"水平 - 图片在左" atY:startY - 25];
    
    // 2. 水平排列：文字在左，图片在右
    ZLLayoutButton *btn2 = [self makeButton];
    btn2.layoutAxis = ZLLayoutButtonAxisHorizontal;
    btn2.layoutOrder = ZLLayoutButtonOrderTitleFirst;
    btn2.layoutSpacing = 8;
    btn2.frame = CGRectMake(0, startY + spacing, 0, 0);
    [btn2 sizeToFit];
    btn2.center = CGPointMake(self.view.center.x, btn2.center.y);
    [self.view addSubview:btn2];
    [self addLabel:@"水平 - 文字在左" atY:startY + spacing - 25];
    
    // 3. 垂直排列：图片在上，文字在下
    ZLLayoutButton *btn3 = [self makeButton];
    btn3.layoutAxis = ZLLayoutButtonAxisVertical;
    btn3.layoutOrder = ZLLayoutButtonOrderImageFirst;
    btn3.layoutSpacing = 6;
    btn3.frame = CGRectMake(0, startY + spacing * 2, 0, 0);
    [btn3 sizeToFit];
    btn3.center = CGPointMake(self.view.center.x, btn3.center.y);
    [self.view addSubview:btn3];
    [self addLabel:@"垂直 - 图片在上" atY:startY + spacing * 2 - 25];
    
    // 4. 垂直排列：文字在上，图片在下
    ZLLayoutButton *btn4 = [self makeButton];
    btn4.layoutAxis = ZLLayoutButtonAxisVertical;
    btn4.layoutOrder = ZLLayoutButtonOrderTitleFirst;
    btn4.layoutSpacing = 6;
    btn4.frame = CGRectMake(0, startY + spacing * 3, 0, 0);
    [btn4 sizeToFit];
    btn4.center = CGPointMake(self.view.center.x, btn4.center.y);
    [self.view addSubview:btn4];
    [self addLabel:@"垂直 - 文字在上" atY:startY + spacing * 3 - 25];
    
    // 5. 固定图片大小 + 内边距
    ZLLayoutButton *btn5 = [self makeButton];
    btn5.layoutAxis = ZLLayoutButtonAxisHorizontal;
    btn5.layoutOrder = ZLLayoutButtonOrderImageFirst;
    btn5.layoutSpacing = 10;
    btn5.layoutImageSize = CGSizeMake(20, 20);
    btn5.layoutEdgeInsets = UIEdgeInsetsMake(10, 16, 10, 16);
    btn5.layer.cornerRadius = 8;
    btn5.frame = CGRectMake(0, startY + spacing * 4 + 10, 0, 0);
    [btn5 sizeToFit];
    btn5.center = CGPointMake(self.view.center.x, btn5.center.y);
    [self.view addSubview:btn5];
    [self addLabel:@"固定图片大小 + 内边距" atY:startY + spacing * 4 - 15];
    
    // 6. 弹性间距
    ZLLayoutButton *btn6 = [self makeButton];
    btn6.layoutAxis = ZLLayoutButtonAxisHorizontal;
    btn6.layoutOrder = ZLLayoutButtonOrderImageFirst;
    btn6.layoutSpacing = 8;
    btn6.flexibleSpacing = YES;
    btn6.layoutEdgeInsets = UIEdgeInsetsMake(10, 16, 10, 16);
    btn6.frame = CGRectMake(30, startY + spacing * 5 + 10, self.view.bounds.size.width - 60, 44);
    [self.view addSubview:btn6];
    [self addLabel:@"弹性间距（撑满按钮）" atY:startY + spacing * 5 - 15];
}

- (ZLLayoutButton *)makeButton {
    ZLLayoutButton *btn = [[ZLLayoutButton alloc] init];
    btn.layoutImage = [self iconImageWithColor:[UIColor systemBlueColor]];
    btn.layoutTitle = @"按钮";
    btn.layoutTitleFont = [UIFont systemFontOfSize:15];
    btn.layoutTitleColor = [UIColor darkTextColor];
    btn.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.0];
    btn.layer.cornerRadius = 6;
    return btn;
}

/// 生成一个纯色方块图片作为 icon
- (UIImage *)iconImageWithColor:(UIColor *)color {
    CGSize size = CGSizeMake(28, 28);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [color setFill];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:6];
    [path fill];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)addLabel:(NSString *)text atY:(CGFloat)y {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor grayColor];
    [label sizeToFit];
    label.center = CGPointMake(self.view.center.x, y + label.bounds.size.height / 2.0);
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
