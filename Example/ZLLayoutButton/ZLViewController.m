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
@property (nonatomic, strong) UIStackView *stackView;
@end

@implementation ZLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // ScrollView
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:self.scrollView];
    [NSLayoutConstraint activateConstraints:@[
        [self.scrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
    ]];
    
    // StackView 作为 scrollView 内容容器
    self.stackView = [[UIStackView alloc] init];
    self.stackView.axis = UILayoutConstraintAxisVertical;
    self.stackView.alignment = UIStackViewAlignmentCenter;
    self.stackView.spacing = 20;
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:self.stackView];
    [NSLayoutConstraint activateConstraints:@[
        [self.stackView.topAnchor constraintEqualToAnchor:self.scrollView.contentLayoutGuide.topAnchor constant:20],
        [self.stackView.bottomAnchor constraintEqualToAnchor:self.scrollView.contentLayoutGuide.bottomAnchor constant:-20],
        [self.stackView.leadingAnchor constraintEqualToAnchor:self.scrollView.frameLayoutGuide.leadingAnchor],
        [self.stackView.trailingAnchor constraintEqualToAnchor:self.scrollView.frameLayoutGuide.trailingAnchor],
    ]];
    
    // ========== 第一组：基本排列方式 ==========
    [self addSectionTitle:@"基本排列方式"];
    
    // 1. 水平 - 图片在左，文字在右（默认）
    {
        ZLLayoutButton *btn = [self makeButtonWithTitle:@"确认" color:[UIColor systemBlueColor]];
        btn.layoutAxis = ZLLayoutButtonAxisHorizontal;
        btn.layoutOrder = ZLLayoutButtonOrderImageFirst;
        btn.layoutSpacing = 8;
        [self addButton:btn label:@"水平 · 图片在左"];
    }
    
    // 1.5 图片偏移 + 文字偏移
    {
        ZLLayoutButton *btn = [self makeButtonWithTitle:@"图片下移+文字右移" color:[UIColor systemTealColor]];
        btn.layoutAxis = ZLLayoutButtonAxisHorizontal;
        btn.layoutSpacing = 8;
        btn.imageOffset = UIOffsetMake(0, 24);
        btn.titleOffset = UIOffsetMake(6, 0);
        btn.layoutEdgeInsets = UIEdgeInsetsMake(12, 16, 12, 16);
        [self addButton:btn label:@"imageOffset=(0,24) titleOffset=(6,0)"];
    }
    
    // 1.6 垂直排列 + 偏移（链式写法）
    {
        ZLLayoutButton *btn = [self makeButtonWithTitle:@"偏移示例" color:[UIColor systemPinkColor]];
        btn.layoutAxis = ZLLayoutButtonAxisVertical;
        btn.layoutSpacing = 6;
        btn.imgOffset(-3, 0);
        btn.txtOffset(0, 2);
        btn.layoutEdgeInsets = UIEdgeInsetsMake(12, 16, 12, 16);
        [self addButton:btn label:@"垂直 · imgOffset(-3,0) txtOffset(0,2)"];
    }
    
    // 2. 水平 - 文字在左，图片在右
    {
        ZLLayoutButton *btn = [self makeButtonWithTitle:@"下一步" color:[UIColor systemOrangeColor]];
        btn.layoutAxis = ZLLayoutButtonAxisHorizontal;
        btn.layoutOrder = ZLLayoutButtonOrderTitleFirst;
        btn.layoutSpacing = 8;
        [self addButton:btn label:@"水平 · 文字在左"];
    }
    
    // 3. 垂直 - 图片在上，文字在下
    {
        ZLLayoutButton *btn = [self makeButtonWithTitle:@"相册" color:[UIColor systemGreenColor]];
        btn.layoutAxis = ZLLayoutButtonAxisVertical;
        btn.layoutOrder = ZLLayoutButtonOrderImageFirst;
        btn.layoutSpacing = 6;
        [self addButton:btn label:@"垂直 · 图片在上"];
    }
    
    // 4. 垂直 - 文字在上，图片在下
    {
        ZLLayoutButton *btn = [self makeButtonWithTitle:@"下载" color:[UIColor systemPurpleColor]];
        btn.layoutAxis = ZLLayoutButtonAxisVertical;
        btn.layoutOrder = ZLLayoutButtonOrderTitleFirst;
        btn.layoutSpacing = 6;
        [self addButton:btn label:@"垂直 · 文字在上"];
    }
    
    // ========== 第二组：内边距 & 固定图片大小 ==========
    [self addSectionTitle:@"内边距 & 固定图片大小"];
    
    // 5. 固定图片大小 + 圆角 + 内边距
    {
        ZLLayoutButton *btn = [self makeButtonWithTitle:@"收藏" color:[UIColor systemRedColor]];
        btn.layoutImageSize = CGSizeMake(18, 18);
        btn.layoutSpacing = 6;
        btn.layoutEdgeInsets = UIEdgeInsetsMake(10, 20, 10, 20);
        btn.layer.cornerRadius = 20;
        btn.clipsToBounds = YES;
        [self addButton:btn label:@"固定图片18×18 + 圆角胶囊"];
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
        [self addButton:btn label:@"大内边距 + 深色背景"];
    }
    
    // ========== 第三组：弹性间距 ==========
    [self addSectionTitle:@"弹性间距"];
    
    // 7. 弹性间距 - 水平
    {
        ZLLayoutButton *btn = [self makeButtonWithTitle:@"设置" color:[UIColor systemBlueColor]];
        btn.flexibleSpacing = YES;
        btn.layoutSpacing = 8;
        btn.layoutEdgeInsets = UIEdgeInsetsMake(12, 16, 12, 16);
        btn.layer.cornerRadius = 10;
        [self addFullWidthButton:btn label:@"弹性间距 · 水平撑满" height:48];
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
        [self addFullWidthButton:btn label:@"弹性间距 · 模拟列表箭头" height:50];
    }
    
    // ========== 第四组：交叉轴对齐 ==========
    [self addSectionTitle:@"交叉轴对齐"];
    
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
        btn.translatesAutoresizingMaskIntoConstraints = NO;
        [self.stackView addArrangedSubview:btn];
        // 固定高度展示对齐效果
        [NSLayoutConstraint activateConstraints:@[
            [btn.widthAnchor constraintEqualToConstant:140],
            [btn.heightAnchor constraintEqualToConstant:60],
        ]];
    }
    
    // ========== 第五组：纯文字 / 纯图片 ==========
    [self addSectionTitle:@"纯文字 / 纯图片"];
    
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
        [self addButton:btn label:@"纯文字"];
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
        [self addButton:btn label:@"纯图片"];
    }
    
    // ========== 第六组：横排多个 Tab 样式 ==========
    [self addSectionTitle:@"Tab 样式"];
    {
        UIStackView *tabStack = [[UIStackView alloc] init];
        tabStack.axis = UILayoutConstraintAxisHorizontal;
        tabStack.distribution = UIStackViewDistributionFillEqually;
        tabStack.alignment = UIStackViewAlignmentFill;
        tabStack.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSArray *tabTitles = @[@"首页", @"发现", @"消息", @"我的"];
        NSArray *tabColors = @[[UIColor systemBlueColor], [UIColor systemGreenColor],
                               [UIColor systemOrangeColor], [UIColor systemPurpleColor]];
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
            btn.translatesAutoresizingMaskIntoConstraints = NO;
            [tabStack addArrangedSubview:btn];
        }
        
        [self.stackView addArrangedSubview:tabStack];
        [NSLayoutConstraint activateConstraints:@[
            [tabStack.leadingAnchor constraintEqualToAnchor:self.stackView.leadingAnchor constant:30],
            [tabStack.trailingAnchor constraintEqualToAnchor:self.stackView.trailingAnchor constant:-30],
            [tabStack.heightAnchor constraintEqualToConstant:56],
        ]];
    }
}

