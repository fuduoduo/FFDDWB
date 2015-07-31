//
//  ViewController.m
//  FFDDWB
//
//  Created by fuduoduo on 15/7/23.
//  Copyright (c) 2015年 fuduoduo. All rights reserved.
//

#import "ViewController.h"
#import "MeTableViewController.h"
#import "globalinfo.h"
@interface ViewController ()<UIWebViewDelegate>{
    NSString *_access_token;
    NSString *uid;
    
}
//@property (weak, nonatomic) IBOutlet UIButton *beginButton;

@property (nonatomic, strong) UIWebView *webView;
@end

@implementation ViewController

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   [self.view addSubview:self.webView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    if([segue.identifier isEqualToString:@"accountlogin"]){
//    TabBarViewController* view = segue.destinationViewController;
//        NSLog(@"%@", segue.destinationViewController);
//               view.uid=uid;
//        view._access_token=_access_token;
//    }
//}
-(void)webViewDidFinishLoad:(UIWebView *)_webView{
    NSString *url = self.webView.request.URL.absoluteString;
    NSLog(@"11111absoluteString:%@",url);
    
    if ([url hasPrefix:@"https://api.weibo.com/oauth2/default.html?"]) {
        //find the code range
        NSRange rangeOne;
        rangeOne=[url rangeOfString:@"code="];
        NSRange range = NSMakeRange(rangeOne.length+rangeOne.location, url.length-(rangeOne.length+rangeOne.location));
        
        //get code
        NSString *codeString = [url substringWithRange:range];
        NSLog(@"22222code = :%@",codeString);
        
        //access token调用URL的string
        NSMutableString *muString = [[NSMutableString alloc] initWithString:@"https://api.weibo.com/oauth2/access_token?client_id=4202851703&client_secret=3e5d11ae2c90551cb3704242c592e2c6&grant_type=authorization_code&redirect_uri=https://api.weibo.com/oauth2/default.html&code="];
        [muString appendString:codeString];
        NSLog(@"33333access token url :%@",muString);
        
        //URL
        NSURL *urlstring = [NSURL URLWithString:muString];
        
        //request
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:urlstring cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        
        [request setHTTPMethod:@"POST"];
        NSString *str = @"type=focus-c";
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
        
        //connect
        NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString *str1 = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
        NSLog(@"44444Back String :%@",str1);
        
        NSError *error;
        
        //get access_token
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableContainers error:&error];
        _access_token = [dictionary objectForKey:@"access_token"];
        uid=[dictionary objectForKey:@"uid"];
        NSLog(@"55555access token :%@",_access_token);
        
        [[NSUserDefaults standardUserDefaults] setObject:_access_token forKey:@"access_token"];
        [[NSUserDefaults standardUserDefaults] setObject:uid forKey:@"uid"];
        
        //       //    1.设置请求路径
        //        NSString *accontinfomationurlStr=[NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?access_token=%@&uid=%@",_access_token,uid];
        //        NSURL *url=[NSURL URLWithString:accontinfomationurlStr];
        //        NSLog(@"666666AccontinfomationurlStr :%@",url);
        //        [request setHTTPMethod:@"GET"];
        //       //    2.创建请求对象
        //       //NSURLRequest *accontinfomationrequest=[NSURLRequest requestWithURL:url];
        //        NSMutableURLRequest *accontinfomationrequest =[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        //       //    3.发送同步请求，在主线程执行
        //          NSData *accontinfomationdata=[NSURLConnection sendSynchronousRequest:accontinfomationrequest returningResponse:nil error:nil];
        //       //（一直在等待服务器返回数据，这行代码会卡住，如果服务器没有返回数据，那么在主线程UI会卡住不能继续执行操作）
        //        NSString *accontinfomationdata2=[[NSString alloc]initWithData:accontinfomationdata encoding:NSUTF8StringEncoding];
        //        NSLog(@"77777data:%@",accontinfomationdata2);
//  
//        MeTableViewController *accountinfocontroller=[[MeTableViewController alloc]init];
//     //   me.title=@"Me";
//        accountinfocontroller.uid=uid;
//        accountinfocontroller._access_token=_access_token;
        [globalinfo setaccesstoken:_access_token];
        [globalinfo setuid:uid];
        [self performSegueWithIdentifier:@"accountlogin" sender:self];

        
    }
}


- (IBAction)clickbeginButton:(id)sender {
    [super viewDidLoad];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] stringForKey:@"access_token"];
    if (accessToken) {
        NSString *myuid = [[NSUserDefaults standardUserDefaults] stringForKey:@"uid"];
//        NSString *name=[[NSUserDefaults standardUserDefaults]stringForKey:@"screen_name"];
//        NSString *myimage=[[NSUserDefaults standardUserDefaults]stringForKey:@"profile_image_url"];
        [globalinfo setuid:myuid];
        [globalinfo setaccesstoken:accessToken];
//        [globalinfo setname:name];
//        [globalinfo setmyimage:myimage];
//        MeTableViewController *accountinfocontroller=[[MeTableViewController alloc]init];
//        accountinfocontroller.title=@"Me";
        [self performSegueWithIdentifier:@"accountlogin" sender:self];
  //      [self.navigationController pushViewController:accountinfocontroller animated:YES];

    } else {
        NSString *FSJurl = @"https://api.weibo.com/oauth2/authorize?client_id=4202851703&redirect_uri=https://api.weibo.com/oauth2/default.html&response_type=code&display=mobile";
        
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:FSJurl]];
        
        [self.webView loadRequest:request];
   }
}

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.delegate = self;
    }
    
    return _webView;
}

@end
