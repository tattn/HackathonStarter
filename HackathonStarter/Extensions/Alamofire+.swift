//
//  Alamofire+.swift
//  HackathonStarter
//
//  Created by Tatsuya Tanaka on 2019/07/24.
//  Copyright © 2019 Tatsuya Tanaka. All rights reserved.
//

import Foundation
import Alamofire
import Moya
import Combine

extension MoyaProvider: CombinativeCompatible {}

public extension Combinative where Base: MoyaProviderType {
    func request(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) -> Publisher {
        Publisher(base: base, token: token, callbackQueue: callbackQueue)
    }

    /// Designated request-making method with progress.
    func requestWithProgress(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) -> AnyPublisher<ProgressResponse, MoyaError> {
        ProgressPublisher(base: base, token: token, callbackQueue: callbackQueue)
            .scan(ProgressResponse()) { last, progress in
                // Accumulate all progress and combine them when the result comes
                let progressObject = progress.progressObject ?? last.progressObject
                let response = progress.response ?? last.response
                return ProgressResponse(progress: progressObject, response: response)
            }
            .eraseToAnyPublisher()
    }

    struct Publisher: Combine.Publisher {
        public typealias Output = Response
        public typealias Failure = MoyaError
        let base: Base
        let token: Base.Target
        let callbackQueue: DispatchQueue?

        public func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
            let cancellableToken = base.request(token, callbackQueue: callbackQueue, progress: nil) { result in
                switch result {
                case let .success(response):
                    _ = subscriber.receive(response)
                    subscriber.receive(completion: .finished)
                case let .failure(error):
                    subscriber.receive(completion: .failure(error))
                }
            }

            let subscription = Subscription(cancellableToken: cancellableToken)
            subscriber.receive(subscription: subscription)
        }
    }

    struct ProgressPublisher: Combine.Publisher {
        public typealias Output = ProgressResponse
        public typealias Failure = MoyaError
        let base: Base
        let token: Base.Target
        let callbackQueue: DispatchQueue?

        public func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
            let progressBlock: (ProgressResponse) -> Void = { progress in
                _ = subscriber.receive(progress)
            }

            let cancellableToken = base.request(token, callbackQueue: callbackQueue, progress: progressBlock) { result in
                switch result {
                case .success:
                    subscriber.receive(completion: .finished)
                case let .failure(error):
                    subscriber.receive(completion: .failure(error))
                }
            }

            let subscription = Subscription(cancellableToken: cancellableToken)
            subscriber.receive(subscription: subscription)
        }
    }

    struct Subscription: Combine.Subscription {
        public let combineIdentifier = CombineIdentifier()
        let cancellableToken: Moya.Cancellable

        public func request(_ demand: Subscribers.Demand) {}

        public func cancel() {
            cancellableToken.cancel()
        }
    }
}

public protocol CombinativeCompatible {
    associatedtype CompatibleType
    var combine: CompatibleType { get }
}

public final class Combinative<Base> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

public extension CombinativeCompatible {
    var combine: Combinative<Self> {
        return Combinative(self)
    }
}
