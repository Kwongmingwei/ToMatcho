//
//  TeamRolesController.swift
//  ToMatcho
//
//  Created by Letricia Thio on 26/1/22.
//

import Foundation
import UIKit
import CoreData

//Contact CRUD
class TeamRolesController{
    //Add new contact to Core Data
    func AddTeamRoles(newTeamRoles:TeamRoles)
    {
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "CDRole", in: context)!
        
        let person = NSManagedObject(entity: entity, insertInto: context)
        person.setValue(newTeamRoles.roleName, forKeyPath: "rolename")
        person.setValue(newTeamRoles.roleQuantity, forKeyPath: "rolequantity")
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // Retrieve all contact from Core Data
    func retrieveAllTeamRoles()->[TeamRoles]
    {
        var managedteamRolesList:[NSManagedObject] = []
        var teamRolesList:[TeamRoles] = []
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDRole")
        do {
            managedteamRolesList = try context.fetch(fetchRequest)
            for t in managedteamRolesList {
                let rolename = t.value(forKeyPath: "rolename") as! String
                let rolequantity = t.value(forKeyPath: "rolequantity") as! String
                let teamroles:TeamRoles = TeamRoles(roleid:"",rolename: rolename, rolequantity: Int(rolequantity)!)
                teamRolesList.append(teamroles)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error) \(error.userInfo)")
        }
        
        return teamRolesList
    }
    
    // Update current contact with new contact
    // fetch data based on mobileno
    
    /*func updateContact(mobileno:String, newContact:Contact)
    {
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDContact")
        
        fetchRequest.predicate = NSPredicate(format: "mobileno == %@", mobileno)
        do {
            let results = try context.fetch(fetchRequest)
            for obj in results{
                obj.setValue(newContact.firstName, forKeyPath: "firstname")
                obj.setValue(newContact.lastName, forKeyPath: "lastname")
                obj.setValue(newContact.mobileNo, forKeyPath: "mobileno")
            }
        }catch let error as NSError{
            print("Could not retrieve. \(error), \(error.userInfo)")
        }
        do {
            try context.save()
        }catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
    }*/
    
    // Delete contact
    // fetch data based on mobileno
    func deleteContact(mobileno:String)
    {
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDContact")
        fetchRequest.predicate = NSPredicate(format: "mobileno == %@", mobileno)
        do {
            let results = try context.fetch(fetchRequest)
            for obj in results{
                context.delete(obj)
            }
        }catch let error as NSError{
            print("Could not retrieve. \(error), \(error.userInfo)")
        }
        do {
            try context.save()
        }catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
