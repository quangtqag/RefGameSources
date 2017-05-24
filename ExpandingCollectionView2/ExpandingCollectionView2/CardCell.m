//
//  CardCell.m
//  ExpandingCollectionView2
//
//  Created by Quang Tran on 5/24/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import "CardCell.h"

@implementation CardCell

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self config];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
  self = [super initWithCoder:coder];
  if (self) {
    [self config];
  }
  return self;
}

-(void)config {
  
  self.contentView.layer.cornerRadius = 5;
  self.contentView.layer.masksToBounds = YES;
  self.contentView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
  self.contentView.layer.borderWidth = 0.5;
  
  self.layer.masksToBounds = NO;
  self.layer.shadowOffset = CGSizeMake(10, 15);
  self.layer.shadowRadius = 10;
  self.layer.shadowOpacity = 0.5;
  self.backgroundColor = [UIColor clearColor];
}

-(void)layoutSubviews {
  self.faceImageView.layer.cornerRadius = self.faceImageView.bounds.size.width/2;
  self.faceImageView.layer.masksToBounds = YES;
  
  UIColor *iconTintColor = [UIColor lightGrayColor];
  UIImage *eyeImg = [[UIImage imageNamed:@"eye"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.eyeImageView.image = eyeImg;
  self.eyeImageView.tintColor = iconTintColor;
  
  UIImage *commentImg = [[UIImage imageNamed:@"comment"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.commentImageView.image = commentImg;
  self.commentImageView.tintColor = iconTintColor;
  
  UIImage *heartImg = [[UIImage imageNamed:@"heart"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.heartImageView.image = heartImg;
  self.heartImageView.tintColor = iconTintColor;
}

@end
