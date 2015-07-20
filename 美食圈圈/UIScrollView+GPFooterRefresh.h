//
//  UIScrollView+GPFooterRefresh.h
//  美食圈圈
//
//  Created by qianfeng on 15-7-7.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPFooterRefresh.h"
typedef void(^addDownHandler)();

@interface UIScrollView (GPFooterRefresh)

@property(nonatomic,copy) addDownHandler addDownHandlerBlock;


/**
 *  一个中间变量,一个真正使用的变量
 */
@property(nonatomic,retain) GPFooterRefresh *footRefresh_t;
@property(nonatomic,retain) GPFooterRefresh *footRefresh;


-(void)addDownRefreshHandler:(void(^)())addDownHandler;

@end
