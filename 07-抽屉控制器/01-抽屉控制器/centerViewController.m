//
//  centerViewController.m
//  01-抽屉控制器
//
//  Created by cyw on 2017/2/7.
//  Copyright © 2017年 cyw. All rights reserved.
//

#import "centerViewController.h"
#import "UIBarButtonItem+left.h"
#import "UIViewController+MMDrawerController.h"

@interface centerViewController ()

@end

@implementation centerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Demo";
    self.view.backgroundColor = [UIColor greenColor];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithTarget:self action:@selector(leftBtnClick) image:@"菜单 (1)" hightImage:@"菜单"];
}

-(void)leftBtnClick{
//    将左边的控制器打开
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
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
