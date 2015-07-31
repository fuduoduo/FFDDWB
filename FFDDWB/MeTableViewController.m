//
//  MeTableViewController.m
//  FFDDWB
//
//  Created by fuduoduo on 15/7/24.
//  Copyright (c) 2015年 fuduoduo. All rights reserved.
//

#import "MeTableViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIImageView+AFNetworking.h"
#import "globalinfo.h"
#import "friendTableViewController.h"
#import "followerTableViewController.h"

@interface MeTableViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSDictionary *medictionary;
    NSMutableData *medata;
    NSMutableArray *mearray;
}
@property (weak, nonatomic) IBOutlet UIImageView *myphotoImage;
@property (weak, nonatomic) IBOutlet UILabel *mynameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mytextLabel;
@property (weak, nonatomic) IBOutlet UILabel *friendnumberLable;
@property (weak, nonatomic) IBOutlet UILabel *followernumbleLable;
@property (weak, nonatomic) IBOutlet UILabel *mystatusLable;

//@property (strong, nonatomic) IBOutlet UITableView *metabelview;

@property(strong,nonatomic) NSDictionary *infomationDictionary;
@end

@implementation MeTableViewController
//@synthesize  uid;
//@synthesize _access_token;
@synthesize metabelview;


- (void)viewDidLoad {
    
    [super viewDidLoad];
  //  [self meRequest];
    NSString *uid=[globalinfo getuid];
    NSString *_access_token=[globalinfo getaccesstoken];
    NSDictionary *parameters = @{@"access_token":_access_token,@"uid":uid};
    NSLog(@"111111111111111111%@",parameters);
    AFHTTPRequestOperationManager *accountinfomation = [AFHTTPRequestOperationManager manager];
    [accountinfomation GET:@"https://api.weibo.com/2/users/show.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //      [mearray addObjectsFromArray:[responseObject valueForKey:@"users"]];
        medictionary=responseObject;
         NSLog(@"4444444444444444444444444444%@", responseObject);
        NSLog(@"555555555555555555555555555%@", medictionary);
        NSString *account_name=[medictionary objectForKey:@"name"];
        self.mynameLabel.text=[NSString stringWithFormat:@"昵称: %@",account_name];
        
        NSString *account_IDnubmer=[medictionary objectForKey:@"description"];
        self.mytextLabel.text=[NSString stringWithFormat:@"签名：%@",account_IDnubmer];
        
        NSString *account_friends_number=[medictionary objectForKey:@"friends_count"];
        self.friendnumberLable.text=[NSString stringWithFormat:@"关注：%@",account_friends_number];
        
        NSString *account_followers_number=[medictionary objectForKey:@"followers_count"];
        self.followernumbleLable.text=[NSString stringWithFormat:@"粉丝：%@",account_followers_number];
        
        
        NSString *account_statuses_number=(NSString *)[medictionary objectForKey:@"statuses_count"];
        self.mystatusLable.text=[NSString stringWithFormat:@"状态：%@",account_statuses_number];
        
        NSString *account_photoUrl=(NSString *)[medictionary objectForKey:@"avatar_hd"];
        NSURL *url=[NSURL URLWithString:[account_photoUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [self.myphotoImage setImageWithURL:url];

        [globalinfo setname:account_name];
        [globalinfo setmyimage:account_photoUrl];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error --> %@", error);
    }];
    NSLog(@"22222222222222222222%@", medictionary);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
//-(void)meRequest{
//    NSDictionary *parameters = @{@"access_token":__access_token,@"uid":_uid,@"trim_status":@"0"};
//    AFHTTPRequestOperationManager *accountfriendinfomation = [AFHTTPRequestOperationManager manager];
//    [accountfriendinfomation GET:@"https://api.weibo.com/2/users/show.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//  //      [mearray addObjectsFromArray:[responseObject valueForKey:@"users"]];
//        medictionary=responseObject;
//        [self.metabelview reloadData];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"error --> %@", error);
//    }];
//    
//}



-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    CGRect bounds=[UIScreen mainScreen].bounds;
    self.metabelview.frame=CGRectMake(0, 0, bounds.size.width, bounds.size.height);
    self.myphotoImage.frame=CGRectMake(20, 20,60, 60);
}


//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
////#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 2;
//}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
////#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)clickgotofriend:(id)sender {
    friendTableViewController *vc=[[friendTableViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"%@",self.navigationController);
}
@end
