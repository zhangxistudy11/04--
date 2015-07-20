//
//  GPContentView.h
//  美食圈圈
//
//  Created by qianfeng on 15-6-30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GPSubject;
@class GPContentView;
typedef void(^didSelectRowAtIndexPath)(GPContentView* contentView,NSIndexPath * indexPath,GPSubject *subject);



@interface GPContentView : UIView

/**
 *  用于存储话题模型数组
 */
@property(nonatomic,strong) NSMutableArray *subjects;
@property(nonatomic,strong) didSelectRowAtIndexPath didSelectRowAtIndexPathBlock;


+(id)contentView;

+(id)contentViewWithBlock:(void(^)(GPContentView* contentView,NSIndexPath * indexPath,GPSubject *subject))block andInstanceView:(UIView*)view;

//修改原有方法时，不能直接修改,如果直接修改，可能会导致没有升级的用户程序崩溃
//不过在新的功能中不能继续使用
+(id)contentViewWithBlock:(void(^)(GPContentView* contentView,NSIndexPath * indexPath,GPSubject *subject))block andInstanceView:(UIView*)view andModel:(NSArray*)models;

@end
