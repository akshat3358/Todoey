import UIKit

class TodoListViewController: UITableViewController {

    var itemArray : [Item] = [Item]()
    
    
    //var itemArray = ["Buy Eggs","Buy Sleepers","Buy Mug","Buy Basket","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p"]
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
        
        //now we just hardcoded  multiple object of our model class and added that into our array
        let newItem = Item()
        newItem.title="Find Kohli"
        itemArray.append(newItem)
        
        let newItem1 = Item()
        newItem1.title="Find Rohit"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title="Find Jadeja"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title="Find Ajay"
        itemArray.append(newItem3)
        
        let newItem4 = Item()
        newItem4.title="Find Shami"
        itemArray.append(newItem4)
        
        let newItem5 = Item()
        newItem5.title="Find Ramesh"
        itemArray.append(newItem5)
        
        let newItem6 = Item()
        newItem6.title="Find KK"
        itemArray.append(newItem6)
        
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
        
       
        //We are reloading the tableView so that It can call its data source method to populate the latest data into cells after the didselectrowat method called
        tableView.reloadData()
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
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder="Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

