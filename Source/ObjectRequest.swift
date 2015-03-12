//
//  ObjectRequest.swift
//  OKit
//
//  Created by Martín Fernández on 1/5/15.
//  Copyright (c) 2015 bilby91. All rights reserved.
//

import Foundation

import Alamofire

import ObjectMapper

public class ObjectRequest : Alamofire.Request {

  private var keyPath: String?

  public func responseKeyPath(aKeyPath: String) {
    keyPath = aKeyPath
  }

  private func objectSerializer<N: ObjectMapper.MapperProtocol>() -> GenericSerializer<N> {

    return GenericSerializer<N> { (request, response, data) in
      let JSONSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
      let (JSON: AnyObject?, serializationError) = JSONSerializer(request, response, data)
      if response != nil && JSON != nil {

        let aa = JSON as Dictionary<String, AnyObject>

        var key = (self.keyPath != nil ? aa[self.keyPath!] : aa) as? Dictionary<String, AnyObject>

        if key != nil {
          return(Mapper().map(key!, toType: N.self), nil)
        }

        return (nil, nil)
      } else {
        return (nil, serializationError)
      }
    }
  }


  public func responseObject<T: ObjectMapper.MapperProtocol>(completionHandler: (NSURLRequest, NSHTTPURLResponse?, T?, NSError?) -> Void) -> Self {
    return self.response(serializer: self.objectSerializer(), completionHandler: completionHandler);
  }
}