//
//  ViewController.swift
//  RestAPI
//
//  Created by Quang Tran on 11/4/16.
//  Copyright © 2016 Quang Tran. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  private func buildQueryString() {
    let parameters = [
      "q": "ios",
      "count": 10
    ]
    
    let components = NSURLComponents()
    var queryItems = [NSURLQueryItem]()
    for (key, value) in parameters {
      queryItems.append(NSURLQueryItem(name: key, value: String(value)))
    }
    components.queryItems = queryItems
    print(components.query)
  }

  private func GETMethod() {
    let url : String = "http://beta.getbucketslive.abcv.com/"
    let request = NSMutableURLRequest()
    request.URL = NSURL(string: url)
    request.HTTPMethod = "GET"
    request.setValue("Bearer F3_uLhiIDRI7oGevp_meR2YMXtozePEhU8RLmxg-DzBJJtGDdFVaW5EGF08q2xxNToR-du3Tue-71RKpeMOKcPgnqTSo1fh0MDQ4Bq-1YMNvnKnwtngQ2dDmBURINentq5CnZL9NvM7gCSlWGj1NpamaCFi2QKxBAoOGoH5_T-tG8_UrR2kyMKLfXuvG38t5Sl6FQ7tIu1jwlZzbkU1T_V3dN_zt5Yq9sp4K5yiISshafcQNKd0yeAC0SuFt11CKmNFW0WutKswkd2lIBJdlCA6UlipwTy6_Pu0HMdQ8aIz7ZVR5x5w3zFjIbaR6Xd4gRCR0iGGQZodcxaFrLk2ELBhysgaWALr7VZVvza7DbBo09Xxt5SGuDQpWwOBKN3_M3P0F5rS7tsDpkqPoCwMq6nuoYSXLhh1u9pXKY3mlMrcIWutBZU5ByF80N434nY7kXP4nVvFjfttcofzx_vjIuJ_dzubDJq-dG6fR7VF16pjOfa9eXP2flEzgcHF5C8PhzGddBY5URbF1QmDDzDBa8GvF3v9rU6XHZpANhDmOmwLBJVWyZogUmdJCC2F1rUr_Hox2KjrpkYWH_JbO7SlbnsTg2y6PJpPY3ChNlRxs-Lu6RPTsUKufc75n-hRyUfax42NVQgAk_ZGRzmRpwcwk2w", forHTTPHeaderField: "Authorization")
    
    NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
      if error == nil {
        let jsonResult: NSDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
        print(jsonResult)
      }
      else {
        print(error)
      }
      }.resume()
  }
  
  private func POSTJSON() {
    let url : String = "http://beta.getbucketslive.abcv.com/"
    let request = NSMutableURLRequest()
    request.URL = NSURL(string: url)
    request.HTTPMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer F3_uLhiIDRI7oGevp_meR2YMXtozePEhU8RLmxg-DzBJJtGDdFVaW5EGF08q2xxNToR-du3Tue-71RKpeMOKcPgnqTSo1fh0MDQ4Bq-1YMNvnKnwtngQ2dDmBURINentq5CnZL9NvM7gCSlWGj1NpamaCFi2QKxBAoOGoH5_T-tG8_UrR2kyMKLfXuvG38t5Sl6FQ7tIu1jwlZzbkU1T_V3dN_zt5Yq9sp4K5yiISshafcQNKd0yeAC0SuFt11CKmNFW0WutKswkd2lIBJdlCA6UlipwTy6_Pu0HMdQ8aIz7ZVR5x5w3zFjIbaR6Xd4gRCR0iGGQZodcxaFrLk2ELBhysgaWALr7VZVvza7DbBo09Xxt5SGuDQpWwOBKN3_M3P0F5rS7tsDpkqPoCwMq6nuoYSXLhh1u9pXKY3mlMrcIWutBZU5ByF80N434nY7kXP4nVvFjfttcofzx_vjIuJ_dzubDJq-dG6fR7VF16pjOfa9eXP2flEzgcHF5C8PhzGddBY5URbF1QmDDzDBa8GvF3v9rU6XHZpANhDmOmwLBJVWyZogUmdJCC2F1rUr_Hox2KjrpkYWH_JbO7SlbnsTg2y6PJpPY3ChNlRxs-Lu6RPTsUKufc75n-hRyUfax42NVQgAk_ZGRzmRpwcwk2w", forHTTPHeaderField: "Authorization")
    
    let json = ["UserID": "08d29cd0-ba09-4826-b056-676f4f2bfb12"]
    let jsonData = try! NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
    request.HTTPBody = jsonData
    
    NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
      if error == nil {
        let jsonResult: NSDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
        print(jsonResult)
      }
      else {
        print(error)
      }
      }.resume()
  }
  
  private func POSTCustomContentType() {
    let url : String = "http://beta.getbucketslive.abcv.com/api/Login"
    let request = NSMutableURLRequest()
    request.URL = NSURL(string: url)
    request.HTTPMethod = "POST"
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    let bodyData = "username=tester1@gmail.com&password=aaaaaa&grant_type=password&client_id=MobileApp"
    request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding)
    
    NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
      if error == nil {
        let jsonResult: NSDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
        print(jsonResult)
      }
      else {
        print(error)
      }
      }.resume()
  }
}

