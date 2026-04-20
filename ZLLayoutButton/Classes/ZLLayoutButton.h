//
//  ZLLayoutButton.h
//  ZLTagListView
//
//  Created by fanpeng on 2026/04/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 图片与文字的排列方向
typedef NS_ENUM(NSUInteger, ZLLayoutButtonAxis) {
    ZLLayoutButtonAxisHorizontal = 0,  // 水平排列
    ZLLayoutButtonAxisVertical,        // 垂直排列
};

/// 图片与文字的先后顺序
typedef NS_ENUM(NSUInteger, ZLLayoutButtonOrder) {
    ZLLayoutButtonOrderImageFirst = 0, // 图片在前（左/上）
    ZLLayoutButtonOrderTitleFirst,     // 文字在前（左/上）
};

/// 内容在按钮内的对齐方式（交叉轴）
typedef NS_ENUM(NSUInteger, ZLLayoutButtonContentAlignment) {
    ZLLayoutButtonContentAlignmentCenter = 0, // 居中
    ZLLayoutButtonContentAlignmentStart,      // 起始对齐（左/上）
    ZLLayoutButtonContentAlignmentEnd,        // 末尾对齐（右/下）
};

/**
 * ZLLayoutButton - 继承 UIButton，支持自定义图文布局
 *
 * 功能：
 * - 图片和文字可切换先后顺序（imageFirst / titleFirst）
 * - 支持水平或垂直排列
 * - 支持设置图文间距 (layoutSpacing)
 * - 支持弹性间距 (flexibleSpacing)，图文之间会尽可能撑满
 * - 完整支持 Auto Layout，intrinsicContentSize 自动撑开
 * - 支持 layoutEdgeInsets 设置内边距
 * - 支持固定图片大小 (layoutImageSize)
 *
 * 注意：使用 UIButton 原生的 setTitle:forState: / setImage:forState: 设置内容，
 *       或使用便捷属性 layoutImage / layoutTitle。
 */
@interface ZLLayoutButton : UIButton

/// 排列方向，默认 Horizontal
@property (nonatomic, assign) ZLLayoutButtonAxis layoutAxis;

/// 图文顺序，默认 ImageFirst
@property (nonatomic, assign) ZLLayoutButtonOrder layoutOrder;

/// 内容对齐方式（在交叉轴上），默认 Center
@property (nonatomic, assign) ZLLayoutButtonContentAlignment layoutContentAlignment;

/// 图文间距，默认 4
@property (nonatomic, assign) CGFloat layoutSpacing;

/// 是否启用弹性间距（图文之间弹性撑满），默认 NO
/// 启用后 layoutSpacing 作为最小间距
@property (nonatomic, assign) BOOL flexibleSpacing;

/// 内边距，默认 UIEdgeInsetsZero
@property (nonatomic, assign) UIEdgeInsets layoutEdgeInsets;

/// 图片固定大小，默认 CGSizeZero 表示使用图片自身大小
@property (nonatomic, assign) CGSize layoutImageSize;

/// 便捷设置图片（设置 Normal 状态）
@property (nonatomic, strong, nullable) UIImage *layoutImage;

/// 便捷设置标题（设置 Normal 状态）
@property (nonatomic, copy, nullable) NSString *layoutTitle;

/// 便捷设置字体
@property (nonatomic, strong, nullable) UIFont *layoutTitleFont;

/// 便捷设置字体颜色（设置 Normal 状态）
@property (nonatomic, strong, nullable) UIColor *layoutTitleColor;

@end

NS_ASSUME_NONNULL_END
