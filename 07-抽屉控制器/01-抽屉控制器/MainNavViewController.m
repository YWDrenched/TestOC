//
//  MainNavViewController.m
//  01-抽屉控制器
//
//  Created by cyw on 2017/2/7.
//  Copyright © 2017年 cyw. All rights reserved.
//

#import "MainNavViewController.h"
#import "UIBarButtonItem+left.h"
@interface MainNavViewController ()

@end

@implementation MainNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    
    if (self.viewControllers.count > 0) {
//        viewController.title = @"Demo";
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithTarget:self action:@selector(back) image:@"返回 (2)" hightImage:@"返回 (3)"];
    }
    
    [super pushViewController:viewController animated:animated];
}

-(void)back{
    [self popViewControllerAnimated:YES];
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
