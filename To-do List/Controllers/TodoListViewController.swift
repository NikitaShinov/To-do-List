//
//  ViewController.swift
//  To-do List
//
//  Created by max on 23.01.2022.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadItems()
        
//        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
//            itemArray = items
//        }
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
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: - IBActions
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Add item", style: .default) { action in
            //What will happen after user taps to add
            guard let newTask = textField.text else { return }
            let newItem = Item()
            newItem.name = newTask
            
            self.itemArray.append(newItem)
            
            self.saveItems()
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems () {
        let encoder = PropertyListEncoder()
        
        
        do {
            let data = try encoder.encode(itemArray)
            guard let filePath = dataFilePath else { return }
            try data.write(to: filePath)
        } catch {
            print("Error, \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItems() {
        guard let filePath = dataFilePath else { return }
        if let data = try? Data(contentsOf: filePath) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print ("Error, \(error)")
            }
            
        }
    }
    
}

