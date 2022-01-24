//
//  ViewController.swift
//  To-do List
//
//  Created by max on 23.01.2022.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let newItem = Item()
        newItem.name = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.name = "Find Stan"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.name = "Find Bill"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            itemArray = items
        }
    }
    
    //MARK: - Tableview Datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.name
        
        cell.accessoryType = item.isDone ? .checkmark : .none
        
        return cell
    }
    //MARK: - Tableview Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].isDone = !itemArray[indexPath.row].isDone
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: - IBActions
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Add item", style: .default) { [weak self] action in
            //What will happen after user taps to add
            guard let newTask = textField.text else { return }
            let newItem = Item()
            newItem.name = newTask
            
            self?.itemArray.append(newItem)
            
            self?.defaults.set(self?.itemArray, forKey: "ToDoListArray")
            
            self?.tableView.reloadData()
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(addAction)
        present(alert, animated: true, completion: nil)
    }
    
}
