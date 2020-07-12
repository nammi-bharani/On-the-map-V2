//
//  ViewController.swift
//  On the map
//
//  Created by Bharani Nammi on 6/30/20.
//  Copyright © 2020 Bharani Nammi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginTapped(_ sender: UIButton)
    {
        //performSegue(withIdentifier: "completeLogin", sender: nil)
        
        print(UdacityClient.Endpoints.login.url)
        
        print("button presssed")
        
        UdacityClient.login(username: emailTextField.text ?? "", password: passwordTextField.text ?? "", completion: handleLoginResponse(success:error:))
    }
    
    func handleLoginResponse(success: Bool, error: Error?) {
        if success {
            performSegue(withIdentifier: "completeLogin", sender: nil)
        } else {
            let alert = UIAlertController(title: "Alert", message: "Username or Password Incorrect", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            print("not suceesfull")
        }
    }
    
 
    @IBAction func Logout(_ sender: Any) {
        
        UdacityClient.logout()
        self.dismiss(animated: true, completion: nil)
        //can this go here?
        //or do I have to create a new view controller
        
        
    }
}

