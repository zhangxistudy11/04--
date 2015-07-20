//
//  GPSubjectCell.m
//  美食圈圈
//
//  Created by qianfeng on 15-6-30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "GPSubjectCell.h"

@interface GPSubjectCell ()


@end

@implementation GPSubjectCell



- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}



-(void)setSub:(GPSubject *)sub
{
    _sub = sub;
    self.iconImageView.image = [UIImage imageNamed:sub.icon];
    self.titleLable.text = sub.title;
    self.cardNumberLable.text = sub.cardNumber;
    self.noteLable.text = sub.note;
}


+(id)subjectCell
{
    UINib *nib = [UINib nibWithNibName:@"GPSujectCell" bundle:nil];
    
    return [[nib instantiateWithOwner:self options:nil] lastObject];
    //return  [[[NSBundle mainBundle]loadNibNamed:@"GPSujectCell" owner:nil options:nil] firstObject];
}

+(id)subjectcellWithTableView:(UITableView*)tableview
{
//    static NSString *inden = @"GPSUBCELL";
//    GPSubjectCell *cell = [tableview dequeueReusableCellWithIdentifier:inden];
//    if (!cell) {
//        UINib *nib = [UINib nibWithNibName:@"GPSujectCell" bundle:nil];
//        cell = [[nib instantiateWithOwner:self options:nil] lastObject];
//    }
    
    NSString *Identifier = NSStringFromClass([self class]);
    UINib *nib = [UINib nibWithNibName:Identifier bundle:nil];
    [tableview registerNib:nib forCellReuseIdentifier:Identifier];
    return [tableview dequeueReusableCellWithIdentifier:Identifier];;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
