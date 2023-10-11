//
//  ViewController.swift
//  coredata
//
//  Created by Imcrinox Mac on 26/12/1444 AH.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var items:[Detail]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tablesetup()
        fetchDetail()
        // Do any additional setup after loading the view.
    }

    func tablesetup() {
        table.delegate = self
        table.dataSource = self
        DispatchQueue.main.async {
            self.table.reloadData()
        }
    }

    func fetchDetail()
    {
        do {
            self.items = try context.fetch(Detail.fetchRequest())
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
        catch {
            
        }
    }

    @IBAction func btnTapped (_ sender: Any) {
        let alert = UIAlertController(title: "Add Person", message: "what is their name ? ", preferredStyle: .alert)
        alert.addTextField()
        alert.addTextField()
        
        let submitButton = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let nameTextField = alert.textFields![0]
            let positionTextField = alert.textFields![1]
            
            let newPerson = Detail(context: self.context)
            newPerson.name = nameTextField.text
            newPerson.position = positionTextField.text
//            newPerson.age = 30
            newPerson.salary = 30000
            
            do {
                try self.context.save()
            }
            catch{
                
            }
            self.fetchDetail()
        }
        
        
        alert .addAction(submitButton)
    
        self.present(alert, animated: true, completion: nil)
    
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let person = self.items![indexPath.row]
        cell.textLabel?.text = person.name
        cell.detailTextLabel?.text = person.position
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = self.items![indexPath.row]
    
        let alert = UIAlertController(title: "Edit", message: "edit name: ", preferredStyle: .alert)
        alert .addTextField()
        alert .addTextField()
        
        let  nameTextField = alert.textFields![0]
        let  positionTextField = alert .textFields![1]
        
        nameTextField.text = person.name
        positionTextField.text = person.position
        
        let saveButton = UIAlertAction(title: "Save", style: .default) {
            (action) in
            
            let nameTextField = alert.textFields![0]
            let positionTextField = alert.textFields![1]
            
            person.name = nameTextField.text
            person.position = positionTextField.text
            
            do {
                try self.context.save()
                

            }
            catch{
                
                
            }
            self.fetchDetail()
        }
        alert.addAction(saveButton)
        
        self.present(alert, animated: true, completion:  nil)
        
        }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteaction = UIContextualAction(style: .destructive, title: "Delete") { (action , view, completionHandler) in
            
            let personToRemove = self.items![indexPath.row]
            self.context.delete(personToRemove)
            completionHandler(true)
            do {
                try self.context.save()
            }
            catch {
                
            }
        }
        deleteaction.backgroundColor = UIColor.cyan
        let configuration = UISwipeActionsConfiguration(actions: [deleteaction])
        configuration.performsFirstActionWithFullSwipe = true
        return UISwipeActionsConfiguration(actions: [deleteaction])
        }
}
