
import UIKit

class RevealTransitioner : NSObject, UIViewControllerTransitioningDelegate {
  
  let transitionDuration: TimeInterval = 0.5
  
  func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    return RevealPresentationController(presentedViewController: presented, presenting: presenting)
  }
  
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return self
  }
  
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return self
  }
}

extension RevealTransitioner : UIViewControllerAnimatedTransitioning {
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
      return transitionDuration
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
    let vc1 = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
    let vc2 = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
    let con = transitionContext.containerView
    
    let r1start = transitionContext.initialFrame(for: vc1!)
    print("r1start = \(r1start)")
    let r2end = transitionContext.finalFrame(for: vc2!)
    print("r2end = \(r2end)")
    let v1 = transitionContext.view(forKey: UITransitionContextViewKey.from)
    let v2 = transitionContext.view(forKey: UITransitionContextViewKey.to)
    
    // presenting
    if let v2 = v2 {
      con.addSubview(v2)
      v2.frame  = CGRect(x: 0, y: con.frame.size.height, width: con.frame.size.width, height: r2end.size.height)
      v2.alpha = 0
      
      UIView.animate(withDuration: transitionDuration, animations: {
        v2.alpha = 1
        v2.frame = r2end
        }, completion: { _ in
          transitionContext.completeTransition(true)
      })
    }
    // dismissing
    else if let v1 = v1 {
      UIView.animate(withDuration: transitionDuration, animations: {
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
    self.presentingViewController.dismiss(animated: true, completion: nil)
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
    con.insertSubview(shadow, at: 0)
    shadow.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    let tc = vc.transitionCoordinator!
    tc.animate(alongsideTransition: { _ in
      shadow.alpha = 1
      }, completion: { _ in
        v?.tintAdjustmentMode = .dimmed
    })
  }
  
  override func dismissalTransitionWillBegin() {
    let vc = self.presentingViewController
    let v = vc.view
    let con = self.containerView!
    let shadow = con.subviews[0]
    let tc = vc.transitionCoordinator!
    tc.animate(alongsideTransition: { _ in
      shadow.alpha = 0
      }, completion: { _ in
        v?.tintAdjustmentMode = .automatic
    })
  }
  
  override var frameOfPresentedViewInContainerView : CGRect {
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


