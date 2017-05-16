//
//  ViewController.m
//  demo
//
//  Created by Quang Tran on 5/9/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#define SUBLAYER_WIDTH  50
#define SUBLAYER_HEIGHT 50
#define INTERSPACE      8
#define XINSTANCES      7
#define YINSTANCES      5

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  CGPoint centralPoint = CGPointMake(self.view.bounds.size.width/2., self.view.bounds.size.height/2.);
  
  CGPoint firstLayerPosition = CGPointMake(centralPoint.x-(SUBLAYER_WIDTH+INTERSPACE)*(XINSTANCES-1)/2.0,
                                           centralPoint.y-(SUBLAYER_HEIGHT+INTERSPACE)*(YINSTANCES-1)/2.0);
  
  CAReplicatorLayer *xLayer = [CAReplicatorLayer layer];
  xLayer.instanceCount = XINSTANCES;
  xLayer.instanceDelay = .1;
  xLayer.instanceGreenOffset = -.1;
  xLayer.instanceRedOffset = -.15;
  xLayer.instanceBlueOffset = -.07;
  xLayer.preservesDepth = YES;
  xLayer.instanceTransform = CATransform3DMakeTranslation(SUBLAYER_WIDTH+INTERSPACE, 0, 0);
  [xLayer addAnimation:[self pushAnimation] forKey:@"pushAnimation"];
  
  CAReplicatorLayer *yLayer = [CAReplicatorLayer layer];
  yLayer.instanceCount = YINSTANCES;
  yLayer.instanceDelay = .2;
  yLayer.instanceGreenOffset = -.01;
  yLayer.instanceRedOffset = -.1;
  yLayer.instanceBlueOffset = -.08;
  yLayer.preservesDepth = YES;
  yLayer.instanceTransform = CATransform3DMakeTranslation(0, SUBLAYER_HEIGHT+INTERSPACE, 0);
  
  CAReplicatorLayer *zLayer = [CAReplicatorLayer layer];
  zLayer.instanceCount = 3;
  zLayer.instanceDelay = .35;
  zLayer.preservesDepth = YES;
  zLayer.instanceGreenOffset = -.1;
  zLayer.instanceRedOffset = -.07;
  zLayer.instanceBlueOffset = -.1;
  zLayer.instanceTransform = CATransform3DMakeTranslation(0, 0, -100);
  zLayer.bounds = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
  zLayer.position = CGPointMake(self.view.bounds.size.width/2., self.view.bounds.size.height/2.);
  [zLayer addAnimation:[self rotationAnimation] forKey:@"rotationAnimation"];
  
  CALayer *rootLayer = [CALayer layer];
  rootLayer.bounds = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
  rootLayer.position = CGPointMake(self.view.bounds.size.width/2., self.view.bounds.size.height/2.);
  rootLayer.backgroundColor = [[UIColor darkGrayColor] CGColor];
  
  CATransform3D tI = CATransform3DIdentity;
  tI.m34 = 1.0 / -900.0;
  rootLayer.sublayerTransform = tI;
  
  CALayer *layer1 = [CALayer layer];
  layer1.position = firstLayerPosition;
  layer1.bounds = CGRectMake(0, 0, SUBLAYER_WIDTH, SUBLAYER_HEIGHT);
  layer1.backgroundColor = [[UIColor yellowColor] CGColor];
  layer1.cornerRadius = 10.;
  layer1.shadowColor = [[UIColor blackColor] CGColor];
  layer1.shadowRadius = 4.0f;
  layer1.shadowOffset = CGSizeMake(0.0f, 3.0f);
  layer1.shadowOpacity = .8;
  layer1.opacity = 0.8;
  layer1.borderColor = [[UIColor whiteColor] CGColor];
  layer1.borderWidth = 2.0;
  [layer1 addAnimation:[self waveAnimation] forKey:@"rotationAnimation"];
  
  [xLayer addSublayer:layer1];
  [yLayer addSublayer:xLayer];
  [zLayer addSublayer:yLayer];
  [rootLayer addSublayer:zLayer];
  [self.view.layer addSublayer:rootLayer];
  
}

- (CABasicAnimation *)pushAnimation {
  CABasicAnimation *pushAnim = [CABasicAnimation animationWithKeyPath:@"instanceTransform"];
  pushAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(SUBLAYER_WIDTH+INTERSPACE, 0, 0)];
  pushAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(SUBLAYER_WIDTH+INTERSPACE+60, 0, 0)];
  pushAnim.duration = 3.0;
  pushAnim.autoreverses = YES;
  pushAnim.repeatCount = HUGE_VAL; 
  pushAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  return pushAnim;
}

- (CABasicAnimation *)rotationAnimation {
  CABasicAnimation *rotAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
  CATransform3D t = CATransform3DIdentity;
  CATransform3D t2 = CATransform3DRotate(t, -0.8, 1, 0, 0);
  rotAnim.fromValue = [NSValue valueWithCATransform3D:t2];
  CATransform3D t3 = CATransform3DRotate(t, 0.9, 1, 0, 0);
  rotAnim.toValue = [NSValue valueWithCATransform3D:t3];
  rotAnim.duration = 5.0;
  rotAnim.autoreverses = YES;
  rotAnim.repeatCount = HUGE_VAL;
  rotAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  return rotAnim;
}

- (CABasicAnimation *)waveAnimation {
  CABasicAnimation *waveAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
  waveAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 100)];
  waveAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, -100)];
  waveAnim.duration  = 1.5f;
  waveAnim.autoreverses = YES;
  waveAnim.repeatCount = HUGE_VAL;
  waveAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  return waveAnim;
}

//-(void)viewDidAppear:(BOOL)animated {
//  CGFloat layerWidth = 100.0, layerHeight = 100.0;
//  
//  CALayer *layer1 = [CALayer layer];
//  layer1.position = CGPointMake(0, 0);
//  layer1.bounds = CGRectMake(0, 0, layerWidth, layerHeight);
//  layer1.backgroundColor = [[UIColor yellowColor] CGColor];
//  layer1.cornerRadius = 10.;
//  layer1.shadowColor = [[UIColor blackColor] CGColor];
//  layer1.shadowRadius = 4.0f;
//  layer1.shadowOffset = CGSizeMake(0.0f, 3.0f);
//  layer1.shadowOpacity = .8;
//  layer1.opacity = 0.8;
//  layer1.borderColor = [[UIColor whiteColor] CGColor];
//  layer1.borderWidth = 2.0;
//  
//  CAReplicatorLayer *xLayer = [CAReplicatorLayer layer];
//  xLayer.position = CGPointMake(0, 0);
//  xLayer.instanceCount = 3;
//  xLayer.instanceDelay = .2;
//  xLayer.instanceGreenOffset = -.03;
//  xLayer.instanceRedOffset = -.02;
//  xLayer.instanceBlueOffset = -.01;
//  xLayer.instanceAlphaOffset = -.05;
//  xLayer.preservesDepth = YES;
//  xLayer.instanceTransform = CATransform3DMakeTranslation(110, 0, 200);
//  [xLayer addSublayer:layer1];
//
//  [self.view.layer addSublayer:xLayer];
//  
//  NSLog(@"xLayout bounds = %@", [NSValue valueWithCGRect:xLayer.bounds]);
//}

@end
