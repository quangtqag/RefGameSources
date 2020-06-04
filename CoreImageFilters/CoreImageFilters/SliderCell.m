//
//  SliderCell.m
//  CoreImageFilters
//
//  Created by Quang Tran on 3/19/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import "SliderCell.h"

@implementation SliderCell

- (void)awakeFromNib {
  [super awakeFromNib];
  // Initialization code
//  self.slider.continuous = self.affectImmediately;
}

-(void)setAffectImmediately:(BOOL)affectImmediately {
  _affectImmediately = affectImmediately;
  self.slider.continuous = affectImmediately;
}

-(void)setDisplayName:(NSString*)displayName
             minValue:(float)minValue
             maxValue:(float)maxValue
             defaultValue:(float)defaultValue {
  self.titleLb.text = [NSString stringWithFormat:@"%@ (%.2f ~ %.2f)", displayName, minValue, maxValue];
  self.valueLb.text = [NSString stringWithFormat:@"%.2f", defaultValue];
  self.slider.minimumValue = minValue;
  self.slider.maximumValue = maxValue;
  self.slider.value = defaultValue;
}

- (IBAction)sliderValueDidChange:(UISlider *)sender {
  CGFloat newValue;
  if (self.allowStrip == YES) {
    newValue = roundf(sender.value);
  }
  else {
    newValue = sender.value;
  }
  
  self.valueLb.text = [NSString stringWithFormat:@"%.2f", newValue];
  self.sliderValueDidChangeCallback(newValue);
}

@end
