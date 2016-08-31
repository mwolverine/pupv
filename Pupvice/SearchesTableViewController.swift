//
//  SearchesTableViewController.swift
//  Pupvice
//
//  Created by Chris Yoo on 8/30/16.
//  Copyright © 2016 Chris Yoo. All rights reserved.
//


import UIKit

protocol SearchesTableViewControllerDelegate: class {
    func searchesController(controller: SearchesTableViewController, didSelectSearch Searches: [String])
}

class SearchesTableViewController: UITableViewController {
    
    let possibleSearchesDictionary = ["dog park":"Dog park"]
    var selectedSearches: [String]!
    weak var delegate: SearchesTableViewControllerDelegate!
    var sortedKeys: [String] {
        return possibleSearchesDictionary.keys.sort()
    }
    
    // MARK: - Actions
    @IBAction func donePressed(sender: AnyObject) {
        delegate?.searchesController(self, didSelectSearch: selectedSearches)
    }
    
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return possibleSearchesDictionary.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TypeCell", forIndexPath: indexPath)
        let key = sortedKeys[indexPath.row]
        let search = possibleSearchesDictionary[key]!
        cell.textLabel?.text = search
        cell.imageView?.image = UIImage(named: key)
        cell.accessoryType = (selectedSearches!).contains(key) ? .Checkmark : .None
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let key = sortedKeys[indexPath.row]
        if (selectedSearches!).contains(key) {
            selectedSearches = selectedSearches.filter({$0 != key})
        } else {
            selectedSearches.append(key)
        }
        
        tableView.reloadData()
    }
}
