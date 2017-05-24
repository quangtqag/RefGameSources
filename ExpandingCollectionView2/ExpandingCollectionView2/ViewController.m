//
//  ViewController.m
//  ExpandingCollectionView2
//
//  Created by Quang Tran on 5/24/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+Ext.h"
#import "CardCell.h"
#import "CardCollectionViewController.h"
#import "NumberCollectionViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *numberCollectionView;
@end

@implementation ViewController {
  CardCollectionViewController *_cardCollectionViewController;
  NumberCollectionViewController *_numberCollectionViewController;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self configCardCollectionView];
  [self configNumberCollectionView];
}

-(void)configNumberCollectionView {
  _numberCollectionViewController = [NumberCollectionViewController new];
  self.numberCollectionView.delegate = _numberCollectionViewController;
  self.numberCollectionView.dataSource = _numberCollectionViewController;
  self.numberCollectionView.showsVerticalScrollIndicator = NO;
  self.numberCollectionView.backgroundColor = [UIColor clearColor];
}

-(void)configCardCollectionView {
  _cardCollectionViewController = [CardCollectionViewController new];
  self.cardCollectionView.delegate = _cardCollectionViewController;
  self.cardCollectionView.dataSource = _cardCollectionViewController;
  self.cardCollectionView.showsHorizontalScrollIndicator = NO;
  self.cardCollectionView.backgroundColor = [UIColor clearColor];
  self.cardCollectionView.layer.masksToBounds = NO;
}

@end
