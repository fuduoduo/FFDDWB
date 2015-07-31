//
//  InfoTableViewCell.m
//  FFDDWB
//
//  Created by fuduoduo on 15/7/24.
//  Copyright (c) 2015年 fuduoduo. All rights reserved.
//

#import "InfoTableViewCell.h"
@interface InfoTableViewCell()
@end
@implementation InfoTableViewCell

- (void)prepareForReuse{
    [super prepareForReuse];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.friendname.font=[UIFont boldSystemFontOfSize:18];
    self.friendtext.font=[UIFont boldSystemFontOfSize:13];
    self.friendtext.textColor=[UIColor grayColor];
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
