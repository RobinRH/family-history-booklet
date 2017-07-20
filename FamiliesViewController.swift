//
//  FamiliesViewController.swift
//  Copyright (c) 2017 Robin Reynolds. All rights reserved.
//

import UIKit

class FamiliesViewController: UITableViewController {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    // this function is called when one of the rows in the families table is clicked
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            switch (indexPath.row) {
            case 0: GlobalData.selectedPerson = GlobalData.oneTree.me
            case 1: GlobalData.selectedFamily = GlobalData.oneTree.parents
            case 2: GlobalData.selectedFamily = GlobalData.oneTree.grandParentsFather
            case 3: GlobalData.selectedFamily = GlobalData.oneTree.grandParentsMother
            case 4: GlobalData.selectedFamily = GlobalData.oneTree.greatGrandParentsFatherFather
            case 5: GlobalData.selectedFamily = GlobalData.oneTree.greatGrandParentsFatherMother
            case 6: GlobalData.selectedFamily = GlobalData.oneTree.greatGrandParentsMotherFather
            case 7: GlobalData.selectedFamily = GlobalData.oneTree.greatGrandParentsMotherMother
            default : GlobalData.selectedFamily = Family()
            }
        }
    }

    // MARK: - Table View
    
    // this function creates the string of mother and father names in the second line of
    // text in each row in the families table
    // for example, "John Smith & Susan Harris"
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let names : UILabel = cell.detailTextLabel!
        
        switch (indexPath.row) {
        case 0:
            names.text = GlobalData.oneTree.me.name
        case 1:
            names.text =
                GlobalData.oneTree.parents.father.name + " & " +
                GlobalData.oneTree.parents.mother.name
        case 2:
            names.text =
                GlobalData.oneTree.grandParentsFather.father.name + " & " +
                GlobalData.oneTree.grandParentsFather.mother.name
        case 3:
            names.text =
                GlobalData.oneTree.grandParentsMother.father.name + " & "  +
                GlobalData.oneTree.grandParentsMother.mother.name
        case 4:
            names.text =
                GlobalData.oneTree.greatGrandParentsFatherFather.father.name + " & "  +
                GlobalData.oneTree.greatGrandParentsFatherFather.mother.name
        case 5:
            names.text =
                GlobalData.oneTree.greatGrandParentsFatherMother.father.name + " & "  +
                GlobalData.oneTree.greatGrandParentsFatherMother.mother.name
        case 6:
            names.text =
                GlobalData.oneTree.greatGrandParentsMotherFather.father.name + " & "  +
                GlobalData.oneTree.greatGrandParentsMotherFather.mother.name
        case 7:
            names.text =
                GlobalData.oneTree.greatGrandParentsMotherMother.father.name + " & "  +
                GlobalData.oneTree.greatGrandParentsMotherMother.mother.name
        case 8: 
            names.text = ""
        case 9:
            names.text = ""
        default : cell.detailTextLabel!.text = ""
        }
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .Delete {
//            objects.removeAtIndex(indexPath.row)
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//        } else if editingStyle == .Insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//        }
//    }


}

