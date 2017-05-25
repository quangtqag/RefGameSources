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
#import "Course.h"
#import "CardCollectionViewLayout.h"
#import "NumberCollectionViewLayout.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *numberCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *totalCoursesLabel;
@end

@implementation ViewController {
  CardCollectionViewController *_cardCollectionViewController;
  NumberCollectionViewController *_numberCollectionViewController;
}

const CGFloat kNumberCellHeight = 60;
const CGFloat kCardCellWidth = 200;

- (void)viewDidLoad {
  [super viewDidLoad];
  
  NSArray<Course*>* coursesData = [self coursesData];
  self.totalCoursesLabel.text = [NSString stringWithFormat:@"%ld", coursesData.count];
  [self configCardCollectionViewWithCourses:coursesData];
  [self configNumberCollectionViewWithAmount:coursesData.count];
}

-(NSArray<Course*>*)coursesData {
  NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
  NSData *data = [NSData dataWithContentsOfFile:path];
  NSError *err;
  NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
  if (err == nil) {
    return [Course coursesWithDictArray:arr];
  }
  else {
    [NSException raise:@"Can not get courses data!" format:@"%@", err.localizedDescription];
    return nil;
  }
}

-(void)configNumberCollectionViewWithAmount:(NSUInteger)amount {
  _numberCollectionViewController = [NumberCollectionViewController new];
  _numberCollectionViewController.amount = amount;
  self.numberCollectionView.delegate = _numberCollectionViewController;
  self.numberCollectionView.dataSource = _numberCollectionViewController;
  self.numberCollectionView.showsVerticalScrollIndicator = NO;
  self.numberCollectionView.backgroundColor = [UIColor clearColor];
  NumberCollectionViewLayout *layout = (NumberCollectionViewLayout*)self.numberCollectionView.collectionViewLayout;
  layout.cellHeight = kNumberCellHeight;
}

-(void)configCardCollectionViewWithCourses:(NSArray<Course*>*)courses {
  _cardCollectionViewController = [CardCollectionViewController new];
  _cardCollectionViewController.courses = courses;
  _cardCollectionViewController.numOfItems = courses.count;
  _cardCollectionViewController.cellWidth = kCardCellWidth;
  self.cardCollectionView.prefetchingEnabled = NO;
  self.cardCollectionView.delegate = _cardCollectionViewController;
  self.cardCollectionView.dataSource = _cardCollectionViewController;
  self.cardCollectionView.showsHorizontalScrollIndicator = NO;
  self.cardCollectionView.backgroundColor = [UIColor clearColor];
  self.cardCollectionView.layer.masksToBounds = NO;
  CardCollectionViewLayout *layout = (CardCollectionViewLayout*)self.cardCollectionView.collectionViewLayout;
  layout.cellWidth = kCardCellWidth;
  __weak UICollectionView *weakNumberCollectionView = self.numberCollectionView;
  _cardCollectionViewController.collectionViewDidScrollPercent = ^(CGFloat percent) {
    [weakNumberCollectionView setContentOffset:CGPointMake(0, percent * kNumberCellHeight * (courses.count - 1))];
  };
}

@end
