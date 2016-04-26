//
//  HBHttpNetWorking.h
//  HppleDemo
//
//  Created by lanou3g on 16/4/18.
//
//

#import <Foundation/Foundation.h>
// 声明代理
@protocol receiveDataFromHBDelegate <NSObject>
@optional
// ****************************************************
// 用这个方法可以获取网络请求完的标题
-(void)receiveTitleFromContent:(NSMutableArray *)titleArr;
// ****************************************************


// ****************************************************
// 用这个方法可以获取网络请求完的与标题对应的url
-(void)receiveUrlFromContent:(NSMutableArray *)urlArr;
// ****************************************************

// http://www.lanou3g.com/bbs/forum.php?mod=viewthread&tid=5189

// ****************************************************
// 不建议自己调用
// 用这个方法可以获取Content的HTML
// 给封装后的HBSecondPageView用的
// 使用时应使用HBSecondPageView类
-(void)receiveHTMLFromArticle:(NSMutableString *)articleStr baseURL:(NSURL *)url;
// ****************************************************
@end


@interface HBHttpNetWorking : NSObject
// ****************************************************
// 协议的代理
@property(nonatomic,assign)id<receiveDataFromHBDelegate> delegate;
// ****************************************************


// ****************************************************
// 不建议直接调用
// 这个只是用来存值的
// 使用时应使用代理的方法
@property(nonatomic,strong)NSMutableArray *arrFromContentTitles;
@property(nonatomic,strong)NSMutableArray *arrFromContentUrls;
@property(nonatomic,strong)NSMutableString *strOfHTMLFromArticle;
// ****************************************************



// ****************************************************
// 获取目录页面里的标题和与之对应的Url
-(void)parseTitleAndUrlFromHttpContentPage:(NSString *)contentURLStr;
// ****************************************************



// ****************************************************
// 不建议自己调用
// 这个方法是给封装后的HBSecondPageView的
// 使用时应使用HBSecondPageView类
-(void)parseContentFromHttpArticle:(NSString *)pageUrlStr;
// ****************************************************


@end
