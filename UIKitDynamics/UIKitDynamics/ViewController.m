//
//  ViewController.m
//  UIKitDynamics
//
//  Created by Quang Tran on 5/22/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UICollisionBehaviorDelegate>

@end

@implementation ViewController {
  UIDynamicAnimator* _animator;
  UIGravityBehavior* _gravity;
  UICollisionBehavior* _collision;
  BOOL _firstContact;

}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UIView* square = [[UIView alloc] initWithFrame: CGRectMake(100, 100, 100, 100)];
  square.backgroundColor = [UIColor grayColor];
  [self.view addSubview:square];
  
  UIView* barrier = [[UIView alloc] initWithFrame:CGRectMake(0, 300, 130, 20)];
  barrier.backgroundColor = [UIColor redColor];
  [self.view addSubview:barrier];
  
  _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
  _gravity = [[UIGravityBehavior alloc] initWithItems:@[square]];
  [_animator addBehavior:_gravity];
  
  _collision = [[UICollisionBehavior alloc] initWithItems:@[square]];
  _collision.collisionDelegate = self;

//  _collision.action =  ^{
//    NSLog(@"%@, %@",
//          NSStringFromCGAffineTransform(square.transform),
//          NSStringFromCGPoint(square.center));
//  };
  
  // add a boundary that coincides with the top edge
  CGPoint rightEdge = CGPointMake(barrier.frame.origin.x + barrier.frame.size.width, barrier.frame.origin.y);
  [_collision addBoundaryWithIdentifier:@"barrier"
                              fromPoint:barrier.frame.origin
                                toPoint:rightEdge];
  
  _collision.translatesReferenceBoundsIntoBoundary = YES;
  [_animator addBehavior:_collision];

  UIDynamicItemBehavior* itemBehaviour = [[UIDynamicItemBehavior alloc] initWithItems:@[square]];
  itemBehaviour.elasticity = 0.6;
  [_animator addBehavior:itemBehaviour];
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior
      beganContactForItem:(id<UIDynamicItem>)item
   withBoundaryIdentifier:(id<NSCopying>)identifier
                  atPoint:(CGPoint)p {
//  NSLog(@"Boundary contact occurred - %@", identifier);
  
  UIView* view = (UIView*)item;
  view.backgroundColor = [UIColor yellowColor];
  [UIView animateWithDuration:0.3 animations:^{
    view.backgroundColor = [UIColor grayColor];
  }];
  
  if (!_firstContact)
  {
    _firstContact = YES;
    
    UIView* square = [[UIView alloc] initWithFrame:CGRectMake(30, 0, 100, 100)];
    square.backgroundColor = [UIColor grayColor];
    [self.view addSubview:square];
    
    [_collision addItem:square];
    [_gravity addItem:square];
    
    UIAttachmentBehavior* attach = [[UIAttachmentBehavior alloc] initWithItem:view attachedToItem:square];
    [_animator addBehavior:attach];
  }
}

@end
