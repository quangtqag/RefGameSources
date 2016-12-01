
import UIKit

class RevealTransitioner : NSObject, UIViewControllerTransitioningDelegate {
  
  let transitionDuration: NSTimeInterval = 0.5
  
  func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController?, sourceViewController source: UIViewController) -> UIPresentationController? {
    return RevealPresentationController(presentedViewController: presented, presentingViewController: presenting)
  }
  
  func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return self
  }
  
  func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return self
  }
}

extension RevealTransitioner : UIViewControllerAnimatedTransitioning {
  
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
      return transitionDuration
  }
  
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    
    let vc1 = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
    let vc2 = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
    let con = transitionContext.containerView()
    
    let r1start = transitionContext.initialFrameForViewController(vc1!)
    print("r1start = \(r1start)")
    let r2end = transitionContext.finalFrameForViewController(vc2!)
    print("r2end = \(r2end)")
    let v1 = transitionContext.viewForKey(UITransitionContextFromViewKey)
    let v2 = transitionContext.viewForKey(UITransitionContextToViewKey)
    
    // presenting
    if let v2 = v2 {
      con.addSubview(v2)
      v2.frame  = CGRect(x: 0, y: con.frame.size.height, width: con.frame.size.width, height: r2end.size.height)
      v2.alpha = 0
      
      UIView.animateWithDuration(transitionDuration, animations: {
        v2.alpha = 1
        v2.frame = r2end
        }, completion: { _ in
          transitionContext.completeTransition(true)
      })
    }
    // dismissing
    else if let v1 = v1 {
      UIView.animateWithDuration(transitionDuration, animations: {
        v1.alpha = 0
        v1.frame  = CGRect(x: 0, y: con.frame.size.height, width: con.frame.size.width, height: v1.frame.size.height)
        }, completion: { _ in
          transitionContext.completeTransition(true)
      })
    }
    
  }
}

class RevealPresentationController : UIPresentationController {
  
  let topSpace: CGFloat = 64
  
  func shadowViewDidTap() {
    self.presentingViewController.dismissViewControllerAnimated(true, completion: nil)
  }
  
  override func presentationTransitionWillBegin() {
    let vc = self.presentingViewController
    let v = vc.view
    let con = self.containerView!
    let shadow = UIView(frame:con.bounds)
    let tapGR = UITapGestureRecognizer(target: self, action: #selector(shadowViewDidTap))
    shadow.addGestureRecognizer(tapGR)
    shadow.backgroundColor = UIColor(white:0, alpha:0.4)
    shadow.alpha = 0
    con.insertSubview(shadow, atIndex: 0)
    shadow.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    let tc = vc.transitionCoordinator()!
    tc.animateAlongsideTransition({ _ in
      shadow.alpha = 1
      }, completion: { _ in
        v.tintAdjustmentMode = .Dimmed
    })
  }
  
  override func dismissalTransitionWillBegin() {
    let vc = self.presentingViewController
    let v = vc.view
    let con = self.containerView!
    let shadow = con.subviews[0]
    let tc = vc.transitionCoordinator()!
    tc.animateAlongsideTransition({ _ in
      shadow.alpha = 0
      }, completion: { _ in
        v.tintAdjustmentMode = .Automatic
    })
  }
  
  override func frameOfPresentedViewInContainerView() -> CGRect {
    let con = self.containerView!
    var newFrame = con.bounds
    newFrame.origin.y = topSpace
    newFrame.size.height -= topSpace
    return newFrame.integral
  }
  
  override func containerViewWillLayoutSubviews() {
    // deal with future rotation
    //    let v = self.presentedView()!
    //    v.autoresizingMask = [.FlexibleTopMargin, .FlexibleBottomMargin, .FlexibleLeftMargin, .FlexibleRightMargin]
    //    v.translatesAutoresizingMaskIntoConstraints = true
  }
  
}


