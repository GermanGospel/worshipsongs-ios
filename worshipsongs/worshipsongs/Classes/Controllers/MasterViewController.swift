//
//  MasterViewController.swift
//  worshipsongs
//
//  Created by Seenivasan Sankaran on 12/16/14.
//  Copyright (c) 2014 Seenivasan Sankaran. All rights reserved.
//

import Foundation

import UIKit

class MasterViewController: UITableViewController, UITableViewDataSource, UISearchBarDelegate  {
    
    var songTitles : NSMutableArray = []
    var songList = [SongModel]()
    var filteredSongList = [SongModel]()
    var dataCell: UITableViewCell?
    var mySearchBar: UISearchBar!
    
    override func viewDidLoad() {
        self.navigationItem.title = "Worship songs"
        
        self.songTitles = DatabaseHelper.instance.getTitles()
        for var index = 0; index < songTitles.count; index++ {
            self.songList.append(SongModel(title: songTitles[index] as String, lyrics: songTitles[index] as String))
        }
        
        var myFrame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y,
            self.view.bounds.size.width, 44);
        mySearchBar = UISearchBar(frame: myFrame)
    
        mySearchBar.delegate = self;
        mySearchBar.placeholder = "Search Songs"
        //display the cancel button next to the search bar
        mySearchBar.showsCancelButton = false;
        mySearchBar.tintColor = UIColor.grayColor()
        tableView.dataSource = self
        self.tableView.tableHeaderView = mySearchBar;
        
        // Reload the table
        self.tableView.reloadData()
    }
    
    // Return the number of sections
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView && filteredSongList.count > 0{
            return self.filteredSongList.count
        } else {
            return self.songList.count
        }
    }
    
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //ask for a reusable cell from the tableview, the tableview will create a new one if it doesn't have any
        var dataCell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("CELL_ID") as? UITableViewCell
        if(dataCell == nil)
        {
            dataCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CELL_ID")
        }
        var song : SongModel
        // Check to see whether the normal table or search results table is being displayed and set the Candy object from the appropriate array
        if tableView == self.tableView && filteredSongList.count > 0 {
            song = filteredSongList[indexPath.row]
        } else {
            song = songList[indexPath.row]
        }
        dataCell!.textLabel!.text = song.title
        return dataCell!
    }
    
    
    // MARK: UISearchBarDelegate
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        filterContentForSearchText(mySearchBar)
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentForSearchText(mySearchBar)
        self.tableView.reloadData()
    }
    
    func filterContentForSearchText(searchBar: UISearchBar) {
        // Filter the array using the filter method
        var searchText = searchBar.text
            self.filteredSongList = self.songList.filter({( song: SongModel) -> Bool in
            let stringMatch = song.title.rangeOfString(searchText)
            return (stringMatch != nil)
        })
    }
    
     override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        var welcomeMessage: String
//        let viewController = ViewController()
//        viewController.candies = candies
//       // viewController.candies = candies
//        self.navigationController?.presentViewController(viewController, animated: true, completion: nil)
    }

    
}