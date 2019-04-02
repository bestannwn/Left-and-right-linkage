//
//  AppDelegate.h
//  组件 - 列表联动
//
//  Created by Best 石 稳 on 2019/4/2.
//  Copyright © 2019 石稳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

