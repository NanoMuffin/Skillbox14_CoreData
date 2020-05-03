//
//  ViewController.swift
//  Skillbox14_CoreData
//
//  Created by Александр Сорока on 03.05.2020.
//  Copyright © 2020 Александр Сорока. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

  
    var items: [NSManagedObject] = []
    @IBOutlet weak var tableVIew: UITableView!
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Items")
        
        do {
            items = try! context.fetch(fetchRequest)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    func saveData() {
        
        let alertController = UIAlertController.init(title: "Hello", message: "What's the plan?", preferredStyle: .alert)
        
        alertController.addTextField()
        
        func addToCoreData (item: String) {
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            
            let context = appDelegate.persistentContainer.viewContext
            
            guard let entity = NSEntityDescription.entity(forEntityName: "Items", in: context) else { return }
            
           let itemToAdd = NSManagedObject.init(entity: entity, insertInto: context)
            
            itemToAdd.setValue(item, forKey: "itemText")
            itemToAdd.setValue(false, forKey: "isCompleted")
            tableVIew.reloadData()
            
            do {
                try! context.save()
                items.append(itemToAdd) }
            catch let error as NSError {
                print("Error: \(error)")
            }
                    
                }
        
        
        let done = UIAlertAction.init(title: "Done", style: .cancel) { (action) in
            
            guard let textToSave = alertController.textFields?.last?.text else { return }
            
         addToCoreData(item: textToSave)
            self.tableVIew.reloadData()
            
        }
            
        let cancel = UIAlertAction.init(title: "Cancel", style: .default)
        
        alertController.addAction(done)
        alertController.addAction(cancel)
        
        self.present(alertController, animated: true)
            
        }
    
    func helpingThing() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        do {
        try! context.save() }
            catch let error as NSError {
            print("Error: \(error)")
                   }
    }
    
    
    @IBAction func addToDo(_ sender: Any) {
        saveData()
        tableVIew.reloadData()
    }
    
    
    }

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
//    MARK: TableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Header")
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let toDo = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell") as! ToDoTableViewCell
        cell.toDoItem.text = toDo.value(forKeyPath: "itemText") as! String
        
        if toDo.value(forKeyPath: "isCompleted") as! Bool == true {
            cell.accessoryType = .checkmark
        } else { cell.accessoryType = .none
            
        }
        
        return cell
        
    }
    
    //    MARK: TableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let toDo = items[indexPath.row]
        toDo.value(forKeyPath: "isCompleted") = ! toDo.value(forKeyPath: "isCompleted")
        
        
        
        
    }
    
}

