//
//  SliderCell.h
//  CoreImageFilters
//
//  Created by Quang Tran on 3/19/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SliderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *valueLb;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@property (nonatomic, assign) BOOL allowStrip;
@property (nonatomic, strong) void (^sliderValueDidChangeCallback)(float value);
@property(nonatomic, assign) BOOL affectImmediately;

-(void)setDisplayName:(NSString*)displayName
             minValue:(float)minValue
             maxValue:(float)maxValue
         defaultValue:(float)defaultValue;

@end
