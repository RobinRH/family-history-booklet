//
//  ExportViewController.swift
//  Copyright (c) 2017 Robin Reynolds. All rights reserved.
//

import UIKit

class ExportViewController: UIViewController {

    var docController : UIDocumentInteractionController!
    
    @IBOutlet weak var textJson: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // create the json string for the family tree
        let je = JSONEncoder()
        je.outputFormatting = .prettyPrinted
        let data = try? je.encode(GlobalData.oneTree)
        textJson.text = String(data: data!, encoding: .utf8)!
        
        // write the json out as a file in the document directory
        let fileName = "export.json"
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = paths[0] as NSString
        let dataPath = documentDirectory.appendingPathComponent(fileName as String)
        
        let url = URL(fileURLWithPath: dataPath)
        do {
            try data!.write(to: url)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        self.docController = UIDocumentInteractionController(url: url)
        
    }

    @IBAction func openBook(_ sender: AnyObject) {
        docController.presentOptionsMenu(from: sender as! UIBarButtonItem, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
