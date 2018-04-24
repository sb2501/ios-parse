//
//  LoginViewController.swift
//  Instagram
//
//  Created by user132893 on 4/11/18.
//  Copyright © 2018 user132893. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func loginUser(){
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if let error = error{
                print(error.localizedDescription)
            }
            else
            {
                print((user?.username)! + " logged in successfully!")
                self.performSegue(withIdentifier: "goToHome", sender: nil)
            }
        }
    }
    
    @IBAction func login(_ sender: Any) {
        loginUser()
    }
   

}
