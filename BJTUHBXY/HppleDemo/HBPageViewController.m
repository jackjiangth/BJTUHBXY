//
//  HBPageViewController.m
//  HppleDemo
//
//  Created by lanou3g on 16/4/23.
//
//

#import "HBPageViewController.h"

@interface HBPageViewController ()

@end

// 单例
static HBHttpNetWorking *hbNetWork = nil;


@implementation HBPageViewController
// 便利构造器
-(instancetype)initWithHttpOfUrl:(NSString *)url{
    if (self = [super init]) {
        [self updateHBPage:url];
        NSLog(@"123");
    }
    return self;
}

-(void)updateHBPage:(NSString *)url{
    if (hbNetWork == nil) {
        hbNetWork = [[HBHttpNetWorking alloc] init];
    }
    if (hbNetWork.delegate == nil) {
        hbNetWork.delegate = self;
    }
    [hbNetWork parseContentFromHttpArticle:url];
    
}

-(void)loadView{
    self.hbWV = [[UIWebView alloc] init];
    
    self.view = self.hbWV;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)receiveHTMLFromArticle:(NSMutableString *)articleStr baseURL:(NSURL *)url{
    
    [self.hbWV loadHTMLString:[self reSizeImageWithHTML:articleStr] baseURL:url];
    
    
//    [self.hbWV stringByEvaluatingJavaScriptFromString:@"$(""img"").removeAttr(height);"];
    
    NSLog(@"123");
    NSLog(@"%@",articleStr);
}
- (NSString *)reSizeImageWithHTML:(NSString *)html {
    
    return [NSString stringWithFormat:@"<head><style>img{margin-left: -40px; max-width:300px;_width:expression(this.width > 300 ? ""300px"" : this.width);height:auto;}</style></head>%@", html];
    
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
