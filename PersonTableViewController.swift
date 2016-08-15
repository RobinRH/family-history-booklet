//
//  FatherTableViewController.swift
//  FamilyPhone
//
//  Created by Robin Reynolds on 8/10/15.
//  Copyright (c) 2015 Robin Reynolds. All rights reserved.
//

import UIKit

class PersonTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var birthPlaceText: UITextField!
    @IBOutlet weak var birthDateText: UITextField!
    @IBOutlet weak var templeWordSegment: UISegmentedControl!
    @IBOutlet weak var familySearchSegment: UISegmentedControl!
    @IBOutlet weak var deathDateText: UITextField!
    @IBOutlet weak var deathPlaceText: UITextField!
    @IBOutlet weak var storiesText: UITextView!
    @IBOutlet weak var familySearchSwitch: UISwitch!
    @IBOutlet weak var templeWorkSwitch: UISwitch!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var photoCell: UITableViewCell!

    @IBAction func doneClick(sender: AnyObject) {
        storiesText.resignFirstResponder();
    }
    
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    let imagePicker = UIImagePickerController()
    
    @IBAction func selectPhoto(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    

//    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //photoImage.contentMode = .ScaleAspectFit
            photoImage!.image = pickedImage
            FamilyTree.selectedPerson.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func configureView() {
        let person = FamilyTree.selectedPerson
        nameText!.text = person.name
        birthDateText!.text = person.birthDate
        birthPlaceText!.text = person.birthPlace
        deathDateText!.text = person.deathDate
        deathPlaceText!.text = person.deathPlace
//        templeWorkSwitch!.on = person.templeWork
//        familySearchSwitch!.on = person.familySearch
        photoImage!.image = person.image
        storiesText!.text = person.description
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        self.configureView()
        
        nameText.delegate = self
        birthDateText.delegate = self
        birthPlaceText.delegate = self
        deathDateText.delegate = self
        deathPlaceText.delegate = self
        
        storiesText.layer.borderColor = UIColor.lightGrayColor().CGColor
        storiesText.layer.borderWidth = 0.5
        storiesText.layer.cornerRadius = 5
        // this part to set the width doesn't seem to work
        let width = storiesText.superview?.frame.width
        storiesText.frame.size = CGSize(width: width! - 16, height: storiesText.frame.size.height)
        
        switch (FamilyTree.selectedPerson.personType) {
        case PersonType.Me: self.navigationItem.title = "Me"
        case PersonType.Father: self.navigationItem.title = "Father"
        case PersonType.Mother: self.navigationItem.title = "Mother"
        case PersonType.Child: self.navigationItem.title = "Child"
        }
        
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        photoImage.contentMode = .ScaleAspectFit
        photoImage.image = FamilyTree.selectedPerson.image
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        // save the values back to the model
        let person = FamilyTree.selectedPerson
        person.name = nameText!.text!
        person.birthDate = birthDateText!.text!
        person.birthPlace = birthPlaceText!.text!
        person.deathDate = deathDateText!.text!
        person.deathPlace = deathPlaceText!.text!
        person.image = photoImage!.image
        person.description = storiesText!.text!
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.section == 0 && indexPath.row == 1 && FamilyTree.selectedPerson.personType == PersonType.Child) {
            return 0
        }
        else if (indexPath.section == 3 && indexPath.row == 2 && FamilyTree.selectedPerson.personType == PersonType.Child) {
            return 0
        }
        else {
            return super.tableView(self.tableView, heightForRowAtIndexPath: indexPath)
        }
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Potentially incomplete method implementation.
//        // Return the number of sections.
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete method implementation.
//        // Return the number of rows in the section.
//        return 0
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

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
