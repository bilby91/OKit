//
//  Manager.swift
//  OKit
//
//  Created by Martín Fernández on 12/31/14.
//  Copyright (c) 2014 bilby91. All rights reserved.
//

import Foundation

import Alamofire
import ObjectMapper

public class Manager {

  public let baseURL: NSURL
  private let httpManager: ObjectManager

  public init(aBaseURL: NSURL) {
    baseURL = aBaseURL;
    httpManager = ObjectManager(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())

  }

  public func get<T: ObjectMapper.MapperProtocol>(path: String, completionHandler: (NSURLRequest, NSHTTPURLResponse?, T?, NSError?) -> Void) -> ObjectRequest {
    let URL = baseURL.absoluteString! + path

    return httpManager.request(.GET, URL)
    .responseObject(completionHandler)
  }

  public func post<T: ObjectMapper.MapperProtocol>(path: String, completionHandler: (NSURLRequest, NSHTTPURLResponse?, T?, NSError?) -> Void) -> ObjectRequest {
    let URL = baseURL.absoluteString! + path

    return httpManager.request(.POST, URL)
      .responseObject(completionHandler)
  }

  public func put<T: ObjectMapper.MapperProtocol>(path: String, completionHandler: (NSURLRequest, NSHTTPURLResponse?, T?, NSError?) -> Void) -> ObjectRequest {
    let URL = baseURL.absoluteString! + path

    return httpManager.request(.PUT, URL)
      .responseObject(completionHandler)
  }

  public func patch<T: ObjectMapper.MapperProtocol>(path: String, completionHandler: (NSURLRequest, NSHTTPURLResponse?, T?, NSError?) -> Void) -> ObjectRequest {
    let URL = baseURL.absoluteString! + path

    return httpManager.request(.PATCH, URL)
      .responseObject(completionHandler)
  }

}

public class ObjectManager: Alamofire.Manager {

  public override func requestForSession(session: NSURLSession, dataTask: NSURLSessionDataTask?) -> ObjectRequest {
    return ObjectRequest(session: session, task: dataTask!)
  }

  override public func request(method: Alamofire.Method, _ URLString: URLStringConvertible, parameters: [String: AnyObject]? = nil, encoding: ParameterEncoding = .URL) -> ObjectRequest {
    return super.request(method, URLString, parameters: parameters, encoding: encoding) as ObjectRequest
  }

}
