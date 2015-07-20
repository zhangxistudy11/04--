//
//  GPHeaderRefresh.h
//  美食圈圈
//
//  Created by qianfeng on 15-7-2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GPHeaderRefresh : UIView

typedef enum GPHeaderRefreshStatus{
    HeaderRefreshStatusDraging,
    HeaderRefreshStatusLoading,
    HeaderRefreshStatusEndDraing
    
}GPHeaderRefreshStatus;


@property (nonatomic,assign) GPHeaderRefreshStatus state;

+(GPHeaderRefresh*)headerRefresh;

@property (nonatomic,retain) UIScrollView * scrollView;

@end
