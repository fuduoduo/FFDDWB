//
//  InfoTableViewCell.h
//  FFDDWB
//
//  Created by fuduoduo on 15/7/24.
//  Copyright (c) 2015年 fuduoduo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoTableViewCell : UITableViewCell
@property (weak,nonatomic) IBOutlet UILabel *friendname;
@property (weak, nonatomic) IBOutlet UIImageView *friendphoto;
@property(weak,nonatomic)IBOutlet UILabel *friendtext;
@end
