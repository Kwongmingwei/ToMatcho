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

class MyTeamsViewController: UITableViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        //loadData()
        tableView.reloadData()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return appDelegate.gameList.count
        return 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=self.tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath)
        /*let game=appDelegate.gameList[indexPath.row]
        cell.textLabel!.textColor = UIColor.white
        cell.textLabel!.text = "\(game.gameName)"
        print("gamelist count:"+game.gameName)
        print("gamelist count:"+game.gameid)
        cell.detailTextLabel!.text = "\(game.gameid)"
        cell.detailTextLabel!.textColor = UIColor.white*/
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle:
        UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
        }
    }
}
