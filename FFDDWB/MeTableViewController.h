//
//  MeTableViewController.h
//  FFDDWB
//
//  Created by fuduoduo on 15/7/24.
//  Copyright (c) 2015年 fuduoduo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeTableViewController : UITableViewController< UITableViewDelegate , UITableViewDataSource,NSURLConnectionDataDelegate,NSURLConnectionDelegate >{
    NSString *_access_token;
    NSString *uid;
}
@property (strong, nonatomic) IBOutlet UITableView *metabelview;
//@property (strong,nonatomic)NSString *_access_token;
//@property (strong,nonatomic)NSString *uid;
@end
