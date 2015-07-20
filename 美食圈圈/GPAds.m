//
//  GPAds.m
//  美食圈圈
//
//  Created by qianfeng on 15-6-30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "GPAds.h"

@implementation GPAds

+(id)AdsWithDict:(NSDictionary*)dict
{
    return [[self alloc]initAdsWithDict:dict];
}

-(id)initAdsWithDict:(NSDictionary*)dict
{
    
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}


-(NSString*)description
{
    return [NSString stringWithFormat:@"%@ %@",_icon,_name];
}


@end
