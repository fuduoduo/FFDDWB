//
//  friendTableViewController.m
//  FFDDWB
//
//  Created by fuduoduo on 15/7/27.
//  Copyright (c) 2015年 fuduoduo. All rights reserved.
//

#import "friendTableViewController.h"
#import "InfoTableViewCell.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIImageView+AFNetworking.h"
#import "globalinfo.h"

@interface friendTableViewController(){
    NSDictionary *friendictionary;
    NSMutableArray *friendarray;
    NSArray *friendnamearray;
    NSArray *friendtextarray;
    NSArray *friendphotoarray;
    NSArray *isfriendarray;
    NSMutableData *friendshowdata;
}

@end

@implementation friendTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.friendtableview registerNib:[UINib nibWithNibName:NSStringFromClass([InfoTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cellidentifier"];
    if (!friendarray) {
        friendarray = [NSMutableArray array];
    }
    [self friendRequest];
}

-(void)friendRequest{
    NSString *uid=[globalinfo getuid];
    NSString *_access_token=[globalinfo getaccesstoken];
    NSDictionary *parameters = @{@"access_token":_access_token,@"uid":uid,@"trim_status":@"0"};
    AFHTTPRequestOperationManager *accountfriendinfomation = [AFHTTPRequestOperationManager manager];
    [accountfriendinfomation GET:@"https://api.weibo.com/2/friendships/friends.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [friendarray addObjectsFromArray:[responseObject valueForKey:@"users"]];
        [self.friendtableview reloadData];
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
    self.friendtableview.frame=CGRectMake(bounds.origin.x,bounds.origin.y,bounds.size.width,bounds.size.height);
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%s, %lu", __func__, (unsigned long)friendnamearray.count);
    return friendarray.count;
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
    label1.text=@"  全部关注";
    return label1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellidentifier=@"cellidentifier";
    InfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier forIndexPath:indexPath];
    friendnamearray=[friendarray valueForKeyPath:@"name"];
    friendtextarray=[friendarray valueForKeyPath:@"status.text"];
    friendphotoarray=[friendarray valueForKeyPath:@"profile_image_url"];
    NSUInteger row=[indexPath row];
    cell.friendname.text=[friendnamearray objectAtIndex:indexPath.row];
    NSLog(@"%lu",(unsigned long)row);
    NSLog(@"%@",cell.friendname.text);
    NSLog(@"%@",friendnamearray);
    
    cell.friendtext.text=[friendtextarray objectAtIndex:indexPath.row];
    NSString *profileImageUrl=[friendphotoarray objectAtIndex:indexPath.row];
    NSURL *url=[NSURL URLWithString:[profileImageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [cell.friendphoto setImageWithURL:url];
    return cell;
}



- (UITableView *)friendtableview
{
    return (UITableView *)self.view;
}
@end
