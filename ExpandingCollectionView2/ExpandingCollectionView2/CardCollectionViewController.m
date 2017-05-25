//
//  CardCollectionViewController.m
//  ExpandingCollectionView2
//
//  Created by Quang Tran on 5/24/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import "CardCollectionViewController.h"
#import "CardCell.h"
#import "CardCollectionViewLayout.h"

@implementation CardCollectionViewController

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.courses.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  CardCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
  cell.course = self.courses[indexPath.row];
  return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (self.collectionViewDidScrollPercent != nil) {
    CGFloat percent = scrollView.contentOffset.x / (self.cellWidth * (self.numOfItems - 1));
    self.collectionViewDidScrollPercent(percent);
  }
}


@end
