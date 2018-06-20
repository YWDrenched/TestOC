//
//  ViewController.m
//  01-摇一摇功能
//
//  Created by cyw on 16/12/8.
//  Copyright © 2016年 cyw. All rights reserved.
//

#import "ViewController.h"
#import <Accelerate/Accelerate.h>


@interface ViewController ()<UIAccelerometerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIAccelerometer *acclerate = [UIAccelerometer sharedAccelerometer];
    
    acclerate.updateInterval = 2.0;
    
    acclerate.delegate = self;
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration{
    NSLog(@"%f-----%f-------%f",acceleration.x,acceleration.y,acceleration.z);
}


//-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
//    NSLog(@"1");
//}
//-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
//    NSLog(@"2");
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
