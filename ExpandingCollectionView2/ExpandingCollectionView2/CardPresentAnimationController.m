//
//  CardAnimator.m
//  ExpandingCollectionView2
//
//  Created by Quang Tran on 5/25/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import "CardPresentAnimationController.h"

@implementation CardPresentAnimationController

static const NSTimeInterval duration = 0.5;

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
  return duration;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
  
  UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  
  CGRect initialFrame = self.originFrame;
  CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
  finalFrame = CGRectInset(finalFrame, 20, 0);
  toVC.view.frame = initialFrame;
  toVC.view.layer.masksToBounds = YES;
  toVC.view.layer.borderColor = [[UIColor darkGrayColor] CGColor];
  toVC.view.layer.borderWidth = 0.5;
  
  [fromVC.view setUserInteractionEnabled:NO];
  [toVC.view layoutIfNeeded];
  
  UIView *containerView = transitionContext.containerView;
  [containerView addSubview:fromVC.view];
//  [containerView addSubview:[fromVC.view snapshotViewAfterScreenUpdates:YES]];
  [containerView addSubview:toVC.view];
  
  
  [UIView animateWithDuration:duration
                   animations:^{
                     toVC.view.frame = finalFrame;
                     [toVC.view layoutIfNeeded];
                   }
                   completion:^(BOOL finished) {
                     [transitionContext completeTransition:YES];
                     
                     [containerView addSubview:fromVC.view];
                     [containerView sendSubviewToBack:fromVC.view];
                   }];
}

@end
