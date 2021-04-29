//
//  CommentsService.swift
//  URLSessionProject
//
//  Created by Thiago de Oliveira Santos on 22/12/20.
//

import Foundation

enum CommentsPath: String {
    case comments = "comments"
}

protocol CommentsService {
    func comments(postId: Int, completion: @escaping (Result<[Comment], Error>) -> Void)
}

class CommentsServiceImpl: CommentsService {
    let apiClient = APIClient()
    func comments(postId: Int, completion: @escaping (Result<[Comment], Error>) -> Void) {
        let path = "\(PostsPath.posts)/\(postId)/\(CommentsPath.comments)"
        apiClient.request(path: path, method: .get, parameters: nil, headers: nil, completion: completion)
    }
}
