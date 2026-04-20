//
//  ZLLayoutButton.m
//  ZLTagListView
//
//  Created by fanpeng on 2026/04/20.
//

#import "ZLLayoutButton.h"
#define kRGBHexColor(hex) [UIColor colorWithRed:((CGFloat)((hex >> 16) & 0xFF)/255.0) green:((CGFloat)((hex >> 8) & 0xFF)/255.0) blue:((CGFloat)(hex & 0xFF)/255.0) alpha:1.0]
#define kRGBAHexColor(hex) [UIColor colorWithRed:((CGFloat)((hex >> 16) & 0xFF)/255.0) green:((CGFloat)((hex >> 8) & 0xFF)/255.0) blue:((CGFloat)(hex & 0xFF)/255.0) alpha:1.0]
static inline UIColor *__UIColorFromHexString(NSString *hexStr) {
    hexStr = [hexStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([hexStr hasPrefix:@"0x"])hexStr = [hexStr substringFromIndex:2];
    if([hexStr hasPrefix:@"#"])hexStr = [hexStr substringFromIndex:1];
    unsigned int hexInt = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    [scanner scanHexInt:&hexInt];
    return hexStr.length > 6 ? kRGBAHexColor(hexInt) : kRGBHexColor(hexInt);
}

@interface ZLLayoutButton ()
/// 缓存的内容尺寸，避免重复计算
@property (nonatomic, assign) CGSize cachedImageSize;
@property (nonatomic, assign) CGSize cachedTitleSize;
@property (nonatomic, assign) BOOL needsRecalculate;
@property (nonatomic,weak)UILabel *lab;
@property (nonatomic,weak)UIImageView *imgView;
@end

@implementation ZLLayoutButton
- (void)addSubview:(UIView *)view {
    [super addSubview: view];
    [self saveView:view];
}
- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index {
    [super insertSubview:view atIndex:index];
    [self saveView:view];
}
- (void)insertSubview:(UIView *)view aboveSubview:(UIView *)siblingSubview {
    [super insertSubview:view aboveSubview:siblingSubview];
    [self saveView:view];
}
- (void)insertSubview:(UIView *)view belowSubview:(UIView *)siblingSubview {
    [super insertSubview:view belowSubview:siblingSubview];
    [self saveView:view];
}
- (void)saveView:(UIView *)view {
    if ([self.titleLabel isEqual:view]) {
        self.lab = (UILabel*)view;
    }
    if ([self.imageView isEqual:view]) {
        self.imgView = (UIImageView *)view;
    }
}
#pragma mark - Init
+ (instancetype)verticalLayout {
    return [self buttonWithType:UIButtonTypeCustom].verticalLayout;
}
+ (instancetype)horizontalLayout {
    return [self buttonWithType:UIButtonTypeCustom].horizontalLayout;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) [self _zl_setupDefaults];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) [self _zl_setupDefaults];
    return self;
}

- (void)_zl_setupDefaults {
    _layoutAxis = ZLLayoutButtonAxisHorizontal;
    _layoutOrder = ZLLayoutButtonOrderImageFirst;
    _layoutContentAlignment = ZLLayoutButtonContentAlignmentCenter;
    _layoutSpacing = 4;
    _flexibleSpacing = NO;
    _layoutEdgeInsets = UIEdgeInsetsZero;
    _layoutImageSize = CGSizeZero;
    _imageOffset = UIOffsetZero;
    _titleOffset = UIOffsetZero;
    _needsRecalculate = YES;
}

#pragma mark - Convenience Setters

- (void)setLayoutImage:(UIImage *)layoutImage {
    [self setImage:layoutImage forState:UIControlStateNormal];
    [self _zl_markDirty];
}
- (ZLLayoutButton * _Nonnull (^)(id _Nonnull))image {
    return ^(id img) {
        if ([img isKindOfClass:UIImage.class]) {
            self.layoutImage = img;
        } else if ([img isKindOfClass:NSString.class]) {
            self.layoutImage = [UIImage imageNamed:img];
        }else {
            self.layoutImage = nil;
        }
        return self;
    };
}
- (UIImage *)layoutImage {
    return [self imageForState:UIControlStateNormal];
}

