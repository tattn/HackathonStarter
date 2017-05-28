//
//  HTTPClient.swift
//  HackathonStarter
//
//  Created by Tatsuya Tanaka on 20170528.
//  Copyright © 2017年 tattn. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxAlamofire

final class HTTPRequestConfiguration {
    var url: URL = "https://***.com"
    var method: HTTPMethod = .get
    var parameters: [String: Any] = [:]
    var encoding: ParameterEncoding = URLEncoding.default
    var headers: [String: String] = [:]
}

protocol HTTPRequestType: class {
    associatedtype ResponseType
    
    var configuration: HTTPRequestConfiguration { get set }
    
    func asObservable() -> Observable<ResponseType>
}

protocol HTTPDefaultRequestType {
    associatedtype ResponseType
    var _request: (HTTPMethod, URLConvertible, [String: Any]?, ParameterEncoding, [String: String]?) -> Observable<ResponseType> { get }
}

extension HTTPRequestType where Self: HTTPDefaultRequestType {
    func asObservable() -> Observable<ResponseType> {
        return _request(configuration.method,
                        configuration.url,
                        configuration.parameters,
                        configuration.encoding,
                        configuration.headers)
    }
}

extension HTTPRequestType {
    func configure(block: (HTTPRequestConfiguration) -> Void) -> Self {
        block(configuration)
        return self
    }
    
    func setURL(_ url: URL) -> Self {
        self.configuration.url = url
        return self
    }
    
    func setMethod(_ method: HTTPMethod) -> Self {
        self.configuration.method = method
        return self
    }
    
    func setParameters(_ parameters: [String: Any]) -> Self {
        self.configuration.parameters = parameters
        return self
    }
    
    func setEncoding(_ encoding: ParameterEncoding) -> Self {
        self.configuration.encoding = encoding
        return self
    }
    
    func setHeaders(_ headers: [String: String]) -> Self {
        self.configuration.headers = headers
        return self
    }
}
