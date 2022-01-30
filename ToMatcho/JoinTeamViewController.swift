//
//  JoinTeamViewController.swift
//  ToMatcho
//
//  Created by Ho Jun An on 30/1/22.
//

import UIKit
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class JoinTeamViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var roleTableView: UITableView!
    
    @IBOutlet weak var displayTeamName: UILabel!
    @IBOutlet weak var displayTeamDescription: UILabel!
    @IBOutlet weak var inputAccountID: UITextField!
    
    func displayTeamData() {
        self.displayTeamName.text = appDelegate.chosenTeamName
        self.displayTeamDescription.text = appDelegate.chosenTeamDescription
    }
    
    func loadData() {
        Firestore.firestore().collection("teams").whereField("teamID", isEqualTo: appDelegate.gameID).getDocuments() {(querySnapshot,err) in
            if err == nil {
                self.appDelegate.teamRolesList.removeAll()
                for document in querySnapshot!.documents {
                    let roleName = document.get("roleName") as! String
                    let roleQuantity = document.get("roleQuantity") as! Int
                    let teamID = document.get("teamID") as! String
                    
                    self.appDelegate.teamRolesList.append(TeamRoles(rolename: roleName, rolequantity: roleQuantity))
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayTeamData()
        loadData()
        
        roleTableView.delegate = self
        roleTableView.dataSource = self
        roleTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.teamRolesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        cell = tableView.dequeueReusableCell(withIdentifier: "roleCell", for: indexPath)
        cell.textLabel!.text = appDelegate.teamRolesList[indexPath.row].roleName
        cell.detailTextLabel?.text = "Quantity: " + String(appDelegate.teamRolesList[indexPath.row].roleQuantity)
        return cell
    }
    
    @IBAction func joinTeam(_ sender: Any) {
        // Send data to Firebase
        
        
        // Sends user back to Teams List
        _ = navigationController?.popViewController(animated: true)
    }
}
