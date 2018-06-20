//
//  ViewController.m
//  IbeaconDemo
//
//  Created by AnRu on 2017/3/7.
//  Copyright © 2017年 anru. All rights reserved.
//

#import "ViewController.h"
#import "ANPeripheralManager.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *startBtn;

@property(nonatomic,strong)ANPeripheralManager *pmgr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pmgr = [ANPeripheralManager sharedPeripheralManager];
}
- (IBAction)startBroad:(UIButton *)sender
{

    [self.pmgr startAdvert];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
