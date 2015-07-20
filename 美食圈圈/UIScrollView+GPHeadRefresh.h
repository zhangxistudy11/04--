//
//  UIScrollView+GPHeadRefresh.h
//  美食圈圈
//
//  Created by qianfeng on 15-7-5.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPHeaderRefresh.h"
#import "GPFooterRefresh.h"

typedef void(^addUpHandler)();

@interface UIScrollView (GPHeadRefresh)

//上拉更新操作
@property(nonatomic,copy) addUpHandler addUpHandlerBlock;

//中间变量,不能直接访问
@property(nonatomic,weak) GPHeaderRefresh *headerRefresht;
@property(nonatomic,weak) GPHeaderRefresh *headerRefresh;

//添加更新操作
-(void)addUpRefreshHandle:(void(^)())addUpHandler;



#pragma mark 上拉刷新,现在必须写在同一个文件？？
typedef void(^addDownHandler)();
@property(nonatomic,copy) addDownHandler addDownHandlerBlock;


/**
 *  一个中间变量,一个真正使用的变量
 */
@property(nonatomic,retain) GPFooterRefresh *footRefresh_t;
@property(nonatomic,retain) GPFooterRefresh *footRefresh;


-(void)addDownRefreshHandler:(void(^)())addDownHandler;

@end