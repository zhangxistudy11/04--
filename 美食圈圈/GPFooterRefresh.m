//
//  GPFooterRefresh.m
//  美食圈圈
//
//  Created by qianfeng on 15-7-1.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "GPFooterRefresh.h"

@interface GPFooterRefresh ()

//提示加载更多
@property (nonatomic,retain) UIButton *alertButton;

@property (nonatomic,retain) UIView *loadingView;
@end


@implementation GPFooterRefresh

-(UIView*)loadingView
{
    if (_loadingView == nil) {
        UIView *loadView = [[UIView alloc]init];
        loadView.frame = self.bounds;
        [self addSubview:loadView];
        self.loadingView = loadView;
        
        //创建菊花
        UIActivityIndicatorView * activityView = [[UIActivityIndicatorView alloc]init];
        [loadView addSubview:activityView];
        [activityView startAnimating];
        
        CGFloat activityViewX = 0;
        CGFloat activityViewY = 0.0;

        activityView.frame = CGRectMake(100, 0, 30, 30);
        activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        
        //添加UILable
        UILabel *label = [[UILabel alloc]init];
        label.text = @"正在读取...";
        [loadView addSubview:label];
        
        
        CGFloat labelX = activityViewX + 150;
        CGFloat labelY = 0;
        label.frame = CGRectMake(labelX, labelY, 200, 30);
    }
    
    return _loadingView;
}

-(UIButton*)alertButton
{
    if (_alertButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"拖拽读取更多" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
        btn.frame = self.bounds;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        
        btn.userInteractionEnabled = NO;
        //设置标识图片距离文字间距50
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 50);
        //箭头默认方向为指向上面
        btn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        [self addSubview:btn];
        _alertButton = btn;
    }
    return _alertButton;
}

+(id)GPFooterRefresh
{
    return [[self alloc]init];
}

-(void)setStatus:(FooterRefreshStatus)status
{
    _status = status;
    switch (status) {
        case FooterRefreshStatusDraging:
        {
            //NSLog(@"拖拽读取更多...");
            [self.alertButton setTitle:@"拖拽读取更多" forState:UIControlStateNormal];
            self.alertButton.imageView.transform = CGAffineTransformMakeRotation(M_PI);
            break;
        }
        case FooterRefreshStatusEndDraging:
        {
            [self.alertButton setTitle:@"松开读取更多" forState:UIControlStateNormal];
            [UIView animateWithDuration:0.2 animations:^{
                self.alertButton.imageView.transform = CGAffineTransformIdentity;
            }];
            //NSLog(@"松开读取更多...");
            break;
        }
        case FooterRefreshStatusLoading:
        {
            [self loadingView];
            self.alertButton.hidden = YES;
            //NSLog(@"松开加载更多...");
            break;
        }
        default:
            break;
    }
}


//将要显示在SuperView上时候

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    NSLog(@"footer's superView is %@",newSuperview);
    UIScrollView *tableView = (UIScrollView*)newSuperview;
    CGFloat selfX = 0.0f;
    CGFloat selfY = tableView.contentSize.height;
    CGFloat selfW = tableView.frame.size.width;
    CGFloat selfH = 60;
    
    self.backgroundColor = [UIColor lightGrayColor];
    self.frame = CGRectMake(selfX, selfY, selfW, selfH);
    self.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:255];
    
}

@end
