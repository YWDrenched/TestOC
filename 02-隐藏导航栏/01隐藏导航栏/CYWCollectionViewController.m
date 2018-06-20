//
//  CYWCollectionViewController.m
//  01隐藏导航栏
//
//  Created by 陈友文 on 2018/3/16.
//  Copyright © 2018年 陈友文. All rights reserved.
//

#import "CYWCollectionViewController.h"
#import <AMScrollingNavbar/UIViewController+ScrollingNavbar.h>

@interface CYWCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end

@implementation CYWCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self followScrollView:self.collectionView usingTopConstraint:self.topConstraint withDelay:60.f];
    [self.navigationController.navigationBar setBarTintColor:[UIColor greenColor]];
    [self.navigationController.navigationBar setTranslucent:NO];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
}

-(void)dealloc{
    [self stopFollowingScrollView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self showNavBarAnimated:NO];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat side = [UIScreen mainScreen].bounds.size.width / 2 - 8;
    return (CGSize){ side, side };
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 40;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"exampleCell" forIndexPath:indexPath];
    return cell;
}


@end
