//
//  HomeFeedViewController.swift
//  Instagram
//
//  Created by user132893 on 4/11/18.
//  Copyright © 2018 user132893. All rights reserved.
//

import UIKit
import Parse

class HomeFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 400
        // Do any additional setup after loading the view.
        let refreshControl = UIRefreshControl()
        fetch()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        self.tableView.insertSubview(refreshControl, at: 0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.post = self.posts[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPost"
        {
            let cell = sender as! UITableViewCell
            if let indexPath = self.tableView.indexPath(for: cell){
                let post = self.posts[indexPath.row]
                let nav = segue.destination as! UINavigationController
                let vc = nav.viewControllers.first as! PostDetailViewController
                vc.post = post
                
                
            }
        }
    }
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        
    
            
            // ... Use the new data to update the data source ...
            fetch()
        
            
            // Tell the refreshControl to stop spinning
            refreshControl.endRefreshing()
        
    
    }
    
    func fetch(){
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.limit = 20
        
        // fetch data asynchronously
        query?.findObjectsInBackground(block: { (posts: [PFObject]?, error) in
            if let error = error{
                print(error.localizedDescription)
            }
            else
            {
               
                self.posts = posts as! [Post]
                self.tableView.reloadData()
            }
        })
        
    }
    
    @IBAction func logout(_ sender: Any) {
        PFUser.logOutInBackground { (error) in
            if let error = error{
                print(error.localizedDescription)
            }
            else
            {
                print("Logged out successfully!")
                
            }
        }
    }
    
    @IBAction func createPost(_ sender: Any) {
        let modal: PostViewController = self.storyboard?.instantiateViewController(withIdentifier: "PostVC") as! PostViewController
        let nav = UINavigationController(rootViewController: modal)
        self.present(nav, animated: true, completion: nil)
    }
    
}
