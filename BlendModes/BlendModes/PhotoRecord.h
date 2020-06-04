//
//  PhotoRecord.h
//  BlendModes
//
//  Created by Quang Tran on 4/8/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PhotoRecord : NSObject
@property(nonatomic, strong) NSString *filterName;
@property(nonatomic, strong) UIImage* inImg;
@property(nonatomic, strong) UIImage* bgImg;
@property(nonatomic, strong) UIImage* outImg;
@end
