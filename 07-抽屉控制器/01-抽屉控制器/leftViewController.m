//
//  leftViewController.m
//  01-抽屉控制器
//
//  Created by cyw on 2017/2/7.
//  Copyright © 2017年 cyw. All rights reserved.
//

#import "leftViewController.h"
#import "pushViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MainNavViewController.h"

@interface leftViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation leftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
       self.view.backgroundColor = [UIColor blueColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }

    cell.detailTextLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    pushViewController *pushVc = [[pushViewController alloc] init];
    pushVc.title = [NSString stringWithFormat:@"%zd",indexPath.row];
    
//    [self.navigationController pushViewController:pushVc animated:YES];
    
    MainNavViewController *mainNavVc = (MainNavViewController *)self.mm_drawerController.centerViewController;
    [mainNavVc pushViewController:pushVc animated:YES];
    
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    NSLog(@"123123");
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
