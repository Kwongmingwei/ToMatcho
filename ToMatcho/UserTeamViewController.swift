//
//  UserTeamViewController.swift
//  ToMatcho
//
//  Created by Kwong Ming Wei on 29/1/22.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class UserTeamViewController: UITableViewController {
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var myteamsList:[Teams]=[]
    var userid = Auth.auth().currentUser?.uid
    
    
    func loadData(){
        Firestore.firestore().collection("teams").whereField("gameID", isEqualTo: appDelegate.gameID).getDocuments() {(querySnapshot,err) in
            if err == nil{
                print("b4 myteams count:"+String(self.myteamsList.count))
                self.myteamsList.removeAll()
                for document in querySnapshot!.documents{
                    let docId=document.documentID
                    let teamname=document.get("teamName") as! String
                    let gameid = document.get("gameID") as! String
                    let teamdesc = document.get("teamDescription") as! String
                    let createdby = document.get("createdBy") as! String
                    let createdDate = document.get("createdDate") as! String
                    let ownerstatus = document.get("ownerStatus") as! String
                    //let developer=document.get("developer") as! String
                    //self.gameList.append(Game(gamename: gamename, gameId: docId,gameDev: developer))
                    self.myteamsList.append(Teams(teamname: teamname, teamid: docId, teamdesc: teamdesc, gameid: gameid, createdby: createdby, createddate: createdDate, ownerstatus: ownerstatus))
                }
            }
            print("myteams count:"+String(self.myteamsList.count))
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        super.viewDidLoad()
        
        loadData()
        //tableView.reloadData()
    }
    
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myteamsList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=self.tableView.dequeueReusableCell(withIdentifier: "UserTeamCell", for: indexPath)
        let team=myteamsList[indexPath.row]
        //cell.textLabel!.textColor = UIColor.white
        cell.textLabel!.text = "\(team.teamName)"
        cell.detailTextLabel!.text = "Created On \(team.createdDate)"
        //cell.detailTextLabel!.textColor = UIColor.white
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle:
        UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc=storyboard?.instantiateViewController(withIdentifier: "JoinTeam") as? RoleSelectViewController{
            vc.teamid=myteamsList[indexPath.row].teamId
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
