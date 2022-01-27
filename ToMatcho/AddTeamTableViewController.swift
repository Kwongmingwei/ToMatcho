//
//  AddTeamTableViewController.swift
//  ToMatcho
//
//  Created by Letricia Thio on 26/1/22.
//

import Foundation

import UIKit

class ShowContactViewController: UITableViewController {
    
    var appDelegate =  UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.reloadData() //refresh data
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    /*override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let ec = storyboard?.instantiateViewController(withIdentifier: "EditContactViewController") as? EditContactViewController{
            ec.originalFName = appDelegate.contactList[indexPath.row].firstName
            ec.originalLName = appDelegate.contactList[indexPath.row].lastName
            ec.originalMobileNo = appDelegate.contactList[indexPath.row].mobileNo
            ec.index = indexPath.row
            self.navigationController?.pushViewController(ec, animated: true)
        }
            
    }*/
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.teamRolesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TeamRoleCell", for: indexPath)
        
        let teamroles = appDelegate.teamRolesList[indexPath.row]
        cell.textLabel!.text = "\(teamroles.roleName)"
        cell.detailTextLabel!.text = "\(teamroles.roleQuantity)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle:
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
        self.tableView.reloadData()
    }
    
}
