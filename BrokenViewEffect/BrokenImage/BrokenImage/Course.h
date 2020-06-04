//
//  Course.h
//  ExpandingCollectionView2
//
//  Created by Quang Tran on 5/25/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Commenter.h"

@interface Course : NSObject

@property(nonatomic, strong) NSString *featuredImageName;
@property(nonatomic, assign) NSUInteger views;
@property(nonatomic, assign) NSUInteger likes;
@property(nonatomic, strong) NSArray<Commenter*> *commenters;

+(Course*)courseWithDict:(NSDictionary *)dict;
+(NSArray<Course*>*)coursesWithDictArray:(NSArray<NSDictionary*>*)arr;

@end
