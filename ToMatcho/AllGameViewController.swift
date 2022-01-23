//
//  AllGameViewController.swift
//  ToMatcho
//
//  Created by Kwong Ming Wei on 23/1/22.
//

import UIKit
import Foundation
import Firebase
import FirebaseFirestore

class AllGameViewController: UITableViewController {
    var gameList:[Game]=[]
    
    func loadData(){
        gameList.removeAll()
        Firestore.firestore().collection("games").getDocuments() {(querySnapshot,err) in
            if err == nil{
                for document in querySnapshot!.documents{
                    let docId=document.documentID
                    let gamename=document.get("name") as! String
                    self.gameList.append(Game(gamename: gamename, gameId: docId))
                }
            }
            print("gamelist count:"+String(self.gameList.count))
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(gameList.count)
        return gameList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=self.tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath)
        let game=gameList[indexPath.row]
        cell.textLabel!.text = "\(game.gameName)"
        cell.detailTextLabel!.text = "\(game.gameid)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle:
        UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
        }
    }
    
    
}
