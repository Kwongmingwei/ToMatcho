//
//  RegisterViewController.swift
//  ToMatcho
//
//  Created by Kwong Ming Wei on 18/1/22.
//

import UIKit
import Foundation

class RegisterViewController: UIViewController {

    @IBOutlet weak var usrNameFld: UITextField!
    @IBOutlet weak var emailFld: UITextField!
    @IBOutlet weak var pwdFld: UITextField!
    @IBOutlet weak var pwdFld2: UITextField!
    @IBOutlet weak var errorFld: UILabel!
    @IBOutlet weak var regBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    
    }

    @IBAction func regBtnClick(_ sender: Any) {
        let bool=isPasswordValid(password: pwdFld.text!, password2: pwdFld2.text!)
        if (bool){
            
        }
        else{
            errorFld.alpha=1
        }
    }
    
    public func isPasswordValid(password:String,password2:String)->Bool{
        if (password==password2){
            let pwdValid=NSPredicate(format:"SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[$@$#!%*?&]).{6,}$")
            return pwdValid.evaluate(with: password)
        }
        return false
    }
    
}
