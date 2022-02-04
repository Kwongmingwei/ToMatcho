//
//  MyTeamsDetailViewController.swift
//  ToMatcho
//
//  Created by Kwong Ming Wei on 30/1/22.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore

class MyTeamsDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var lblTName: UILabel!
    
    @IBOutlet weak var lblTDesc: UILabel!
    
    @IBOutlet weak var memberTV: UITableView!
    var teamid:String=""
    
    var memberList:[TeamMembers]=[]
    
    func loadData(){
        if (teamid != ""){
            let docRef = Firestore.firestore().collection("teams").document(teamid)

            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    self.lblTName.text=document.get("teamName") as? String
                    self.lblTDesc.text=document.get("teamDescription") as? String
                } else {
                    print("Document does not exist")
                }
            }
            
            Firestore.firestore().collection("teamroles").whereField("teamid", isEqualTo: teamid).getDocuments() {(querySnapshot,err) in
                if err == nil{
                    self.memberList.removeAll()
                    for document in querySnapshot!.documents{
                        let rolename=document.get("roleName") as! String
                        let gameuserid=document.get("uInGameID") as! String
                        self.memberList.append(TeamMembers(gameuid: gameuserid,rolename:rolename))
                    }
                }
                self.memberTV.reloadData()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(String(memberList.count))
        return memberList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell=UITableViewCell()
        print("3")
        cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath)
        cell.textLabel!.text=memberList[indexPath.row].gameUid
        cell.detailTextLabel!.text = "Role: "+memberList[indexPath.row].roleName
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memberTV.delegate=self
        memberTV.dataSource=self
        memberTV.reloadData()
        loadData()
    }
    
    
}
