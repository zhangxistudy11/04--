//
//  GPCircleController.m
//  美食圈圈
//
//  Created by qianfeng on 15-6-30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "GPCircleController.h"
#import "GPSubject.h"
#import "GPAds.h"
#import "GPSubjectCell.h"
#import "GPContentView.h"
@interface GPCircleController ()
/**
 *  存储plist数组
 */
@property(nonatomic,strong) NSArray *plsit;

/**
 *  用于存储话题模型数组
 */
@property(nonatomic,strong) NSArray *subjects;

@property(nonatomic,strong) NSArray *adses;

@end
@implementation GPCircleController


-(NSArray *)subjects
{
    
    if (_subjects == nil) {
        //获取数组
        NSMutableArray *objs = [[NSMutableArray alloc]init];
        NSArray * tmp = self.plsit[1];
        for (NSDictionary * dict in tmp) {
            GPSubject * sub = [GPSubject subjectWithDict:dict];
            [objs addObject:sub];
        }
        _subjects = objs;
    }
    
    return _subjects;
}


-(NSArray*)plsit
{
    if (_plsit == nil) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"quanquan.plist" ofType:nil];
        _plsit = [NSArray arrayWithContentsOfFile:path];
    }
    
    return _plsit;
}


-(NSArray *)adses
{
    if (_adses == nil) {
        NSArray * tmp = self.plsit[0];
        NSMutableArray *objs = [[NSMutableArray alloc]init];
        for (NSDictionary *dict in tmp) {
            GPAds *gpads = [[GPAds alloc]init];
            [gpads setValuesForKeysWithDictionary:dict];
            [objs addObject:gpads];
        }
        _adses = objs;
    }
    return _adses;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    GPContentView * contentView = [GPContentView contentView];
//    [self.view addSubview:contentView];
//    contentView.subjects = self.subjects;
    
    
//    GPContentView *contentView = [GPContentView contentViewWithBlock:^(GPContentView *contentView, NSIndexPath *indexPath, GPSubject *subject) {
//        NSLog(@"点击了row %ld",(long)indexPath.row);
//    } andInstanceView:self.view];
    
//    [GPContentView contentViewWithBlock:^(GPContentView *contentView, NSIndexPath *indexPath, GPSubject *subject) {
//        NSLog(@"this is a test");
//    } :self.view andModel:self.subjects];
    
    [GPContentView contentViewWithBlock:^(GPContentView *contentView, NSIndexPath *indexPath, GPSubject *subject) {
        NSLog(@"ads");
    } andInstanceView:self.view andModel:self.subjects];
}



/**
 *  隐藏状态栏
 *
 *  @return
 */

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
