//
//  MySession.m
//  MyPB
//
//  Created by lanou3g on 16/4/6.
//  Copyright © 2016年 hyc. All rights reserved.
//

#import "MySession.h"
#import "TFHpple.h"


@implementation MySession
-(void)myGetSession:(NSString *)urlString{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    self.data = [[NSMutableData alloc] init];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        if ([data length] > 0 && error == nil) {
            self.data = (NSMutableData *)data;
        } else if ([data length] == 0 && error == nil ){
            NSLog(@"No data was return");
        } else if (error != nil){
            NSLog(@"Error happened = %@",error);
        }
    }];
    
    [task resume];
}



/*
-(void)analyseHttp{
    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:self.myData];
    
    // 标题链接
    //NSArray *dataArray = [xpathParser searchWithXPathQuery:@"//body//table//tr//td//div//div[4]//tr//font"];

    // 跳转链接
    NSArray *dataArray = [xpathParser searchWithXPathQuery:@"//body//table//tr//td//div//div[4]//tr//a"];

    
    int i = 0;
//    TFHppleElement *tempHppleElement = [[TFHppleElement alloc] init];
    
    for (TFHppleElement *hppleElement in dataArray) {
        NSLog(@"%d===========%@",i++,hppleElement.raw);

        
        //        if (i == 3) {
//            tempHppleElement = hppleElement;
//        }
        
        // 跳转链接
        NSString *temStr = [hppleElement objectForKey:@"href"];
        
        //NSLog(@"==%@",temStr);
        
        // 跳转
        //[self jumpToPage:temStr];
        
        
        
    }
}
*/
-(void)jumpToPage:(NSString *)pageStr{
    NSMutableString *appendStr = [NSMutableString stringWithFormat:@"http://www.bjtuhbxy.cn/%@",pageStr];
    
    // 测试
    //NSURL *url = [NSURL URLWithString:appendStr];
    
    //NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    
    //NSString *temURL = [NSString stringWithContentsOfURL:url encoding:enc error:nil];
    
    //NSLog(@"%@",temURL);
    
    [self parsePage:appendStr];
}

-(void)parsePage:(NSString *)pageStr{
    //NSURL *url = [NSURL URLWithString:pageStr];
    NSURL *url = [NSURL URLWithString:@"http://www.bjtuhbxy.cn/News_View.asp?NewsID=1949"];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:data];
    
    //NSArray *dataArray = [xpathParser searchWithXPathQuery:@"//body//table//tr//td//div//div[2]//div//span"];
    
    // 解析图片
    NSArray *dataArray = [xpathParser searchWithXPathQuery:@"//body//table//tr//td//div//div[2]//div//p//img"];
    
    for (TFHppleElement *hppleElement in dataArray) {
        NSLog(@"===========%@",hppleElement.raw);
        
        NSString *temStr = [hppleElement objectForKey:@"src"];
        NSLog(@"== %@",temStr);
    }
    

    
    
}
@end
