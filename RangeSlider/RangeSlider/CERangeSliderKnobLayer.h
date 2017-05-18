//
//  CERangeSliderKnobLayer.h
//  CERangeSlider
//
//  Created by Quang Tran on 5/13/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@class CERangeSlider;

@interface CERangeSliderKnobLayer : CALayer

@property BOOL highlighted;
@property (weak) CERangeSlider* slider;

@end
