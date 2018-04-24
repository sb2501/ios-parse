//
//  PostCell.swift
//  Instagram
//
//  Created by user132893 on 4/15/18.
//  Copyright © 2018 user132893. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PostCell: UITableViewCell {
    
    var post: Post!{
        didSet{
            self.captionLabel.text = post.caption
            self.postImageView.file = post.media
            self.postImageView.loadInBackground()
            
        }
    }
    
    
    @IBOutlet weak var postImageView: PFImageView!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
