//
//  ViewController.m
//  DrawPad
//
//  Created by Quang Tran on 5/16/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
  CGPoint lastPoint;
  CGFloat red;
  CGFloat green;
  CGFloat blue;
  CGFloat brush;
  CGFloat opacity;
  BOOL mouseSwiped;
}

@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UIImageView *tempDrawImage;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  red = 0.0/255.0;
  green = 0.0/255.0;
  blue = 0.0/255.0;
  brush = 10.0;
  opacity = 1.0;
  
}

- (IBAction)pencilPressed:(UIButton *)sender {
  UIButton * PressedButton = (UIButton*)sender;
  
  switch(PressedButton.tag)
  {
    case 0:
      red = 0.0/255.0;
      green = 0.0/255.0;
      blue = 0.0/255.0;
      break;
    case 1:
      red = 105.0/255.0;
      green = 105.0/255.0;
      blue = 105.0/255.0;
      break;
    case 2:
      red = 255.0/255.0;
      green = 0.0/255.0;
      blue = 0.0/255.0;
      break;
    case 3:
      red = 0.0/255.0;
      green = 0.0/255.0;
      blue = 255.0/255.0;
      break;
    case 4:
      red = 102.0/255.0;
      green = 204.0/255.0;
      blue = 0.0/255.0;
      break;
    case 5:
      red = 102.0/255.0;
      green = 255.0/255.0;
      blue = 0.0/255.0;
      break;
    case 6:
      red = 51.0/255.0;
      green = 204.0/255.0;
      blue = 255.0/255.0;
      break;
    case 7:
      red = 160.0/255.0;
      green = 82.0/255.0;
      blue = 45.0/255.0;
      break;
    case 8:
      red = 255.0/255.0;
      green = 102.0/255.0;
      blue = 0.0/255.0;
      break;
    case 9:
      red = 255.0/255.0;
      green = 255.0/255.0;
      blue = 0.0/255.0;
      break;
  }
}

- (IBAction)eraserPressed:(UIButton *)sender {
  red = 255.0/255.0;
  green = 255.0/255.0;
  blue = 255.0/255.0;
  opacity = 1.0;
}

- (IBAction)reset:(UIButton *)sender {
  self.mainImage.image = nil;
}

- (IBAction)settings:(UIButton *)sender {

}

- (IBAction)save:(UIButton *)sender {
  UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@""
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles:@"Save to Camera Roll", @"Tweet it!", @"Cancel", nil];
  [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
  if (buttonIndex == 1)
  {
    //Tweet Image
  }
  if (buttonIndex == 0)
  {
    UIGraphicsBeginImageContextWithOptions(_mainImage.bounds.size, NO,0.0);
    [_mainImage.image drawInRect:CGRectMake(0, 0, _mainImage.frame.size.width, _mainImage.frame.size.height)];
    UIImage *SaveImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(SaveImage, self,@selector(image:didFinishSavingWithError:contextInfo:), nil);
  }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
  // Was there an error?
  if (error != NULL)
  {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Image could not be saved.Please try again"  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close", nil];
    [alert show];
  } else {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Image was successfully saved in photoalbum"  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close", nil];
    [alert show];
  }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  
  mouseSwiped = NO;
  UITouch *touch = [touches anyObject];
  lastPoint = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  
  mouseSwiped = YES;
  UITouch *touch = [touches anyObject];
  CGPoint currentPoint = [touch locationInView:self.view];
  
  UIGraphicsBeginImageContext(self.view.frame.size);
  [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
  CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
  CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
  CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
  CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush );
  CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
  CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
  
  CGContextStrokePath(UIGraphicsGetCurrentContext());
  self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
  [self.tempDrawImage setAlpha:opacity];
  UIGraphicsEndImageContext();
  
  lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  
  if(!mouseSwiped) {
    UIGraphicsBeginImageContext(self.view.frame.size);
    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, opacity);
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    CGContextFlush(UIGraphicsGetCurrentContext());
    self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
  }
  
  UIGraphicsBeginImageContext(self.mainImage.frame.size);
  [self.mainImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
  [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:opacity];
  self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext();
  self.tempDrawImage.image = nil;
  UIGraphicsEndImageContext();
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
  SettingsViewController * settingsVC = (SettingsViewController *)segue.destinationViewController;
  settingsVC.delegate = self;
  settingsVC.brush = brush;
  settingsVC.opacity = opacity;
  settingsVC.red = red;
  settingsVC.green = green;
  settingsVC.blue = blue;
  
}

#pragma mark - SettingsViewControllerDelegate methods

- (void)closeSettings:(id)sender {
  
  brush = ((SettingsViewController*)sender).brush;
  opacity = ((SettingsViewController*)sender).opacity;
  red = ((SettingsViewController*)sender).red;
  green = ((SettingsViewController*)sender).green;
  blue = ((SettingsViewController*)sender).blue;
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
