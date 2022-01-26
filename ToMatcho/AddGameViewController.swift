//
//  AddGameViewController.swift
//  ToMatcho
//
//  Created by Kwong Ming Wei on 26/1/22.
//

import UIKit
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class AddGameViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var txtGDev: UITextField!
    @IBOutlet weak var txtGName: UITextField!
    @IBOutlet weak var pvAgeRate: UIPickerView!
    var selectedpvValue=0
    var pickerData:[String] = ["Early Childhood","Everyone","Everyone (10+)","Teen (13+)","Mature (17+)","Adults only (18+)"]
    var pickerDataValue:[Int]=[0,0,10,13,17,18]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedpvValue = pickerDataValue[row]
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pvAgeRate.delegate = self
        self.pvAgeRate.dataSource = self
    }
    
    
    /*override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let storyboard=UIStoryboard(name: "Admin", bundle: nil)
        let vc=storyboard.instantiateViewController(withIdentifier: "AllGame") as! UITableViewController
        print("reload")
        vc.tableView.reloadData()
        }*/
    
    @IBAction func backbtn(_ sender: Any) {
        let storyboard=UIStoryboard(name: "Admin", bundle: nil)
        let vc=storyboard.instantiateViewController(withIdentifier: "AdminTBC") as UIViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc,animated:true,completion: nil)
    }
    @IBAction func addGameBtn(_ sender: Any) {
        
        if txtGDev.text!.replacingOccurrences(of: " ", with: "") == "" || txtGName.text!.replacingOccurrences(of: " ", with: "") == "" {
            let alertView = UIAlertController(title: "Empty fields", message: "Fields cannot be empty", preferredStyle: UIAlertController.Style.alert)
            alertView.addAction(UIAlertAction(title: "Return", style: UIAlertAction.Style.default, handler: { _ in
            }))
            self.present(alertView,animated: false,completion: nil)
        }
        
        else{
            let db = Firestore.firestore()
            var ref: DocumentReference? = nil
            ref = db.collection("games").addDocument(data: [
                "name": txtGName.text!,
                "developer": txtGName.text!,
                "ageRating":selectedpvValue
            ]) { err in
                if let err = err {
                    let alertView = UIAlertController(title: "Unsuccessful Action", message: "Error: "+err.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    alertView.addAction(UIAlertAction(title: "Try again", style: UIAlertAction.Style.default, handler: { _ in
                    }))
                    self.present(alertView,animated: false,completion: nil)
                } else {
                    self.appDelegate.gameList.append(Game(gamename: self.txtGName.text!, gameId: ref!.documentID, gameDev: self.txtGName.text!))
                    let alertView = UIAlertController(title: "Successful", message: "Game added successfully, add more games or return?", preferredStyle: UIAlertController.Style.alert)
                    alertView.addAction(UIAlertAction(title: "Add Games", style: UIAlertAction.Style.default, handler: { _ in
                        self.txtGName.text=""
                        self.txtGDev.text=""
                        self.pvAgeRate.selectRow(0, inComponent: 0, animated: false)
                    }))
                    alertView.addAction(UIAlertAction(title: "Return", style: UIAlertAction.Style.default, handler: { _ in
                        let storyboard=UIStoryboard(name: "Admin", bundle: nil)
                        let vc=storyboard.instantiateViewController(withIdentifier: "AdminTBC") as UIViewController
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc,animated:true,completion: nil)
                    }))
                    self.present(alertView,animated: false,completion: nil)
                }
            }
        }
            
            
        
       
    }
    
}
