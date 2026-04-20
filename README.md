# ZLLayoutButton

[![CI Status](https://img.shields.io/travis/fanpeng/ZLLayoutButton.svg?style=flat)](https://travis-ci.org/fanpeng/ZLLayoutButton)
[![Version](https://img.shields.io/cocoapods/v/ZLLayoutButton.svg?style=flat)](https://cocoapods.org/pods/ZLLayoutButton)
[![License](https://img.shields.io/cocoapods/l/ZLLayoutButton.svg?style=flat)](https://cocoapods.org/pods/ZLLayoutButton)
[![Platform](https://img.shields.io/cocoapods/p/ZLLayoutButton.svg?style=flat)](https://cocoapods.org/pods/ZLLayoutButton)

`ZLLayoutButton` 是一个继承自 `UIButton` 的自定义按钮，支持灵活的图文混排布局。通过简单的属性配置即可实现图片与文字的水平/垂直排列、顺序切换、间距调整等常见需求，完整支持 Auto Layout。

## 特性

- ✅ 支持**水平**和**垂直**两种图文排列方向
- ✅ 支持图片在前或文字在前的**顺序切换**
- ✅ 支持自定义**图文间距**
- ✅ 支持**弹性间距**模式，图文自动撑满按钮宽度/高度
- ✅ 支持**交叉轴对齐**方式（居中 / 起始 / 末尾）
- ✅ 支持自定义**内边距** (`layoutEdgeInsets`)
- ✅ 支持**固定图片大小** (`layoutImageSize`)
- ✅ 完整支持 `intrinsicContentSize`，与 Auto Layout 无缝配合
- ✅ 支持 Interface Builder (`initWithCoder`)

## 安装

### CocoaPods

在 `Podfile` 中添加：

```ruby
pod 'ZLLayoutButton'
```

然后执行：

```bash
pod install
```

## 使用

### 引入头文件

```objc
#import <ZLLayoutButton/ZLLayoutButton.h>
```

### 基本用法

```objc
ZLLayoutButton *button = [[ZLLayoutButton alloc] init];
button.layoutImage = [UIImage imageNamed:@"icon"];
button.layoutTitle = @"按钮文字";
button.layoutTitleFont = [UIFont systemFontOfSize:14];
button.layoutTitleColor = [UIColor darkTextColor];
```

### 水平排列（默认）— 图片在左，文字在右

```objc
button.layoutAxis = ZLLayoutButtonAxisHorizontal;
button.layoutOrder = ZLLayoutButtonOrderImageFirst;
button.layoutSpacing = 8;
```

### 垂直排列 — 文字在上，图片在下

```objc
button.layoutAxis = ZLLayoutButtonAxisVertical;
button.layoutOrder = ZLLayoutButtonOrderTitleFirst;
button.layoutSpacing = 6;
```

### 固定图片大小

```objc
button.layoutImageSize = CGSizeMake(24, 24);
```

### 设置内边距

```objc
button.layoutEdgeInsets = UIEdgeInsetsMake(8, 12, 8, 12);
```

### 弹性间距

启用后图片与文字之间的间距会自动撑满可用空间，`layoutSpacing` 作为最小间距：

```objc
button.flexibleSpacing = YES;
```

### 交叉轴对齐

```objc
button.layoutContentAlignment = ZLLayoutButtonContentAlignmentStart;  // 起始对齐
button.layoutContentAlignment = ZLLayoutButtonContentAlignmentCenter; // 居中（默认）
button.layoutContentAlignment = ZLLayoutButtonContentAlignmentEnd;    // 末尾对齐
```

## API 参考

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `layoutAxis` | `ZLLayoutButtonAxis` | `Horizontal` | 排列方向：水平 / 垂直 |
| `layoutOrder` | `ZLLayoutButtonOrder` | `ImageFirst` | 图文顺序：图片在前 / 文字在前 |
| `layoutContentAlignment` | `ZLLayoutButtonContentAlignment` | `Center` | 交叉轴对齐方式 |
| `layoutSpacing` | `CGFloat` | `4` | 图文间距 |
| `flexibleSpacing` | `BOOL` | `NO` | 是否启用弹性间距 |
| `layoutEdgeInsets` | `UIEdgeInsets` | `UIEdgeInsetsZero` | 内边距 |
| `layoutImageSize` | `CGSize` | `CGSizeZero` | 固定图片大小（零则使用原始大小） |
| `layoutImage` | `UIImage *` | `nil` | 便捷设置 Normal 状态图片 |
| `layoutTitle` | `NSString *` | `nil` | 便捷设置 Normal 状态标题 |
| `layoutTitleFont` | `UIFont *` | `nil` | 便捷设置字体 |
| `layoutTitleColor` | `UIColor *` | `nil` | 便捷设置 Normal 状态字体颜色 |

## 系统要求

- iOS 10.0+
- Objective-C

## 许可证

ZLLayoutButton 基于 MIT 许可证开源，详情请参阅 [LICENSE](LICENSE) 文件。
