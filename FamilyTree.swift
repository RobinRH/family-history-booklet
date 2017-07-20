//
//  FamilyTree.swift
//  Copyright (c) 2017 Robin Reynolds. All rights reserved.
//

import Foundation
import UIKit

enum FamilyColor : Int, Codable {
    
    case me, parents, grandParents, greatGrandParents
    
    func getUIColor() -> UIColor {
        switch (self) {
        case .me : return UIColor(red: 45/255, green: 208/255, blue: 0/255, alpha: 1.0)
        case .parents : return UIColor(red: 106/255, green: 148/255, blue: 212/255, alpha: 1.0)
        case .grandParents : return UIColor(red: 255/255, green: 203/255, blue: 115/255, alpha: 1.0)
        case .greatGrandParents : return UIColor(red: 250/255, green: 112/255, blue: 128/255, alpha: 1.0)
        }
    }
    
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
    var parents = Family(name: "Parents", friendly1: "My Parents", friendly2: "", color: .parents)
    var grandParentsFather = Family(name: "GrandParentsFathersSide", friendly1: "My Grandparents", friendly2: "Father's Side", color: .grandParents)
    var grandParentsMother = Family(name: "GrandParentsMothersSide", friendly1: "My Grandparents", friendly2: "Mother's Side", color: .grandParents)
    var greatGrandParentsFatherFather = Family(name: "GreatGrandParentsFatherFather", friendly1: "My Great-Grandparents", friendly2: "Father's Father's Side", color: .greatGrandParents)
    var greatGrandParentsFatherMother = Family(name: "GreatGrandParentsFatherMother", friendly1: "My Great-Grandparents", friendly2: "Father's Mothers's Side", color: .greatGrandParents)
    var greatGrandParentsMotherFather = Family(name: "GreatGrandParentsMotherFather", friendly1: "My Great-Grandparents", friendly2: "Mother's Father's Side", color: .greatGrandParents)
    var greatGrandParentsMotherMother = Family(name: "GreatGrandParentsMotherMother", friendly1: "My Great-Grandparents", friendly2: "Mother's Mother's Side", color: .greatGrandParents)
    
    init() {
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

//extension UIColor : Codable {
//    public convenience init(from decoder: Decoder) throws {
//    }
//
//    public func encode(to encoder: Encoder) throws {
//
//    }
//
//}


class Family : Codable {
    var father = Person()
    var mother = Person()
    var marriage = Marriage()
    var children = [Person]()
    var familyName = ""
    var friendlyName1 = ""
    var friendlyName2 = ""
    var colorComps : [CGFloat]? = CGColor(colorLiteralRed: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).components
    var generationColor : FamilyColor = FamilyColor.me
    
    var color : UIColor {
        return generationColor.getUIColor()
    }
    
    init(name: String, friendly1 : String, friendly2 : String, color : FamilyColor) {
        familyName = name
        friendlyName1 = friendly1
        friendlyName2 = friendly2
        generationColor = color
    }
    
    init() {
        
    }
    
}
