//
//  CardCollectionViewController.h
//  ExpandingCollectionView2
//
//  Created by Quang Tran on 5/24/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Course.h"

@interface CardCollectionViewController : NSObject<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong, nonnull) NSArray<Course*>* courses;
@property(assign) CGFloat cellWidth;
@property(assign) NSUInteger numOfItems;
@property(nonatomic, copy, nullable) void (^collectionViewDidScrollPercent)(CGFloat);

@end
