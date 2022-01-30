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
        return appDelegate.teamRolesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell=UITableViewCell()
        print("3")
        cell = tableView.dequeueReusableCell(withIdentifier: "roleCell", for: indexPath)
        cell.textLabel!.text = appDelegate.teamRolesList[indexPath.row].roleName
        cell.detailTextLabel?.text = String(appDelegate.teamRolesList[indexPath.row].roleQuantity)
        return cell
    }
    
    
    @IBAction func addRoleBtn(_ sender: Any) {
        let alertController = UIAlertController(title: "Add Role",
                                                    message: nil,
                                                    preferredStyle: .alert)
            
            self.present(alertController,
                         animated: true)
        alertController.addTextField { (textField) in
            textField.placeholder = "RoleName"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "RoleQuantity"
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                           style: .default) { [weak alertController] _ in
                                            self.viewDidLoad()
                                            self.dismiss(animated: true, completion: nil)
            
        }
        alertController.addAction(cancelAction)
        let continueAction = UIAlertAction(title: "Continue",
                                           style: .default) { [weak alertController] _ in
                                            guard let textFields = alertController?.textFields else { return }
                                            
                                            if let roleName = textFields[0].text,
                                               let roleQuantity = textFields[1].text {
                                                print("RoleName: \(roleName)")
                                                print("RoleQuantiy: \(roleQuantity)")
                                                self.appDelegate.teamRolesList.append(TeamRoles(roleid: "", rolename: roleName, rolequantity: Int(roleQuantity)!))
                                                self.viewDidLoad()
                                                self.dismiss(animated: true, completion: nil)
                                            }
            
    }
        alertController.addAction(continueAction)
        
    }
    
    @IBAction func addTeamBtn(_ sender: Any) {
        print("test1")
        if txtTeamName.text!.replacingOccurrences(of: " ", with: "") == "" || txtTeamDescription.text!.replacingOccurrences(of: " ", with: "") == "" {
            let alertView = UIAlertController(title: "Empty fields", message: "Fields cannot be empty", preferredStyle: UIAlertController.Style.alert)
            alertView.addAction(UIAlertAction(title: "Return", style: UIAlertAction.Style.default, handler: { _ in
            }))
            self.present(alertView,animated: false,completion: nil)
        }
        
        else{
            print("test2")
            let db = Firestore.firestore()
            let uid = Auth.auth().currentUser?.uid
            let date = Date()
            let dateFormatter = DateFormatter()
            //var count = 0
            dateFormatter.dateFormat = "dd/MM/yyyy"
            print(dateFormatter.string(from: date))
            var ref: DocumentReference? = nil
            print(dateFormatter.string(from: date))
            ref = db.collection("teams").addDocument(data: [
                "teamName": txtTeamName.text!,
                "teamDescription": txtTeamDescription.text!,
                "gameID": appDelegate.gameID,
                "createdBy": String(uid!),
                "createdDate": dateFormatter.string(from: date) ])
            for i in appDelegate.teamRolesList {
                db.collection("roles").addDocument(data: [
                    "roleName": i.roleName,
                    "roleQuantity": i.roleQuantity,
                    "teamID": ref!.documentID])
                }
            
        }
        appDelegate.teamRolesList = []
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle:
        UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            if indexPath.section == 0 {
                appDelegate.teamRolesList.remove(at: indexPath.row)
                
            }
            else { appDelegate.teamRolesList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath as IndexPath],with:UITableView.RowAnimation.fade)}
        }
        else if editingStyle == UITableViewCell.EditingStyle.insert {
            // Create a new instance of the appropriate class, insert it into the array,
            //and add a new row to the table view.
        }
        roleTV.reloadData()
    }
}
