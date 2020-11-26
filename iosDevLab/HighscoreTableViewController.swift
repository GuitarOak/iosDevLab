//
//  HighscoreTableViewController.swift
//  iosDevLab
//
//  Created by Emil Karlsson on 2020-11-26.
//

import UIKit
import CoreData

class HighscoreTableViewController: UITableViewController {

    var fetchedResultsController: NSFetchedResultsController<GameResult>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "highscoreIdentifier")
        setupFetchedResultsController()
    }

    private func setupFetchedResultsController() {
        // Refactor the setup of the NSFetchedResultsController into GameResultDatabaseManager
        let managedObjectContext = DatabaseManager.shared.managedObjectContext
        
        let request = NSFetchRequest<GameResult>(entityName: "GameResult")
        let dataSort = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [dataSort]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        do{
            try fetchedResultsController.performFetch()
        }catch{
            fatalError("Failed to initialize fetchedResultsController")
        }
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "highscoreIdentifier", for: indexPath)

        let gameResult = fetchedResultsController.object(at: indexPath)
        cell.textLabel?.text = "Out of \(gameResult.numberOfQuestions) you answered \(gameResult.rightAnswers) right!"
        
        return cell
    }
 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Table view delegate

extension HighscoreTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected this row: \(indexPath.row)")
    }
    
}
