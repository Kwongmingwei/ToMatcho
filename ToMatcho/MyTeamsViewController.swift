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
    
    func loadData(){
        Firestore.firestore().collection("teams").whereField("createdBy", isEqualTo: userid!).getDocuments() {(querySnapshot,err) in
            if err == nil{
                print("b4 myteams count:"+String(self.myteamsList.count))
                self.myteamsList.removeAll()
                for document in querySnapshot!.documents{
                    print("+1")
                    let docId=document.documentID
                    let teamname=document.get("teamName") as! String
                    let gameid = document.get("gameID") as! String
                    let teamdesc = document.get("teamDescription") as! String
                    let createdby = document.get("createdBy") as! String
                    let createdDate = document.get("createdDate") as! String
                    //let developer=document.get("developer") as! String
                    //self.gameList.append(Game(gamename: gamename, gameId: docId,gameDev: developer))
                    self.myteamsList.append(Teams(teamname: teamname, teamid: docId, teamdesc: teamdesc, gameid: gameid, createdby: createdby, createddate: createdDate, ownerstatus: ""))
                }
            }
            print("myteams count:"+String(self.myteamsList.count))
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
    }
    
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myteamsList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=self.tableView.dequeueReusableCell(withIdentifier: "MyTeamCell", for: indexPath)
        let team=myteamsList[indexPath.row]
        cell.textLabel!.textColor = UIColor.white
        cell.textLabel!.text = "\(team.teamName)"
        cell.detailTextLabel!.text = "Created On \(team.createdDate)"
        cell.detailTextLabel!.textColor = UIColor.white
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
            deleteIt(teamId: teamid)
            myteamsList.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
}
