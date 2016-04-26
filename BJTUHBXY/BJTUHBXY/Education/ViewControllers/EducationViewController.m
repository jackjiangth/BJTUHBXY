//
//  EducationViewController.m
//  HppleDemo
//
//  Created by jack on 16/4/19.
//
//

#import "EducationViewController.h"

#import "HBHttpNetWorking.h"

#import "EducationDetailViewController.h"
#import "HBPageViewController.h"

@interface EducationViewController () <UITableViewDelegate,UITableViewDataSource,receiveDataFromHBDelegate>

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *contentArray;

@end

@implementation EducationViewController

- (void)loadView {
    self.tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view = self.tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    HBHttpNetWorking *hbNetWorking = [[HBHttpNetWorking alloc] init];
    [hbNetWorking parseTitleAndUrlFromHttpContentPage:@"http://www.bjtuhbxy.cn/news_more.asp?lm2=91"];
    
    hbNetWorking.delegate = self;
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"myCell"];
    
    
    
    
    
}

- (void)receiveTitleFromContent:(NSMutableArray *)titleArr {
    
    self.array = titleArr;
    [self.tableView reloadData];
}

- (void)receiveUrlFromContent:(NSMutableArray *)urlArr {
    self.contentArray = urlArr;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    cell.textLabel.text = self.array[indexPath.row];
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}


static HBPageViewController *hbPageViewController = nil;


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (hbPageViewController == nil) {
        hbPageViewController = [[HBPageViewController alloc] initWithHttpOfUrl:self.contentArray[indexPath.row]];
    } else {
        [hbPageViewController updateHBPage:self.contentArray[indexPath.row]];
    }
    
    [self.navigationController pushViewController:hbPageViewController animated:YES];
    
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
