//
//  GoodsClassCollectionViewFlowLayout.h
//  PH869-iOS
//
//  Created by Best 石 稳 on 2019/3/19.
//  Copyright © 2019 yjz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GoodsClassFlowLayoutDelegate <UICollectionViewDelegateFlowLayout>

- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout backgroundColorForSection:(NSInteger)section;

@end

@interface GoodsClassCollectionViewFlowLayout : UICollectionViewFlowLayout

/**
 *  导航栏高度，默认为0
 */
@property (nonatomic, assign) CGFloat navHeight;

@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *decorationViewAttrs;

@end

NS_ASSUME_NONNULL_END
