//
//  LogoutViewController.swift
//  On the map
//
//  Created by Bharani Nammi on 7/10/20.
//  Copyright © 2020 Bharani Nammi. All rights reserved.
//

import Foundation
import UIKit

class LogoutViewController: UITabBarController {
    
    
    
    @IBOutlet weak var loginButton: UIButton!

    @IBAction func logoutTapped(_ sender: UIButton)
    {
       
        
        print(UdacityClient.Endpoints.login.url)
        
        UdacityClient.logout()
        
        print("logout button presssed")
        
        performSegue(withIdentifier: "CompleteLogout", sender: nil)

    }

    func handleLoginResponse(success: Bool, error: Error?) {
        if success {
            
        } else {
        }
    }
}
