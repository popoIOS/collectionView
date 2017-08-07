//
//  WaterFlowViewController.m
//  WaterFlowDemo
//
//  Created by xuehaodong on 2016/12/8.
//  Copyright © 2016年 NJQY. All rights reserved.
//

#import "WaterFlowViewController.h"
#import "WaterFlowLayout.h"
#import "CustomCell.h"

static NSString *ID = @"UICollectionViewCell";

@interface WaterFlowViewController ()<UICollectionViewDataSource>

@end

@implementation WaterFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    WaterFlowLayout *layout = [[WaterFlowLayout alloc] init];
   
    self.collectionView.collectionViewLayout = layout;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    [self.collectionView setDataSource:self];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor orangeColor]];
    
    NSInteger tag = 10;
    
    UILabel *lable = [cell viewWithTag:10];
    
    if (!lable) {
        lable = [[UILabel alloc] init];
        lable.tag = tag;
        [cell.contentView addSubview:lable];
    }
    
    [lable setText:[NSString stringWithFormat:@"%zd",indexPath.row]];
    [lable sizeToFit];
    return cell;
}

@end
