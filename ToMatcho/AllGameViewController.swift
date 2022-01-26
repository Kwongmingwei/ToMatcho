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
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //var gameList:[Game]=[]
    
    func loadData(){
        Firestore.firestore().collection("games").getDocuments() {(querySnapshot,err) in
            if err == nil{
                print("b4 gamelist count:"+String(self.appDelegate.gameList.count))
                //self.gameList.removeAll()
                self.appDelegate.gameList.removeAll()
                for document in querySnapshot!.documents{
                    let docId=document.documentID
                    let gamename=document.get("name") as! String
                    let developer=document.get("developer") as! String
                    //self.gameList.append(Game(gamename: gamename, gameId: docId,gameDev: developer))
                    self.appDelegate.gameList.append(Game(gamename: gamename, gameId: docId,gameDev: developer))
                }
            }
            print("gamelist count:"+String(self.appDelegate.gameList.count))
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
        let cell=self.tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath)
        let game=appDelegate.gameList[indexPath.row]
        cell.textLabel!.text = "\(game.gameName)"
        print("gamelist count:"+game.gameName)
        print("gamelist count:"+game.gameid)
        cell.detailTextLabel!.text = "\(game.gameid)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle:
        UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
        }
    }
    
    @IBAction func addBtn(_ sender: Any) {
        let storyboard=UIStoryboard(name: "Admin", bundle: nil)
        let vc=storyboard.instantiateViewController(withIdentifier: "AddGame") as UIViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc,animated:true,completion: nil)
    }
    
}
