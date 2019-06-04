//
//  GoodsShopModel.h
//  PH869-iOS
//
//  Created by Best 石 稳 on 2019/3/19.
//  Copyright © 2019 yjz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsShopModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray *subcategories;

@end

@interface SubCategoryModel : NSObject

@property (nonatomic, copy) NSString *icon_url;
@property (nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
