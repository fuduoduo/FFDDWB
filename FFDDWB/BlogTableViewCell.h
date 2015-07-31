//
//  BlogTableViewCell.h
//  FFDDWB
//
//  Created by fuduoduo on 15/7/28.
//  Copyright (c) 2015年 fuduoduo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlogTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *textsourceLabel;
@property (weak, nonatomic) IBOutlet UIView *retweetedblogView;
@property (weak, nonatomic) IBOutlet UIImageView *photoImage1;
@property (weak, nonatomic) IBOutlet UIImageView *photoImage2;
@property (weak, nonatomic) IBOutlet UIImageView *photoImage3;
@property (weak, nonatomic) IBOutlet UIImageView *photoImage4;
@property (weak, nonatomic) IBOutlet UIImageView *photoImage5;
@property (weak, nonatomic) IBOutlet UIImageView *photoImage6;
@property (weak, nonatomic) IBOutlet UIImageView *photoImage7;
@property (weak, nonatomic) IBOutlet UIImageView *photoImage8;
@property (weak, nonatomic) IBOutlet UIImageView *photoImage9;
@property (weak, nonatomic) IBOutlet UILabel *reweetednameLabel;
@property (weak, nonatomic) IBOutlet UILabel *reweetedtextLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *image1fromReweetedtext;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *image1fromMytext;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightofMytext;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightofReweetedView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightofReweetedText;
-(void)setmyTextAndHeight:(NSString *)text;
-(void)setReweetedTextAndHeight:(NSString *)text;
-(void)setPhotoAndNumber:(NSArray *)photoarray;
-(void)setretweetedblogview:(NSArray *)source;
-(CGFloat)getcellheight;


@end
