//
//  WaterFlowLayout.m
//  WaterFlowDemo
//
//  Created by 薛豪东 on 2016/11/21.
//  Copyright © 2016年 NJQY. All rights reserved.
//

#import "WaterFlowLayout.h"


@interface WaterFlowLayout()

@property (nonatomic,strong) NSMutableArray *attrArray;

@property (nonatomic,strong) NSMutableArray *maxArray;
@end

@implementation WaterFlowLayout

- (NSMutableArray *)attrArray{
    if (!_attrArray) {
        _attrArray = [NSMutableArray array];
    }
    return _attrArray;
}

- (NSMutableArray *)maxArray{
    if (!_maxArray) {
        _maxArray = [NSMutableArray array];
    }
    return _maxArray;
}

- (instancetype)init{
    if (self = [super init]) {
        
        _defaultColumnCount = 3;
        _defaultColumnSpacing = 10;
        _defaultRowSpacing = 10;
        _itemInsects = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}

#pragma mark -
- (void)prepareLayout{
    [super prepareLayout];
    
    [self.attrArray removeAllObjects];
    [self.maxArray removeAllObjects];
    
    
    for (NSInteger i=0; i<_defaultColumnCount; i++) {
        [self.maxArray addObject:@(_itemInsects.top)];
    }
    
    
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i=0; i<itemCount; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        [self.attrArray addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    
    NSInteger __block minHeightColumn = 0;
    NSInteger __block minHeight = [self.maxArray[minHeightColumn] floatValue];
    
    NSLog(@"minHeight ========= %ld",minHeight);
    
    [self.maxArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat columnHeight = [(NSNumber *)obj floatValue];
        
        NSLog(@"columnHeight ======= %f",columnHeight);
        
        if (minHeight > columnHeight) {
            minHeight = columnHeight;
            minHeightColumn = idx;
            
            NSLog(@"columnColumn ====== %ld",idx);
        }
        
    }];
    
    CGFloat x;
    CGFloat y;
    CGFloat width;
    CGFloat height;
    
    
    height = 100+arc4random_uniform(100);
    width = (ScreenWidth - _itemInsects.right - _itemInsects.left - _defaultColumnSpacing *(_defaultColumnCount-1))/3;
    
    x = _itemInsects.left + minHeightColumn * (width + _defaultColumnSpacing);
    
    y = minHeight;
    
    if (y != _itemInsects.top) {
        y += _defaultRowSpacing;
    }
    
    [attributes setFrame:CGRectMake(x, y, width, height)];
    self.maxArray[minHeightColumn] = @(CGRectGetMaxY(attributes.frame));
    return attributes;
}

- (CGSize)collectionViewContentSize{
    
    
    NSInteger __block MaxHeight = 0;
    
    [self.maxArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat columnHeight = [(NSNumber *)obj floatValue];
        
        NSLog(@"columnHeight ======= %f",columnHeight);
        
        if (MaxHeight < columnHeight) {
            MaxHeight = columnHeight;
        }
        
    }];

    return CGSizeMake(0, MaxHeight + _defaultRowSpacing);
}

@end
