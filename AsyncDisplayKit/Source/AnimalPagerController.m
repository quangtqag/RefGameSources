/**
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import "AnimalPagerController.h"
#import "AnimalTableController.h"
#import "RainforestCardInfo.h"
#import "CardNode.h"

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface AnimalPagerController ()
@property (strong, nonatomic) ASPagerNode *pagerNode;
@property (strong, nonatomic) NSArray<NSArray<RainforestCardInfo *> *> *animals;
@end

@interface AnimalPagerController (ASPagerDataSource)<ASPagerDataSource>
@end


@implementation AnimalPagerController

#pragma mark - Lifecycle

- (instancetype)init {
  if (!(self = [super init])) { return nil; }

  _animals = @[[RainforestCardInfo birdCards],
               [RainforestCardInfo mammalCards],
               [RainforestCardInfo reptileCards]];

  // Create and configure ASPagerNode instance here:

  _pagerNode = [[ASPagerNode alloc] init];
  _pagerNode.dataSource = self;
  _pagerNode.backgroundColor = [UIColor blackColor];
  

  return self;
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  self.pagerNode.frame = self.view.bounds;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.view addSubnode:self.pagerNode];
}

#pragma mark - View Controller Appearance

- (BOOL)prefersStatusBarHidden {
  return YES;
}

@end


@implementation AnimalPagerController (ASPagerDataSource)

- (NSInteger)numberOfPagesInPagerNode:(ASPagerNode *)pagerNode {
  return self.animals.count;
}

- (ASCellNode *)pagerNode:(ASPagerNode *)pagerNode nodeAtIndex:(NSInteger)index {
  //1
  CGSize pagerNodeSize = pagerNode.bounds.size;
  NSArray *animals = self.animals[index];
  
  //2
  ASCellNode *node = [[ASCellNode alloc] initWithViewControllerBlock:^{
    return [[AnimalTableController alloc] initWithAnimals:animals];
  } didLoadBlock:nil];
  
  return node;
}

@end
