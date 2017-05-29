//
//  ViewController.m
//  BrokenImage
//
//  Created by Quang Tran on 5/28/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
  UIView *_brokenView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

-(BOOL)prefersStatusBarHidden {
  return YES;
}

- (IBAction)animateButtonDidTap:(id)sender {
  [_brokenView removeFromSuperview];
  [self animate];
}

-(void)animate {
  UIImage *img = [UIImage imageNamed:@"lion"];
  _brokenView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
  _brokenView.center = self.view.center;
  CATransform3D tI = CATransform3DIdentity;
  tI.m34 = 1.0 / -900.0;
  _brokenView.layer.sublayerTransform = tI;
  _brokenView.layer.masksToBounds = YES;
  [self.view addSubview:_brokenView];
  
  CGFloat layerWidth = self.view.bounds.size.width;
  CGFloat layerHeight = 200;
  
  NSUInteger pieceSize = 9;
  NSUInteger horizontalLayoutCount = layerWidth / pieceSize;
  NSUInteger verticalLayoutCount = layerHeight / pieceSize;
  
  CGFloat subLayerWidth = layerWidth / horizontalLayoutCount;
  CGFloat subLayerHeight = layerHeight / verticalLayoutCount;
  
  NSMutableArray *subLayers = [NSMutableArray new];
  for (int v = 0; v < verticalLayoutCount; v++) {
    for (int h = 0; h < horizontalLayoutCount; h++) {
      CGRect subFrame = CGRectMake(h * subLayerWidth, v * subLayerHeight, subLayerWidth, subLayerHeight);
      CALayer *subLayer = [CALayer layer];
      subLayer.frame = subFrame;
      subLayer.cornerRadius = subLayerWidth / 2;
      subLayer.masksToBounds = YES;
      UIImage *subImg = [self cropImage:img toRect:subFrame];
      subLayer.contents = (__bridge id _Nullable)(subImg.CGImage);
      
      [subLayers addObject:subLayer];
      [_brokenView.layer addSublayer:subLayer];
    }
  }
  
  NSRange xRange = NSMakeRange(0, 300);
  NSRange yRange = NSMakeRange(0, 300);
  NSRange zRange = NSMakeRange(100, 1000);
  NSRange zRotateRange = NSMakeRange(10, 360);
  CGFloat minScale = 0.1;
  CGFloat maxScale = 3;
  CGFloat duration = 2.0f;
  for (CALayer *subLayer in subLayers) {
    
    int xRandom = (int)(arc4random_uniform((unsigned int)xRange.length + 1) + xRange.location);
    xRandom *= arc4random_uniform(2) == 0 ? -1 : 1;
    
    int yRandom = (int)(arc4random_uniform((unsigned int)yRange.length + 1) + yRange.location);
    yRandom *= arc4random_uniform(2) == 0 ? -1 : 1;
    
    int zRandom = (int)(arc4random_uniform((unsigned int)zRange.length + 1) + zRange.location);
    zRandom *= arc4random_uniform(2) == 0 ? -1 : 1;
    
    int zRotateRandom = (int)(arc4random_uniform((unsigned int)zRotateRange.length + 1) + zRotateRange.location);
    
    CGFloat scaleRandom = arc4random_uniform((maxScale - minScale) * 10 + 1) / 10 + minScale;
    
    // Transform animation
    CABasicAnimation *translateAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
//    translateAnim.duration = duration;
    translateAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    CATransform3D targetTransform = CATransform3DMakeTranslation(xRandom, yRandom, zRandom);
//    targetTransform = CATransform3DScale(targetTransform, scaleRandom, scaleRandom, 1);
    targetTransform = CATransform3DRotate(targetTransform, zRotateRandom * M_PI / 180, 0, 0, 1);
    translateAnim.toValue = [NSValue valueWithCATransform3D: targetTransform];
    translateAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    subLayer.transform = targetTransform;
    
    // Opacity animation
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
//    opacityAnim.duration = duration;
    opacityAnim.fromValue = [NSNumber numberWithFloat:1];
    opacityAnim.toValue = [NSNumber numberWithFloat:.0];
    opacityAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    subLayer.opacity = 0;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    [group setDuration:duration];
    [group setAnimations:@[translateAnim, opacityAnim]];
    
    [subLayer addAnimation:group forKey:nil];
  }
}

-(void)viewDidAppear:(BOOL)animated {
  [self animate];
}

- (UIImage *)cropImage:(UIImage *)img toRect:(CGRect)rect {
  CGRect scaledRect = CGRectMake(rect.origin.x * img.scale, rect.origin.y * img.scale, rect.size.width * img.scale, rect.size.height * img.scale);
  CGImageRef imageRef = CGImageCreateWithImageInRect([img CGImage], scaledRect);
  UIImage *cropped = [UIImage imageWithCGImage:imageRef];
  CGImageRelease(imageRef);
  return cropped;
}


@end
