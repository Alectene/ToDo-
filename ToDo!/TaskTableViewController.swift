//
//  TaskTableViewController.swift
//  ToDo!
//
//  Created by Alec Tenefrancia on 4/22/20.
//  Copyright © 2020 Alec Tenefrancia. All rights reserved.
//

import UIKit
import os.log

class TaskTableViewController: UITableViewController {

    //Properties
    
    var tasks = [Task]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //adds edit button
        navigationItem.leftBarButtonItem = editButtonItem
        //loads saved tasks, otherwise load sample data
        if let savedTasks = loadTasks(){
            
            tasks += savedTasks
            
        }else{
        //load Sample Data
        loadSampleTasks()
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

       // Table view cells are reused and should be dequeued using a cell identifier.
          let cellIdentifier = "TaskTableViewCell"
          
          guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TaskTableViewCell  else {
              fatalError("The dequeued cell is not an instance of MealTableViewCell.")
          }
          
          // Fetches the appropriate meal for the data source layout.
          let task = tasks[indexPath.row]
          
          cell.nameLabel.text = task.name
          cell.photoImageView.image = task.photo
          
          
          
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tasks.remove(at: indexPath.row)
            saveTasks()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

     //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? ""){
            
            case "AddItem":
                os_log("Adding a new task.", log: OSLog.default, type: .debug)
                
            case "ShowDetail":
                guard let taskDetailViewController = segue.destination as? TaskViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
                
                guard let selectedTaskCell = sender as? TaskTableViewCell else {
                    fatalError("Unexpected sender: \(sender)")
                }
                
                guard let indexPath = tableView.indexPath(for: selectedTaskCell) else {
                    fatalError("The selected cell is not being displayed by the table")
                }
                
                let selectedTask = tasks[indexPath.row]
                taskDetailViewController.task = selectedTask
                
            default:
                fatalError("Unexpected Segue Identifier; \(segue.identifier)")
            }
        
    }
    
    //Actions
    
    @IBAction func unwindToTaskList(sender: UIStoryboardSegue){
        
        if let sourceViewController = sender.source as? TaskViewController, let task = sourceViewController.task {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                tasks[selectedIndexPath.row] = task
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
            
           // Add a new meal.
           let newIndexPath = IndexPath(row: tasks.count, section: 0)
            
            tasks.append(task)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
        }
        saveTasks()
        
    }
    }//end func unwindToTaskList

    //Private methods
    private func loadSampleTasks(){
        
        let photo1 = UIImage(named: "task1")
        
         guard let task1 = Task(name: "Bench Press Later", photo: photo1) else {
            fatalError("Unable to instantiate meal1")
        }
        
        tasks += [task1]
        
    }// end func loadSampleTasks
    
    private func saveTasks(){
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(tasks, toFile: Task.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("tasks successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save task...", log: OSLog.default, type: .error)
        }
        
    }//end func saveTasks
    
   private func loadTasks() -> [Task]?  {
       return NSKeyedUnarchiver.unarchiveObject(withFile: Task.ArchiveURL.path) as? [Task]
   }//end func loadTasks
    
    
    
}
