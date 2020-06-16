//
//  ViewController.swift
//  T_Estes_DataSaveApp
//
//  Created by Tracy Estes on 6/16/20.
//  Copyright © 2020 Tracy Estes. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class ViewController: UIViewController {
    var dataManager: NSManagedObjectContext!
    var listArray = [NSManagedObject]()
    
    @IBOutlet var dataTextField: UITextField!
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBAction func saveButton(_ sender: Any) {
        let newEntity = NSEntityDescription.insertNewObject(forEntityName:"Item", into: dataManager)
        newEntity.setValue(dataTextField.text!, forKey: "name")
        do {
            try self.dataManager.save()
            listArray.append(newEntity)
        } catch {
            print ("Error saving data")
        }
        nameLabel.text?.removeAll()
        dataTextField.text?.removeAll()
        fetchData()
    }
    
   
    @IBAction func deleteButton(_ sender: Any) {
        let deleteItem = dataTextField.text!
        for item in listArray {
            if item.value(forKey: "name") as! String == deleteItem {
                dataManager.delete(item)
            }
            do {
                try self.dataManager.save()
            } catch {
                print ("Error deleting data")
            }
            nameLabel.text?.removeAll()
            dataTextField.text?.removeAll()
            fetchData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        dataManager = appDelegate.persistentContainer.viewContext
        nameLabel.text?.removeAll()
        fetchData()
    }
    
    func fetchData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Item")
        do {
            let result = try dataManager.fetch(fetchRequest)
            listArray = result as! [NSManagedObject]
            for item in listArray {
                let product = item.value(forKey: "name") as! String
                nameLabel.text! += product
            }
        } catch {
            print ("Error retrieving data")
        }
    }
}
   



