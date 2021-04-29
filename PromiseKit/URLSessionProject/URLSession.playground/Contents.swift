import UIKit
import Alamofire

struct Post: Codable {
    let id: Int
    let body: String
    let title: String
    let userId: Int
}

struct ProjectError: Error, Decodable {
    let title: String
    let message: String
}

let urlArrayPosts = URL(string: "https://jsonplaceholder.typicode.com/posts")
URLSession.shared.dataTask(with: urlArrayPosts!) { (data, response, error) in
    if let data = data {
        do {
            // Data to JSON
            let json = try JSONSerialization.jsonObject(with: data, options: [])
//            print(json)

            // Data to Object
            let posts: [Post] = try JSONDecoder().decode([Post].self, from: data)

            print("\nPOST Array:")
            print(posts.first?.title)
            print(posts.first?.body)

        } catch {
            print("JSON error: \(error.localizedDescription)")
        }
    }
//    print(data)
//    print((response as? HTTPURLResponse)?.statusCode)
//    print(error)
}.resume()

let urlPost = URL(string: "https://jsonplaceholder.typicode.com/posts/1")
URLSession.shared.dataTask(with: urlPost!) { (data, response, error) in
    if let data = data {
        do {

            // Data to JSON
            let json = try JSONSerialization.jsonObject(with: data, options: [])
//            print(json)


            // Data to Object
            let posts: Post = try JSONDecoder().decode(Post.self, from: data)

            print("\nPOST:")
            print(posts.title)
            print(posts.body)

        } catch {
            print("JSON error: \(error.localizedDescription)")
        }
    }
//    print(data)
//    print((response as? HTTPURLResponse)?.statusCode)
//    print(error)
}.resume()



let urlSession = URLSession(configuration: .default)
var urlRequestGet = URLRequest(url: urlPost!)
urlRequestGet.httpMethod = "GET"
urlRequestGet.addValue("DASDKQOJ312312039", forHTTPHeaderField: "Authorization")
urlSession.dataTask(with: urlRequestGet) { (data, response, error) in
    if let data = data {
        do {
            // Data to Object
            let posts: Post = try JSONDecoder().decode(Post.self, from: data)

            print("\nGET URLRequest:")
            print(posts.title)
            print(posts.body)

        } catch {
            print("JSON error: \(error.localizedDescription)")
        }
    }
}.resume()

var urlRequest = URLRequest(url: urlArrayPosts!)
let encodablePost = Post(id: 1,
                         body: "13212412",
                         title: "dasdsakdlas",
                         userId: 1)

urlRequest.httpMethod = "POST"
urlRequest.httpBody = try? JSONEncoder().encode(encodablePost)
urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
urlSession.dataTask(with: urlRequest) { (data, response, error) in
    if let data = data {
        do {

            if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
                print("\nPOST URLRequest:")
                let posts: Post = try JSONDecoder().decode(Post.self, from: data)
                print(posts.title)
                print(posts.body)
            } else {
                print("\nERROR POST URLRequest:")
                let error: ProjectError = try JSONDecoder().decode(ProjectError.self, from: data)
                print(error)
            }



        } catch {
            print("JSON error: \(error.localizedDescription)")
        }
    }
}.resume()


urlSession.dataTask(with: URL(string: "https://dmwnh9nwzeoaa.cloudfront.net/2020-11/ciandt-logo-thumbnail.png")!) { (data, _, _) in
    let image = UIImage(data: data!)
}.resume()


let session = Session()
session.request(URLRequest(url: urlArrayPosts!)).validate().responseData { (response) in
    print(response.data)
    let posts: [Post] = try! JSONDecoder().decode([Post].self, from: response.data!)
    print(posts)
}


