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



-(void)parseHttpContent:(NSString *)contentURLStr;

-(void)parseHttpContentOfPage:(NSString *)pageURLStr;

-(void)parseHttpImgOfPage:(NSString *)pageURLStr;

@end
