//
//  TRCollectionViewLayout.h
//  CollectionViewDemo
//
//  Created by rong on 16/6/22.
//  Copyright © 2016年 com.aihuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TRCollectionViewLayoutDelegate <NSObject>

@required

- (CGFloat)collectionViewLayout:(UICollectionViewLayout *)layout ItemWidth:(CGFloat)itemWidth IndexPath:(NSIndexPath *)indexPath;

@optional

/**
    列数
 */
- (NSInteger)numberOfcolumnInCollectionViewLayout:(UICollectionViewLayout *)layout;

/**
    行间距
 */
- (CGFloat)lineSpacingInCollectionViewLayout:(UICollectionViewLayout *)layout;

/**
    列间距
 */
- (CGFloat)columnSpacingInCollectionViewLayout:(UICollectionViewLayout *)layout;

/**
    边缘间距
 */
- (UIEdgeInsets)edgeInsetsInCollectionViewLayout:(UICollectionViewLayout *)layout;

@end

@interface TRCollectionViewLayout : UICollectionViewLayout

@property (nonatomic, weak) id<TRCollectionViewLayoutDelegate>delegate;

@end
