//
//  ImageFiltration.m
//  BlendModes
//
//  Created by Quang Tran on 4/8/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import "ImageFiltration.h"

@interface ImageFiltration()

@end

@implementation ImageFiltration

-(id)initWithPhotoRecord:(PhotoRecord*) photoRecord {
  self = [super init];
  self.photoRecord = photoRecord;
  return self;
}

-(void)main {
  if (self.cancelled == YES) {
    return;
  }
  
  self.photoRecord.outImg = [self filterImage:self.photoRecord.inImg
                                        bgImg:self.photoRecord.bgImg
                                   filterName:self.photoRecord.filterName];
}

-(UIImage *)filterImage:(UIImage *)inputImg bgImg:(UIImage *)bgImg filterName:(NSString *)filterName {
  CIFilter *filter = [CIFilter filterWithName:filterName];
  
  CIImage *ciInputImg = [CIImage imageWithCGImage:inputImg.CGImage];
  [filter setValue:ciInputImg forKey:kCIInputImageKey];
  
  CIImage *ciBgImg = [CIImage imageWithCGImage:bgImg.CGImage];
  [filter setValue:ciBgImg forKey:kCIInputBackgroundImageKey];
  
  CIImage *outputImage = filter.outputImage;
  CIContext *context = [CIContext contextWithOptions:nil];
  CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
  UIImage *newImage = [UIImage imageWithCGImage:cgimg scale:1.0 orientation:inputImg.imageOrientation];
  CGImageRelease(cgimg);
  
  return newImage;
}


@end
