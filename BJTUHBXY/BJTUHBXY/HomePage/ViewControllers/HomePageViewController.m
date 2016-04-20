//
//  HomePageViewController.m
//  HppleDemo
//
//  Created by jack on 16/4/19.
//
//

#import "HomePageViewController.h"
#import "SDCycleScrollView.h"
#import "QRViewController.h"
@interface HomePageViewController ()<SDCycleScrollViewDelegate>

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.backgroundColor = [UIColor orangeColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_menu_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(US:)];

    
    self.view.backgroundColor = [UIColor clearColor];
    UIImageView *backgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1.jpg"]];
    backgroundView.frame = self.view.bounds;
    [self.view addSubview:backgroundView];
    UIScrollView *demoContentView=[[UIScrollView alloc]initWithFrame:self.view.frame];
    demoContentView.contentSize=CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:demoContentView];
    self.title =@"北京交通大学海滨学院";
    //采用网络图片展示
    NSArray *imageURLStrings = @[@"http://www.bjtuhbxy.cn/edit/uploadfile/20164/2016-4-15-16-30-48.jpg",
                                 @"http://www.bjtuhbxy.cn/edit/uploadfile/20163/2016-3-28-11-4-58.jpg",
                                 @"http://www.bjtuhbxy.cn/edit/uploadfile/20163/2016-3-25-11-38-2.jpg",@"http://www.bjtuhbxy.cn/edit/uploadfile/20163/2016-3-25-11-38-24.jpg"];
    //图片匹配的文字
    NSArray *titles=@[@"图片一,",@"图片二",@"图片三",@"图片四"];
    CGFloat w = self.view.bounds.size.width;
 //创建带标题的轮播图
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,64,w,150) delegate:self placeholderImage:[UIImage imageNamed:@"1.jpg"]];
    cycleScrollView.pageControlAliment=SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView.titlesGroup = titles;
    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
    cycleScrollView.currentPageDotColor=[UIColor whiteColor];
    [demoContentView addSubview:cycleScrollView];
   //模拟延迟加载
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView.imageURLStringsGroup = imageURLStrings;
    });
    
}


-(void)US:(id)sender{
    QRViewController *qr = [[QRViewController alloc]init];
    [self.navigationController pushViewController:qr animated:YES];
}
#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
    [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
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
