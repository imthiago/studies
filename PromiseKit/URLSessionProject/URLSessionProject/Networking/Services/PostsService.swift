//
//  PostsService.swift
//  URLSessionProject
//
//  Created by Thiago de Oliveira Santos on 21/12/20.
//

import Foundation

enum PostsPath: String {
    case posts = "posts"
}

protocol PostsService {
    func posts(completion: @escaping (Result<[Post], Error>) -> Void)
    func post(postId: Int, completion: @escaping (Result<Post, Error>) -> Void)
    func create(post: Post, completion: @escaping (Result<Post, Error>) -> Void)
    func update(post: Post, completion: @escaping (Result<Post, Error>) -> Void)
    func delete(postId: Int, completion: @escaping (Result<Void, Error>) -> Void)
}

class PostsServiceImpl: PostsService {

    let apiClient = APIClient()

    func posts(completion: @escaping (Result<[Post], Error>) -> Void) {
        apiClient.request(path: PostsPath.posts.rawValue, method: .get, parameters: nil, headers: nil, completion: completion)
    }

    func post(postId: Int, completion: @escaping (Result<Post, Error>) -> Void) {
        apiClient.request(path: PostsPath.posts.rawValue, method: .get, parameters: nil, headers: nil, completion: completion)
    }

    func create(post: Post, completion: @escaping (Result<Post, Error>) -> Void) {
        let params: [String: Any] = ["userId": post.userId, "title": post.title, "body": post.body]
        let path = "\(PostsPath.posts.rawValue)/\(post.id)"
        apiClient.request(path: path, method: .post, parameters: params, headers: nil, completion: completion)
    }

    func update(post: Post, completion: @escaping (Result<Post, Error>) -> Void) {
        let params: [String: Any] = ["userId": post.userId, "title": post.title, "body": post.body]
        let path = "\(PostsPath.posts.rawValue)/\(post.id)"
        apiClient.request(path: path, method: .put, parameters: params, headers: nil, completion: completion)
    }

    func delete(postId: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        let path = "\(PostsPath.posts.rawValue)/\(postId)"
        apiClient.request(path: path, method: .delete, parameters: nil, headers: nil, completion: completion)
    }
}
