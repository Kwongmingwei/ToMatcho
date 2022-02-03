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

    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
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
        loadingIndicator.isHidden=false
        loadingIndicator.startAnimating()
        errorFld.alpha=0
        //errorFld.text=""
        let validation=isPasswordValid(password: pwdFld.text!, password2: pwdFld2.text!)
        if (validation=="valid"){
            Auth.auth().createUser(withEmail: emailFld.text!, password: pwdFld.text!, completion: {(result, err) in
                if err != nil{
                    let alertView = UIAlertController(title: "Unsuccessful registration", message: "Error: "+err!.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    alertView.addAction(UIAlertAction(title: "Try again", style: UIAlertAction.Style.default, handler: { _ in
                        self.emailFld.text=""
                    }))
                    self.loadingIndicator.stopAnimating()
                    self.loadingIndicator.isHidden=true
                    self.present(alertView,animated: false,completion: nil)
                }
                else{
                    //TRY CHECK FOR USERNAME EXIST OR SMTH
                    let db = Firestore.firestore()
                    
                    db.collection("users").document(result!.user.uid).setData(["name":self.usrNameFld.text!,"access":"user"],completion: {(error) in
                        if error != nil{
                            let alertView = UIAlertController(title: "Unsuccessful registration", message: "Error: "+error!.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                            alertView.addAction(UIAlertAction(title: "Try again", style: UIAlertAction.Style.default, handler: { _ in
                                /*self.emailFld.text=""
                                self.pwdFld.text=""
                                self.pwdFld2.text=""*/
                            }))
                            self.loadingIndicator.stopAnimating()
                            self.loadingIndicator.isHidden=true
                            self.present(alertView,animated: false,completion: nil)
                        }
                        else{
                            let alertView = UIAlertController(title: "Registration successful", message: "Registration successful, return to login screen to log in", preferredStyle: UIAlertController.Style.alert)
                            alertView.addAction(UIAlertAction(title: "Return", style: UIAlertAction.Style.default, handler: { _ in
                                let storyboard=UIStoryboard(name: "Main", bundle: nil)
                                let vc=storyboard.instantiateViewController(withIdentifier: "MainInitialVC") as UIViewController
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc,animated:true,completion: nil)
                            }))
                            self.loadingIndicator.stopAnimating()
                            self.loadingIndicator.isHidden=true
                            self.present(alertView,animated: false,completion: nil)
                        }
                    })
                }
            })
        }
        else{
            errorFld.alpha=1
            if (validation=="nomatch"){
                errorFld.text="Passwords do not match!"
                self.loadingIndicator.stopAnimating()
                self.loadingIndicator.isHidden=true
                
                
            }
            else if (validation=="novalid"){
                errorFld.text="Passwords must contain at least one special character and is 6 character long"
                self.loadingIndicator.stopAnimating()
                self.loadingIndicator.isHidden=true
            }
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
