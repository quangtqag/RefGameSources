//
//  ImageFiltration.h
//  BlendModes
//
//  Created by Quang Tran on 4/8/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoRecord.h"

@interface ImageFiltration : NSOperation

-(id)initWithPhotoRecord:(PhotoRecord*) photoRecord;
@property(nonatomic, strong) PhotoRecord *photoRecord;

@end
