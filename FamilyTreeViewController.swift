//
//  FamilyTreeViewController.swift
//  Copyright (c) 2017 Robin Reynolds. All rights reserved.
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
        
        meLabel!.text = GlobalData.oneTree.me.name
        fatherLabel!.text = GlobalData.oneTree.parents.father.name
        motherLabel!.text = GlobalData.oneTree.parents.mother.name
        gp1!.text = GlobalData.oneTree.grandParentsFather.father.name
        gp2!.text = GlobalData.oneTree.grandParentsFather.mother.name
        gp3!.text = GlobalData.oneTree.grandParentsMother.father.name
        gp4!.text = GlobalData.oneTree.grandParentsMother.mother.name
        
        ggp1!.text = GlobalData.oneTree.greatGrandParentsFatherFather.father.name
        ggp2!.text = GlobalData.oneTree.greatGrandParentsFatherFather.mother.name
        ggp3!.text = GlobalData.oneTree.greatGrandParentsFatherMother.father.name
        ggp4!.text = GlobalData.oneTree.greatGrandParentsFatherMother.mother.name
        ggp5!.text = GlobalData.oneTree.greatGrandParentsMotherFather.father.name
        ggp6!.text = GlobalData.oneTree.greatGrandParentsMotherFather.mother.name
        ggp7!.text = GlobalData.oneTree.greatGrandParentsMotherMother.father.name
        ggp8!.text = GlobalData.oneTree.greatGrandParentsMotherMother.mother.name
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
