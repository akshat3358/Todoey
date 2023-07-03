import UIKit

class TodoListViewController: UITableViewController {

    var itemArray : [Item] = [Item]()
    
    
    //var itemArray = ["Buy Eggs","Buy Sleepers","Buy Mug","Buy Basket","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p"]
//    let defaults = UserDefaults.standard
    
    //we are just creating data file path to document folder
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //will check this later
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
        
        //now we just hardcoded  multiple object of our model class and added that into our array
        let newItem = Item()
        newItem.title="Find Kohli"
        itemArray.append(newItem)
        
    }

    //Mark - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //Mark - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //toggling the done value of that particular cell
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        self.saveItems()
       
        //To show the cell is being clicked
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Mark - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let newItem = Item()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen once the user clicks the Add Item button  on our UIAlert
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.saveItems()
            //now we won't  use this userdefault metthod as we are using encoder to store custom item objects
            
            //self.defaults.set(self.itemArray, forKey: "TodoListArray")
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder="Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
        } catch {
            print("Error encoding item array,\(error)")
        }
        
        self.tableView.reloadData()
    }
    
}

