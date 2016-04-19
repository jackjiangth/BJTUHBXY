//
//  DrawerViewController.h
//  HppleDemo
//
//  Created by jack on 16/4/19.
//
//

#import <UIKit/UIKit.h>

@interface DrawerViewController : UIViewController<UIGestureRecognizerDelegate>

//  抽屉的根视图控制器
@property(nonatomic,strong) UIViewController *rootViewController;
//  抽屉的左菜单视图控制器
@property(nonatomic,strong) UIViewController *leftViewController;

//  当菜单栏成为第一响应者 通过点击手势进行返回
@property(nonatomic,readonly) UITapGestureRecognizer *tap;

//  自定义初始化方法，在自定义方法中设置根视图控制器对象
- (id)initWithRootViewController:(UIViewController*)controller;
//  设置根视图控制器
- (void)setRootController:(UIViewController *)controller animated:(BOOL)animated;
//  显示根视图
- (void)showRootController:(BOOL)animated;
//  显示左边菜单视图
- (void)showLeftController:(BOOL)animated;

@end
