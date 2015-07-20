//
//  GPHeaderRefresh.m
//  美食圈圈
//
//  Created by qianfeng on 15-7-2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "GPHeaderRefresh.h"

@interface GPHeaderRefresh ()

@property (nonatomic,retain) UIButton *alertButton;

@property (nonatomic,retain) UIView *loadingView;



@end


@implementation GPHeaderRefresh

+(GPHeaderRefresh*)headerRefresh
{
    GPHeaderRefresh * refresh = [[GPHeaderRefresh alloc]init];
    return refresh;
}


-(void)setState:(GPHeaderRefreshStatus)state
{
    if (state == HeaderRefreshStatusDraging) {
        _state = HeaderRefreshStatusDraging;
        [self.alertButton setTitle:@"拖拽读取更多" forState:UIControlStateNormal];
    } else if (state == HeaderRefreshStatusEndDraing) {
        _state = HeaderRefreshStatusEndDraing;
        [self.alertButton setTitle:@"松开加载更多" forState:UIControlStateNormal];
        [UIView animateWithDuration:0.2 animations:^{
            self.alertButton.imageView.transform = CGAffineTransformMakeRotation(-3.14);
        }];
    } else if (state == HeaderRefreshStatusLoading) {
        _state = HeaderRefreshStatusLoading;
        self.alertButton.hidden = YES;
        [self loadingView];
    }
}


-(UIButton*)alertButton
{
    if (_alertButton == nil) {
        UIButton *alertButton = [UIButton buttonWithType:UIButtonTypeSystem];
        alertButton.frame = CGRectMake(0, 10, 320, 40);
        [alertButton setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
        [alertButton setTitle:@"拖拽加载更多" forState:UIControlStateNormal];
        _alertButton = alertButton;
        [self addSubview:_alertButton];
    }
    return _alertButton;
}

-(UIView*)loadingView
{
    if (_loadingView == nil) {
        //添加view
        UIView *view = [[UIView alloc]init];
        view.frame = self.bounds;
        [self addSubview:view];
        
        //添加菊花
        UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc]init];
        [view addSubview:activity];
        
        CGFloat activiX = 135;
        //CGFloat activiY = view.frame.size.height/2-20;
        NSLog(@"yyyy====%f",view.frame.size.height);
        
        activity.frame = CGRectMake(activiX, 15, 30, 30);
        
        NSLog(@"xxxxx====%f",activity.frame.size.height);
        [activity startAnimating];
        
        
        view.backgroundColor = [UIColor lightGrayColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(activiX+30, 15, 100, 30)];
        label.text = @"正在刷新...";
        [view addSubview:label];
        _loadingView = view;
    }
    return _loadingView;
}



/**
 *  即将显示在主界面上的时候
 *
 *  @param newSuperview
 */
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    self.frame = newSuperview.bounds;
    self.backgroundColor = [UIColor lightGrayColor];
    CGFloat X = 0.0;
    CGFloat Y = -60;
    CGFloat Width = newSuperview.frame.size.width;
    CGFloat Height = 60;
    
    self.frame = CGRectMake(X, Y, Width, Height);
}

@end
