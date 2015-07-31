//
//  MypageTableViewController.m
//  FFDDWB
//
//  Created by fuduoduo on 15/7/31.
//  Copyright (c) 2015年 fuduoduo. All rights reserved.
//

#import "MypageTableViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIImageView+AFNetworking.h"
#import "globalinfo.h"
#import "BlogTableViewCell.h"

@interface MypageTableViewController(){
    NSDictionary *myhomepagedictionary;
    NSMutableArray *myhomepagearray;
    NSArray *mystatuestimearray;
    NSArray *mystatuestextarray;
    NSArray *retweetedstatusarray;
    NSArray *mystatuesphotoarray;
    NSMutableData *myhomepagedata;
    CGFloat cellheight;
}

@end


@implementation MypageTableViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.myhomepagetableview registerNib:[UINib nibWithNibName:NSStringFromClass([BlogTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"blogcellidentifier"];
    if (!myhomepagearray) {
        myhomepagearray = [NSMutableArray array];
    }
    [self homepageRequest];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect bounds = [UIScreen mainScreen].bounds;
    self.myhomepagetableview.frame=CGRectMake(bounds.origin.x,bounds.origin.y,bounds.size.width,bounds.size.height);
}

-(void)homepageRequest{
    NSString *uid=[globalinfo getuid];
    NSString *_access_token=[globalinfo getaccesstoken];
    NSDictionary *parameters=@{@"access_token":_access_token,@"uid":uid};
    AFHTTPRequestOperationManager *myhomepage=[AFHTTPRequestOperationManager manager];
    [myhomepage GET:@"https://api.weibo.com/2/statuses/user_timeline.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        [myhomepagearray addObjectsFromArray:[responseObject valueForKey:@"statuses"]];
        //       NSLog(@"memememmmmmmmmmmmmmmmmmmmmmmmmmmmmmm%@",responseObject);
        [self.myhomepagetableview reloadData];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
    }
     ];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //    NSLog(@"%s, %lu", __func__, (unsigned long)namearray.count);
    //    return followerarray.count;
    return myhomepagearray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellheight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellidentifier=@"blogcellidentifier";
    BlogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier forIndexPath:indexPath];
    //清楚cell的缓存
    
    
    //头像，昵称，发布时间
    mystatuestimearray=[myhomepagearray valueForKeyPath:@"created_at"];
    cell.nameLabel.text=[globalinfo getname];
    cell.timeLabel.text=[mystatuestimearray objectAtIndex:indexPath.row];
    NSString *myImageUrl=[globalinfo getmyimage];
    NSURL *url=[NSURL URLWithString:[myImageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [cell.headImage setImageWithURL:url];
    
    //我发的text和photo
    mystatuestextarray=[myhomepagearray valueForKeyPath:@"text"];
    mystatuesphotoarray=[myhomepagearray valueForKeyPath:@"pic_urls"];
    NSArray *statuesphoto=[mystatuesphotoarray objectAtIndex:indexPath.row];
    [cell setmyTextAndHeight:[mystatuestextarray objectAtIndex:indexPath.row]];
    NSLog(@"statuesphoto-----------> %@", statuesphoto);
    if (!statuesphoto.count==0 ) {
        cell.image1fromMytext.active=YES;
        cell.image1fromReweetedtext.active=NO;
        [cell setPhotoAndNumber:statuesphoto];
    }
     
    //    NSLog(@"mystatues.text ---------------> %@",mystatuestextarray);
    
    //转发的微博
    retweetedstatusarray=[myhomepagearray valueForKeyPath:@"retweeted_status"];
    NSArray *reweetedstatues=[retweetedstatusarray objectAtIndex:indexPath.row];
    NSArray *reweetedstatuesID=[reweetedstatues valueForKey:@"id"];
    NSLog(@"reweetedstatues-----------> %@", reweetedstatues);
    
    if (![reweetedstatuesID isKindOfClass:[NSNull class]] ) {
        cell.image1fromMytext.active=NO;
        cell.image1fromReweetedtext.active=YES;
        [cell setretweetedblogview:reweetedstatues];
    }
    //   NSLog(@"reweeted status array -----------> %@",retweetedstatusarray);
    cellheight=[cell getcellheight];
    return cell;
}

-(void)viewDidAppear:(BOOL)animated{
    //     NSLog(@"retweetedstatusarray ------------> %@",retweetedstatusarray);
    //    NSLog(@"rererererrrrrrr%lu,%lu",retweetedstatusarray.count,mystatuestextarray.count);
    
}

- (UITableView *)myhomepagetableview
{
    return (UITableView *)self.view;
}
@end
