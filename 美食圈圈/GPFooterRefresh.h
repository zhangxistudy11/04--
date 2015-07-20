//
//  GPFooterRefresh.h
//  美食圈圈
//
//  Created by qianfeng on 15-7-1.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

enum FooterRefreshStatus
{
    FooterRefreshStatusDraging,     //拖拽读取更多
    FooterRefreshStatusEndDraging,  //松开读取更多
    FooterRefreshStatusLoading      //正在读取
};

typedef enum FooterRefreshStatus FooterRefreshStatus;



@interface GPFooterRefresh : UIView

/**
 *  根据传入的状态进行变化,进行提示数据的切换
 */
@property(nonatomic,assign) FooterRefreshStatus status;

+(id)GPFooterRefresh;

@end
