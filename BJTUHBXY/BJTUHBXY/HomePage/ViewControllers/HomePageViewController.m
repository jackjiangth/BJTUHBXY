//
//  HomePageViewController.m
//  HppleDemo
//
//  Created by jack on 16/4/19.
//
//

#import "HomePageViewController.h"
#import "SDCycleScrollView.h"
@interface HomePageViewController ()<SDCycleScrollViewDelegate>



@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.view.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:0.99];
    
    UIScrollView *demoContainerView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    demoContainerView.contentSize = CGSizeMake(self.view.frame.size.width, 0);//Y的大小可以是任意数,不会有影响
    [self.view addSubview:demoContainerView];
    
    
    // 情景二：采用网络图片实现
    NSArray *imagesURLStrings = @[@"http://www.bjtuhbxy.cn/edit/uploadfile/20164/2016-4-15-16-30-48.jpg",@"http://www.bjtuhbxy.cn/edit/uploadfile/20163/2016-3-28-11-4-58.jpg",@"http://www.bjtuhbxy.cn/edit/uploadfile/20163/2016-3-28-14-35-59.jpg"];
    NSArray *titles = @[@"我院举行学生公寓消防逃生演练",@"我院2016届毕业生春季校园双选会成功举办",@"我院部署2016年重点工作"];
    CGFloat w = self.view.bounds.size.width;
    
#pragma mark----------
    // 网络加载 --- 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, 180) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView2.titlesGroup = titles;
    cycleScrollView2.currentPageDotColor = [UIColor blackColor]; // 自定义分页控件小圆标颜色
    [demoContainerView addSubview:cycleScrollView2];
    
    //---模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
    });
    


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
