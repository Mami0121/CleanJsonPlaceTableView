//
//  JsonPlaceHolderService.swift
//  CleanJsonPlaceTableView
//
//  Created by Muhammet on 14.08.2022.
//

import Alamofire


protocol JsonPLaceHolderProtocol {
    func fethAllPosts(onSuccess: @escaping ([PostModel]) -> Void, onFail: @escaping (String?) -> Void)
}

enum JsonPLaceHolderPath: String {
    case POSTS = "/posts"
}

extension JsonPLaceHolderPath {

    func withBaseUrl() -> String {
        return "https://jsonplaceholder.typicode.com\(self.rawValue)"
    }
}

struct JsonPlaceHolderService: JsonPLaceHolderProtocol {
    func fethAllPosts(onSuccess: @escaping ([PostModel]) -> Void, onFail: @escaping (String?) -> Void) {
        AF.request(JsonPLaceHolderPath.POSTS.withBaseUrl(), method: .get).validate().responseDecodable(of: [PostModel].self) { (response) in
            guard let items = response.value else {
                onFail(response.debugDescription)
                return
            }
            onSuccess(items)
        }
    }
}
