//
//  GPContentView.m
//  美食圈圈
//
//  Created by qianfeng on 15-6-30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "GPContentView.h"
#import "GPSubjectCell.h"
#import "GPFooterRefresh.h"
#import "GPHeaderRefresh.h"
#import "UIScrollView+GPHeadRefresh.h"


@interface GPContentView ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak,nonatomic) GPFooterRefresh * footrefresh;

@property (weak,nonatomic) GPHeaderRefresh * headrefresh;

@end
@implementation GPContentView


//测试initWithFrame
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //1.创建子控件
        //tableView
        NSLog(@"%@",NSStringFromCGRect(frame));
        UITableView *tableView = [[UITableView alloc] init];
        [self addSubview:tableView];
        tableView.delegate = self;
        tableView.dataSource = self;
        self.tableView = tableView;
    }
    return self;
}


-(void)addUpRefreshAndDownRefreshUI
{
//    __weak GPContentView * weakSelf = self;
//    
//    [self.tableView addUpRefreshHandle:^{
//        NSLog(@"开始请求网络...");
//        [self netInsertData];
//        //重新加载数据
//        [weakSelf.tableView reloadData];
//    }];
    
    
    [self.tableView addDownRefreshHandler:^{
        //NSLog(@"footrefresh....");
    }];
    //NSLog(@"do end....");
}


-(void)netInsertData {
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 2);
    
    dispatch_after(time, dispatch_get_main_queue(), ^{
        NSLog(@"请求网络操作....");
        //[self.subjects addObjectsFromArray:self.subjects];
        //[self.tableView reloadData];
    });
    
    NSLog(@"dispatch_after Block下面的函数....");
    //NSLog(@"网络请求执行完毕....");
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"请求网络数据....");
//        NSLog(@"开始加载数据...");
//    });
}

/**
 *  lazy 加载
 *
 *  @return GPFooterRefresh
 */
-(GPFooterRefresh*)footrefresh
{
    if (_footrefresh == nil) {
        GPFooterRefresh * footrefresh = [GPFooterRefresh GPFooterRefresh];
        _footrefresh = footrefresh;
        [self.tableView addSubview:footrefresh];
    }
    return _footrefresh;
}

-(GPHeaderRefresh*)headrefresh
{
    if (_headrefresh == nil) {
        GPHeaderRefresh *headRefresh = [GPHeaderRefresh headerRefresh];
        _headrefresh = headRefresh;
        [self.tableView addSubview:_headrefresh];
    }
    return _headrefresh;
}

-(void)setSubjects:(NSArray *)subjects
{
    _subjects = subjects;
    [self.tableView reloadData];
}

+(id)contentView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

+(id)contentViewWithBlock:(void(^)(GPContentView* contentView,NSIndexPath * indexPath,GPSubject *subject))block andInstanceView:(UIView*)view
{
    GPContentView *contentView = [self contentView];
    [view addSubview:contentView];
    return contentView;
}

+(id)contentViewWithBlock:(void(^)(GPContentView* contentView,NSIndexPath * indexPath,GPSubject *subject))block andInstanceView:(UIView*)view andModel:(NSArray*)models
{
    GPContentView *contentView = [self contentViewWithBlock:block andInstanceView:view];
    contentView.subjects = models;
    return contentView;
}

-(void)awakeFromNib
{
    //设置分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

//self即将被添加到父视图上时调用
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    self.frame = newSuperview.bounds;
    self.backgroundColor = [UIColor redColor];
    self.tableView.frame = self.bounds;
    
    [self addUpRefreshAndDownRefreshUI];
}

#pragma mark 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _subjects.count;
}

#pragma mark 数据源方法
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GPSubjectCell *cell = [GPSubjectCell subjectcellWithTableView:tableView];
    cell.sub = [self.subjects objectAtIndex:indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"index path row... %ld",(long)indexPath.row);
    //点击了哪一行
    //点击了哪一组
    //这一组的数据模型
    if (self.didSelectRowAtIndexPathBlock)
    {
        //self.didSelectRowAtIndexPathBlock(self,indexPath,self.subjects[indexPath.row]);
    }
}

#pragma mark ScrollViewDelegate方法
//什么时候加载到uitable上
/*-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //GPFooterRefresh * aa = [GPFooterRefresh GPFooterRefresh];
    //[self.tableView addSubview:aa];
    //NSLog(@"this is contentSizeHeight %f",scrollView.contentSize.height);
    //NSLog(@"this is contentoff y %f",scrollView.contentOffset.y);
    CGFloat maxY = scrollView.contentSize.height  - scrollView.frame.size.height;
    CGFloat footHeight = self.footrefresh.frame.size.height;
    
    //如果已经滑动到了底部,设置footer,设置footer的状态为正拖拽加载更多
    if (scrollView.contentOffset.y > maxY && scrollView.contentOffset.y < maxY + footHeight) {
        //NSLog(@"jiazai more");
        [self.footrefresh setStatus:FooterRefreshStatusDraging];
    }
    
    if (scrollView.contentOffset.y > maxY + footHeight) {
        [self.footrefresh setStatus:FooterRefreshStatusEndDraging];
    }
    
    CGFloat headHeight = self.headrefresh.frame.size.height;
    if (scrollView.contentOffset.y < 0)
    {
        //NSLog(@"拖拽开始...");
        [self.headrefresh setState:HeaderRefreshStatusDraging];
    }
    if (scrollView.contentOffset.y < -headHeight ) {
        [self.headrefresh setState:HeaderRefreshStatusEndDraing];
        //NSLog(@"结束拖拽...");
    }
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"停止拖拽...");
    if (self.footrefresh.status == FooterRefreshStatusEndDraging)
    {
        NSLog(@"))))))))))))))000000000000");
        [self.footrefresh setStatus:FooterRefreshStatusLoading];
        
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, self.footrefresh.frame.size.height, 0);
        //隐藏提示alertBtn
        //2.数据加载完成
        //3.恢复contentSize的值
        //删除
        //4.模拟网络加载数据的真实情况
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 2);
        
        //GCD 延迟执行方法
        dispatch_after(time, dispatch_get_main_queue(), ^{
            
            //回复contentSet的值
            scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            [self.footrefresh removeFromSuperview];
            [self.subjects addObjectsFromArray:self.subjects];
            [self.tableView reloadData];
        });
    }
    
    if (self.headrefresh.state == HeaderRefreshStatusEndDraing)
    {
        NSLog(@"刷新....");
        
        [self.headrefresh setState:HeaderRefreshStatusLoading];
        
        scrollView.contentInset = UIEdgeInsetsMake(self.headrefresh.frame.size.height, 0, 0, 0);
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 2);
        
        dispatch_after(time, dispatch_get_main_queue(), ^{
            scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            [self.headrefresh removeFromSuperview];
            //[self.subjects addObjectsFromArray:self.subjects];
            //[self.tableView reloadData];
        });
        
    }
    
}*/
@end