#pragma mark - Helpers

- (void)addSectionTitle:(NSString *)title {
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.font = [UIFont boldSystemFontOfSize:18];
    label.textColor = [UIColor blackColor];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    
    // 包一层 view 让 label 左对齐
    UIView *container = [[UIView alloc] init];
    container.translatesAutoresizingMaskIntoConstraints = NO;
    [container addSubview:label];
    [NSLayoutConstraint activateConstraints:@[
        [label.leadingAnchor constraintEqualToAnchor:container.leadingAnchor constant:30],
        [label.topAnchor constraintEqualToAnchor:container.topAnchor constant:10],
        [label.bottomAnchor constraintEqualToAnchor:container.bottomAnchor],
    ]];
    [self.stackView addArrangedSubview:container];
    [container.leadingAnchor constraintEqualToAnchor:self.stackView.leadingAnchor].active = YES;
    [container.trailingAnchor constraintEqualToAnchor:self.stackView.trailingAnchor].active = YES;
}

- (void)addButton:(ZLLayoutButton *)btn label:(NSString *)text {
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    
    // 描述 label
    UILabel *lbl = [[UILabel alloc] init];
    lbl.text = text;
    lbl.font = [UIFont systemFontOfSize:12];
    lbl.textColor = [UIColor grayColor];
    lbl.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.stackView addArrangedSubview:lbl];
    [self.stackView addArrangedSubview:btn];
}

- (void)addFullWidthButton:(ZLLayoutButton *)btn label:(NSString *)text height:(CGFloat)h {
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    
    UILabel *lbl = [[UILabel alloc] init];
    lbl.text = text;
    lbl.font = [UIFont systemFontOfSize:12];
    lbl.textColor = [UIColor grayColor];
    lbl.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.stackView addArrangedSubview:lbl];
    [self.stackView addArrangedSubview:btn];
    [NSLayoutConstraint activateConstraints:@[
        [btn.leadingAnchor constraintEqualToAnchor:self.stackView.leadingAnchor constant:30],
        [btn.trailingAnchor constraintEqualToAnchor:self.stackView.trailingAnchor constant:-30],
        [btn.heightAnchor constraintEqualToConstant:h],
    ]];
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

- (UIImage *)iconImageWithColor:(UIColor *)color {
    CGSize size = CGSizeMake(28, 28);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [color setFill];
    [[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:6] fill];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
