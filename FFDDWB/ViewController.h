//
//  ViewController.h
//  FFDDWB
//
//  Created by fuduoduo on 15/7/23.
//  Copyright (c) 2015年 fuduoduo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIWebViewDelegate>{
}
- (IBAction)clickbeginButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *beginButton;
@end

