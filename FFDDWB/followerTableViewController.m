//
//  followerTableViewController.m
//  FFDDWB
//
//  Created by fuduoduo on 15/7/27.
//  Copyright (c) 2015年 fuduoduo. All rights reserved.
//

#import "followerTableViewController.h"
#import "InfoTableViewCell.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIImageView+AFNetworking.h"
#import "globalinfo.h"

@interface followerTableViewController(){
    NSDictionary *followerdictionary;
    NSMutableArray *followerarray;
    NSArray *followernamearray;
    NSArray *followertextarray;
    NSArray *followerphotoarray;
    NSArray *isfriendarray;
    NSMutableData *followershowdata;
}

@end

@implementation followerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.followertableview registerNib:[UINib nibWithNibName:NSStringFromClass([InfoTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cellidentifier"];
    if (!followerarray) {
        followerarray = [NSMutableArray array];
    }
    [self friendRequest];
}

-(void)friendRequest{
    NSString *uid=[globalinfo getuid];
    NSString *_access_token=[globalinfo getaccesstoken];
    NSDictionary *parameters = @{@"access_token":_access_token,@"uid":uid,@"trim_status":@"0"};
    AFHTTPRequestOperationManager *accountfriendinfomation = [AFHTTPRequestOperationManager manager];
    [accountfriendinfomation GET:@"https://api.weibo.com/2/friendships/followers.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [followerarray addObjectsFromArray:[responseObject valueForKey:@"users"]];
        [self.followertableview reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error --> %@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect bounds = [UIScreen mainScreen].bounds;
    self.followertableview.frame=CGRectMake(bounds.origin.x,bounds.origin.y,bounds.size.width,bounds.size.height);
    NSLog(@"screen width ----------> %f", bounds.size.width);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%s, %lu", __func__, (unsigned long)followernamearray.count);
    return followerarray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(30, 8, 100, 24)];
    label1.font=[UIFont boldSystemFontOfSize:14];
    label1.backgroundColor=[UIColor lightGrayColor];
    label1.text=@"  全部粉丝";
    return label1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellidentifier=@"cellidentifier";
    InfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier forIndexPath:indexPath];
    followernamearray=[followerarray valueForKeyPath:@"name"];
    followertextarray=[followerarray valueForKeyPath:@"status.text"];
    followerphotoarray=[followerarray valueForKeyPath:@"profile_image_url"];
    NSUInteger row=[indexPath row];
    cell.friendname.text=[followernamearray objectAtIndex:indexPath.row];
    NSLog(@"%lu",(unsigned long)row);
    NSLog(@"%@",cell.friendname.text);
    NSLog(@"%@",followernamearray);
    
    cell.friendtext.text=[followertextarray objectAtIndex:indexPath.row];
    NSString *profileImageUrl=[followerphotoarray objectAtIndex:indexPath.row];
    NSURL *url=[NSURL URLWithString:[profileImageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [cell.friendphoto setImageWithURL:url];
    return cell;
}



- (UITableView *)followertableview
{
    return (UITableView *)self.view;
}

@end
