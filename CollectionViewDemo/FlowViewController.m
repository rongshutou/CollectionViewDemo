//
//  FlowViewController.m
//  CollectionViewDemo
//
//  Created by rong on 16/6/22.
//  Copyright © 2016年 com.aihuo. All rights reserved.
//

#import "FlowViewController.h"
#import "Masonry.h"
#import "TRCollectionViewLayout.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

NSString * const KFlowCellID = @"cellID";


@interface FlowViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,TRCollectionViewLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation FlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建布局
    TRCollectionViewLayout *flowLayout = [[TRCollectionViewLayout alloc] init];
    flowLayout.delegate = self;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    //注册重复使用的cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:KFlowCellID];
}

#pragma mark- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:KFlowCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

#pragma mark - TRCollectionViewLayoutDelegate
- (CGFloat)collectionViewLayout:(UICollectionViewLayout *)layout ItemWidth:(CGFloat)itemWidth IndexPath:(NSIndexPath *)indexPath{
    return 40 + arc4random_uniform(100);
}

- (UIEdgeInsets)edgeInsetsInCollectionViewLayout:(UICollectionViewLayout *)layout{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
