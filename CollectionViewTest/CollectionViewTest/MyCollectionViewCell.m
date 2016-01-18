//
//  MyCollectionViewCell.m
//  CollectionViewTest
//
//  Created by YB on 15/12/17.
//  Copyright © 2015年 YB. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell

- (void)awakeFromNib {
    self.label = [[UILabel alloc]initWithFrame:self.contentView.bounds];
    self.label.opaque = NO;
    self.contentView.backgroundColor = [UIColor redColor];
//    self.label.backgroundColor = [UIColor redColor];
//    [self.contentView addSubview:self.label];
//    [self.imgView addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}
- (void)setText:(NSString *)text
{
    self.label.text = text;
}

@end
