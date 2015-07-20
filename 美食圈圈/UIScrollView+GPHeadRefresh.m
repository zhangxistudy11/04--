//
//  UIScrollView+GPHeadRefresh.m
//  美食圈圈
//
//  Created by qianfeng on 15-7-5.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "UIScrollView+GPHeadRefresh.h"
#import "GPHeaderRefresh.h"
#import <objc/runtime.h>
#import <Foundation/Foundation.h>
@interface UIScrollView ()

@end

@implementation UIScrollView (GPHeadRefresh)

#pragma mark 设置block的get/set方法
//绑定Block
-(addUpHandler)addUpHandlerBlock {
     return objc_getAssociatedObject(self, @selector(addUpHandlerBlock));
}

-(void)setAddUpHandlerBlock:(addUpHandler)addUpHandlerBlock {
    objc_setAssociatedObject(self, @selector(addUpHandlerBlock),addUpHandlerBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark HeadRefresh
//绑定HeadRefresh,给属性增加get/set方法
-(GPHeaderRefresh *)headerRefresht {
    return objc_getAssociatedObject(self, @selector(headerRefresh));
}

-(void)setHeaderRefresht:(GPHeaderRefresh *)headerRefresh {
    objc_setAssociatedObject(self, @selector(headerRefresh), headerRefresh, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//由于不能直接访问成员变量,不能使用懒加载的方式,所以在这里提供另外一个借口访问
-(GPHeaderRefresh *)headerRefresh {
    if (self.headerRefresht == nil) {
        [self setHeaderRefresht:[GPHeaderRefresh headerRefresh]];
        self.headerRefresht.state = HeaderRefreshStatusDraging;
        [self addSubview:self.headerRefresht];
    }
    return self.headerRefresht;
}

/**
 *  给外面的类提供的接口,添加上拉刷新事件
 *
 *  @param addUpHandler blcok
 */
-(void)addUpRefreshHandle:(void (^)())addUpHandler
{
    self.addUpHandlerBlock = addUpHandler;
    [self.headerRefresh setScrollView:self];
    //添加监听
    [self registerKeyAndValueListen];
}

//添加监听
-(void)registerKeyAndValueListen
{
    static int n = 0;
    if (n==0)
    {
        [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        n = 1;
    }
}

//取得监听的值
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint point = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
        //NSLog(@"this is point %@",NSStringFromCGPoint(point));
        self.footRefresh_t.frame = CGRectMake(0, self.contentSize.height, self.frame.size.width, 60);
        [self scrollViewDidScrollView:point];
        [self scrollViewDidScrollForDownRefresh:point];
    }
}

-(void)scrollViewDidScrollView:(CGPoint)point
{
    if (self.isDragging) {
        if (point.y < 0 && self.headerRefresht.state != HeaderRefreshStatusEndDraing) {
            [self.headerRefresh setState:HeaderRefreshStatusDraging];
            //NSLog(@"开始拖拽...");
        }
        if (point.y <= -60 && self.headerRefresh.state != HeaderRefreshStatusEndDraing) {
            //NSLog(@"结束拖拽...");
            [self.headerRefresh setState:HeaderRefreshStatusEndDraing];
        }
    }
    else if(self.headerRefresh.state == HeaderRefreshStatusEndDraing)
    {
        //NSLog(@"开始加载...");
        [self.headerRefresh setState:HeaderRefreshStatusLoading];
        self.contentInset = UIEdgeInsetsMake(self.headerRefresh.frame.size.height, 0, 0, 0);
        
        //执行用户的回调用操作
        if (self.addUpHandlerBlock)
            self.addUpHandlerBlock();
        [self performSelector:@selector(runBlock) withObject:nil afterDelay:2.0];
    }
}


//延迟执行,多线程?异步,阻塞
-(void)runBlock
{
    //NSLog(@"reomove data from data...");
    self.contentInset = UIEdgeInsetsMake(0, 0, self.headerRefresh.frame.size.height, 0);
    [self.headerRefresh removeFromSuperview];
    [self setHeaderRefresht:nil];
}

//移除监听者
-(void)removeFromSuperview
{
    [self removeObserver:self forKeyPath:@"contentOffset"];
}



#pragma mark  上加加载
-(void)setAddDownHandlerBlock:(addDownHandler)addDownHandlerBlock {
    objc_setAssociatedObject(self, @selector(addDownHandlerBlock), addDownHandlerBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(addDownHandler)addDownHandlerBlock {
    return objc_getAssociatedObject(self, @selector(addDownHandlerBlock));
}


-(void)setFootRefresh_t:(GPFooterRefresh *)footRefresh_t {
    objc_setAssociatedObject(self, @selector(footRefresh), footRefresh_t, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(GPFooterRefresh *)footRefresh_t {
    return objc_getAssociatedObject(self, @selector(footRefresh));
}

//真正使用的接口,damn it 避免警告
-(void)setFootRefresh:(GPFooterRefresh *)footRefresh {}
-(GPFooterRefresh *)footRefresh {
    if (self.footRefresh_t == nil) {
        [self setFootRefresh_t:[GPFooterRefresh GPFooterRefresh]];
        [self addSubview:self.footRefresh_t];
    }
    return self.footRefresh_t;
}

/**
 *  提供对外接口,用于设置回调
 *
 *  @param addDownHandler block
 */
-(void)addDownRefreshHandler:(void(^)())addDownHandler
{
    //保存block
    self.addDownHandlerBlock = addDownHandler;
    self.footRefresh;
    //NSLog(@"添加成功...");
    [self registerKeyAndValueListen];
    
    [self.footRefresh setStatus:FooterRefreshStatusDraging];
}


-(void)scrollViewDidScrollForDownRefresh:(CGPoint)point
{
    CGFloat maxY = self.contentSize.height  - self.frame.size.height;
    CGFloat footHeight = self.footRefresh.frame.size.height;
    
    //如果已经滑动到了底部,设置footer,设置footer的状态为正拖拽加载更多
    if (self.isDragging) {
        if (self.contentOffset.y > maxY && self.contentOffset.y < maxY + footHeight) {
            //NSLog(@"jiazai more");
            [self.footRefresh setStatus:FooterRefreshStatusDraging];
        }
        if (self.contentOffset.y > maxY + footHeight) {
            [self.footRefresh setStatus:FooterRefreshStatusEndDraging];
        }
    }
    //停止拖拽 && 到达指定位置
    else if (self.footRefresh.status == FooterRefreshStatusEndDraging)
    {
        //NSLog(@"Footer结束拖拽...");
        self.contentInset = UIEdgeInsetsMake(0, 0, self.footRefresh.frame.size.height, 0);
        [self.footRefresh setStatus:FooterRefreshStatusLoading];
        
        //执行回调
        if (self.addUpHandlerBlock)
            self.addUpHandlerBlock();
        [self performSelector:@selector(runDownBlock) withObject:nil afterDelay:2];
    }
    
}


#pragma mark 下拉刷新事件
-(void)runDownBlock
{
    self.contentInset = UIEdgeInsetsMake(self.headerRefresh.frame.size.height, 0, 0, 0);
    [self.footRefresh_t removeFromSuperview];
    self.footRefresh_t = nil;
}
@end