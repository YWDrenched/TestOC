//
//  CYWTableViewController.m
//  01隐藏导航栏
//
//  Created by 陈友文 on 2018/3/15.
//  Copyright © 2018年 陈友文. All rights reserved.
//

#import "CYWTableViewController.h"
#import <AMScrollingNavbar/UIViewController+ScrollingNavbar.h>

@interface CYWTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topContraint;


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)NSArray *dataArr;

@end

@implementation CYWTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarTintColor:[UIColor orangeColor]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self followScrollView:self.tableView usingTopConstraint:self.topContraint withDelay:200.f];
//    [self setShouldScrollWhenContentFits:YES];
    self.dataArr = @[@"123",@"2222",@"3333",@"123",@"2222",@"3333",@"123",@"2222",@"3333",@"123",@"2222",@"3333",@"123",@"2222",@"3333",@"123",@"2222",@"3333",@"123",@"2222",@"3333"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableViewCell"];
    }
    
    cell.textLabel.text = self.dataArr[indexPath.row];
    
    return cell;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self showNavBarAnimated:NO];
}

//- (void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//    [self showNavBarAnimated:NO];
//}


@end
