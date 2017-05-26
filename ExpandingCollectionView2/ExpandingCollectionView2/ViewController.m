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
#import "Course.h"
#import "CardCollectionViewLayout.h"
#import "NumberCollectionViewLayout.h"
#import "DetailViewController.h"
#import "NumberCell.h"
#import "CardAnimator.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UIViewControllerTransitioningDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *numberCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *totalCoursesLabel;

@property(strong) NSArray<Course*>* courses;
@property(strong) CardAnimator *transition;
@end

@implementation ViewController

const CGFloat kNumberCellHeight = 60;
const CGFloat kCardCellWidth = 200;

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.courses = [self coursesData];
  self.totalCoursesLabel.text = [NSString stringWithFormat:@"%ld", self.courses.count];
  [self configCardCollectionView];
  [self configNumberCollectionView];
  
  self.transition = [CardAnimator new];
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

-(void)configNumberCollectionView {
  self.numberCollectionView.delegate = self;
  self.numberCollectionView.dataSource = self;
  self.numberCollectionView.showsVerticalScrollIndicator = NO;
  self.numberCollectionView.backgroundColor = [UIColor clearColor];
  self.numberCollectionView.userInteractionEnabled = NO;
  NumberCollectionViewLayout *layout = (NumberCollectionViewLayout*)self.numberCollectionView.collectionViewLayout;
  layout.cellHeight = kNumberCellHeight;
}

-(void)configCardCollectionView {
  self.cardCollectionView.prefetchingEnabled = NO;
  self.cardCollectionView.delegate = self;
  self.cardCollectionView.dataSource = self;
  self.cardCollectionView.showsHorizontalScrollIndicator = NO;
  self.cardCollectionView.backgroundColor = [UIColor clearColor];
  self.cardCollectionView.layer.masksToBounds = NO;
  CardCollectionViewLayout *layout = (CardCollectionViewLayout*)self.cardCollectionView.collectionViewLayout;
  layout.cellWidth = kCardCellWidth;
}

-(void)showDetailViewControllerWithCourse:(Course *)c {
  DetailViewController *detailViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DetailViewController"];
  detailViewController.course = c;
  detailViewController.transitioningDelegate = self;
  [self presentViewController:detailViewController animated:YES completion:nil];
}

#pragma mark - Collection View Delegate DataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.courses.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  if ([collectionView isEqual:self.cardCollectionView]) {
    CardCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.course = self.courses[indexPath.row];
    return cell;
  }
  else {
    NumberCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.number = indexPath.row + 1;
    return cell;
  }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if ([scrollView isEqual:self.cardCollectionView]) {
    CGFloat percent = scrollView.contentOffset.x / (kCardCellWidth * (self.courses.count - 1));
    [self.numberCollectionView setContentOffset:CGPointMake(0, percent * kNumberCellHeight * (self.courses.count - 1))];
  }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  if (collectionView.contentOffset.x != indexPath.row * kCardCellWidth) {
    [collectionView setContentOffset:CGPointMake(indexPath.row * kCardCellWidth, 0) animated:YES];
  }
  else {
    [self showDetailViewControllerWithCourse:self.courses[indexPath.row]];
  }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
  NSIndexPath *selectedIndexPath = self.cardCollectionView.indexPathsForSelectedItems.firstObject;
  [self showDetailViewControllerWithCourse:self.courses[selectedIndexPath.row]];
}

#pragma mark - UIViewControllerTransitioningDelegate
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                 presentingController:(UIViewController *)presenting
                                                                     sourceController:(UIViewController *)source {
  NSIndexPath *selectedIndexPath = self.cardCollectionView.indexPathsForSelectedItems.firstObject;
  CardCell *cell = (CardCell *)[self.cardCollectionView cellForItemAtIndexPath:selectedIndexPath];
  CGRect cellFrame = [cell convertRect:cell.contentView.frame toView:nil];
  self.transition.originFrame = cellFrame;
  return self.transition;
}

@end

