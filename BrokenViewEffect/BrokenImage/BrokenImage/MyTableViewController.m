//
//  MyTableViewController.m
//  BrokenImage
//
//  Created by Quang Tran on 5/30/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import "MyTableViewController.h"
#import "CommenterCell.h"
#import "MGSwipeButton.h"
#import "Course.h"
#import "UIImage+Ext.h"

@interface MyTableViewController ()<UITableViewDataSource, CAAnimationDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong) NSMutableArray<Commenter*> *commenters;

@end

@implementation MyTableViewController

static const NSTimeInterval kBrokenViewDuration = 2;

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.tableView.dataSource = self;
  self.tableView.tableFooterView = [UIView new];
  self.tableView.allowsSelection = NO;
  
  NSArray<Course*>* courses = [self coursesData];
  self.commenters = [NSMutableArray arrayWithArray:courses.firstObject.commenters];
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.commenters.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  CommenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
  cell.commenter = self.commenters[indexPath.row];
  
  __weak MyTableViewController *weakSelf = self;
  MGSwipeButton *deleteBtn =
  [MGSwipeButton
   buttonWithTitle:@""
   icon: [UIImage imageNamed:@"delete"]
   backgroundColor:[UIColor redColor]
   padding: 20
   callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
     [cell hideSwipeAnimated:YES completion:^(BOOL finished) {
       // Get image from selected cell
       UIGraphicsBeginImageContext(cell.bounds.size);
       [cell.layer renderInContext:UIGraphicsGetCurrentContext()];
       UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
       UIGraphicsEndImageContext();
       
       // Trigger broken image effect
       CGRect contentCellFrame = [cell convertRect:cell.contentView.bounds toView:weakSelf.view];
       [self brokeImage:img atPosition:contentCellFrame.origin duration:kBrokenViewDuration];

       // Animate delete row and set custom duration
       [UIView beginAnimations:@"deleteRowAnimation" context:nil];
       [UIView setAnimationDuration:kBrokenViewDuration / 2];
       
       [tableView beginUpdates];
       NSIndexPath *indexPath = [tableView indexPathForCell:cell];
       [weakSelf.commenters removeObjectAtIndex:indexPath.row];
       [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
       [tableView endUpdates];
       
       [CATransaction commit];
       [UIView commitAnimations];
     }];
     return NO;
   }];
  deleteBtn.tintColor = [UIColor whiteColor];
  cell.rightButtons = @[deleteBtn];
  
  return cell;
}

-(void)brokeImage:(UIImage *)img
       atPosition:(CGPoint)position
         duration:(NSTimeInterval)duration {
  __block UIView *brokenView = [[UIView alloc] initWithFrame:CGRectMake(position.x,
                                                                position.y,
                                                                img.size.width,
                                                                img.size.height)];
  // Create depth for sub layers
  CATransform3D depthTransform = CATransform3DIdentity;
  depthTransform.m34 = 1.0 / -900.0;
  brokenView.layer.sublayerTransform = depthTransform;
  brokenView.layer.masksToBounds = YES;
  [self.view addSubview:brokenView];
  
  // Set number of pixels for every sub layer
  NSUInteger pieceSize = 4;
  
  // Set range to translate sub layer horizontal
  NSRange xRange = NSMakeRange(0, 300);
  
  // Set range to translate sub layer vertically
  NSRange yRange = NSMakeRange(0, 300);
  
  // Set range to translate sub layer in depth
  NSRange zRange = NSMakeRange(100, 1000);
  
  // Set range to rotate sub layer
  NSRange zRotateRange = NSMakeRange(10, 360);
  
  CGFloat layerWidth = img.size.width;
  CGFloat layerHeight = img.size.height;
  NSUInteger horizontalLayoutCount = layerWidth / pieceSize;
  NSUInteger verticalLayoutCount = layerHeight / pieceSize;
  CGFloat subLayerWidth = layerWidth / horizontalLayoutCount;
  CGFloat subLayerHeight = layerHeight / verticalLayoutCount;
  
  NSMutableArray *subLayers = [NSMutableArray new];
  // Generate sub layers, set cropped small image and store them into an array
  for (int v = 0; v < verticalLayoutCount; v++) {
    for (int h = 0; h < horizontalLayoutCount; h++) {
      CGRect subFrame = CGRectMake(h * subLayerWidth, v * subLayerHeight, subLayerWidth, subLayerHeight);
      CALayer *subLayer = [CALayer layer];
      subLayer.frame = subFrame;
      subLayer.cornerRadius = subLayerWidth / 2;
      subLayer.masksToBounds = YES;
      UIImage *subImg = [img cropToRect:subFrame];
      subLayer.contents = (__bridge id _Nullable)(subImg.CGImage);
      
      [subLayers addObject:subLayer];
      [brokenView.layer addSublayer:subLayer];
    }
  }
  
  // Add animations for every sub layers
  for (CALayer *subLayer in subLayers) {
    // Random x, y, z and zRotate values
    int xTranslatingRandom = (int)(arc4random_uniform((unsigned int)xRange.length + 1) + xRange.location);
    xTranslatingRandom *= arc4random_uniform(2) == 0 ? -1 : 1;
    
    int yTranslatingRandom = (int)(arc4random_uniform((unsigned int)yRange.length + 1) + yRange.location);
    yTranslatingRandom *= arc4random_uniform(2) == 0 ? -1 : 1;
    
    int zTranslatingRandom = (int)(arc4random_uniform((unsigned int)zRange.length + 1) + zRange.location);
    zTranslatingRandom *= arc4random_uniform(2) == 0 ? -1 : 1;
    
    int zRotatingRandom = (int)(arc4random_uniform((unsigned int)zRotateRange.length + 1) + zRotateRange.location);
    
    // Transform animation
    CABasicAnimation *translateAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    translateAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    CATransform3D targetTransform = CATransform3DMakeTranslation(xTranslatingRandom, yTranslatingRandom, zTranslatingRandom);
    targetTransform = CATransform3DRotate(targetTransform, zRotatingRandom * M_PI / 180, 0, 0, 1);
    translateAnim.toValue = [NSValue valueWithCATransform3D: targetTransform];
    translateAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    subLayer.transform = targetTransform;
    
    // Opacity animation
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.fromValue = [NSNumber numberWithFloat:1];
    opacityAnim.toValue = [NSNumber numberWithFloat:.0];
    opacityAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    subLayer.opacity = 0;
    
    // Group animations
    CAAnimationGroup *group = [CAAnimationGroup animation];
    [group setDuration:duration];
    [group setAnimations:@[translateAnim, opacityAnim]];
    group.delegate = self;
    [subLayer addAnimation:group forKey:nil];
  }
  
  // Remove broken view after animated
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [brokenView removeFromSuperview];
    brokenView = nil;
  });
}

@end
