//
//  CommonViewController.m
//  CollectionViewDemo
//
//  Created by rong on 16/6/21.
//  Copyright © 2016年 com.aihuo. All rights reserved.
//

#import "CommonViewController.h"
#import "Masonry.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

NSString * const KcollectionViewCellID = @"cellID";
NSString * const KReusableHeaderView = @"reuseHeader";
NSString * const KReusableFooterView = @"reuseFooter";


@interface CommonViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic ,strong) NSMutableArray *data;

@end

@implementation CommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _data = [NSMutableArray array];
    for (int index = 0; index < 6; index ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dog%d.jpg",index]];
        [_data addObject:image];
    }
    
    //创建布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    //注册重复使用的cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:KcollectionViewCellID];
    
    //注册重复使用的headerView和footerView
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:KReusableHeaderView];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:KReusableFooterView];
    
    //添加长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.collectionView addGestureRecognizer:longPress];
}

#pragma mark- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:KcollectionViewCellID forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:_data[indexPath.row]];
    cell.backgroundView = imageView;
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return 3;
//}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath{
    id obj = [_data objectAtIndex:sourceIndexPath.item];
    [_data removeObject:obj];
    [_data insertObject:obj atIndex:destinationIndexPath.item];
}

//设置headerView和footerView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        reusableView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:KReusableHeaderView forIndexPath:indexPath];
        UILabel *lab = [[UILabel alloc] init];
        lab.text = @"头部";
        [reusableView addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(reusableView);
        }];
//        reusableView.backgroundColor = [UIColor redColor];
    }else{
        reusableView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:KReusableFooterView forIndexPath:indexPath];
        UILabel *lab = [[UILabel alloc] init];
        lab.text = @"尾部";
        [reusableView addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(reusableView);
        }];

//        reusableView.backgroundColor = [UIColor yellowColor];
    }
    return reusableView;
}

#pragma mark - UICollectionViewDelegateFlowLayout
//设置cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = CGSizeMake((SCREEN_WIDTH-30)/2.0, (SCREEN_WIDTH-30)/2.0);
    return size;
}

//设置cell与边缘的间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    UIEdgeInsets inset = UIEdgeInsetsMake(10, 10, 10, 10);
    return inset;
}

//最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

//最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

//设置header高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size = CGSizeMake(0, 30);
    return size;
}

//设置footer高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    CGSize size = CGSizeMake(0, 30);
    return size;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击section%ld的第%ld个cell",indexPath.section,indexPath.row);
}

- (void)longPress:(UILongPressGestureRecognizer *)longPress{
    UIGestureRecognizerState state = longPress.state;
    switch (state) {
        case UIGestureRecognizerStateBegan:{
            CGPoint pressPoint = [longPress locationInView:self.collectionView];
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:pressPoint];
            if (!indexPath) {
                break;
            }
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            break;
        }
        case UIGestureRecognizerStateChanged:{
            CGPoint pressPoint = [longPress locationInView:self.collectionView];
            [self.collectionView updateInteractiveMovementTargetPosition:pressPoint];
            break;
        }
        case UIGestureRecognizerStateEnded:{
            [self.collectionView endInteractiveMovement];
            break;
        }
        default:
            [self.collectionView cancelInteractiveMovement];
            break;
    }
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
