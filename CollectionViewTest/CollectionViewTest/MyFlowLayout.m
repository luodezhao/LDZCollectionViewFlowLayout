//
//  MyFlowLayout.m
//  CollectionViewTest
//
//  Created by YB on 16/1/18.
//  Copyright © 2016年 YB. All rights reserved.
//
#define screen [UIScreen mainScreen]
#import "MyFlowLayout.h"

@interface MyFlowLayout()
{
    NSMutableArray *arraycolunmHeight;
    NSMutableArray *arrayItems ;
    UIEdgeInsets edgeInsets;
    

}
@property (nonatomic,assign) NSInteger column;
@property (nonatomic,weak) id <UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource> delegate;

@end
@implementation MyFlowLayout
- (instancetype)initWithColumn:(NSInteger)colum andDelegate:(id )delegate {
self = [super init];
    if (self) {
        self.column = colum;
        self.delegate = delegate;
    }
    return self;
}

- (void)prepareLayout {
    arraycolunmHeight = [[NSMutableArray alloc]init];
    NSInteger numberOfItem = [self.collectionView numberOfItemsInSection:0];
    arrayItems = [NSMutableArray arrayWithCapacity:numberOfItem];
    if (!self.column) {
        self.column = 2;
    }
    edgeInsets = [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:0];
    self.headerReferenceSize = CGSizeZero;
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForHeaderInSection:)]) {
        self.headerReferenceSize = [self.delegate collectionView:self.collectionView layout:self referenceSizeForHeaderInSection:0];
        
        UICollectionViewLayoutAttributes *headerAttributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        headerAttributes.frame = CGRectMake(0, 0, self.headerReferenceSize.width, self.headerReferenceSize.height);
        [arrayItems addObject:headerAttributes];
    }
    arraycolunmHeight = [NSMutableArray arrayWithCapacity:self.column];
    for (NSInteger i = 0; i < self.column; i ++) {
        [arraycolunmHeight addObject:[NSNumber numberWithInt:self.headerReferenceSize.height]];
    }
    for (NSInteger i = 0; i < numberOfItem; i++) {
        NSInteger shrtCol = [self getMin];
        

        CGFloat y = [(NSNumber *)arraycolunmHeight[shrtCol] integerValue] + edgeInsets.top;
        NSIndexPath *indexpath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexpath];
        CGSize size = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexpath];
                CGFloat x = size.width *shrtCol + edgeInsets.left * (shrtCol + 1);

        attri.frame = CGRectMake(x, y, size.width, size.height);
        [arraycolunmHeight replaceObjectAtIndex:shrtCol withObject:[NSNumber numberWithFloat:y  + size.height]];
        [arrayItems addObject:attri];
    }
}
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{

    return arrayItems;

}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return arrayItems[indexPath.item];
}
- (CGSize)collectionViewContentSize {
    CGFloat y = [(NSNumber *)[arraycolunmHeight objectAtIndex:[self getMax]] floatValue];
    return CGSizeMake(self.collectionView.frame.size.width,  y);}


- (NSInteger)getMin {
    CGFloat min  = MAXFLOAT;
    NSInteger col = 0;
    for (NSInteger i = 0; i<arraycolunmHeight.count; i ++) {
        NSNumber *num = arraycolunmHeight[i];
        if ([num floatValue] < min) {
            min = [num floatValue];
            col = i;
        }
    }
    return col;
}
- (NSInteger)getMax {
    CGFloat max  = 0;
    NSInteger col = 0;
    for (NSInteger i = 0; i<arraycolunmHeight.count; i ++) {
        NSNumber *num = arraycolunmHeight[i];
        if ([num floatValue] > max) {
            max = [num floatValue];
            col = i;
        }
    }
    return col;
    
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return NO;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *itemAttributes = [arrayItems objectAtIndex:0];
    return itemAttributes;
}


@end
