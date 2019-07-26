//
//  APITemplate.swift
//  HackathonStarter
//
//  Created by Tatsuya Tanaka on 2019/07/25.
//  Copyright © 2019 Tatsuya Tanaka. All rights reserved.
//

import Foundation
import Moya

extension Template {
    enum MockAPI: TargetType {
        case getToDo(todoId: Int = 1, userId: Int = 1)

        var baseURL: URL {
            URL(string: "https://jsonplaceholder.typicode.com")!
        }

        var path: String {
            switch self {
            case .getToDo(_, let userId):
                return "/todos/\(userId)"
            }
        }

        var method: Moya.Method {
            .get
        }

        var task: Task {
            switch self {
            case .getToDo(_, let userId):
                return .requestParameters(parameters: ["userId": userId],
                                          encoding: URLEncoding.default)
            }
            // .requestPlain
        }

        var headers: [String : String]? {
            nil
        }
    }
}

extension Template.MockAPI {
    struct Todo: Codable {
        let userId: Int
        let id: Int
        let title: String
        let completed: Bool
    }
}
