//
//  HBPageViewController.h
//  HppleDemo
//
//  Created by lanou3g on 16/4/23.
//
//

#import <UIKit/UIKit.h>
#import "HBHttpNetWorking.h"

@interface HBPageViewController : UIViewController<receiveDataFromHBDelegate>
@property(nonatomic,strong)UIWebView *hbWV;

// ****************************************************
// 用这个方法进行初始化
-(instancetype)initWithHttpOfUrl:(NSString *)url;
// ****************************************************

// ****************************************************
// 用这个方法可以对页面进行更新
-(void)updateHBPage:(NSString *)url;
// ****************************************************

@end
