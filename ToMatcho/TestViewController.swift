//
//  TestViewController.swift
//  ToMatcho
//
//  Created by Kwong Ming Wei on 18/1/22.
//

import Foundation

import UIKit

class TestViewController: UIViewController {
    
    var teamid:String=""
    
    var rolename:String=""
    
    var roleid:String=""
    
    @IBOutlet weak var teamidtxt: UILabel!
    
    @IBOutlet weak var rolenametxt: UILabel!
    
    @IBOutlet weak var roleidtxt: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamidtxt.text=teamid
        rolenametxt.text=rolename
        roleidtxt.text=roleid
    }
}
