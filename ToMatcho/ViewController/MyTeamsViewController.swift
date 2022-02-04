//
//  MyTeamsViewController.swift
//  ToMatcho
//
//  Created by Kwong Ming Wei on 29/1/22.
//

import UIKit
import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

class MyTeamsViewController: UITableViewController {
    
    var myteamsList:[Teams]=[]
    var userid = Auth.auth().currentUser?.uid
    
    func TeamExist(teamid:String,list:[Teams])->Int {

            for t in list {
                let id = t.teamId
                if (id == teamid) {
                    return 1
                }
            }
        return 0
    }
        
    func loadData(){
        myteamsList.removeAll()
        Firestore.firestore().collection("teamroles").whereField("userid", isEqualTo: userid!).getDocuments() {(querySnapshot,err) in
            if err == nil{
                //print("b4 myteams count:"+String(self.myteamsList.count))
                for document in querySnapshot!.documents{
                    //print("+1")
                    let teamid=document.get("teamid") as! String
                    print(String(teamid))
                    Firestore.firestore().collection("teams").document(teamid).getDocument { [self] (document, error) in
                        if let document = document, document.exists {
                            let teamname = document.get("teamName") as! String
                            let teamdesc = document.get("teamDescription") as! String
                            let gameid = document.get("gameID") as! String
                            let createdby = document.get("createdBy") as! String
                            let createdDate = document.get("createdDate") as! String
                            print ("added")
                            let exist = TeamExist(teamid: teamid, list: self.myteamsList)
                            if (exist==0){
                                self.myteamsList.append(Teams(teamname: teamname, teamid: teamid, teamdesc: teamdesc, gameid: gameid, createdby: createdby, createddate: createdDate))
                            }
                            
                            print("teamciunt" + String(self.myteamsList.count))
                            self.tableView.reloadData()
                            print("reload data1")
                        } else {
                            print("Document does not exist")
                        }
                    }
                }
                
                self.tableView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
        self.tableView.reloadData()
        print("reload data2")
        
        
    }
    
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tv count" + String(myteamsList.count))
        return myteamsList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "MyTeamCell", for: indexPath)
        let team=myteamsList[indexPath.row]
        cell.textLabel!.textColor = UIColor.white
        cell.textLabel!.text = "\(team.teamName)"
        cell.detailTextLabel!.text = "Created On \(team.createdDate)"
        cell.detailTextLabel!.textColor = UIColor.white
        print("Cell")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc=storyboard?.instantiateViewController(withIdentifier: "TeamDetails") as? MyTeamsDetailViewController{
            vc.teamid = myteamsList[indexPath.row].teamId
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func deleteIt(teamId:String){
        Firestore.firestore().collection("teamroles").whereField("teamid", isEqualTo: teamId).getDocuments() {(querySnapshot,err) in
            if err == nil{
                for document in querySnapshot!.documents{
                    print("have docs")
                    let id=String(document.documentID)
                    Firestore.firestore().collection("teamroles").document(id).delete() { err in
                        if let err = err {
                            print("Error removing document: \(err)")
                        } else {
                            print("Document successfully removed!")
                        }
                    }
                }
            }
        }
        
        Firestore.firestore().collection("roles").whereField("teamID", isEqualTo: teamId).getDocuments() {(querySnapshot,err) in
            if err == nil{
                for document in querySnapshot!.documents{
                    print("have docs")
                    let id=String(document.documentID)
                    print(id)
                    Firestore.firestore().collection("roles").document(id).delete() { err in
                        if let err = err {
                            print("Error removing document: \(err)")
                        } else {
                            print("Document successfully removed!")
                        }
                    }
                }
            }
        }
        
        Firestore.firestore().collection("teams").document(teamId).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle:
        UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let teamid=String(myteamsList[indexPath.row].teamId)
            let teamowner = String(myteamsList[indexPath.row].createdBy)
            if (teamowner == self.userid){
                let alertView = UIAlertController(title: "Delete team", message: "Deleting team will delete it forever. Are you sure?", preferredStyle: UIAlertController.Style.alert)
                alertView.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
                }))
                alertView.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.default, handler: { _ in
                    self.deleteIt(teamId: teamid)
                    self.loadData()
                    self.tableView.reloadData()
                }))
                self.present(alertView,animated: false,completion: nil)
            }
            else{
                let alertView = UIAlertController(title: "Error!", message: "Error: "+"You do not have permission to delete this team", preferredStyle: UIAlertController.Style.alert)
                alertView.addAction(UIAlertAction(title: "Return", style: UIAlertAction.Style.default, handler: { _ in
                }))
                self.present(alertView,animated: false,completion: nil)
            }
            
        }
    }
}
