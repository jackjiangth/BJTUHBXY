//
//  HBHttpNetWorking.m
//  HppleDemo
//
//  Created by lanou3g on 16/4/18.
//
//

#import "HBHttpNetWorking.h"
#import "TFHpple.h"

@implementation HBHttpNetWorking
#pragma mark --解析目录页面的标题与链接并存到相应的数组中
-(void)parseTitleAndUrlFromHttpContentPage:(NSString *)contentURLStr{
    
    NSURL *url = [NSURL URLWithString:contentURLStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if ([data length] > 0 && error == nil) {
            if (self.delegate != nil) {
                [self.delegate receiveTitleFromContent:[self titleParse:data]];
                
                [self.delegate receiveUrlFromContent:[self contentOfURLParse:data]];
            }
        } else if ([data length] == 0 && error == nil ){
            NSLog(@"No data was return");
        } else if (error != nil){
            NSLog(@"Error happened = %@",error);
        }
    }];
    
    [task resume];
}

// 用来解析页面的标题
-(NSMutableArray *)titleParse:(NSData *)data{
    self.arrFromContentTitles = [NSMutableArray array];
    
    NSString *titlePredicate = @"//body//table//tr//td//div//div[4]//tr//font";
    NSArray *titleArray = [self getHttpPage:data Predicate:titlePredicate];
    
    // 用来甄别数据
    int i = 1;
    int j = 1;
    
    for (TFHppleElement *hppleElement in titleArray) {
        //NSLog(@"%d===========%@",i++,hppleElement.text);
        
        if (i++ == j) {
            //NSLog(@"%@",hppleElement.text);
            
            NSString *str = hppleElement.text;
            [self.arrFromContentTitles addObject:str];
            j = j+3;
        }
    }
    
    return self.arrFromContentTitles;
}

// 用来解析与标题对应的url
-(NSMutableArray *)contentOfURLParse:(NSData *)data{
    self.arrFromContentUrls = [NSMutableArray array];
    
    NSString *urlPredicate = @"//body//table//tr//td//div//div[4]//tr//a";
    
    NSArray *urlArray = [self getHttpPage:data Predicate:urlPredicate];
    
    int i = 1;
    int j = 2;
    
    for (TFHppleElement *hppleElement in urlArray) {
        
        if (i++ == j) {
            NSString *temStr = [hppleElement objectForKey:@"href"];
            
            NSString *urlStr = [self complementedHBURL:temStr];
            
            [self.arrFromContentUrls addObject:urlStr];
            
            j = j+2;
        }
    }
    
    return self.arrFromContentUrls;
}


#pragma mark --解析文章页面的内容
-(void)parseContentFromHttpArticle:(NSString *)pageUrlStr{
    
    NSURL *url = [NSURL URLWithString:pageUrlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if ([data length] > 0 && error == nil) {
            if (self.delegate != nil) {
                [self.delegate receiveHTMLFromArticle:[self pageArticlePrase:data] baseURL:url];
            }
        } else if ([data length] == 0 && error == nil ){
            NSLog(@"No data was return");
        } else if (error != nil){
            NSLog(@"Error happened = %@",error);
        }
    }];
    
    [task resume];
    
}
// 解析文章页面的内容
-(NSMutableString *)pageArticlePrase:(NSData *)data{
    self.strOfHTMLFromArticle = [[NSMutableString alloc] init];
    
    NSString *pagePredicate = @"//body//table//tr//td//div//div[2]//div";
    NSArray *urlArray = [self getHttpPage:data Predicate:pagePredicate];
    
    for (TFHppleElement *hppleElement in urlArray) {
        if ([[hppleElement objectForKey:@"class"] isEqualToString:@"content"]) {
            self.strOfHTMLFromArticle = (NSMutableString *)hppleElement.raw;
            //NSLog(@"%@",self.strOfHTMLFromArticle);
        }
    }
    return self.strOfHTMLFromArticle;
}









// ***********************************************************
#pragma mark --将GBK编码转换为UTF8编码
-(NSData *)toUTF8:(NSData *)sourceData{
    // GBK编码
    // NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    
    CFStringRef gbkStr = CFStringCreateWithBytes(NULL, [sourceData bytes], [sourceData length], kCFStringEncodingGB_18030_2000, false);
    
    if (gbkStr == NULL) {
        return nil;
    }else{
        NSString *gbkString = (__bridge NSString *)gbkStr;
        
        //根据网页源代码中编码方式进行修改，此处为从gbk转换为utf8
        NSString *utf8_String = [gbkString stringByReplacingOccurrencesOfString:@"META http-equiv=""Content-Type"" content=""text/html; charset=GBK""" withString:@"META http-equiv=""Content-Type"" content=""text/html; charset=UTF-8"""];
        
        return [utf8_String dataUsingEncoding:NSUTF8StringEncoding];
    }
}

#pragma mark --获取页面代码,并返回一个存放该数据的数组
-(NSArray *)getHttpPage:(NSData *)date Predicate:(NSString *)parseStr{
    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:date];
    NSArray *dataArray = [xpathParser searchWithXPathQuery:parseStr];
    return dataArray;
}

#pragma mark -- 补全url
-(NSString *)complementedHBURL:(NSString *)str{
    return [NSString stringWithFormat:@"http://www.bjtuhbxy.cn/%@",str];
}


@end
