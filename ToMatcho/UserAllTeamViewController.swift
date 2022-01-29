//
//  UserAllTeamViewController.swift
//  ToMatcho
//
//  Created by Ho Jun An on 29/1/22.
//

import UIKit
import Foundation
import Firebase
import FirebaseFirestore

class UserAllTeamViewController: UITableViewController {
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func loadData(){
        Firestore.firestore().collection("teams").getDocuments() {(querySnapshot,err) in
            if err == nil{
                self.appDelegate.teamList.removeAll()
                for document in querySnapshot!.documents{
                    let teamName = document.get("teamName") as! String
                    let docId = document.documentID
                    let teamDesc = document.get("teamDescription") as! String
                    var gameId = document.get("gameID") as! String
                    var createdBy = document.get("createdBy") as! String
                    var createdDate = document.get("createdDate") as! String
                    
                    self.appDelegate.teamList.append(Teams(teamname: teamName, teamid: docId, teamdesc: teamDesc, gameid: gameId, createdby: createdBy, createddate: createdDate))
                }
            }
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.reloadData()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.gameList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "UserTeamCell", for: indexPath)
        let team = appDelegate.teamList[indexPath.row]
        cell.textLabel!.text = "\(team.teamName)"
        cell.detailTextLabel?.text = "\(team.teamDesc)"
        return cell
    }
}
