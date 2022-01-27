//
//  AddTeamViewController.swift
//  ToMatcho
//
//  Created by Letricia Thio on 26/1/22.
//

import UIKit
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class AddTeamViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    
    @IBOutlet weak var roleTV: UITableView!
    
    var roles:[String]=["Tank","Fighter","Marksman"]
    
    
    
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var txtTeamName: UITextField!
    @IBOutlet weak var txtTeamDescription: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roleTV.delegate=self
        roleTV.dataSource=self
        roleTV.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("1")
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("2")
        return roles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell=UITableViewCell()
        print("3")
        cell = tableView.dequeueReusableCell(withIdentifier: "roleCell", for: indexPath)
        cell.textLabel!.text=roles[indexPath.row]
        return cell
    }
    
   /* @IBOutlet weak var pvAgeRate: UIPickerView!
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
    }*/
    
    
    /*override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let storyboard=UIStoryboard(name: "Admin", bundle: nil)
        let vc=storyboard.instantiateViewController(withIdentifier: "AllGame") as! UITableViewController
        print("reload")
        vc.tableView.reloadData()
        }*/
    
    /*@IBAction func backbtn(_ sender: Any) {
        let storyboard=UIStoryboard(name: "Admin", bundle: nil)
        let vc=storyboard.instantiateViewController(withIdentifier: "AdminTBC") as UIViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc,animated:true,completion: nil)
    }*/
    
    @IBAction func addTeamBtn(_ sender: Any) {
        
        if txtTeamName.text!.replacingOccurrences(of: " ", with: "") == "" || txtTeamDescription.text!.replacingOccurrences(of: " ", with: "") == "" {
            let alertView = UIAlertController(title: "Empty fields", message: "Fields cannot be empty", preferredStyle: UIAlertController.Style.alert)
            alertView.addAction(UIAlertAction(title: "Return", style: UIAlertAction.Style.default, handler: { _ in
            }))
            self.present(alertView,animated: false,completion: nil)
        }
        
        else{
            let db = Firestore.firestore()
            var ref: DocumentReference? = nil
            ref = db.collection("games").addDocument(data: [
                "name": txtTeamName.text!,
                "developer": txtTeamDescription.text!
            ]) { err in
                if let err = err {
                    let alertView = UIAlertController(title: "Unsuccessful Action", message: "Error: "+err.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    alertView.addAction(UIAlertAction(title: "Try again", style: UIAlertAction.Style.default, handler: { _ in
                    }))
                    self.present(alertView,animated: false,completion: nil)
                } else {
                    self.appDelegate.gameList.append(Game(gamename: self.txtTeamName.text!, gameId: ref!.documentID, gameDev: self.txtTeamName.text!))
                    let alertView = UIAlertController(title: "Successful", message: "Game added successfully, add more games or return?", preferredStyle: UIAlertController.Style.alert)
                    alertView.addAction(UIAlertAction(title: "Add Games", style: UIAlertAction.Style.default, handler: { _ in
                        self.txtTeamName.text=""
                        self.txtTeamDescription.text=""
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
