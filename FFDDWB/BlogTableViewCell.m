//
//  BlogTableViewCell.m
//  FFDDWB
//
//  Created by fuduoduo on 15/7/28.
//  Copyright (c) 2015年 fuduoduo. All rights reserved.
//

#import "BlogTableViewCell.h"
#import "UIImageView+AFNetworking.h"
@interface BlogTableViewCell(){
    NSArray *photoUrl;
    CGFloat cellheight;
    CGFloat reweetedviewheight;
}

@end
@implementation BlogTableViewCell
@synthesize headImage;
@synthesize nameLabel;
@synthesize timeLabel;
@synthesize textsourceLabel;

@synthesize retweetedblogView;
@synthesize reweetedtextLabel;
@synthesize reweetednameLabel;

@synthesize photoImage1;
@synthesize photoImage2;
@synthesize photoImage3;
@synthesize photoImage4;
@synthesize photoImage5;
@synthesize photoImage6;
@synthesize photoImage7;
@synthesize photoImage8;
@synthesize photoImage9;

@synthesize image1fromMytext;
@synthesize image1fromReweetedtext;

@synthesize heightofMytext;
@synthesize heightofReweetedText;
@synthesize heightofReweetedView;

- (void)prepareForReuse{
    [super prepareForReuse];
    textsourceLabel.hidden=YES;
    retweetedblogView.hidden=YES;
    reweetedtextLabel.hidden=YES;
    reweetednameLabel.hidden=YES;
    photoImage1.hidden=YES;;
    photoImage2.hidden=YES;
    photoImage3.hidden=YES;
    photoImage4.hidden=YES;
    photoImage5.hidden=YES;
    photoImage6.hidden=YES;
    photoImage7.hidden=YES;
    photoImage8.hidden=YES;
    photoImage9.hidden=YES;

}

- (void)awakeFromNib {
    // Initialization code
//    self.nameLabel.font=[UIFont boldSystemFontOfSize:18];
//    self.timeLabel.font=[UIFont boldSystemFontOfSize:13];
    self.timeLabel.textColor=[UIColor grayColor];
    CGRect bounds = [UIScreen mainScreen].bounds;
    self.contentView.frame=CGRectMake(bounds.origin.x,bounds.origin.y,bounds.size.width,bounds.size.height);
    cellheight=(CGFloat)70;
    reweetedviewheight=0;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // TODO:
    
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//    // Configure the view for the selected state
////    textsourceLabel.lineBreakMode = NSLineBreakByWordWrapping;
////    CGSize size = [textsourceLabel sizeThatFits:CGSizeMake(textsourceLabel.frame.size.width, MAXFLOAT)];
////    textsourceLabel.frame = CGRectMake(textsourceLabel.frame.origin.x, textsourceLabel.frame.origin.y, textsourceLabel.frame.size.width, size.height);
////    CGRect frame=self.frame;
////    frame.size.height=size.height+100;
////    self.frame=frame;
//// NSLog(@"=.=.=.=.=heigheihihihihii%f",size.height);
//}

-(void)setmyTextAndHeight:(NSString *)text{
    cellheight=(CGFloat)140;
    reweetedviewheight=20;
    textsourceLabel.hidden=NO;
    self.textsourceLabel.text=text;
    self.textsourceLabel.numberOfLines=0;
    self.textsourceLabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [textsourceLabel sizeThatFits:CGSizeMake(textsourceLabel.frame.size.width, MAXFLOAT)];
 self.heightofMytext.constant = size.height;
    cellheight+=size.height;
    NSLog(@"cellheight ========  %f",cellheight);
}

-(void)setReweetedTextAndHeight:(NSString *)text{
    reweetedtextLabel.text=text;
    reweetedtextLabel.numberOfLines=0;
    reweetednameLabel.hidden=NO;
    reweetedtextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [reweetedtextLabel sizeThatFits:CGSizeMake(reweetedtextLabel.frame.size.width, MAXFLOAT)];
    self.heightofReweetedText.constant = size.height;
    cellheight+=size.height;
    reweetedviewheight+=size.height;
}

-(void)setPhotoAndNumber:(NSArray *)photoarray{
  photoUrl = [photoarray valueForKeyPath:@"thumbnail_pic"];
    NSLog(@"mystatued photoUrl -------> %@",photoUrl);
    if (!(photoUrl.count==0)) {
        for (int i=0; i<9; i=i+1) {
            if ( i<photoUrl.count) {
                UIImageView *photo=(UIImageView *)[self.contentView viewWithTag:i+1];
                photo.hidden = NO;
                NSString *ImageUrl=[photoUrl objectAtIndex:i];
                NSLog(@"%@",ImageUrl);
                NSURL *url=[NSURL URLWithString:[ImageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                [photo setImageWithURL:url];
                NSLog(@"photo frame --> %@", NSStringFromCGRect(photo.frame));
            }else{
                [self.contentView viewWithTag:i+1].hidden=YES;
            }
          
        }
        cellheight+=(photoUrl.count/3+1)*100+8;
        reweetedviewheight+=(photoUrl.count/3+1)*100+8;
    }
}

-(void)setretweetedblogview:(NSArray *)source{
    
    NSArray *reweetedbloguser=[source valueForKey:@"user"];
    NSString *reweetedblogtext=[source valueForKey:@"text"];
    NSArray  *reweetedblogphoto=[source valueForKey:@"pic_urls"];
    if(![source isKindOfClass:[NSNull class]]){
        reweetednameLabel.hidden=NO;
        reweetedtextLabel.hidden=NO;
        retweetedblogView.hidden=NO;
        reweetednameLabel.text=[reweetedbloguser valueForKey:@"name"];
        reweetedviewheight+=reweetednameLabel.frame.size.height;
        cellheight+=reweetednameLabel.frame.size.height;
//        NSLog(@"trweetedname____________------->%@",reweetedblogname);
        reweetedtextLabel.text=reweetedblogtext;

        self.reweetedtextLabel.numberOfLines=0;
        self.reweetedtextLabel.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size = [self.reweetedtextLabel sizeThatFits:CGSizeMake(self.reweetedtextLabel.frame.size.width, MAXFLOAT)];
        self.heightofReweetedText.constant=size.height;
        cellheight+=size.height;
        reweetedviewheight+=size.height;
        
        if (!reweetedblogphoto.count==0) {
            [self setPhotoAndNumber:reweetedblogphoto];
        }

        heightofReweetedView.constant=reweetedviewheight;

        
    }
}
-(CGFloat) getcellheight{
    return cellheight;
}

@end
