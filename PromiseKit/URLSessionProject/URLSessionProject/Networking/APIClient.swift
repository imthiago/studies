//
//  APIClient.swift
//  URLSessionProject
//
//  Created by Thiago de Oliveira Santos on 23/12/20.
//

import Foundation

enum ProjectError: Error {
    case genericError
}

enum MethodHTTP: String {
    case get = "GET"
    case delete = "DELETE"
    case put = "PUT"
    case post = "POST"
}

class APIClient {

    private let urlSession: URLSession

    init(urlSession: URLSession = URLSession(configuration: .default)) {
        self.urlSession = urlSession
    }

    private func tryMap<T: Decodable>(data: Data) -> Result<T, Error> {
        guard let object: T = try? JSONDecoder().decode(T.self, from: data) else {
            return Result.failure(ProjectError.genericError)
        }

        return Result.success(object)
    }

    private func handleResponse<T: Decodable>(data: Data?, response: URLResponse?, error: Error?) -> Result<T, Error> {
        if error != nil {
            return Result.failure(ProjectError.genericError)
        }

        if let response = response as? HTTPURLResponse, let data = data, 200...299 ~= response.statusCode {
            return tryMap(data: data)
        }

        return Result.failure(ProjectError.genericError)
    }

    func request(path: String, method: MethodHTTP, parameters: [String: Any]?, headers: [String: String]?, completion: @escaping ((Result<Void, Error>) -> Void)) {
        guard var url = URL(string: Constants.baseURL) else {
            return completion(Result.failure(ProjectError.genericError))
        }

        url.appendPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        if let parameters = parameters {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters as Any, options: [])
        }
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let headers = headers {
            for (key, value) in headers {
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }

        urlSession.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    return completion(Result.failure(ProjectError.genericError))
                }

                if let response = response as? HTTPURLResponse, let data = data, 200...299 ~= response.statusCode {
                    return completion(Result.success(()))
                }
            }
        }.resume()
    }

    func request<T: Decodable>(path: String, method: MethodHTTP, parameters: [String: Any]?, headers: [String: String]?, completion: @escaping ((Result<T, Error>) -> Void)) {
        guard var url = URL(string: Constants.baseURL) else {
            return completion(Result.failure(ProjectError.genericError))
        }

        url.appendPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        if let parameters = parameters {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters as Any, options: [])
        }
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let headers = headers {
            for (key, value) in headers {
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }

        urlSession.dataTask(with: urlRequest) { (data, response, error) in
            let result: Result<T, Error> = self.handleResponse(data: data, response: response, error: error)
            DispatchQueue.main.async {
                completion(result)
            }
        }.resume()
    }
}
