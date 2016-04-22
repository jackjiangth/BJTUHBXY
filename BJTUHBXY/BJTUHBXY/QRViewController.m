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

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property(nonatomic,strong)UIButton *button ;
@property(nonatomic,strong)UILabel *label;

@end

@implementation QRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.button.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.button];
    [self.button addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(self.button.frame.size.width, self.button.frame.size.width, self.button.frame.size.width, self.button.frame.size.width)];
    self.label.text = @"关于我们";
    [self.button addSubview:self.label];
}


-(void)show:(id)sender{
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(200,100,100,100)];
    [self.view addSubview:self.imageView];
 
 
    
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
   self.imageView.image = [self createNonInterpolatedUIImageFormCIImage:outputImg withSize:200];
    
    
}

/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 */
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
