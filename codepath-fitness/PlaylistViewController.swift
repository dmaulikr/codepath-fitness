//
//  PlaylistViewController.swift
//  codepath-fitness
//
//  Created by Patrick on 6/10/15.
//  Copyright (c) 2015 PPK Inc. All rights reserved.
//

import UIKit

class PlaylistViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var playlistTableView: UITableView!
    
    // Declare parent exercise array
    var exerciseArray: NSArray! = []

    // Declare individual exercise dictionaries
    var pullUpDict = [
        "name" : "Pull-ups", 
        "intensity" : "low", 
        "duration" : "5", 
        "description" : "Pull yourself up over the bar!"]
    var sitUpDict = [
        "name" : "Sit-ups", 
        "intensity" : "medium", 
        "duration" : "3", 
        "description" : "Bend your knees and sit up!"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup initial tableView
        playlistTableView.delegate = self
        playlistTableView.dataSource = self
        
        // API url
        var clientId = "BpmHUyPDIDaWYqoSL5rTcj27ryCj9N29"
        var fitnessApiUrl = NSURL(string: "https://www.kimonolabs.com/api/bfcfz33q?apikey=\(clientId)")!
        
        // Add exercises to an array
        exerciseArray = [pullUpDict, sitUpDict]
        
        var request = NSURLRequest(URL: fitnessApiUrl)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
            (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var responseDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary
            // println(responseDictionary)
            // self.exerciseArray = responseDictionary["results"] as! NSArray
            // println(self.exerciseArray)
            // self.playlistTableView.reloadData()
        }
        
    }
    
    // View for the cell in the TableView
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Define exerciseCell
        var cell = playlistTableView.dequeueReusableCellWithIdentifier("ExerciseCell") as! ExerciseCell
        
        // var exercise = exerciseArray[indexPath.row] as! NSDictionary
        // var exerciseName = exercise.valueForKeyPath("Collection1.Exercise Name.text") as? String
        
        // Populate exerciseCell
        cell.exerciseLabel.text = exerciseArray[indexPath.row]["name"] as? String
        cell.durationLabel.text = exerciseArray[indexPath.row]["duration"] as? String
        cell.intensityLabel.text = exerciseArray[indexPath.row]["intensity"] as? String
        
        return cell
    }
    
    // How many rows in TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseArray.count
        // return 20
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
