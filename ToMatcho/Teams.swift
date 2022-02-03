//
//  Teams.swift
//  ToMatcho
//
//  Created by Kwong Ming Wei on 29/1/22.
//

import Foundation

class Teams{
    var teamName:String
    var teamId:String
    var teamDesc:String
    var gameId:String
    var createdBy:String
    var createdDate:String
    
    init(teamname:String,teamid:String,teamdesc:String,gameid:String,createdby:String,createddate:String) {
        teamName = teamname
        teamId = teamid
        teamDesc = teamdesc
        gameId=gameid
        createdBy=createdby
        createdDate=createddate
    }
}
