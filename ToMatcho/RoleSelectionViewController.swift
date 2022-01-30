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
                        //self.gameList.append(Game(gamename: gamename, gameId: docId,gameDev: developer))
                        self.roleList.append(TeamRoles(roleid: docId, rolename: rolename, rolequantity: quantity))
                    }
                }
                
                self.roleTV.reloadData()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tv")
        return roleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell=UITableViewCell()
        print("3")
        cell = tableView.dequeueReusableCell(withIdentifier: "RoleCell", for: indexPath)
        cell.textLabel!.text=roleList[indexPath.row].roleName
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamid = appDelegate.teamID
        roleTV.delegate=self
        roleTV.dataSource=self
        roleTV.reloadData()
        loadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc=storyboard?.instantiateViewController(withIdentifier: "TestView") as? TestViewController{
            vc.roleid = roleList[indexPath.row].roleId
            vc.rolename = roleList[indexPath.row].roleName
            vc.teamid = teamid
            vc.uid=String(Auth.auth().currentUser!.uid)
            vc.quantity=roleList[indexPath.row].roleQuantity
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