- (void)setLayoutTitle:(NSString *)layoutTitle {
    [self setTitle:layoutTitle forState:UIControlStateNormal];
    [self _zl_markDirty];
}

- (NSString *)layoutTitle {
    return [self titleForState:UIControlStateNormal];
}
- (ZLLayoutButton * _Nonnull (^)(NSString * _Nonnull))title {
    return ^(NSString *title) {
        self.layoutTitle = title;
        return self;
    };
}
- (void)setLayoutTitleFont:(UIFont *)layoutTitleFont {
    self.titleLabel.font = layoutTitleFont;
    [self _zl_markDirty];
}
- (ZLLayoutButton * _Nonnull (^)(CGFloat))titleSysFont {
    return ^(CGFloat size) {
        self.layoutTitleFont = [UIFont systemFontOfSize:size];
        return self;
    };
}
- (ZLLayoutButton * _Nonnull (^)(CGFloat))titleMedFont {
    return ^(CGFloat size) {
        self.layoutTitleFont = [UIFont systemFontOfSize:size weight:UIFontWeightMedium];
        return self;
    };
}
- (ZLLayoutButton * _Nonnull (^)(CGFloat))titleSemFont {
    return ^(CGFloat size) {
        self.layoutTitleFont = [UIFont systemFontOfSize:size weight:UIFontWeightSemibold];
        return self;
    };
}
- (ZLLayoutButton * _Nonnull (^)(CGFloat))titleBoldFont {
    return ^(CGFloat size) {
        self.layoutTitleFont = [UIFont systemFontOfSize:size weight:UIFontWeightBold];
        return self;
    };
}
- (UIFont *)layoutTitleFont {
    return self.titleLabel.font;
}

- (void)setLayoutTitleColor:(UIColor *)layoutTitleColor {
    [self setTitleColor:layoutTitleColor forState:UIControlStateNormal];
}
- (ZLLayoutButton * _Nonnull (^)(id _Nonnull))titleColor {
    return ^(id color) {
        if ([color isKindOfClass:UIColor.class]) {
            self.layoutTitleColor = color;
        } else if ([color isKindOfClass:NSString.class]) {
            self.layoutTitleColor = __UIColorFromHexString(color);
        }
        return self;
    };
}
- (UIColor *)layoutTitleColor {
    return [self titleColorForState:UIControlStateNormal];
}

#pragma mark - Layout Property Setters

- (void)setLayoutAxis:(ZLLayoutButtonAxis)layoutAxis {
    if (_layoutAxis != layoutAxis) { _layoutAxis = layoutAxis; [self _zl_markDirty]; }
}
- (instancetype)verticalLayout {
    self.layoutAxis = ZLLayoutButtonAxisVertical;
    return self;
}
- (instancetype)horizontalLayout {
    self.layoutAxis = ZLLayoutButtonAxisHorizontal;
    return self;
}
- (void)setLayoutOrder:(ZLLayoutButtonOrder)layoutOrder {
    if (_layoutOrder != layoutOrder) { _layoutOrder = layoutOrder; [self _zl_markDirty]; }
}
- (instancetype)imageFirst {
    self.layoutOrder = ZLLayoutButtonOrderImageFirst;
    return self;
}
- (instancetype)titleFirst {
    self.layoutOrder = ZLLayoutButtonOrderTitleFirst;
    return self;
}
- (void)setLayoutContentAlignment:(ZLLayoutButtonContentAlignment)layoutContentAlignment {
    if (_layoutContentAlignment != layoutContentAlignment) { _layoutContentAlignment = layoutContentAlignment; [self setNeedsLayout]; }
}
- (instancetype)alignContentCenter {
    self.layoutContentAlignment = ZLLayoutButtonContentAlignmentCenter;
    return self;
}
- (instancetype)alignContentStart {
    self.layoutContentAlignment = ZLLayoutButtonContentAlignmentStart;
    return self;
}
- (instancetype)alignContentEnd {
    self.layoutContentAlignment = ZLLayoutButtonContentAlignmentEnd;
    return self;
}
- (void)setLayoutSpacing:(CGFloat)layoutSpacing {
    if (_layoutSpacing != layoutSpacing) { _layoutSpacing = layoutSpacing; [self _zl_markDirty]; }
}
- (ZLLayoutButton * _Nonnull (^)(CGFloat))spacing {
    return ^(CGFloat spacing) {
        self.layoutSpacing = spacing;
        return self;
    };
}

