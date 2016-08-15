//
//  FamilyTreeViewController.swift
//  FamilyPhone
//
//  Created by Robin Reynolds on 6/28/15.
//  Copyright (c) 2015 Robin Reynolds. All rights reserved.
//

import UIKit

class FamilyTreeViewController: UIViewController {

    @IBOutlet weak var meLabel: UILabel!
    
    @IBOutlet weak var fatherLabel: UILabel!
    
    @IBOutlet weak var motherLabel: UILabel!

    @IBOutlet weak var gp1: UILabel!
    @IBOutlet weak var gp2: UILabel!
    @IBOutlet weak var gp3: UILabel!
    @IBOutlet weak var gp4: UILabel!
    @IBOutlet weak var ggp1: UILabel!
    @IBOutlet weak var ggp2: UILabel!
    @IBOutlet weak var ggp3: UILabel!
    @IBOutlet weak var ggp4: UILabel!
    @IBOutlet weak var ggp5: UILabel!
    @IBOutlet weak var ggp6: UILabel!
    @IBOutlet weak var ggp7: UILabel!
    @IBOutlet weak var ggp8: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        meLabel!.text = FamilyTree.me.name
        fatherLabel!.text = FamilyTree.parents.father.name
        motherLabel!.text = FamilyTree.parents.mother.name
        gp1!.text = FamilyTree.grandParentsFather.father.name
        gp2!.text = FamilyTree.grandParentsFather.mother.name
        gp3!.text = FamilyTree.grandParentsMother.father.name
        gp4!.text = FamilyTree.grandParentsMother.mother.name
        
        ggp1!.text = FamilyTree.greatGrandParentsFatherFather.father.name
        ggp2!.text = FamilyTree.greatGrandParentsFatherFather.mother.name
        ggp3!.text = FamilyTree.greatGrandParentsFatherMother.father.name
        ggp4!.text = FamilyTree.greatGrandParentsFatherMother.mother.name
        ggp5!.text = FamilyTree.greatGrandParentsMotherFather.father.name
        ggp6!.text = FamilyTree.greatGrandParentsMotherFather.mother.name
        ggp7!.text = FamilyTree.greatGrandParentsMotherMother.father.name
        ggp8!.text = FamilyTree.greatGrandParentsMotherMother.mother.name
        
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
