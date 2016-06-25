//
//  TRCollectionViewLayout.m
//  CollectionViewDemo
//
//  Created by rong on 16/6/22.
//  Copyright © 2016年 com.aihuo. All rights reserved.
//

#import "TRCollectionViewLayout.h"

//默认列数
static NSInteger KDefaultColumnCount = 3;
//默认行间距
static CGFloat KDefaultLineSpacing = 10.0;
//默认列间距
static CGFloat KDefaultColumnSpacing = 10.0;
//默认边缘间距
static UIEdgeInsets KDefaultEdgeInset = {10,10,10,10};

@interface TRCollectionViewLayout ()

//存放属性的数组
@property (nonatomic, strong) NSMutableArray *attriArray;
//存放当前所有列的高度
@property (nonatomic, strong) NSMutableArray *columnsHeightArray;
//内容高度
@property (nonatomic, assign) CGFloat contentHeight;

@end

@implementation TRCollectionViewLayout

//行间距
- (CGFloat)lineSpacing{
    if ([self.delegate respondsToSelector:@selector(lineSpacingInCollectionViewLayout:)]) {
        return [self.delegate lineSpacingInCollectionViewLayout:self];
    }else{
        return KDefaultLineSpacing;
    }
}

//列间距
- (CGFloat)columnSpacing{
    if ([self.delegate respondsToSelector:@selector(columnSpacingInCollectionViewLayout:)]) {
        return [self.delegate columnSpacingInCollectionViewLayout:self];
    }else{
        return KDefaultColumnSpacing;
    }
}

//边缘的间距
- (UIEdgeInsets)edgeInsets{
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInCollectionViewLayout:)]) {
        return [self.delegate edgeInsetsInCollectionViewLayout:self];
    }else{
        return KDefaultEdgeInset;
    }
}

//列数
- (NSInteger)columnCount{
    if ([self.delegate respondsToSelector:@selector(numberOfcolumnInCollectionViewLayout:)]) {
       return [self.delegate numberOfcolumnInCollectionViewLayout:self];
    }else{
        return KDefaultColumnCount;
    }
}

- (NSMutableArray *)attriArray{
    if (!_attriArray) {
        _attriArray = [NSMutableArray array];
    }
    return _attriArray;
}

- (NSMutableArray *)columnsHeightArray{
    if (!_columnsHeightArray) {
        _columnsHeightArray = [NSMutableArray array];
    }
    return _columnsHeightArray;
}

- (void)prepareLayout{
    [super prepareLayout];
    
    //清除上次保存的列高度
    [self.columnsHeightArray removeAllObjects];
    for (int index = 0; index < KDefaultColumnCount; index ++) {
        [self.columnsHeightArray addObject:@(KDefaultEdgeInset.top)];
    }
    
    //清除上次保存的布局属性
    [self.attriArray removeAllObjects];
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    for (int index = 0; index < itemCount; index ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        UICollectionViewLayoutAttributes *attri = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attriArray addObject:attri];
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attriArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat collectionViewWidth = self.collectionView.frame.size.width;
    
    //cell的宽度
    CGFloat cellWidth = (collectionViewWidth - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1)* self.columnSpacing)/self.columnCount;
    
    //cell的高度
    CGFloat cellHeight = [self.delegate collectionViewLayout:self ItemWidth:cellWidth IndexPath:indexPath];
    
    //取出最小的高度
    NSInteger minIndex = 0;
    CGFloat minHeight = [self.columnsHeightArray[0] doubleValue];
    for (int index = 0; index < self.columnCount; index ++) {
        CGFloat height = [self.columnsHeightArray[index] doubleValue];
        if (height < minHeight) {
            minHeight = height;
            minIndex = index;
        }
    }
    
    CGFloat cellX = self.edgeInsets.left + minIndex*(cellWidth + self.columnSpacing);
    CGFloat cellY = minHeight;
    if (cellY != self.edgeInsets.top) {
        cellY += self.lineSpacing;
    }
    
    attri.frame = CGRectMake(cellX, cellY, cellWidth, cellHeight);
    self.columnsHeightArray[minIndex] = @(CGRectGetMaxY(attri.frame));
    
    if (self.contentHeight < minHeight) {
        self.contentHeight = minHeight;
    }
    
    return attri;
}

- (CGSize)collectionViewContentSize{
    CGSize size = CGSizeMake(0, self.contentHeight + self.edgeInsets.bottom);
    return size;
}



@end
