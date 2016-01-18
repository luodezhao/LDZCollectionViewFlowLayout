//
//  MyCollectionViewCell.h
//  CollectionViewTest
//
//  Created by YB on 15/12/17.
//  Copyright © 2015年 YB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong,nonatomic) UILabel *label;
@property (copy,nonatomic) NSString *text;
@property (assign,nonatomic) CGSize cellSize;
@end
