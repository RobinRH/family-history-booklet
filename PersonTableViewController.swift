//
//  FatherTableViewController.swift
//  Copyright (c) 2017 Robin Reynolds. All rights reserved.
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

    @IBAction func doneClick(_ sender: AnyObject) {
        storiesText.resignFirstResponder();
    }
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    let imagePicker = UIImagePickerController()
    
    
    
    @IBAction func selectPhoto(_ sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            photoImage!.image = pickedImage
            GlobalData.selectedPerson.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func configureView() {
        let person = GlobalData.selectedPerson
        nameText!.text = person.name
        birthDateText!.text = person.birth.date
        birthPlaceText!.text = person.birth.place
        deathDateText!.text = person.death.date
        deathPlaceText!.text = person.death.place
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
        
        storiesText.layer.borderColor = UIColor.lightGray.cgColor
        storiesText.layer.borderWidth = 0.5
        storiesText.layer.cornerRadius = 5
        // this part to set the width doesn't seem to work
        let width = storiesText.superview?.frame.width
        storiesText.frame.size = CGSize(width: width! - 16, height: storiesText.frame.size.height)

        self.navigationItem.title = GlobalData.selectedPerson.personType.toString()

        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        photoImage.contentMode = .scaleAspectFit
        photoImage.image = GlobalData.selectedPerson.image
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        // save the values back to the model
        let person = GlobalData.selectedPerson
        person.name = nameText!.text!
        person.birth.date = birthDateText!.text!
        person.birth.place = birthPlaceText!.text!
        person.death.date = deathDateText!.text!
        person.death.place = deathPlaceText!.text!
        //person.image = photoImage!.image!
        person.description = storiesText!.text!
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0 && indexPath.row == 1 && GlobalData.selectedPerson.personType == PersonType.child) {
            return 0
        }
        else if (indexPath.section == 3 && indexPath.row == 2 && GlobalData.selectedPerson.personType == PersonType.child) {
            return 0
        }
        else {
            return super.tableView(self.tableView, heightForRowAt: indexPath)
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
