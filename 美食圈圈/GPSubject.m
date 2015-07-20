//
//  GPSubject.m
//  美食圈圈
//
//  Created by qianfeng on 15-6-30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "GPSubject.h"

@implementation GPSubject


+(id)subjectWithDict:(NSDictionary*)dict
{
    return [[self alloc]initWithDict:dict];
}


-(id)initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if (self) {
        //模型数据封装
        //缺点:属性很多的时候,不能一一记得属性
        //容易写错
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

-(NSString*)description
{
    return [NSString stringWithFormat:@"title %@,cardNumber %@,note %@,icon %@",_title,_cardNumber,_note,_icon];
}

@end
