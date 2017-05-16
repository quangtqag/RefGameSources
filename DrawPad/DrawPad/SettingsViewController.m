//
//  SettingsViewController.m
//  DrawPad
//
//  Created by Quang Tran on 5/16/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISlider *brushControl;
@property (weak, nonatomic) IBOutlet UISlider *opacityControl;
@property (weak, nonatomic) IBOutlet UIImageView *brushPreview;
@property (weak, nonatomic) IBOutlet UIImageView *opacityPreview;
@property (weak, nonatomic) IBOutlet UILabel *brushValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *opacityValueLabel;
@property (weak, nonatomic) IBOutlet UISlider *redControl;
@property (weak, nonatomic) IBOutlet UISlider *greenControl;
@property (weak, nonatomic) IBOutlet UISlider *blueControl;
@property (weak, nonatomic) IBOutlet UILabel *redLabel;
@property (weak, nonatomic) IBOutlet UILabel *greenLabel;
@property (weak, nonatomic) IBOutlet UILabel *blueLabel;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
}

- (IBAction)closeSettings:(id)sender {
  [self.delegate closeSettings:self];
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
  
  // ensure the values displayed are the current values
  
  int redIntValue = self.red * 255.0;
  self.redControl.value = redIntValue;
  [self sliderChanged:self.redControl];
  
  int greenIntValue = self.green * 255.0;
  self.greenControl.value = greenIntValue;
  [self sliderChanged:self.greenControl];
  
  int blueIntValue = self.blue * 255.0;
  self.blueControl.value = blueIntValue;
  [self sliderChanged:self.blueControl];
  
  self.brushControl.value = self.brush;
  [self sliderChanged:self.brushControl];
  
  self.opacityControl.value = self.opacity;
  [self sliderChanged:self.opacityControl];
  
}

- (IBAction)sliderChanged:(UISlider *)sender {
  UISlider * changedSlider = (UISlider*)sender;
  
  if(changedSlider == self.brushControl) {
    
    self.brush = self.brushControl.value;
    self.brushValueLabel.text = [NSString stringWithFormat:@"%.1f", self.brush];
    
  } else if(changedSlider == self.opacityControl) {
    
    self.opacity = self.opacityControl.value;
    self.opacityValueLabel.text = [NSString stringWithFormat:@"%.1f", self.opacity];
    
  } else if(changedSlider == self.redControl) {
    
    self.red = self.redControl.value/255.0;
    self.redLabel.text = [NSString stringWithFormat:@"Red: %d", (int)self.redControl.value];
    
  } else if(changedSlider == self.greenControl){
    
    self.green = self.greenControl.value/255.0;
    self.greenLabel.text = [NSString stringWithFormat:@"Green: %d", (int)self.greenControl.value];
  } else if (changedSlider == self.blueControl){
    
    self.blue = self.blueControl.value/255.0;
    self.blueLabel.text = [NSString stringWithFormat:@"Blue: %d", (int)self.blueControl.value];
    
  }
  
  UIGraphicsBeginImageContext(self.brushPreview.frame.size);
  CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
  CGContextSetLineWidth(UIGraphicsGetCurrentContext(),self.brush);
  CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), self.red, self.green, self.blue, 1.0);
  CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 45, 45);
  CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 45, 45);
  CGContextStrokePath(UIGraphicsGetCurrentContext());
  self.brushPreview.image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  UIGraphicsBeginImageContext(self.opacityPreview.frame.size);
  CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
  CGContextSetLineWidth(UIGraphicsGetCurrentContext(),self.brush);
  CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), self.red, self.green, self.blue, self.opacity);
  CGContextMoveToPoint(UIGraphicsGetCurrentContext(),45, 45);
  CGContextAddLineToPoint(UIGraphicsGetCurrentContext(),45, 45);
  CGContextStrokePath(UIGraphicsGetCurrentContext());
  self.opacityPreview.image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
}

@end
