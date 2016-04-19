//
//  MenuViewController.m
//  HppleDemo
//
//  Created by jack on 16/4/19.
//
//

#import "MenuViewController.h"
#import "AppDelegate.h"
#import "DrawerViewController.h"
#import "NotificationViewController.h"
#import "NewsViewController.h"
#import "EducationViewController.h"
#import "StudentViewController.h"
#import "HomePageViewController.h"

@interface MenuViewController (){
    NSMutableArray *list;
}


@end

@implementation MenuViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    list = [[NSMutableArray alloc]init];
    [list addObject:@"首页"];
    [list addObject:@"通知公告"];
    [list addObject:@"新闻中心"];
    [list addObject:@"教务信息"];
    [list addObject:@"学生工作"];
    
    
    
}

//改变行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

//返回tableview中有多少数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [list count];
}
//返回有多少个分组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//组装每一条的数据
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CustomCellIdentifier =@"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CustomCellIdentifier];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CustomCellIdentifier];
    }
    cell.textLabel.text = [list objectAtIndex:indexPath.row];
    return cell;
}

//选中Cell响应事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //  获取抽屉对象
    DrawerViewController *menuController = (DrawerViewController*)((AppDelegate *)[[UIApplication sharedApplication] delegate]).drawerController;
    
    if(indexPath.row == 0) {  // 设置首页为抽屉的根视图
        
      HomePageViewController*viewController = [[HomePageViewController alloc]init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
        [menuController setRootController:navController animated:YES];
        
    } else if(indexPath.row == 1){  // 设置通知公告为抽屉的根视图
        
        NotificationViewController *controller = [[NotificationViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        [menuController setRootController:navController animated:YES];
        
    } else if(indexPath.row == 2){  // 设置新闻中心为抽屉的根视图
        
        NewsViewController *controller = [[NewsViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        [menuController setRootController:navController animated:YES];
        
    } else if(indexPath.row == 3){ //设置教务信息为抽屉的根视图
        EducationViewController *controller = [[EducationViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        [menuController setRootController:navController animated:YES];
    }else if (indexPath.row == 4){//设置学生工作为抽屉的根视图
        StudentViewController *controller = [[StudentViewController alloc]init];
        UINavigationController *navController =[[UINavigationController alloc]initWithRootViewController:controller];
        [menuController setRootController:navController animated:YES];
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
