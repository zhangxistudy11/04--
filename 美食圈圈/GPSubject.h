//
//  GPSubject.h
//  美食圈圈
//
//  Created by qianfeng on 15-6-30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface GPSubject : NSObject

/**
*  用户存储话题标题内容
*/
@property(nonatomic,copy) NSString *title;

/**
 *  用户存储跟帖人数
 */
@property(nonatomic,copy) NSString *cardNumber;

/**
 *  用户存储帖子内容
 */
@property(nonatomic,copy) NSString *note;

/**
 *  icon图片
 */
@property(nonatomic,copy) NSString *icon;


/**
 *  获得Subject
 *
 *  @param dict 内部使用KVC进行数据封装
 *
 *  @return id
 */
+(id)subjectWithDict:(NSDictionary*)dict;

-(id)initWithDict:(NSDictionary*)dict;

@end
