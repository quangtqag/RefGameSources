//
//  ViewController.m
//  MyLogger
//
//  Created by Quang Tran on 8/4/16.
//  Copyright © 2016 ABC Virtual Communications. All rights reserved.
//

#import "ViewController.h"
#import "asl.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  
}

-(void)viewDidAppear:(BOOL)animated {
  NSLog(@"Hello world 1");
  NSLog(@"Hello world 2");
  
  aslmsg q, m;
  int i;
  const char *key, *val;
  
  q = asl_new(ASL_TYPE_QUERY);
  
  aslresponse r = asl_search(NULL, q);
  while (NULL != (m = aslresponse_next(r)))
  {
    NSMutableDictionary *tmpDict = [NSMutableDictionary dictionary];
    
    for (i = 0; (NULL != (key = asl_key(m, i))); i++)
    {
      NSString *keyString = [NSString stringWithUTF8String:(char *)key];
      
      val = asl_get(m, key);
      
      NSString *string = val?[NSString stringWithUTF8String:val]:@"";
      [tmpDict setObject:string forKey:keyString];
    }
    
    NSLog(@"%@", tmpDict);
  }
  aslresponse_free(r);
}



@end
