//
//  OCViewController.m
//  QQBuglyDemo
//
//  Created by zm004 on 16/4/15.
//  Copyright © 2016年 zm004. All rights reserved.
//

#import "OCViewController.h"

@interface OCViewController ()

@end

@implementation OCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *aLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 100, 100, 50)];
    self.view.backgroundColor = [UIColor whiteColor];
    aLabel.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:aLabel];
    aLabel.text = @"\uE056";
    // Do any additional setup after loading the view.
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
