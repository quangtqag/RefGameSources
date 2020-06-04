//
//  UIImage+Ext.m
//  BrokenImage
//
//  Created by Quang Tran on 5/31/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import "UIImage+Ext.h"

@implementation UIImage (Ext)

- (UIImage *)cropToRect:(CGRect)rect {
  CGRect scaledRect = CGRectMake(rect.origin.x * self.scale, rect.origin.y * self.scale, rect.size.width * self.scale, rect.size.height * self.scale);
  CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], scaledRect);
  UIImage *cropped = [UIImage imageWithCGImage:imageRef];
  CGImageRelease(imageRef);
  return cropped;
}


@end