- (void)setFlexibleSpacing:(BOOL)flexibleSpacing {
    if (_flexibleSpacing != flexibleSpacing) { _flexibleSpacing = flexibleSpacing; [self _zl_markDirty]; }
}
- (instancetype)enableFlexibleSpacing {
    self.flexibleSpacing = YES;
    return self;
}
- (ZLLayoutButton * _Nonnull (^)(CGFloat, CGFloat, CGFloat, CGFloat))edgeInsets {
    return ^(CGFloat top, CGFloat leading, CGFloat bottom, CGFloat trailing) {
        self.layoutEdgeInsets = UIEdgeInsetsMake(top, leading, bottom, trailing);
        return self;
    };
}

- (void)setLayoutEdgeInsets:(UIEdgeInsets)layoutEdgeInsets {
    _layoutEdgeInsets = layoutEdgeInsets;
    [self _zl_markDirty];
}

- (void)setLayoutImageSize:(CGSize)layoutImageSize {
    _layoutImageSize = layoutImageSize;
    [self _zl_markDirty];
}
- (ZLLayoutButton * _Nonnull (^)(CGFloat, CGFloat))imageSize {
    return ^(CGFloat width, CGFloat height) {
        self.layoutImageSize = CGSizeMake(width, height);
        return self;
    };
}

- (void)setImageOffset:(UIOffset)imageOffset {
    _imageOffset = imageOffset;
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}

- (ZLLayoutButton * _Nonnull (^)(CGFloat, CGFloat))imgOffset {
    return ^(CGFloat horizontal, CGFloat vertical) {
        self.imageOffset = UIOffsetMake(horizontal, vertical);
        return self;
    };
}

- (void)setTitleOffset:(UIOffset)titleOffset {
    _titleOffset = titleOffset;
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}

- (ZLLayoutButton * _Nonnull (^)(CGFloat, CGFloat))txtOffset {
    return ^(CGFloat horizontal, CGFloat vertical) {
        self.titleOffset = UIOffsetMake(horizontal, vertical);
        return self;
    };
}

- (void)_zl_markDirty {
    _needsRecalculate = YES;
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}

#pragma mark - Size Calculation

- (void)_zl_recalculateIfNeeded {
    if (!_needsRecalculate) return;
    [self _zl_doRecalculate];
}

- (void)_zl_doRecalculate {
    _needsRecalculate = NO;

    UIImage *img = [self imageForState:self.state] ?: [self imageForState:UIControlStateNormal];
    if (img) {
        if (_layoutImageSize.width > 0 && _layoutImageSize.height > 0) {
            _cachedImageSize = _layoutImageSize;
        } else {
            _cachedImageSize = img.size;
        }
    } else {
        _cachedImageSize = CGSizeZero;
    }

    NSString *title = [self titleForState:self.state] ?: [self titleForState:UIControlStateNormal];
    NSAttributedString *attrTitle = [self attributedTitleForState:self.state] ?: [self attributedTitleForState:UIControlStateNormal];

    if (attrTitle.length > 0) {
        CGRect r = [attrTitle boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                           context:nil];
        _cachedTitleSize = CGSizeMake(ceil(r.size.width), ceil(r.size.height));
    } else if (title.length > 0) {
        UIFont *font = self.titleLabel.font ?: [UIFont systemFontOfSize:15];
        NSDictionary *attrs = @{NSFontAttributeName: font};
        CGRect r = [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:attrs
                                       context:nil];
        _cachedTitleSize = CGSizeMake(ceil(r.size.width), ceil(r.size.height));
    } else {
        _cachedTitleSize = CGSizeZero;
    }
}

