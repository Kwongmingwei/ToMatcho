//
//  LoginViewController.swift
//  ToMatcho
//
//  Created by Kwong Ming Wei on 18/1/22.
//

import UIKit
import Foundation

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    
    }
    @IBAction func loginBtn(_ sender: Any) {
    }
    
    @IBAction func registerBtn(_ sender: Any) {
        let storyboard=UIStoryboard(name: "Main", bundle: nil)
        let vc=storyboard.instantiateViewController(withIdentifier: "Register") as UIViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc,animated:true,completion: nil)
    }
    
}
