//
//  ZLViewController.m
//  ZLLayoutButton
//
//  Created by fanpeng on 04/20/2026.
//  Copyright (c) 2026 fanpeng. All rights reserved.
//

#import "ZLViewController.h"
#import <ZLLayoutButton/ZLLayoutButton.h>

@interface ZLViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation ZLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 使用 ScrollView 承载所有 demo
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:self.scrollView];
    
    CGFloat y = 60;
    CGFloat centerX = CGRectGetMidX(self.view.bounds);
    CGFloat fullW = self.view.bounds.size.width;
    
    // ========== 第一组：基本排列方式 ==========
    y = [self addSectionTitle:@"基本排列方式" atY:y];
    
    // 1. 水平 - 图片在左，文字在右（默认）
    {
        ZLLayoutButton *btn = [self makeButtonWithTitle:@"确认" color:[UIColor systemBlueColor]];
        btn.layoutAxis = ZLLayoutButtonAxisHorizontal;
        btn.layoutOrder = ZLLayoutButtonOrderImageFirst;
        btn.layoutSpacing = 8;
        [btn sizeToFit];
        btn.center = CGPointMake(centerX, y + btn.bounds.size.height / 2.0);
        [self.scrollView addSubview:btn];
        [self addLabel:@"水平 · 图片在左" atY:y - 18];
        y += btn.bounds.size.height + 45;
    }
    
    
    // 2. 水平 - 文字在左，图片在右
    {
        ZLLayoutButton *btn = [self makeButtonWithTitle:@"下一步" color:[UIColor systemOrangeColor]];
        btn.layoutAxis = ZLLayoutButtonAxisHorizontal;
        btn.layoutOrder = ZLLayoutButtonOrderTitleFirst;
        btn.layoutSpacing = 8;
        [btn sizeToFit];
        btn.center = CGPointMake(centerX, y + btn.bounds.size.height / 2.0);
        [self.scrollView addSubview:btn];
        [self addLabel:@"水平 · 文字在左" atY:y - 18];
        y += btn.bounds.size.height + 45;
    }
    
    // 3. 垂直 - 图片在上，文字在下
    {
        ZLLayoutButton *btn = [self makeButtonWithTitle:@"相册" color:[UIColor systemGreenColor]];
        btn.layoutAxis = ZLLayoutButtonAxisVertical;
        btn.layoutOrder = ZLLayoutButtonOrderImageFirst;
        btn.layoutSpacing = 6;
        [btn sizeToFit];
        btn.center = CGPointMake(centerX, y + btn.bounds.size.height / 2.0);
        [self.scrollView addSubview:btn];
        [self addLabel:@"垂直 · 图片在上" atY:y - 18];
        y += btn.bounds.size.height + 45;
    }
    
    // 4. 垂直 - 文字在上，图片在下
    {
        ZLLayoutButton *btn = [self makeButtonWithTitle:@"下载" color:[UIColor systemPurpleColor]];
        btn.layoutAxis = ZLLayoutButtonAxisVertical;
        btn.layoutOrder = ZLLayoutButtonOrderTitleFirst;
        btn.layoutSpacing = 6;
        [btn sizeToFit];
        btn.center = CGPointMake(centerX, y + btn.bounds.size.height / 2.0);
        [self.scrollView addSubview:btn];
        [self addLabel:@"垂直 · 文字在上" atY:y - 18];
        y += btn.bounds.size.height + 55;
    }
    
    // ========== 第二组：内边距 & 固定图片大小 ==========
    y = [self addSectionTitle:@"内边距 & 固定图片大小" atY:y];
    
    // 5. 固定图片大小 + 圆角 + 内边距
    {
        ZLLayoutButton *btn = [self makeButtonWithTitle:@"收藏" color:[UIColor systemRedColor]];
        btn.layoutImageSize = CGSizeMake(18, 18);
        btn.layoutSpacing = 6;
        btn.layoutEdgeInsets = UIEdgeInsetsMake(10, 20, 10, 20);
        btn.layer.cornerRadius = 20;
        btn.clipsToBounds = YES;
        [btn sizeToFit];
        btn.center = CGPointMake(centerX, y + btn.bounds.size.height / 2.0);
        [self.scrollView addSubview:btn];
        [self addLabel:@"固定图片18×18 + 圆角胶囊" atY:y - 18];
        y += btn.bounds.size.height + 45;
    }
    
    // 6. 大内边距 + 大间距
    {
        ZLLayoutButton *btn = [self makeButtonWithTitle:@"立即购买" color:[UIColor systemIndigoColor]];
        btn.layoutSpacing = 12;
        btn.layoutEdgeInsets = UIEdgeInsetsMake(14, 30, 14, 30);
        btn.layer.cornerRadius = 10;
        btn.backgroundColor = [UIColor systemIndigoColor];
        btn.layoutTitleColor = [UIColor whiteColor];
        btn.layoutImage = [self iconImageWithColor:[UIColor whiteColor]];
        [btn sizeToFit];
        btn.center = CGPointMake(centerX, y + btn.bounds.size.height / 2.0);
        [self.scrollView addSubview:btn];
        [self addLabel:@"大内边距 + 深色背景" atY:y - 18];
        y += btn.bounds.size.height + 55;
    }
    
    // ========== 第三组：弹性间距 ==========
    y = [self addSectionTitle:@"弹性间距" atY:y];
    
    // 7. 弹性间距 - 水平
    {
        ZLLayoutButton *btn = [self makeButtonWithTitle:@"设置" color:[UIColor systemBlueColor]];
        btn.flexibleSpacing = YES;
        btn.layoutSpacing = 8;
        btn.layoutEdgeInsets = UIEdgeInsetsMake(12, 16, 12, 16);
        btn.frame = CGRectMake(30, y, fullW - 60, 48);
        btn.layer.cornerRadius = 10;
        [self.scrollView addSubview:btn];
        [self addLabel:@"弹性间距 · 水平撑满" atY:y - 18];
        y += 48 + 45;
    }
    
    // 8. 弹性间距 - 文字在左，图片在右（类似列表 cell 箭头）
    {
        ZLLayoutButton *btn = [[ZLLayoutButton alloc] init];
        btn.layoutTitle = @"个人信息";
        btn.layoutTitleFont = [UIFont systemFontOfSize:16];
        btn.layoutTitleColor = [UIColor darkTextColor];
        btn.layoutImage = [self arrowImageWithColor:[UIColor systemGrayColor]];
        btn.layoutOrder = ZLLayoutButtonOrderTitleFirst;
        btn.flexibleSpacing = YES;
        btn.layoutSpacing = 8;
        btn.layoutEdgeInsets = UIEdgeInsetsMake(14, 16, 14, 16);
        btn.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.97 alpha:1.0];
        btn.layer.cornerRadius = 10;
        btn.frame = CGRectMake(30, y, fullW - 60, 50);
        [self.scrollView addSubview:btn];
        [self addLabel:@"弹性间距 · 模拟列表箭头" atY:y - 18];
        y += 50 + 55;
    }
    
    // ========== 第四组：交叉轴对齐 ==========
    y = [self addSectionTitle:@"交叉轴对齐" atY:y];
    
    NSArray *alignNames = @[@"居中", @"顶部对齐", @"底部对齐"];
    NSArray *alignValues = @[@(ZLLayoutButtonContentAlignmentCenter),
                             @(ZLLayoutButtonContentAlignmentStart),
                             @(ZLLayoutButtonContentAlignmentEnd)];
    
    for (NSInteger i = 0; i < 3; i++) {
        ZLLayoutButton *btn = [[ZLLayoutButton alloc] init];
        btn.layoutImage = [self iconImageWithColor:[UIColor systemTealColor]];
        btn.layoutTitle = alignNames[i];
        btn.layoutTitleFont = [UIFont systemFontOfSize:14];
        btn.layoutTitleColor = [UIColor darkTextColor];
        btn.layoutAxis = ZLLayoutButtonAxisHorizontal;
        btn.layoutSpacing = 8;
        btn.layoutContentAlignment = (ZLLayoutButtonContentAlignment)[alignValues[i] unsignedIntegerValue];
        btn.layoutEdgeInsets = UIEdgeInsetsMake(8, 12, 8, 12);
        btn.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.0];
        btn.layer.cornerRadius = 6;
        // 给一个较高的 frame 来展示对齐效果
        btn.frame = CGRectMake(0, y, 140, 60);
        btn.center = CGPointMake(centerX, btn.center.y);
        [self.scrollView addSubview:btn];
        [self addLabel:alignNames[i] atY:y - 18];
        y += 60 + 40;
    }
    
    y += 10;
    
    // ========== 第五组：纯文字 / 纯图片 ==========
    y = [self addSectionTitle:@"纯文字 / 纯图片" atY:y];
    
    // 9. 纯文字
    {
        ZLLayoutButton *btn = [[ZLLayoutButton alloc] init];
        btn.layoutTitle = @"纯文字按钮";
        btn.layoutTitleFont = [UIFont boldSystemFontOfSize:16];
        btn.layoutTitleColor = [UIColor whiteColor];
        btn.layoutEdgeInsets = UIEdgeInsetsMake(12, 24, 12, 24);
        btn.backgroundColor = [UIColor systemBlueColor];
        btn.layer.cornerRadius = 22;
        btn.clipsToBounds = YES;
        [btn sizeToFit];
        btn.center = CGPointMake(centerX, y + btn.bounds.size.height / 2.0);
        [self.scrollView addSubview:btn];
        [self addLabel:@"纯文字" atY:y - 18];
        y += btn.bounds.size.height + 45;
    }
    
    // 10. 纯图片
    {
        ZLLayoutButton *btn = [[ZLLayoutButton alloc] init];
        btn.layoutImage = [self iconImageWithColor:[UIColor systemRedColor]];
        btn.layoutImageSize = CGSizeMake(32, 32);
        btn.layoutEdgeInsets = UIEdgeInsetsMake(12, 12, 12, 12);
        btn.backgroundColor = [UIColor colorWithRed:1.0 green:0.9 blue:0.9 alpha:1.0];
        btn.layer.cornerRadius = 28;
        btn.clipsToBounds = YES;
        [btn sizeToFit];
        btn.center = CGPointMake(centerX, y + btn.bounds.size.height / 2.0);
        [self.scrollView addSubview:btn];
        [self addLabel:@"纯图片" atY:y - 18];
        y += btn.bounds.size.height + 45;
    }
    
    // ========== 第六组：横排多个 Tab 样式 ==========
    y = [self addSectionTitle:@"Tab 样式" atY:y];
    {
        NSArray *tabTitles = @[@"首页", @"发现", @"消息", @"我的"];
        NSArray *tabColors = @[[UIColor systemBlueColor], [UIColor systemGreenColor],
                               [UIColor systemOrangeColor], [UIColor systemPurpleColor]];
        CGFloat tabW = (fullW - 60) / tabTitles.count;
        for (NSInteger i = 0; i < tabTitles.count; i++) {
            ZLLayoutButton *btn = [[ZLLayoutButton alloc] init];
            btn.layoutAxis = ZLLayoutButtonAxisVertical;
            btn.layoutOrder = ZLLayoutButtonOrderImageFirst;
            btn.layoutSpacing = 4;
            btn.layoutImage = [self iconImageWithColor:tabColors[i]];
            btn.layoutImageSize = CGSizeMake(24, 24);
            btn.layoutTitle = tabTitles[i];
            btn.layoutTitleFont = [UIFont systemFontOfSize:11];
            btn.layoutTitleColor = [UIColor darkGrayColor];
            btn.frame = CGRectMake(30 + tabW * i, y, tabW, 56);
            [self.scrollView addSubview:btn];
        }
        [self addLabel:@"垂直排列模拟 TabBar" atY:y - 18];
        y += 56 + 50;
    }
    
    self.scrollView.contentSize = CGSizeMake(fullW, y + 40);
}

