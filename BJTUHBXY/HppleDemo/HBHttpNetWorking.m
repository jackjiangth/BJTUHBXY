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

#pragma mark --解析目录页面的标题与链接并存到相应的数组中
-(void)parseHttpContent:(NSString *)contentURLStr{
    
    NSURL *url = [NSURL URLWithString:contentURLStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if ([data length] > 0 && error == nil) {
            
            [self titleParse:data];
            
            [self contentOfURLParse:data];
            
        } else if ([data length] == 0 && error == nil ){
            NSLog(@"No data was return");
        } else if (error != nil){
            NSLog(@"Error happened = %@",error);
        }
    }];
    
    [task resume];
}

-(void)titleParse:(NSData *)data{
    self.contentTitles = [NSMutableArray array];
    
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
            [self.contentTitles addObject:str];
            j = j+3;
        }
    }
    
    for (NSString *str in self.contentTitles) {
        NSLog(@"%@",str);
    }
}

-(void)contentOfURLParse:(NSData *)data{
    self.contentURLs = [NSMutableArray array];
    
    NSString *urlPredicate = @"//body//table//tr//td//div//div[4]//tr//a";
    
    NSArray *urlArray = [self getHttpPage:data Predicate:urlPredicate];
    
    int i = 1;
    int j = 2;
    
    for (TFHppleElement *hppleElement in urlArray) {
        
        if (i++ == j) {
            NSString *temStr = [hppleElement objectForKey:@"href"];
            
            NSString *urlStr = [self complementedHBURL:temStr];
            
            [self.contentURLs addObject:urlStr];
            
            j = j+2;
        }
    }
    
        for (NSString *str in self.contentURLs) {
            NSLog(@"%@",str);
        }
}

#pragma mark -- 补全url
-(NSString *)complementedHBURL:(NSString *)str{
    return [NSString stringWithFormat:@"http://www.bjtuhbxy.cn%@",str];
}

#pragma mark --解析文章的img的url 并返回一个数组
-(void)parseHttpImgOfPage:(NSString *)pageURLStr{
    NSURL *url = [NSURL URLWithString:pageURLStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if ([data length] > 0 && error == nil) {
            
            self.imgURLArr = (NSMutableArray *)[self pageImgPrase:data];
            
            
            
        } else if ([data length] == 0 && error == nil ){
            NSLog(@"No data was return");
        } else if (error != nil){
            NSLog(@"Error happened = %@",error);
        }
    }];
    
    [task resume];
}

#pragma mark --解析文章页面的内容
-(void)parseHttpContentOfPage:(NSString *)pageURLStr{
    
    NSURL *url = [NSURL URLWithString:pageURLStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if ([data length] > 0 && error == nil) {
            self.contentStr = (NSMutableString *)[self pageArticlePrase:data];
        } else if ([data length] == 0 && error == nil ){
            NSLog(@"No data was return");
        } else if (error != nil){
            NSLog(@"Error happened = %@",error);
        }
    }];
    
    [task resume];
    
}

//
// 解析img 的url 并返回相应的数组
-(NSArray *)pageImgPrase:(NSData *)data{
    NSString *imgPredicate = @"//body//table//tr//td//div//div[2]//div";
    NSArray *imgArray = [self getHttpPage:data Predicate:imgPredicate];
    
    NSArray *contentArray = [self contentSearch:imgArray];
    
    NSMutableArray *imgURLArr = [NSMutableArray array];
    
    for (TFHppleElement *hppleElement in contentArray){
        if ([self imgSearchPrase:hppleElement Layer:3] != NULL) {
            NSString *temStr1 = [self imgSearchPrase:hppleElement Layer:3];
            
            NSString *temStr2 = [self complementedHBURL:temStr1];
            
            [imgURLArr addObject:temStr2];
        }
    }
    
    for (NSString *temStr in imgURLArr) {
        NSLog(@"%@",temStr);
    }
    
    return imgURLArr;
}

// 寻找class 为 content的内容,并返回相应的数组
-(NSArray *)contentSearch:(NSArray *)tfArr{
    NSMutableArray *temArr = [NSMutableArray array];
    for (TFHppleElement *hppleElement in tfArr) {
        if ([[hppleElement objectForKey:@"class"] isEqualToString:@"content"]) {
            temArr = (NSMutableArray *)hppleElement.children;
        }
    }
    return temArr;
}

// 寻找img节点 并返回img的url
-(NSString *)imgSearchPrase:(TFHppleElement *)temHE Layer:(int)i{
    if (i-- > 0) {
        if ([temHE.tagName isEqualToString:@"img"]) {
            return [temHE objectForKey:@"src"];
        }else{
            return [self imgSearchPrase:temHE.firstChild Layer:i];
        }
    }else{
        return NULL;
    }
    
}

//
// 解析文章页面的内容
-(NSString *)pageArticlePrase:(NSData *)data{
    NSString *pagePredicate = @"//body//table//tr//td//div//div[2]//div";
    NSArray *urlArray = [self getHttpPage:data Predicate:pagePredicate];
    
    NSMutableString *temStr = [NSMutableString string];

    for (TFHppleElement *hppleElement in urlArray) {
        if ([[hppleElement objectForKey:@"class"] isEqualToString:@"content"]) {
            temStr = (NSMutableString *)hppleElement.content;
        }
    }
    NSLog(@"%@",temStr);
    return temStr;
}













@end
