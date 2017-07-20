//
//  FamilyTree.swift
//  Copyright (c) 2017 Robin Reynolds. All rights reserved.
//

import Foundation
import UIKit

class FamilyColor {
    static let me = UIColor(red: 45/255, green: 208/255, blue: 0/255, alpha: 1.0)
    static let parents = UIColor(red: 106/255, green: 148/255, blue: 212/255, alpha: 1.0)
    static let grandParents = UIColor(red: 255/255, green: 203/255, blue: 115/255, alpha: 1.0)
    static let greatGrandParents = UIColor (red: 250/255, green: 112/255, blue: 128/255, alpha: 1.0)
}


//class FamilyTreeNode {
//    var child : Person? = nil
//    var mother : Person? = nil
//    var father : Person? = nil
//}
//
//class FamilyTreeConnected {
//
//    init(data : String) {
//
//    }
//
//}


class FamilyTree : Codable  {

    var me = Person()
    var parents = Family(name: "Parents", friendly1: "My Parents", friendly2: "")
    var grandParentsFather = Family(name: "GrandParentsFathersSide", friendly1: "My Grandparents", friendly2: "Father's Side")
    var grandParentsMother = Family(name: "GrandParentsMothersSide", friendly1: "My Grandparents", friendly2: "Mother's Side")
    var greatGrandParentsFatherFather = Family(name: "GreatGrandParentsFatherFather", friendly1: "My Great-Grandparents", friendly2: "Father's Father's Side")
    var greatGrandParentsFatherMother = Family(name: "GreatGrandParentsFatherMother", friendly1: "My Great-Grandparents", friendly2: "Father's Mothers's Side")
    var greatGrandParentsMotherFather = Family(name: "GreatGrandParentsMotherFather", friendly1: "My Great-Grandparents", friendly2: "Mother's Father's Side")
    var greatGrandParentsMotherMother = Family(name: "GreatGrandParentsMotherMother", friendly1: "My Great-Grandparents", friendly2: "Mother's Mother's Side")
    
    init() {
        me.color = FamilyColor.me
        parents.color = FamilyColor.parents
        grandParentsFather.color = FamilyColor.grandParents
        grandParentsMother.color = FamilyColor.grandParents
        greatGrandParentsFatherFather.color = FamilyColor.greatGrandParents
        greatGrandParentsFatherMother.color = FamilyColor.greatGrandParents
        greatGrandParentsMotherFather.color = FamilyColor.greatGrandParents
        greatGrandParentsMotherMother.color = FamilyColor.greatGrandParents
    }
    
}

class Event : Codable {
    var date = ""
    var place = ""
}



class Marriage : Codable {
    var wedding = Event()
    var husband = Person()
    var wife = Person()
    
    init() {
        
    }
    
}


class Family : Codable {
    var father = Person()
    var mother = Person()
    var marriage = Marriage()
    var children = [Person]()
    var familyName = ""
    var friendlyName1 = ""
    var friendlyName2 = ""
    var colorComps : [CGFloat]? = CGColor(colorLiteralRed: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).components
    
    var color : UIColor {
        get {
            let rc = Float(colorComps![0])
            let gc = Float(colorComps![1])
            let bc = Float(colorComps![2])
            let ac = Float(colorComps![3])
            let cc = CGColor(colorLiteralRed: rc, green: gc, blue: bc, alpha: ac)
            return UIColor(cgColor: cc)
        }
        set {
            colorComps = newValue.cgColor.components
        }
    }

    init(name: String, friendly1 : String, friendly2 : String) {
        familyName = name
        friendlyName1 = friendly1
        friendlyName2 = friendly2
    }
    
    init() {
        
    }
    
}
