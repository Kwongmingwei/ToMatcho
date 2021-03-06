//
//  UserAllGameViewController.swift
//  ToMatcho
//
//  Created by Letricia Thio on 26/1/22.
//
import UIKit
import Foundation
import Firebase
import FirebaseFirestore
import SwiftUI

class UserAllGameViewController: UITableViewController {
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
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        if let promptClass = NSClassFromString("_UINavigationBarModernPromptView") as? UIAppearanceContainer.Type
        {
          UILabel.appearance(whenContainedInInstancesOf: [promptClass]).textColor = UIColor.white
        }
        navigationItem.prompt = NSLocalizedString("Navigation prompts appear at the top.", comment: "")
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
        let cell=self.tableView.dequeueReusableCell(withIdentifier: "UserGameCell", for: indexPath)
        let game=appDelegate.gameList[indexPath.row]
        cell.textLabel!.text = "\(game.gameName)"
        print("gamelist count:"+game.gameName)
        print("gamelist count:"+game.gameid)
        cell.detailTextLabel?.text = "\(game.gameid)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        appDelegate.gameID = appDelegate.gameList[indexPath.row].gameid
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        do {
          try Auth.auth().signOut()
            let storyboard=UIStoryboard(name: "Main", bundle: nil)
            let vc=storyboard.instantiateViewController(withIdentifier: "MainInitialVC") as UIViewController
            self.view.window?.rootViewController=vc
            vc.modalPresentationStyle = .fullScreen
            self.present(vc,animated:true,completion: nil)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    

}