- (BOOL)_zl_hasImage {
    return _cachedImageSize.width > 0 && _cachedImageSize.height > 0;
}

- (BOOL)_zl_hasTitle {
    return _cachedTitleSize.width > 0 && _cachedTitleSize.height > 0;
}

- (CGFloat)_zl_actualSpacing {
    return ([self _zl_hasImage] && [self _zl_hasTitle]) ? _layoutSpacing : 0;
}

#pragma mark - Intrinsic Content Size

- (CGSize)intrinsicContentSize {
    // 始终重新计算，避免标记被提前消费导致数据过期
    [self _zl_doRecalculate];

    CGSize imgSize = _cachedImageSize;
    CGSize txtSize = _cachedTitleSize;
    CGFloat sp = [self _zl_actualSpacing];
    UIEdgeInsets insets = _layoutEdgeInsets;

    CGFloat w, h;
    if (_layoutAxis == ZLLayoutButtonAxisHorizontal) {
        w = imgSize.width + sp + txtSize.width;
        h = MAX(imgSize.height, txtSize.height);
    } else {
        w = MAX(imgSize.width, txtSize.width);
        h = imgSize.height + sp + txtSize.height;
    }

    w += insets.left + insets.right;
    h += insets.top + insets.bottom;

    return CGSizeMake(ceil(w), ceil(h));
}

- (CGSize)sizeThatFits:(CGSize)size {
    return [self intrinsicContentSize];
}

#pragma mark - layoutSubviews

- (void)layoutSubviews {
    [super layoutSubviews];

    // 始终重新计算，确保动态修改内容后布局正确
    [self _zl_doRecalculate];

    CGRect bounds = self.bounds;
    UIEdgeInsets insets = _layoutEdgeInsets;
    CGRect contentRect = CGRectMake(insets.left, insets.top,
                                     MAX(0, bounds.size.width - insets.left - insets.right),
                                     MAX(0, bounds.size.height - insets.top - insets.bottom));

    CGSize imgSize = _cachedImageSize;
    CGSize txtSize = _cachedTitleSize;
    CGFloat sp = [self _zl_actualSpacing];

    BOOL hasImg = [self _zl_hasImage];
    BOOL hasTxt = [self _zl_hasTitle];

    UIImageView *imgView = self.imgView;
    UILabel *lblView = self.lab;

    if (!hasImg && !hasTxt) {
        imgView.frame = CGRectZero;
        lblView.frame = CGRectZero;
        return;
    }

    if (!hasImg) {
        imgView.frame = CGRectZero;
        imgView.hidden = YES;
        CGRect f = [self _zl_centeredRect:txtSize inRect:contentRect];
        f.origin.x += _titleOffset.horizontal;
        f.origin.y += _titleOffset.vertical;
        lblView.frame = f;
        lblView.hidden = NO;
        return;
    }
    if (!hasTxt) {
        lblView.frame = CGRectZero;
        lblView.hidden = YES;
        CGRect f = [self _zl_centeredRect:imgSize inRect:contentRect];
        f.origin.x += _imageOffset.horizontal;
        f.origin.y += _imageOffset.vertical;
        imgView.frame = f;
        imgView.hidden = NO;
        return;
    }

    imgView.hidden = NO;
    lblView.hidden = NO;

    // 两个元素都有
    UIView *firstView, *secondView;
    CGSize firstSize, secondSize;

    if (_layoutOrder == ZLLayoutButtonOrderImageFirst) {
        firstView = imgView;  firstSize = imgSize;
        secondView = lblView; secondSize = txtSize;
    } else {
        firstView = lblView;  firstSize = txtSize;
        secondView = imgView; secondSize = imgSize;
    }

    if (_layoutAxis == ZLLayoutButtonAxisHorizontal) {
        [self _zl_layoutH_first:firstView fs:firstSize second:secondView ss:secondSize sp:sp rect:contentRect];
    } else {
        [self _zl_layoutV_first:firstView fs:firstSize second:secondView ss:secondSize sp:sp rect:contentRect];
    }

    // 应用偏移量（纯视觉偏移，不影响 intrinsicContentSize）
    if (_imageOffset.horizontal != 0 || _imageOffset.vertical != 0) {
        CGRect f = imgView.frame;
        f.origin.x += _imageOffset.horizontal;
        f.origin.y += _imageOffset.vertical;
        imgView.frame = f;
    }
    if (_titleOffset.horizontal != 0 || _titleOffset.vertical != 0) {
        CGRect f = lblView.frame;
        f.origin.x += _titleOffset.horizontal;
        f.origin.y += _titleOffset.vertical;
        lblView.frame = f;
    }
}

