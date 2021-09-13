//
//  ApiCaller.swift
//  CombineIntro
//
//  Created by Thiago Oliveira on 10/09/21.
//

import Combine
import Foundation

class ApiCaller {
    static let shared = ApiCaller()

    func fetchCompanies() -> Future<[String], Error> {
        return Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                promise(.success(["Apple", "Google", "Facebook"]))
            }
        }
    }
}
