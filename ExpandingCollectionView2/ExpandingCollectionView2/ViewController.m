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
#import "CardPresentAnimationController.h"
#import "CardDismissAnimationController.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UIViewControllerTransitioningDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *numberCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *totalCoursesLabel;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@property(strong) NSArray<Course*>* courses;
@property(strong) CardPresentAnimationController *cardPresentAnimationController;
@property(strong) CardDismissAnimationController *cardDismissAnimationController;
@property(strong) DetailViewController *detailViewController;
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
  
  self.cardPresentAnimationController = [CardPresentAnimationController new];
  self.cardDismissAnimationController = [CardDismissAnimationController new];
}

- (IBAction)searchButtonDidTap:(UIButton *)sender {
  [self.detailViewController dismissViewControllerAnimated:YES completion:nil];
  [self changeBackIconToSearchIcon];
}

-(BOOL)prefersStatusBarHidden {
  return YES;
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

-(void)changeSearchIconToBackIcon {
  UIImage *backIcon = [UIImage imageNamed:@"back"];
  [UIView transitionWithView:self.searchButton
                    duration:0.5
                     options:UIViewAnimationOptionTransitionFlipFromLeft
                  animations:^{
                    [self.searchButton setImage:backIcon forState:UIControlStateNormal];
                  } completion:nil];
}

-(void)changeBackIconToSearchIcon {
  UIImage *searchIcon = [UIImage imageNamed:@"search"];
  [UIView transitionWithView:self.searchButton
                    duration:0.5
                     options:UIViewAnimationOptionTransitionFlipFromRight
                  animations:^{
                    [self.searchButton setImage:searchIcon forState:UIControlStateNormal];
                  } completion:nil];
}


-(void)showDetailViewControllerWithCourse:(Course *)c {
  self.detailViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DetailViewController"];
  self.detailViewController.course = c;
  self.detailViewController.transitioningDelegate = self;
  [self presentViewController:self.detailViewController animated:YES completion:nil];
  
  [self.cardCollectionView setUserInteractionEnabled:NO];
  [self animateExpandHideSiblingCells];
  [self changeSearchIconToBackIcon];
}

-(void)animateExpandHideSiblingCells {
  NSIndexPath *selectedIndexPath = self.cardCollectionView.indexPathsForSelectedItems.firstObject;
  CardCell *previousCell;
  CardCell *nextCell;
  
  if (selectedIndexPath.row - 1 >= 0) {
    NSIndexPath *previousIndexPath = [NSIndexPath indexPathForRow:(selectedIndexPath.row - 1) inSection:0];
    previousCell = (CardCell *)[self.cardCollectionView cellForItemAtIndexPath:previousIndexPath];
  }
  
  if (selectedIndexPath.row + 1 < self.courses.count) {
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:(selectedIndexPath.row + 1) inSection:0];
    nextCell = (CardCell *)[self.cardCollectionView cellForItemAtIndexPath:nextIndexPath];
  }
  
  CGAffineTransform translateBackward = CGAffineTransformMakeTranslation(-60, 0);
  CGAffineTransform transformBackward = CGAffineTransformScale(translateBackward, 0.8, 0.8);
  CGAffineTransform translateForward = CGAffineTransformMakeTranslation(60, 0);
  CGAffineTransform transformForward = CGAffineTransformScale(translateForward, 0.8, 0.8);
  [UIView animateWithDuration:0.5
                   animations:^{
                     if (previousCell != nil) {
                       previousCell.transform = transformBackward;
                     }
                     if (nextCell != nil) {
                       nextCell.transform = transformForward;
                     }
                   }];
}

-(void)animateCollapseShowSiblingCells {
  NSIndexPath *selectedIndexPath = self.cardCollectionView.indexPathsForSelectedItems.firstObject;
  CardCell *previousCell;
  CardCell *nextCell;
  
  if (selectedIndexPath.row - 1 >= 0) {
    NSIndexPath *previousIndexPath = [NSIndexPath indexPathForRow:(selectedIndexPath.row - 1) inSection:0];
    previousCell = (CardCell *)[self.cardCollectionView cellForItemAtIndexPath:previousIndexPath];
  }
  
  if (selectedIndexPath.row + 1 < self.courses.count) {
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:(selectedIndexPath.row + 1) inSection:0];
    nextCell = (CardCell *)[self.cardCollectionView cellForItemAtIndexPath:nextIndexPath];
  }
  
  CGAffineTransform transform = CGAffineTransformMakeScale(0.8, 0.8);
  [UIView animateWithDuration:0.5
                   animations:^{
                     if (previousCell != nil) {
                       previousCell.transform = transform;
                     }
                     if (nextCell != nil) {
                       nextCell.transform = transform;
                     }
                   }];
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
  
  // Put in asyn block to make sure that the animation done correctly.
  dispatch_async(dispatch_get_main_queue(), ^{
    [self showDetailViewControllerWithCourse:self.courses[selectedIndexPath.row]];
  });
}

#pragma mark - UIViewControllerTransitioningDelegate
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                 presentingController:(UIViewController *)presenting
                                                                     sourceController:(UIViewController *)source {
  NSIndexPath *selectedIndexPath = self.cardCollectionView.indexPathsForSelectedItems.firstObject;
  CardCell *cell = (CardCell *)[self.cardCollectionView cellForItemAtIndexPath:selectedIndexPath];
  CGRect cellFrame = [cell convertRect:cell.contentView.frame toView:self.view];
  self.cardPresentAnimationController.originFrame = cellFrame;
  
  return self.cardPresentAnimationController;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
  NSIndexPath *selectedIndexPath = self.cardCollectionView.indexPathsForSelectedItems.firstObject;
  CardCell *cell = (CardCell *)[self.cardCollectionView cellForItemAtIndexPath:selectedIndexPath];
  CGRect cellFrame = [cell convertRect:cell.contentView.frame toView:self.view];
  self.cardDismissAnimationController.destinationFrame = cellFrame;
  
  [self.cardCollectionView setUserInteractionEnabled:YES];
  [self animateCollapseShowSiblingCells];
  
  return self.cardDismissAnimationController;
}

@end

