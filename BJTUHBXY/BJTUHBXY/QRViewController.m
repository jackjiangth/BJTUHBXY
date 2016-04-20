//
//  QRViewController.m
//  HppleDemo
//
//  Created by lanou3g on 16/4/20.
//
//

#import "QRViewController.h"
#import <CoreImage/CoreImage.h>
@interface QRViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation QRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    //创建过滤器,生成二维码
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //恢复默认设置
    [filter setDefaults];
    //给过滤器添加数据
    NSString *dataString = @"北京交通大学海滨学院";
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];
    //获取输出的二维码
    CIImage *outputImg= [filter outputImage];
    //显示二维码
    self.imageView.image = [UIImage imageWithCIImage:outputImg];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
