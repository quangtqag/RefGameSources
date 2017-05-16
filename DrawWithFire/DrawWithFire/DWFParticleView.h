//
//  DWFParticleView.h
//  DrawWithFire
//
//  Created by Quang Tran on 5/13/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DWFParticleView : UIView
-(void)setEmitterPositionFromTouch: (UITouch*)t;
-(void)setIsEmitting:(BOOL)isEmitting;

@end
