//
//  Family2TableViewController.swift
//  FamilyPhone
//
//  Created by Robin Reynolds on 8/12/15.
//  Copyright (c) 2015 Robin Reynolds. All rights reserved.
//

import UIKit

class FamilyTableViewController: UITableViewController {
    
    
    @IBAction func addChild(sender: UIBarButtonItem) {
        let newChild = Person()
        newChild.personType = PersonType.Child
        FamilyTree.selectedFamily.children.append(newChild)
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 4
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        var number = 0
        switch(section) {
            case 0 : number = 1
            case 1 : number = 1
            case 2 : number = 1
            case 3 : number = FamilyTree.selectedFamily.children.count
            default : number = 0
        }
        
        return number
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Person", forIndexPath: indexPath) // as! UITableViewCell

        let family = FamilyTree.selectedFamily
        if (indexPath.section == 0) {
            cell.textLabel!.text = FamilyTree.selectedFamily.father.name
            cell.detailTextLabel!.text = "\(family.father.birthDate) - \(family.father.deathDate)"
        }
        else if (indexPath.section == 1) {
            cell.textLabel!.text = FamilyTree.selectedFamily.mother.name
            cell.detailTextLabel!.text = "\(family.mother.birthDate) - \(family.mother.deathDate)"
        }
        else if (indexPath.section == 2) {
            cell.textLabel!.text = FamilyTree.selectedFamily.marriage.date
            cell.detailTextLabel!.text = ""
        }
        else if (indexPath.section == 3) {
            let child = family.children[indexPath.row]
            cell.textLabel!.text = child.name
            cell.detailTextLabel!.text = "\(child.birthDate) - \(child.deathDate)"
        }
        
        return cell
    }

    
    
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        switch(section) {
        case 0: title = "Father"
        case 1: title = "Mother"
        case 2: title = "Marriage"
        case 3: title = "Children"
        default: title = ""
        }
        return title
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            if (indexPath.section == 0) {
                FamilyTree.selectedPerson = FamilyTree.selectedFamily.father
                performSegueWithIdentifier("pushToPerson", sender: self)
            }
            else if (indexPath.section == 1) {
                FamilyTree.selectedPerson = FamilyTree.selectedFamily.mother
                performSegueWithIdentifier("pushToPerson", sender: self)
            }
            else if (indexPath.section == 2) {
                performSegueWithIdentifier("pushToMarriage", sender: self)
            }
            else if (indexPath.section == 3) {
                FamilyTree.selectedPerson = FamilyTree.selectedFamily.children[indexPath.row]
                performSegueWithIdentifier("pushToPerson", sender: self)
            }
    }
    
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
