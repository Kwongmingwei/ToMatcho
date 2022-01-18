//
//  RegisterViewController.swift
//  ToMatcho
//
//  Created by Kwong Ming Wei on 18/1/22.
//

import UIKit
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

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
        let validation=isPasswordValid(password: pwdFld.text!, password2: pwdFld2.text!)
        if (validation=="valid"){
            Auth.auth().createUser(withEmail: emailFld.text!, password: pwdFld.text!, completion: {(result, err) in
                if err != nil{
                }
                else{
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["name":self.usrNameFld.text!,"uid":result!.user.uid], completion: {(error) in
                        if error != nil{
                            
                        }
                        else{
                            /*let storyboard=UIStoryboard(name: "ToMatcho", bundle: nil)
                            let vc=storyboard.instantiateViewController(withIdentifier: "GameTVC") as UIViewController
                            //self.view.window?.rootViewController=vc
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc,animated:true,completion: nil)*/
                        }
                    })
                    
                }
            })
        }
        else{
            errorFld.alpha=1
        }
    }
    
    public func isPasswordValid(password:String,password2:String)->String{
        if (password==password2){
            let pwdValid=NSPredicate(format:"SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[$@$#!%*?&]).{6,}$")
            if (pwdValid.evaluate(with: password)){
                return "valid"
            }
            return "novalid"
        }
        return "nomatch"
    }
    
}
