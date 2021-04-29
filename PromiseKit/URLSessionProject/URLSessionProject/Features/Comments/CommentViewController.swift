//
//  CommentViewController.swift
//  URLSessionProject
//
//  Created by Thiago de Oliveira Santos on 22/12/20.
//

import UIKit

class CommentViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var titleTextField: UITextField?
    @IBOutlet weak var bodyTextView: UITextView?
    @IBOutlet weak var deletePostButton: UIButton?


    var postsService: PostsService = PostsServiceImpl()
    var commentsService: CommentsService = CommentsServiceImpl()

    private var post: Post?
    private var comments: [Comment] = [] {
        didSet {
            tableView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFields()
        fillPostField()
        fetchComments()
    }

    public func setupWith(post: Post) {
        self.post = post
    }

    private func fetchPost(postId: Int) {
        postsService.post(postId: postId) { result in
            switch result {
            case .success(let post):
                self.post = post
            case .failure(_):
                break
            }
        }
    }

    private func fetchComments() {
        if let post = post {
            commentsService.comments(postId: post.id) { result in
                switch result {
                    case .success(let comments):
                        self.comments = comments
                    case .failure(_):
                        break
                }
            }
        }
    }

    private func deletePost() {
        if let post = post {
            postsService.delete(postId: post.id) { result in
                switch result {
                case .success():
                    self.navigationController?.popViewController(animated: true)
                case .failure(_):
                    break
                }
            }
        }
    }

    private func savePost() {
        if let post = post {
            let post = Post(id: post.id,
                            body: bodyTextView?.text ?? "",
                            title: titleTextField?.text ?? "",
                            userId: post.userId)
            postsService.update(post: post) { result in
                switch result {
                case .success(let post):
                    self.post = post
                case .failure(_):
                    break
                }
            }
        }
    }

    private func fillPostField() {
        if let post = post {
            self.fetchPost(postId: post.id)
            titleTextField?.text = post.title
            bodyTextView?.text = post.body
        }
    }

    private func setupFields() {
        bodyTextView?.layer.borderWidth = 1
        bodyTextView?.layer.borderColor = UIColor.lightGray.cgColor
        bodyTextView?.layer.cornerRadius = 5
        deletePostButton?.layer.borderWidth = 1
        deletePostButton?.layer.borderColor = UIColor.lightGray.cgColor
        deletePostButton?.layer.cornerRadius = 5
    }
    
    @IBAction func didTapSaveButton(_ sender: Any) {
        savePost()
    }

    @IBAction func didTapDeletePost(_ sender: Any) {
        deletePost()
    }

}

extension CommentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell") as! CommentTableViewCell
        cell.nameLabel.text = "Title"
        cell.bodyLabel.text = "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla"
        cell.emailLabel.text = "test@email.com"

//        cell.titleLabel.text = comments[indexPath.row-1].title
//        cell.emailLabel.text = comments[indexPath.row-1].email
//        cell.bodyLabel.text = comments[indexPath.row-1].title.body

        return cell
    }
}
