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
+ (instancetype)verticalLayout; // 便捷方法，设置 layoutAxis = Vertical
+ (instancetype)horizontalLayout; // 便捷方法，设置 layoutAxis = Horizontal
/// 排列方向，默认 Horizontal
@property (nonatomic, assign) ZLLayoutButtonAxis layoutAxis;
- (instancetype)verticalLayout; // 便捷方法，设置 layoutAxis = Vertical
- (instancetype)horizontalLayout; // 便捷方法，设置 layoutAxis = Horizontal

/// 图文顺序，默认 ImageFirst
@property (nonatomic, assign) ZLLayoutButtonOrder layoutOrder;
- (instancetype)imageFirst; // 便捷方法，设置 layoutOrder = ImageFirst
- (instancetype)titleFirst; // 便捷方法，设置 layoutOrder = TitleFirst

/// 内容对齐方式（在交叉轴上），默认 Center
@property (nonatomic, assign) ZLLayoutButtonContentAlignment layoutContentAlignment;
- (instancetype)alignContentCenter; // 便捷方法，设置 layoutContentAlignment = Center
- (instancetype)alignContentStart; // 便捷方法，设置 layoutContentAlignment = Start
- (instancetype)alignContentEnd; // 便捷方法，设置 layoutContentAlignment

/// 图文间距，默认 4
@property (nonatomic, assign) CGFloat layoutSpacing;

@property (nonatomic, copy,readonly) ZLLayoutButton* (^spacing)(CGFloat spacing);// layoutSpacing 的别名，便捷设置

/// 是否启用弹性间距（图文之间弹性撑满），默认 NO
/// 启用后 layoutSpacing 作为最小间距
@property (nonatomic, assign) BOOL flexibleSpacing;
- (instancetype)enableFlexibleSpacing; // 便捷方法，设置 flexibleSpacing = YES

/// 内边距，默认 UIEdgeInsetsZero
@property (nonatomic, assign) UIEdgeInsets layoutEdgeInsets;
@property (nonatomic, copy,readonly) ZLLayoutButton* (^edgeInsets)(CGFloat top,CGFloat leading,CGFloat bottom,CGFloat trailing);// layoutEdgeInsets 的别名，便捷设置

/// 图片固定大小，默认 CGSizeZero 表示使用图片自身大小
@property (nonatomic, assign) CGSize layoutImageSize;
@property (nonatomic, copy,readonly) ZLLayoutButton* (^imageSize)(CGFloat width,CGFloat height);// layoutImageSize 的别名，便捷设置

/// 便捷设置图片（设置 Normal 状态）
@property (nonatomic, strong, nullable) UIImage *layoutImage;
@property (nonatomic, copy,readonly) ZLLayoutButton* (^image)(id image);// layoutImage 的别名，便捷设置 UIImage 或 UIImageName

/// 便捷设置标题（设置 Normal 状态）
@property (nonatomic, copy, nullable) NSString *layoutTitle;
@property (nonatomic, copy,readonly) ZLLayoutButton* (^title)(NSString *title);// layoutTitle 的别名，便捷设置

/// 便捷设置字体
@property (nonatomic, strong, nullable) UIFont *layoutTitleFont;
@property (nonatomic, copy,readonly) ZLLayoutButton* (^titleSysFont)(CGFloat fontSize);// layoutTitleFont 的别名，便捷设置
@property (nonatomic, copy,readonly) ZLLayoutButton* (^titleMedFont)(CGFloat fontSize);// layoutTitleFont 的别名，便捷设置
@property (nonatomic, copy,readonly) ZLLayoutButton* (^titleSemFont)(CGFloat fontSize);// layoutTitleFont 的别名，便捷设置
@property (nonatomic, copy,readonly) ZLLayoutButton* (^titleBoldFont)(CGFloat fontSize);// layoutTitleFont 的别名，便捷设置

/// 便捷设置字体颜色（设置 Normal 状态）
@property (nonatomic, strong, nullable) UIColor *layoutTitleColor;
@property (nonatomic, copy,readonly) ZLLayoutButton* (^titleColor)(id color);// layoutTitleColor 的别名，便捷设置 UIColor 或 UIColorHex

/// 图片偏移量（在布局计算完成后额外偏移），正值向右/下，负值向左/上 ，纯视觉偏移，不影响 intrinsicContentSize
@property (nonatomic, assign) UIOffset imageOffset;
@property (nonatomic, copy, readonly) ZLLayoutButton* (^imgOffset)(CGFloat horizontal, CGFloat vertical);

/// 文字偏移量（在布局计算完成后额外偏移），正值向右/下，负值向左/上，纯视觉偏移，不影响 intrinsicContentSize
@property (nonatomic, assign) UIOffset titleOffset;
@property (nonatomic, copy, readonly) ZLLayoutButton* (^txtOffset)(CGFloat horizontal, CGFloat vertical);

@end

NS_ASSUME_NONNULL_END
