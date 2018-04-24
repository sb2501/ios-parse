//
//  SignupViewController.swift
//  Instagram
//
//  Created by user132893 on 4/11/18.
//  Copyright © 2018 user132893. All rights reserved.
//

import UIKit
import Parse

class SignupViewController: UIViewController {

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
    

    func registerUser(){
        let newUser = PFUser()
        
        newUser.username = usernameTextField.text
        newUser.password = passwordTextField.text
        
        
        newUser.signUpInBackground { (success, error) in
            if let error = error{
                print(error.localizedDescription)
            }
            else
            {
                print("User registered successfully!")
                self.performSegue(withIdentifier: "signupSuccess", sender: nil)
            }
        }
    }
    
    @IBAction func signup(_ sender: Any) {
        registerUser()
    }
    
}
