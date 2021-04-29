//
//  Comment.swift
//  URLSessionProject
//
//  Created by Thiago de Oliveira Santos on 22/12/20.
//
import Foundation

// MARK: - Welcome
struct Comment: Codable {
    let postId, id: Int
    let name, email, body: String
}