// Upload file
extension ViewController {
  
  private func uploadFile() {
    let request = createRequest(userid: "", password: "", email: "")
    
    let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
      if error != nil {
        // handle error here
        print(error)
        return
      }
      
      // if response was JSON, then parse it
      
      let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
      print("responseString = \(responseString)")
    }
    task.resume()

  }
  
  func createRequest (userid userid: String, password: String, email: String) -> NSURLRequest {
    let param = [
      "user_id"  : userid,
      "email"    : email,
      "password" : password]  // build your dictionary however appropriate
    
    let boundary = generateBoundaryString()
    
    let url = NSURL(string: "http://localhost:8000")!
    let request = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "POST"
    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    
    let path1 = NSBundle.mainBundle().pathForResource("image1", ofType: "png") as String!
    request.HTTPBody = createBodyWithParameters(param, filePathKey: "file", paths: [path1], boundary: boundary)
    
    return request
  }
  
  /// Create body of the multipart/form-data request
  ///
  /// - parameter parameters:   The optional dictionary containing keys and values to be passed to web service
  /// - parameter filePathKey:  The optional field name to be used when uploading files. If you supply paths, you must supply filePathKey, too.
  /// - parameter paths:        The optional array of file paths of the files to be uploaded
  /// - parameter boundary:     The multipart/form-data boundary
  ///
  /// - returns:                The NSData of the body of the request
  
  func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, paths: [String]?, boundary: String) -> NSData {
    let body = NSMutableData()
    
    if parameters != nil {
      for (key, value) in parameters! {
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
        body.appendString("\(value)\r\n")
      }
    }
    
    if paths != nil {
      for path in paths! {
        let url = NSURL(fileURLWithPath: path)
        let filename = url.lastPathComponent
        let data = NSData(contentsOfURL: url)!
        let mimetype = mimeTypeForPath(path)
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename!)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.appendData(data)
        body.appendString("\r\n")
      }
    }
    
    body.appendString("--\(boundary)--\r\n")
    return body
  }
  
  /// Create boundary string for multipart/form-data request
  ///
  /// - returns:            The boundary string that consists of "Boundary-" followed by a UUID string.
  
  func generateBoundaryString() -> String {
    return "Boundary-\(NSUUID().UUIDString)"
  }
  
  /// Determine mime type on the basis of extension of a file.
  ///
  /// This requires MobileCoreServices framework.
  ///
  /// - parameter path:         The path of the file for which we are going to determine the mime type.
  ///
  /// - returns:                Returns the mime type if successful. Returns application/octet-stream if unable to determine mime type.
  
  func mimeTypeForPath(path: String) -> String {
    let url = NSURL(fileURLWithPath: path)
    let pathExtension = url.pathExtension
    
    if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension! as NSString, nil)?.takeRetainedValue() {
      if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
        return mimetype as String
      }
    }
    return "application/octet-stream";
  }

}

extension NSMutableData {
  func appendString(string: String) {
    let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
    appendData(data!)
  }
}
