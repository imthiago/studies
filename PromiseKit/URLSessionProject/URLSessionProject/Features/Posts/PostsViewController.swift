//
//  ViewController.swift
//  URLSessionProject
//
//  Created by Thiago de Oliveira Santos on 21/12/20.
//

import UIKit

class PostsViewController: UIViewController {

    var postsService: PostsService = PostsServiceImpl()

    @IBOutlet weak var tableView: UITableView!
    
    private var posts: [Post] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPosts()
    }

    private func fetchPosts() {
        postsService.posts { result in
            switch result {
            case .success(let posts):
                self.posts = posts
            case .failure(let error):
                // HANDLE ERROR HERE
                break
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? CommentViewController,
           let indexPath = sender as? IndexPath {
            viewController.setupWith(post: self.posts[indexPath.row])
        }
    }
}

extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as! PostTableViewCell
        cell.setupWith(title: posts[indexPath.row].title,
                       body: posts[indexPath.row].body)

        return cell
    }
}

extension PostsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPostDetail", sender: indexPath)
    }
}

