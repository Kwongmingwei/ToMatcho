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

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var emailFld: UITextField!
    @IBOutlet weak var pwdFld: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    
    }
    @IBAction func loginBtn(_ sender: Any) {
        spinner.isHidden=false
        spinner.startAnimating()
        
        Auth.auth().signIn(withEmail: emailFld.text!, password: pwdFld.text!, completion: {(result,error) in
            if error != nil{
                let alertView = UIAlertController(title: "Unsuccessful login", message: "Error: "+error!.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alertView.addAction(UIAlertAction(title: "Try again", style: UIAlertAction.Style.default, handler: { _ in
                    self.pwdFld.text=""
                }))
                self.spinner.stopAnimating()
                self.spinner.isHidden=true
                self.present(alertView,animated: false,completion: nil)
            }
            else{
                /*let db=Database.database().reference()
                let uid = Auth.auth().currentUser?.uid
                db.child("users").child(uid!).child("access")*/
                
                let uid = Auth.auth().currentUser?.uid
                let docRef = Firestore.firestore().collection("users").document(uid!)
                docRef.getDocument{(doc,error) in
                if error == nil{
                    let access=doc!.get("access") as! String
                    print("Access= "+access)
                    if access == "user"{
                        let storyboard=UIStoryboard(name: "ToMatcho", bundle: nil)
                        let vc=storyboard.instantiateViewController(withIdentifier: "ToMatchoMain") as UIViewController
                        self.view.window?.rootViewController=vc
                        vc.modalPresentationStyle = .fullScreen
                        self.spinner.stopAnimating()
                        self.spinner.isHidden=true
                        self.present(vc,animated:true,completion: nil)
                    }
                    else if access=="admin"{
                        let storyboard=UIStoryboard(name: "Admin", bundle: nil)
                        let vc=storyboard.instantiateViewController(withIdentifier: "AdminTBC") as UIViewController
                        self.view.window?.rootViewController=vc
                        vc.modalPresentationStyle = .fullScreen
                        self.spinner.stopAnimating()
                        self.spinner.isHidden=true
                        self.present(vc,animated:true,completion: nil)
                    }
                }
                }
                
                
            }
        })
    }
    
    
}
