//设置字体
//
//  GoodsClassCollectionViewCell.m
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

//设置颜色
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]
#define kGrayBackgroundColor RGB(240,240,240)
#define kTitleBlackColor RGB(54, 72, 87) //标题黑色 #333333
#define kGrayBackgroundColor RGB(240,240,240)
#define kRedColor [UIColor redColor]
#define kWhiteColor [UIColor whiteColor]
#define kBrownColor [UIColor brownColor]
#define kTitleBlackColor RGB(54, 72, 87) //标题黑色 #333333

#define FONT(size) [UIFont systemFontOfSize:size]

#import "GoodsClassCollectionViewCell.h"
#import "GoodsShopModel.h"
#import "UIView+Layout.h"

#import <UIImageView+WebCache.h>

@interface GoodsClassCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *name;

@end

@implementation GoodsClassCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //self.contentView.backgroundColor = kBrownColor ;
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width * 2 / 3.0)];
        //self.imageV.contentMode = UIViewContentModeScaleAspectFit;
        self.imageV.backgroundColor = kWhiteColor ;
        [self.contentView addSubview:self.imageV];
        
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(0, self.imageV.maxY, self.frame.size.width, 40 * kFitWithWidth)];
        self.name.textColor = kTitleBlackColor ;
        self.name.font = FONT(24 * kFitWithWidth);
        self.name.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.name];
    }
    return self;
}

- (void)setModel:(SubCategoryModel *)model{
    
    _model = model ;
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.icon_url]];
    
//    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.icon_url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        NSLog(@"加载完成") ;
//    }] ;
    
    self.name.text = model.name;
}

@end
