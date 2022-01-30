//
//  AddTeamRolesViewController.swift
//  ToMatcho
//
//  Created by Letricia Thio on 26/1/22.
//

import Foundation

import UIKit

class AddTeamRolesViewController: UIViewController {
    
    @IBOutlet weak var roleNameFld: UITextField!
    @IBOutlet weak var roleQuantityFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        roleNameFld.text = ""
        roleQuantityFld.text = ""
    }
    
    @IBAction func createBtn(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        /*appDelegate.contactList.append(Contact(firstname: firstNameFld.text!, lastname: lastNameFld.text!, mobileno: mobileFld.text!))
        print(String(appDelegate.contactList.count))*/
        //let tr = TeamRolesController()
        //tr.AddTeamRoles(newTeamRoles: TeamRoles(rolename: roleNameFld.text!, rolequantity: roleQuantityFld.text!))
        appDelegate.teamRolesList.append(TeamRoles(rolename: roleNameFld.text!, rolequantity: Int(roleQuantityFld.text!)!))
        print(appDelegate.teamRolesList.count)
        //appDelegate.teamRolesList = tr.retrieveAllTeamRoles()
    }
}
