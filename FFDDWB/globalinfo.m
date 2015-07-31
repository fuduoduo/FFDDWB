//
//  globalinfo.m
//  FFDDWB
//
//  Created by fuduoduo on 15/7/27.
//  Copyright (c) 2015年 fuduoduo. All rights reserved.
//

#import "globalinfo.h"
static NSString *myuid = nil;
static NSString *myaccesstoken=nil;
static NSString *myname= nil;
static NSString *myimage=nil;

@implementation globalinfo
+ (void)setuid:(NSString *)uid{
    myuid = uid;
}
+ (void)setaccesstoken:(NSString *)accesstoken{
    myaccesstoken = accesstoken;
}
+(void)setname:(NSString *)name{
    myname= name;
}
+(void)setmyimage:(NSString *)image{
    myimage = image;
}
+ (NSString *)getuid{
    return myuid;
}
+ (NSString *)getaccesstoken{
    return myaccesstoken;
}
+ (NSString *)getname{
    return myname;
}
+(NSString *)getmyimage{
    return myimage;
}
@end
