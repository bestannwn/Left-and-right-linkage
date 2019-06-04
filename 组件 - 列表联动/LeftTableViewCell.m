//
//  LeftTableViewCell.m
//  Linkage
//
//  Created by LeeJay on 16/8/22.
//  Copyright © 2016年 LeeJay. All rights reserved.
//

#import "LeftTableViewCell.h"

#define defaultColor RGBA(61, 199, 190, 1)
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

@interface LeftTableViewCell ()

@property (nonatomic, strong) UIView *yellowView;

@end

@implementation LeftTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(25 * kFitWithWidth, 0, 115 * kFitWithWidth, 90 * kFitWithWidth)];
        self.name.numberOfLines = 2;
        self.name.textColor = kTitleBlackColor ;
        self.name.font = FONT(27 * kFitWithWidth) ;
        
        [self.contentView addSubview:self.name];

        self.yellowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10 * kFitWithWidth, 90 * kFitWithWidth)];
        self.yellowView.backgroundColor = RGB(61, 199, 190) ;
        [self.contentView addSubview:self.yellowView];
    }
    return self;
}

//- (void)awakeFromNib
//{
//    // Initialization code
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state

    self.contentView.backgroundColor = selected ? RGB(245, 244, 247) : kWhiteColor ;
    self.highlighted = selected;
    //self.name.highlighted = selected;
    if (selected) {
        self.name.font = FONT_BOLD(26 * kFitWithWidth) ;
    }else{
        self.name.font = FONT(26 * kFitWithWidth) ;
    }
    // 改变选中cell的 标题颜色
    //self.name.textColor = RGB(247, 97, 76);
    self.yellowView.hidden = !selected;
}

@end
