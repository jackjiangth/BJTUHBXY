//
//  AppDelegate.m
//  HppleDemo
//
//  Created by Vytautas Galaunia on 11/25/14.
//
//

#import "AppDelegate.h"
#import "DrawerViewController.h"
#import "HomePageViewController.h"
#import "MenuViewController.h"
#import "ViewController.h"


@interface AppDelegate ()
@property(nonatomic,strong)UIImageView *splashView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   //默认功能为homePage
    HomePageViewController *HPVC = [[HomePageViewController alloc]init];
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:HPVC];
    //创建抽屉对象
    DrawerViewController *rootController =[[DrawerViewController alloc]initWithRootViewController:navController];
    _drawerController = rootController;
    //创建菜单对象
    MenuViewController *leftController = [[MenuViewController alloc]init];
    rootController.leftViewController = leftController;
    //将抽屉对象设置成Windows的主视图控制器
    self.window.rootViewController = rootController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
  //设置一个图片
    UIImageView *niceView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.window.frame.size.width, self.window.frame.size.height)];
    niceView.image = [UIImage imageNamed:@"hbxy.png"];
    //添加到场景
    [self.window addSubview:niceView];
    //放到最顶层
    [self.window bringSubviewToFront:niceView];
    //开始设置动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3.0];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.window cache:YES];
    [UIView setAnimationDelegate:self];
 //   [UIView setAnimationDidStopSelector:@selector(startupAnimationDone:finished:context:)];
    niceView.alpha = 0.0;
    niceView.frame = CGRectMake(-60, 85, 440, 635);
    [UIView commitAnimations];
    
    
    
    
    return YES;
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
