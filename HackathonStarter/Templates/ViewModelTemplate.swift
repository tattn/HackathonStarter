//
//  ViewModelTemplate.swift
//  HackathonStarter
//
//  Created by Tatsuya Tanaka on 2019/07/25.
//  Copyright © 2019 Tatsuya Tanaka. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import Moya

extension Template {
    class ViewModel: BindableObject {
        let willChange = PassthroughSubject<ViewModel, Never>()

        private var loadCancellable: Combine.Cancellable?

        private(set) var todo: MockAPI.Todo? {
            willSet {
                willChange.send(self)
            }
        }

        func load() {
            loadCancellable = MoyaProvider<MockAPI>().combine.request(.getToDo())
                    .map { $0.data }
                    .decode(type: MockAPI.Todo.self, decoder: JSONDecoder())
                    .sink(receiveCompletion: { completion in
                        print(completion)
                    }) { [weak self] (response) in
                        print(response)
                        self?.todo = response
                }
        }
    }
}
