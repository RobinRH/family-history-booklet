//
//  ExportViewController.swift
//  FamilyPhone
//
//  Created by Robin Reynolds on 8/12/15.
//  Copyright (c) 2015 Robin Reynolds. All rights reserved.
//

import UIKit

class ExportViewController: UIViewController {

    // UIDocumentInteractionController instance is a class property
    var docController:UIDocumentInteractionController!
    
    @IBOutlet weak var textJson: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let data = FamilyTree.write()
        textJson.text = data
        
        let fileName: NSString = "export.json"
        let path:NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentDirectory: AnyObject = path.objectAtIndex(0)
        let dataPath = documentDirectory.stringByAppendingPathComponent(fileName as String)
        let url = NSURL(fileURLWithPath: dataPath)
        do {
            try data.writeToURL(url, atomically: true, encoding: NSUTF8StringEncoding)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        //        data.writeToURL(url, atomically: true, encoding: NSUTF8StringEncoding, error: nil)
        self.docController = UIDocumentInteractionController(URL: url)
        
    }

    @IBAction func openBook(sender: AnyObject) {
        docController.presentOptionsMenuFromBarButtonItem(sender as! UIBarButtonItem, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
