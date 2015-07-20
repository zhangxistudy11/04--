//
//  UIScrollView+GPFooterRefresh.m
//  美食圈圈
//
//  Created by qianfeng on 15-7-7.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "UIScrollView+GPFooterRefresh.h"
#import <objc/runtime.h>
@implementation UIScrollView (GPFooterRefresh)


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

//真正使用的接口,damn it 避免⚠️
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
    NSLog(@"添加成功...");
    [self registerDowmRefreshListen];
    
    [self.footRefresh setStatus:FooterRefreshStatusDraging];
}

-(void)registerDowmRefreshListen
{
    [self removeObserver:self forKeyPath:@"contentOffset"];
    
    
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    //[self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"检测到值改变....");
    if ([keyPath isEqualToString:@"contentOffset"])
    {
        CGPoint point = [[change valueForKey:NSKeyValueChangeNewKey]CGPointValue];
        [self scrollViewDidScroll:point];
    }
}


-(void)scrollViewDidScroll:(CGPoint)point
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
        self.contentInset = UIEdgeInsetsMake(0, 0, 0/*self.footRefresh.frame.size.height+100*/, 0);
        [self.footRefresh setStatus:FooterRefreshStatusLoading];
        
        //执行回调
        [self performSelector:@selector(runBlock) withObject:nil afterDelay:2];
    }
    
}

-(void)runBlock
{
    self.addDownHandlerBlock();
    [self.footRefresh removeFromSuperview];
}


-(void)removeFromSuperview
{
    [self removeObserver:self forKeyPath:@"contentOffset"];
}

@end
