//
//  HTTPRequest.swift
//  HackathonStarter
//
//  Created by Tatsuya Tanaka on 20170528.
//  Copyright © 2017年 tattn. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxAlamofire

final class HTTPJSONRequest: HTTPRequestType, HTTPDefaultRequestType {
    var configuration = HTTPRequestConfiguration()
    let _request = SessionManager.default.rx.json
}

final class HTTPDataRequest: HTTPRequestType, HTTPDefaultRequestType {
    var configuration = HTTPRequestConfiguration()
    let _request =  SessionManager.default.rx.data
}

final class HTTPStringRequest: HTTPRequestType, HTTPDefaultRequestType {
    var configuration = HTTPRequestConfiguration()
    let _request =  SessionManager.default.rx.responseString
}
