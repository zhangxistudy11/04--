//
//  GPSubjectCell.h
//  美食圈圈
//
//  Created by qianfeng on 15-6-30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPSubject.h"

@interface GPSubjectCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UILabel *cardNumberLable;

@property (weak, nonatomic) IBOutlet UILabel *noteLable;

@property(nonatomic,strong) GPSubject * sub;

+(id)subjectCell;


+(id)subjectcellWithTableView:(UITableView*)tableview;
@end
