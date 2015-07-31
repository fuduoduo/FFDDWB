//
//  globalinfo.h
//  FFDDWB
//
//  Created by fuduoduo on 15/7/27.
//  Copyright (c) 2015年 fuduoduo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface globalinfo : NSObject
+ (void)setuid:(NSString *)uid;
+ (void)setaccesstoken:(NSString *)accesstoken;
+ (void)setname:(NSString *)name;
+ (void)setmyimage:(NSString *)name;
+ (NSString *)getuid;
+ (NSString *)getaccesstoken;
+ (NSString *)getname;
+ (NSString *)getmyimage;
@end
