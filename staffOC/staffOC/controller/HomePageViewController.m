//
//  HomePageViewController.m
//  staffOC
//
//  Created by zm004 on 16/7/28.
//  Copyright © 2016年 zm004. All rights reserved.
//

#import "HomePageViewController.h"
#import "GBApi.h"
#import "ProjectModel.h"
#import "HomePageCell.h"
@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *items;
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.title = @"首页";
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.items = [[NSMutableArray alloc]init];
    [self.tableView registerClass:[HomePageCell class] forCellReuseIdentifier:@"homePageCell"];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self loadData];
    // Do any additional setup after loading the view.
}
- (void)loadData{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    if (self.isAllRefresh) {
        params[@"start"] = 0;
        params[@"limit"] = [NSString stringWithFormat:@"%lu",(unsigned long)self.items.count];
    } else if (self.isLoadMore) {
        params[@"start"] = [NSString stringWithFormat:@"%lu",(unsigned long)self.items.count];
        params[@"limit"] = [NSString stringWithFormat:@"%lu",(unsigned long)5];
    } else {
//        params[@"start"] = 0;
//        params[@"limit"] = [NSString stringWithFormat:@"%lu",(unsigned long)5];
        [params setValue:@"0" forKey:@"start"];
        [params setValue:[NSString stringWithFormat:@"%lu",(unsigned long)5] forKey:@"limit"];
    }
    NSLog(@"%@",params);
    GBApi *gbApi = [[GBApi alloc] initWithUrl:@"common/getAppArticle" params:params vc:self];
    gbApi.successBlock = ^(Zjson *zjson){
        for (NSDictionary *d in zjson.items) {
            ProjectModel *model = [[ProjectModel alloc] initWith:d];
            [self.items addObject:model];
        }
        [self.tableView reloadData];
    };
    [gbApi post];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.items.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homePageCell" forIndexPath:indexPath];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
