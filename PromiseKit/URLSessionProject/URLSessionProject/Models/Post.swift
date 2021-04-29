//
//  Post.swift
//  URLSessionProject
//
//  Created by Thiago de Oliveira Santos on 21/12/20.
//

import Foundation

struct Post: Codable {
    let id: Int
    let body: String
    let title: String
    let userId: Int
}
