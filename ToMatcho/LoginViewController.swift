//
//  LoginViewController.swift
//  ToMatcho
//
//  Created by Kwong Ming Wei on 18/1/22.
//

import UIKit
import Foundation
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailFld: UITextField!
    @IBOutlet weak var pwdFld: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    
    }
    @IBAction func loginBtn(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailFld.text!, password: pwdFld.text!, completion: {(result,error) in
            if error != nil{
                
            }
            else{
                let storyboard=UIStoryboard(name: "Main", bundle: nil)
                let vc=storyboard.instantiateViewController(withIdentifier: "TestLoggedIn") as UIViewController
                self.view.window?.rootViewController=vc
                vc.modalPresentationStyle = .fullScreen
                self.present(vc,animated:true,completion: nil)
            }
        })
    }
    
    
}
