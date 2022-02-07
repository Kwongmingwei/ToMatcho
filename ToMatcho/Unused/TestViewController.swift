//
//  TestViewController.swift
//  ToMatcho
//
//  Created by Kwong Ming Wei on 18/1/22.
//
/*
import Foundation

import UIKit
import Firebase

class TestViewController: UIViewController {
    
    var teamid:String=""
    
    var rolename:String=""
    
    var roleid:String=""
    
    var uid:String=""
    
    var quantity:Int=0
    
    @IBOutlet weak var teamidtxt: UILabel!
    
    @IBOutlet weak var rolenametxt: UILabel!
    
    @IBOutlet weak var roleidtxt: UILabel!
    
    @IBOutlet weak var userid: UILabel!
    
    @IBOutlet weak var idFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamidtxt.text=teamid
        rolenametxt.text=rolename+" quantity: "+String(quantity)
        roleidtxt.text=roleid
        userid.text=uid
    }
    @IBAction func joinTeamBtn(_ sender: Any) {
        let dateformat = DateFormatter()
        //var count = 0
        dateformat.dateFormat = "dd/MM/yyyy"
        let date = dateformat.string(from: Date())
        
        let db = Firestore.firestore()
        db.collection("teamroles").addDocument(data: [
            "teamid": teamidtxt.text!,
            "roleid": roleidtxt.text!,
            "userid":userid.text!,
            "uInGameID":idFld.text!,
            "roleName":rolenametxt.text!,
            "joinedon":date
        ]) { err in
            if let err = err {
                let alertView = UIAlertController(title: "Unsuccessful Action", message: "Error: "+err.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alertView.addAction(UIAlertAction(title: "Try again", style: UIAlertAction.Style.default, handler: { _ in
                }))
                self.present(alertView,animated: false,completion: nil)
            } else {
                db.collection("roles").document(self.roleidtxt.text!).setData([ "roleQuantity": self.quantity-1 ], merge: true)
                print("success")
            }
        }
    }
}
*/
