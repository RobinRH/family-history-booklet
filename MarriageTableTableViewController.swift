//
//  MarriageTableTableViewController.swift
//  Copyright (c) 2017 Robin Reynolds. All rights reserved.
//

import UIKit

class MarriageTableTableViewController: UITableViewController {

    @IBOutlet weak var marriagePlaceText: UITextField!
    @IBOutlet weak var marriageDateText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        marriageDateText!.text = GlobalData.selectedFamily.marriage.wedding.date
        marriagePlaceText!.text = GlobalData.selectedFamily.marriage.wedding.place

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        GlobalData.selectedFamily.marriage.wedding.date = marriageDateText!.text!
        GlobalData.selectedFamily.marriage.wedding.place = marriagePlaceText!.text!
    }

}
