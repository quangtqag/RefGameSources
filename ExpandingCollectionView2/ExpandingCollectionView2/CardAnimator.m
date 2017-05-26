//
//  CardAnimator.m
//  ExpandingCollectionView2
//
//  Created by Quang Tran on 5/25/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import "CardAnimator.h"

@implementation CardAnimator

const NSTimeInterval duration = 5;

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
  return duration;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
  
  UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  
  CGRect initialFrame = self.originFrame;
  CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
  finalFrame = CGRectInset(finalFrame, 20, 0);
  toVC.view.frame = finalFrame;
  
  UIGraphicsBeginImageContext(toVC.view.bounds.size);
  [toVC.view.layer renderInContext:UIGraphicsGetCurrentContext()];
  UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
  imgView.contentMode = UIViewContentModeTop;
  imgView.frame = initialFrame;
  imgView.layer.cornerRadius = 5;
  imgView.layer.masksToBounds = YES;
  
  UIView *containerView = transitionContext.containerView;
  [containerView addSubview:[fromVC.view snapshotViewAfterScreenUpdates:YES]];
  [containerView addSubview:toVC.view];
  toVC.view.hidden = YES;
  [containerView addSubview:imgView];
  
  [UIView animateWithDuration:duration
                   animations:^{
                     imgView.frame = finalFrame;
                   }
                   completion:^(BOOL finished) {
                     toVC.view.hidden = NO;
                     [imgView removeFromSuperview];
                     [transitionContext completeTransition:YES];
                   }];
  
}

@end
