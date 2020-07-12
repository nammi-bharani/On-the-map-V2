//
//  AddLocationViewController.swift
//  On the map
//
//  Created by Bharani Nammi on 7/1/20.
//  Copyright © 2020 Bharani Nammi. All rights reserved.
//

import Foundation
import UIKit

class AddLocationViewController: UIViewController {
    
    
    @IBOutlet weak var location: UITextField!
    
    @IBOutlet weak var mediaUrl: UITextField!
    
    
    @IBOutlet weak var findLocation: UIButton!
    
    @IBAction func addLocation(_ sender: UIButton){
        
        ParseClient.postStudentLocation(location: location.text ?? "", mediaUrl: mediaUrl.text ?? "", completion: handlePostLocationResponse(success:error:))
        
        //self.dismiss(animated: true, completion: nil)
        
    }
    func handlePostLocationResponse(success: Bool, error: Error?) {
        if success {
            print("posted the loaction")
            self.dismiss(animated: true, completion: nil)
            
        } else {
            print("not suceesfull")
        }
    }
    
}
