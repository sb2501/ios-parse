//
//  PostDetailViewController.swift
//  Instagram
//
//  Created by user132893 on 4/16/18.
//  Copyright © 2018 user132893. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PostDetailViewController: UIViewController {

    @IBOutlet weak var postImageView: PFImageView!
    
    
    @IBOutlet weak var captionLabel: UILabel!
    
    
    @IBOutlet weak var timestampLabel: UILabel!
    
    var post: Post!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captionLabel.text = post.caption
        timestampLabel.text = post.timestamp
        postImageView.file = post.media
        postImageView.loadInBackground()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(_ sender: Any) {
        self.performSegue(withIdentifier: "backToHome", sender: nil)
    }
    
    
    
}
