//
//  DagensTableViewController.swift
//  Applitude
//
//  Created by Anders Orset on 12.02.2016.
//  Copyright © 2016 Applitude. All rights reserved.
//
//  The app's main view.
//
//  Detailed explanation of the cell expansion/contraction: stackoverflow.com/a/29851944.
//

import UIKit

class DagensTableViewController: UITableViewController {
    
    // Keeps track of which cell, if any, is currently expanded
    private var expandedIndexPath: NSIndexPath?
    
    // MARK: View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        // Register to receive notifications that we'll post when the dishes collection is updated
        NSNotificationCenter.defaultCenter().addObserver(tableView, selector: #selector(UITableView.reloadData), name: "dishesUpdated", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.sharedInstance.getNumberOfDishes()
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("dagensCell", forIndexPath: indexPath) as! DagensTableViewCell

        // Configure the cell...
        cell.loadCell(DataManager.sharedInstance.getDishAtIndex(indexPath.row))

        return cell
    }
    
    // MARK: Table view delegate (manages cell expansion/contraction)
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // if: User selected expanded cell
        if expandedIndexPath == indexPath {
            expandedIndexPath = nil
        } else {
            expandedIndexPath = indexPath
        }
        
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let contractedHeight: CGFloat = 115
        let expandedHeight: CGFloat = 300

        return indexPath == expandedIndexPath ? expandedHeight : contractedHeight
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