#pragma mark - Horizontal Layout

- (void)_zl_layoutH_first:(UIView *)first fs:(CGSize)fs second:(UIView *)second ss:(CGSize)ss sp:(CGFloat)sp rect:(CGRect)rect {
    CGFloat totalW = fs.width + sp + ss.width;
    CGFloat actualSp = sp;
    CGFloat startX;

    if (_flexibleSpacing) {
        actualSp = MAX(sp, rect.size.width - fs.width - ss.width);
        startX = rect.origin.x;
    } else {
        startX = rect.origin.x + (rect.size.width - totalW) / 2.0;
    }

    CGFloat firstY  = [self _zl_alignedOrigin:fs.height container:rect.size.height offset:rect.origin.y];
    CGFloat secondY = [self _zl_alignedOrigin:ss.height container:rect.size.height offset:rect.origin.y];

    first.frame  = CGRectMake(startX, firstY, fs.width, fs.height);
    second.frame = CGRectMake(startX + fs.width + actualSp, secondY, ss.width, ss.height);
}

#pragma mark - Vertical Layout

- (void)_zl_layoutV_first:(UIView *)first fs:(CGSize)fs second:(UIView *)second ss:(CGSize)ss sp:(CGFloat)sp rect:(CGRect)rect {
    CGFloat totalH = fs.height + sp + ss.height;
    CGFloat actualSp = sp;
    CGFloat startY;

    if (_flexibleSpacing) {
        actualSp = MAX(sp, rect.size.height - fs.height - ss.height);
        startY = rect.origin.y;
    } else {
        startY = rect.origin.y + (rect.size.height - totalH) / 2.0;
    }

    CGFloat firstX  = [self _zl_alignedOrigin:fs.width container:rect.size.width offset:rect.origin.x];
    CGFloat secondX = [self _zl_alignedOrigin:ss.width container:rect.size.width offset:rect.origin.x];

    first.frame  = CGRectMake(firstX, startY, fs.width, fs.height);
    second.frame = CGRectMake(secondX, startY + fs.height + actualSp, ss.width, ss.height);
}

#pragma mark - Helpers

- (CGFloat)_zl_alignedOrigin:(CGFloat)itemLen container:(CGFloat)containerLen offset:(CGFloat)offset {
    switch (_layoutContentAlignment) {
        case ZLLayoutButtonContentAlignmentStart:
            return offset;
        case ZLLayoutButtonContentAlignmentEnd:
            return offset + containerLen - itemLen;
        case ZLLayoutButtonContentAlignmentCenter:
        default:
            return offset + (containerLen - itemLen) / 2.0;
    }
}

- (CGRect)_zl_centeredRect:(CGSize)size inRect:(CGRect)rect {
    return CGRectMake(rect.origin.x + (rect.size.width - size.width) / 2.0,
                      rect.origin.y + (rect.size.height - size.height) / 2.0,
                      size.width, size.height);
}

@end
