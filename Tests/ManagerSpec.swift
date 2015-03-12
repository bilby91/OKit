//
//  OKitTests.swift
//  OKitTests
//
//  Created by Martín Fernández on 12/31/14.
//  Copyright (c) 2014 bilby91. All rights reserved.
//

import Nimble
import Quick
import Nocilla

import OKit
import ObjectMapper
import Alamofire

class User: ObjectMapper.MapperProtocol {

  var name: String

  required init() { name = "Default" }

  func map(mapper: Mapper) {

    name <= mapper["name"]
  }

}

extension LSStubResponseDSL {

  func withJSON(JSON: [String: AnyObject]) {

    let data = NSJSONSerialization.dataWithJSONObject(JSON, options: NSJSONWritingOptions.PrettyPrinted , error: nil)

    self.withBody(data)
  }
}

class ManagerSpec: QuickSpec {

  override func spec() {

    var manager: OKit.Manager?

    beforeEach {
      LSNocilla.sharedInstance().start()
      manager = Manager(aBaseURL: NSURL(string: "http://localhost:4567")!)
      stubRequest("GET", "http://localhost:4567/user.json")
      .andReturn(200)
      .withJSON( [ "user": [ "name" : "foo2" ]])
    }

    afterEach {
      LSNocilla.sharedInstance().clearStubs()
    }

    afterSuite {
      LSNocilla.sharedInstance().stop()
    }

    it("should map name") {

      var testUser: User?

      manager?.get("/user.json", completionHandler: { (_, _, user: User?, _) -> Void in
        testUser = user
      }).responseKeyPath("user")
  

      expect(testUser?.name).toEventually(equal("foo2"))
    }

  }
}
