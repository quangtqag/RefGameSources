//
//  ViewController.swift
//  MyLoggerSwift
//
//  Created by Quang Tran on 8/4/16.
//  Copyright © 2016 ABC Virtual Communications. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }
  
  override func viewDidAppear(animated: Bool) {
//    print("Hello world 1")
    NSLog("Hello world 1")
    
    print(ViewController.systemLogs())
  }
  
  static func systemLogs() -> [[String: String]] {
    let q = asl_new(UInt32(ASL_TYPE_QUERY))
    var logs = [[String: String]]()
    let r = asl_search(nil, q)
    var m = asl_next(r)
    while m != nil {
      var logDict = [String: String]()
      var i: UInt32 = 0
      while true {
        if let key = String.fromCString(asl_key(m, i)) {
          let val = String.fromCString(asl_get(m, key))
          logDict[key] = val
          i++
        } else {
          break
        }
      }
      m = asl_next(r)
      logs.append(logDict)
    }
    asl_release(r)
    return logs
    
    
//    aslmsg q, m;
//    int i;
//    const char *key, *val;
//    
//    q = asl_new(ASL_TYPE_QUERY);
//    
//    aslresponse r = asl_search(NULL, q);
//    while (NULL != (m = aslresponse_next(r)))
//    {
//      NSMutableDictionary *tmpDict = [NSMutableDictionary dictionary];
//      
//      for (i = 0; (NULL != (key = asl_key(m, i))); i++)
//      {
//        NSString *keyString = [NSString stringWithUTF8String:(char *)key];
//        
//        val = asl_get(m, key);
//        
//        NSString *string = val?[NSString stringWithUTF8String:val]:@"";
//        [tmpDict setObject:string forKey:keyString];
//      }
//      
//      NSLog(@"%@", tmpDict);
//    }
//    aslresponse_free(r);
  }

  

}