#pragma mark - Factory

- (ZLLayoutButton *)makeButtonWithTitle:(NSString *)title color:(UIColor *)color {
    ZLLayoutButton *btn = [[ZLLayoutButton alloc] init];
    btn.layoutImage = [self iconImageWithColor:color];
    btn.layoutTitle = title;
    btn.layoutTitleFont = [UIFont systemFontOfSize:15];
    btn.layoutTitleColor = [UIColor darkTextColor];
    btn.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.0];
    btn.layer.cornerRadius = 6;
    return btn;
}

#pragma mark - Image Generators

/// 纯色圆角方块图标
- (UIImage *)iconImageWithColor:(UIColor *)color {
    CGSize size = CGSizeMake(28, 28);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [color setFill];
    [[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:6] fill];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/// 右箭头图标（用于模拟列表箭头）
- (UIImage *)arrowImageWithColor:(UIColor *)color {
    CGSize size = CGSizeMake(12, 20);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(1, 1)];
    [path addLineToPoint:CGPointMake(11, 10)];
    [path addLineToPoint:CGPointMake(1, 19)];
    path.lineWidth = 2;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    [color setStroke];
    [path stroke];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - Helpers

- (CGFloat)addSectionTitle:(NSString *)title atY:(CGFloat)y {
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.font = [UIFont boldSystemFontOfSize:18];
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    label.frame = CGRectMake(30, y, label.bounds.size.width, label.bounds.size.height);
    [self.scrollView addSubview:label];
    return y + label.bounds.size.height + 30;
}

- (void)addLabel:(NSString *)text atY:(CGFloat)y {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor grayColor];
    [label sizeToFit];
    label.center = CGPointMake(CGRectGetMidX(self.view.bounds), y + label.bounds.size.height / 2.0);
    [self.scrollView addSubview:label];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
