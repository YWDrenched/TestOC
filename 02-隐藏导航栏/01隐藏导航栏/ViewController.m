//
//  ViewController.m
//  01隐藏导航栏
//
//  Created by 陈友文 on 2018/3/15.
//  Copyright © 2018年 陈友文. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    CGRect frame = self.navigationController.navigationBar.frame;
//    frame.origin.y = -24;
//    
//    self.navigationController.navigationBar.frame = frame;
    
    NSLog(@"navbar height === %@",NSStringFromCGRect(self.navigationController.navigationBar.frame) );
}


@end
