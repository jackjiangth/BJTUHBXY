//
//  CollectionDetailViewController.m
//  HppleDemo
//
//  Created by jack on 16/4/19.
//
//

#import "CollectionDetailViewController.h"

@interface CollectionDetailViewController ()

@end

@implementation CollectionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.5 green:0.7 blue:0.6 alpha:0.4];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    switch (self.follow) {
        case 0:
            self.view.backgroundColor = [UIColor redColor];
            break;
            
        case 1:
            self.view.backgroundColor = [UIColor orangeColor];
            break;
        case 2:
            self.view.backgroundColor = [UIColor greenColor];
            break;
        case 3:
            self.view.backgroundColor = [UIColor cyanColor];
            break;
            
        default:
            break;
    }


}


-(void)back:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"成功返回上一级视图.哈哈哈");
    }];
    
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
