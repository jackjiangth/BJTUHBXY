//
//  HBHttpNetWorking.h
//  HppleDemo
//
//  Created by lanou3g on 16/4/18.
//
//

#import <Foundation/Foundation.h>

@interface HBHttpNetWorking : NSObject
// 存储的·目录·标签
@property(nonatomic,strong)NSMutableArray *contentTitles;
@property(nonatomic,strong)NSMutableArray *contentURLs;

@property(nonatomic,strong)NSMutableString *contentStr;

@property(nonatomic,strong)NSMutableArray *imgURLArr;



-(void)parseHttpContent:(NSString *)contentURLStr;//获取目录页面的各个标题,和与之对应的地址.

-(void)parseHttpContentOfPage:(NSString *)pageURLStr;//只获取该页面文章的内容,(下滑到页底,加一个button,-->阅读原文,跳转到webview里,在webview里加一个返回的button,返回到上级界面)

-(void)parseHttpImgOfPage:(NSString *)pageURLStr;

@end
