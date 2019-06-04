//
//  GoodsClassCollectionViewCell.h
//  PH869-iOS
//
//  Created by Best 石 稳 on 2019/3/19.
//  Copyright © 2019 yjz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define kCellIdentifier_CollectionView @"CollectionViewCell"

@class SubCategoryModel;

@interface GoodsClassCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) SubCategoryModel *model;

@end



NS_ASSUME_NONNULL_END
