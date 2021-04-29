//
//  PostTableViewCell.swift
//  URLSessionProject
//
//  Created by Thiago de Oliveira Santos on 21/12/20.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupWith(title: String, body: String) {
        titleLabel.text = title
        bodyLabel.text = body
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
