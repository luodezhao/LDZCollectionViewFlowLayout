//
//  ViewController.m
//  CollectionViewTest
//
//  Created by YB on 15/12/17.
//  Copyright © 2015年 YB. All rights reserved.
//

#import "ViewController.h"
#import "MyCollectionViewCell.h"
#import "CollectionReusableView.h"
#import "MyFlowLayout.h"
#define MainScreen [UIScreen mainScreen]
@interface ViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    NSArray *sections;
    MyCollectionViewCell *reuseCell;
    NSArray *sizes;
    NSMutableArray *heights;
    NSMutableArray *cellYs;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    heights = [[NSMutableArray alloc]init];
    cellYs = [[NSMutableArray alloc]init];
    sections = @[[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"3"],[UIImage imageNamed:@"4"],[UIImage imageNamed:@"5"],[UIImage imageNamed:@"6"]];
    CGFloat scale2 = 0.5494;
    CGFloat scale1 = 1.34;
    NSArray *cells = [[NSBundle mainBundle] loadNibNamed:@"MyCollectionViewCell" owner:self options:nil];
    reuseCell = cells[0];
    MyFlowLayout * a=[[MyFlowLayout alloc]initWithColumn:2 andDelegate:self];
    self.collectionView.collectionViewLayout =a ;
    sizes = @[[NSString stringWithFormat:@"%f",scale1],[NSString stringWithFormat:@"%f",scale2],[NSString stringWithFormat:@"%f",scale1],[NSString stringWithFormat:@"%f",scale1],[NSString stringWithFormat:@"%f",scale2],[NSString stringWithFormat:@"%f",scale2]];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"collect"];
    [self.collectionView registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"1"];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return sections.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collect" forIndexPath:indexPath];
    CGFloat scale = [[sizes objectAtIndex:indexPath.row]floatValue];

    cell.imgView.image = [sections objectAtIndex:indexPath.row];
     NSInteger  s = (MainScreen.bounds.size.width-15)/2;
    for (NSLayoutConstraint *layout in  cell.imgView.constraints) {
        if (layout.firstAttribute == NSLayoutAttributeHeight && layout.firstItem == cell.imgView) {
            layout.constant = s/scale;
            NSLog(@"%f",s/scale);
        }
        [cell.contentView layoutIfNeeded];
    }
       return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat  s = (MainScreen.bounds.size.width-15)/2 ;

    CGFloat scale = [[sizes objectAtIndex:indexPath.row]floatValue];
    [heights addObject: [NSString stringWithFormat:@"%f",s/scale]];
       return CGSizeMake(s, s/scale);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5,5);
   
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CollectionReusableView *a  = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"1" forIndexPath:indexPath];
        a.backgroundColor = [UIColor redColor];
        return a;
        
    }else {
        return nil;
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(100, 100);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
