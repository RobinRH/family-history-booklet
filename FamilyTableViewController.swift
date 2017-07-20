//
//  FamilyTableViewController.swift
//  Copyright (c) 2017 Robin Reynolds. All rights reserved.
//

import UIKit

class FamilyTableViewController: UITableViewController {
    
    var family = GlobalData.selectedFamily
    
    @IBAction func addChild(_ sender: UIBarButtonItem) {
        let newChild = Person()
        newChild.personType = PersonType.child
        family.children.append(newChild)
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        family = GlobalData.selectedFamily
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var number = 0
        switch(section) {
            case 0 : number = 1
            case 1 : number = 1
            case 2 : number = 1
            case 3 : number = GlobalData.selectedFamily.children.count
            default : number = 0
        }
        
        return number
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Person", for: indexPath) // as! UITableViewCell

        if (indexPath.section == 0) {
            cell.textLabel!.text = family.father.name
            cell.detailTextLabel!.text = family.father.lifetime()
        }
        else if (indexPath.section == 1) {
            cell.textLabel!.text = family.mother.name
            cell.detailTextLabel!.text = family.mother.lifetime()
        }
        else if (indexPath.section == 2) {
            cell.textLabel!.text = family.marriage.wedding.date
            cell.detailTextLabel!.text = ""
        }
        else if (indexPath.section == 3) {
            let child = family.children[indexPath.row]
            cell.textLabel!.text = child.name
            cell.detailTextLabel!.text = child.lifetime()
        }
        
        return cell
    }

    
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
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
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if (indexPath.section == 0) {
                GlobalData.selectedPerson = GlobalData.selectedFamily.father
                performSegue(withIdentifier: "pushToPerson", sender: self)
            }
            else if (indexPath.section == 1) {
                GlobalData.selectedPerson = GlobalData.selectedFamily.mother
                performSegue(withIdentifier: "pushToPerson", sender: self)
            }
            else if (indexPath.section == 2) {
                performSegue(withIdentifier: "pushToMarriage", sender: self)
            }
            else if (indexPath.section == 3) {
                GlobalData.selectedPerson = GlobalData.selectedFamily.children[indexPath.row]
                performSegue(withIdentifier: "pushToPerson", sender: self)
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
