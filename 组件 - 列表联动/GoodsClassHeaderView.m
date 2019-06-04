//
//  GoodsClassHeaderView.m
//  PH869-iOS
//
//  Created by Best 石 稳 on 2019/3/19.
//  Copyright © 2019 yjz. All rights reserved.
//

// 当前屏幕宽度
#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
// 当前屏幕高度
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
//根据宽度适配
#define kFitWithWidth   kScreenWidth / 720.0
// 状态栏
#define kStatusHeight   [[UIApplication sharedApplication] statusBarFrame].size.height

// 导航栏高度
#define kNavigationBarHeight self.navigationController.navigationBar.frame.size.height

// 界面头部高度
#define kHeaderHeight (kStatusHeight + kNavigationBarHeight)

//设置字体
#define FONT(size) [UIFont systemFontOfSize:size]
#define FONT_BOLD(size) [UIFont boldSystemFontOfSize:size]
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]

//设置颜色
#define kGrayBackgroundColor RGB(240,240,240)
#define kTitleBlackColor RGB(54, 72, 87) //标题黑色 #333333
#define kGrayBackgroundColor RGB(240,240,240)
#define kWhiteColor [UIColor whiteColor]

#import "GoodsClassHeaderView.h"
#import "GoodsClassCollectionViewLayoutAttributes.h"
#import "UIView+Layout.h"

@implementation GoodsClassHeaderView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = RGB(245, 244, 247) ;
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 520 * kFitWithWidth, self.height)];
        self.title.font = FONT_BOLD(24 * kFitWithWidth);
        self.title.textColor = kTitleBlackColor ;
        self.title.textAlignment = NSTextAlignmentLeft ;
        [self addSubview:self.title];
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    if ([layoutAttributes isKindOfClass:[GoodsClassCollectionViewLayoutAttributes class]]) {
        GoodsClassCollectionViewLayoutAttributes *attr = (GoodsClassCollectionViewLayoutAttributes *)layoutAttributes;
        self.backgroundColor = attr.backgroundColor;
    }
}
@end
