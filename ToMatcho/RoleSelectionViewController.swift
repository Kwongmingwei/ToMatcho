//
//  RoleSelectionViewController.swift
//  ToMatcho
//
//  Created by Kwong Ming Wei on 30/1/22.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore

class RoleSelectViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var roleTV: UITableView!
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var teamid:String=""
    
    @IBOutlet weak var tNametxt: UILabel!
    @IBOutlet weak var tDesctxt: UILabel!
    
    
    var roleList:[TeamRoles]=[]
    
    func loadData(){
        
        if (teamid != ""){
            let docRef = Firestore.firestore().collection("teams").document(teamid)

            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    self.tNametxt.text=document.get("teamName") as? String
                    self.tDesctxt.text=document.get("teamDescription") as? String
                } else {
                    print("Document does not exist")
                }
            }
            
            Firestore.firestore().collection("roles").whereField("teamID", isEqualTo: teamid).getDocuments() {(querySnapshot,err) in
                if err == nil{
                    print("b4 rolelist count:"+String(self.roleList.count))
                    self.roleList.removeAll()
                    for document in querySnapshot!.documents{
                        let docId=document.documentID
                        let rolename=document.get("roleName") as! String
                        let quantity=document.get("roleQuantity") as! Int
                        if quantity>0{
                            self.roleList.append(TeamRoles(roleid: docId, rolename: rolename, rolequantity: quantity))
                        }
                    }
                }
                self.roleTV.reloadData()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(String(roleList.count))
        return roleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell=UITableViewCell()
        print("3")
        cell = tableView.dequeueReusableCell(withIdentifier: "RoleCell", for: indexPath)
        cell.textLabel!.text=roleList[indexPath.row].roleName
        cell.detailTextLabel!.text="Quantity needed: " + String(roleList[indexPath.row].roleQuantity)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roleTV.delegate=self
        roleTV.dataSource=self
        roleTV.reloadData()
        loadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alertView = UIAlertController(title: "Join Team?", message:nil, preferredStyle: UIAlertController.Style.alert)
        alertView.addTextField { (textField) in
            textField.placeholder = "In Game User ID"
        }
        alertView.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
        }))
        alertView.addAction(UIAlertAction(title: "Join", style: UIAlertAction.Style.default, handler: { _ in
            let dateformat = DateFormatter()
            dateformat.dateFormat = "dd/MM/yyyy"
            let date = dateformat.string(from: Date())
            guard let textFields = alertView.textFields else { return }
            let db = Firestore.firestore()
            db.collection("teamroles").addDocument(data: [
                "teamid": self.teamid,
                "roleid": self.roleList[indexPath.row].roleId,
                "userid":String(Auth.auth().currentUser!.uid),
                "uInGameID":textFields[0].text!,
                "roleName":self.roleList[indexPath.row].roleName,
                "joinedon":date
            ]) { [self] err in
                if let err = err {
                    let alertView = UIAlertController(title: "Unsuccessful Action", message: "Error: "+err.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    alertView.addAction(UIAlertAction(title: "Try again", style: UIAlertAction.Style.default, handler: { _ in
                    }))
                    self.present(alertView,animated: false,completion: nil)
                } else {
                    db.collection("roles").document(self.roleList[indexPath.row].roleId).setData([ "roleQuantity": self.roleList[indexPath.row].roleQuantity-1], merge: true)
                    print("success")
                    let storyboard=UIStoryboard(name: "ToMatcho", bundle: nil)
                    let vc=storyboard.instantiateViewController(withIdentifier: "ToMatchoMain") as UIViewController
                    self.view.window?.rootViewController=vc
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc,animated:true,completion: nil)
                }
            }
        }))
        self.present(alertView,animated: false,completion: nil)
    }
    
    
}
