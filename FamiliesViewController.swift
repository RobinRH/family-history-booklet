//
//  MasterViewController.swift
//  FamilyPhone
//
//  Created by Robin Reynolds on 6/27/15.
//  Copyright (c) 2015 Robin Reynolds. All rights reserved.
//

import UIKit

class FamiliesViewController: UITableViewController {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //FamilyTree.loadFamilies()
    }

    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                switch (indexPath.row) {
                case 0: FamilyTree.selectedPerson = FamilyTree.me
                case 1: FamilyTree.selectedFamily = FamilyTree.parents
                case 2: FamilyTree.selectedFamily = FamilyTree.grandParentsFather
                case 3: FamilyTree.selectedFamily = FamilyTree.grandParentsMother
                case 4: FamilyTree.selectedFamily = FamilyTree.greatGrandParentsFatherFather
                case 5: FamilyTree.selectedFamily = FamilyTree.greatGrandParentsFatherMother
                case 6: FamilyTree.selectedFamily = FamilyTree.greatGrandParentsMotherFather
                case 7: FamilyTree.selectedFamily = FamilyTree.greatGrandParentsMotherMother
                default : FamilyTree.selectedFamily = Family()
                }
            }
    }

    // MARK: - Table View

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        //return objects.count
//        return 4
//    }
//
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("FamiliesCell", forIndexPath: indexPath) as! UITableViewCell
//
//        cell.textLabel!.text = list[indexPath.row][0]
//        cell.detailTextLabel!.text = list[indexPath.row][1]
//        return cell
//    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let names : UILabel = cell.detailTextLabel!
        
        switch (indexPath.row) {
        case 0:
            names.text = FamilyTree.me.name
        case 1:
            names.text =
                FamilyTree.parents.father.name + " & " +
                FamilyTree.parents.mother.name
        case 2:
            names.text =
                FamilyTree.grandParentsFather.father.name + " & " +
                FamilyTree.grandParentsFather.mother.name
        case 3:
            names.text =
                FamilyTree.grandParentsMother.father.name + " & "  +
                FamilyTree.grandParentsMother.mother.name
        case 4:
            names.text =
                FamilyTree.greatGrandParentsFatherFather.father.name + " & "  +
                FamilyTree.greatGrandParentsFatherFather.mother.name
        case 5:
            names.text =
                FamilyTree.greatGrandParentsFatherMother.father.name + " & "  +
                FamilyTree.greatGrandParentsFatherMother.mother.name
        case 6:
            names.text =
                FamilyTree.greatGrandParentsMotherFather.father.name + " & "  +
                FamilyTree.greatGrandParentsMotherFather.mother.name
        case 7:
            names.text =
                FamilyTree.greatGrandParentsMotherMother.father.name + " & "  +
                FamilyTree.greatGrandParentsMotherMother.mother.name
        case 8: 
            names.text = ""
        case 9:
            names.text = ""
        default : cell.detailTextLabel!.text = ""
        }
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            objects.removeAtIndex(indexPath.row)
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//        } else if editingStyle == .Insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//        }
    }


}

