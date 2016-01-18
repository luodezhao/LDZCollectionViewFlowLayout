//
//  MyFlowLayout.h
//  CollectionViewTest
//
//  Created by YB on 16/1/18.
//  Copyright © 2016年 YB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyFlowLayout : UICollectionViewFlowLayout
- (instancetype)initWithColumn:(NSInteger)colum andDelegate:(id)delegate;
@end
