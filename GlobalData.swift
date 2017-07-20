//
//  GlobalData.swift
//  Copyright © 2017 Robin Reynolds. All rights reserved.
//

import Foundation


class GlobalData {
    static var oneTree = FamilyTree()
    static var selectedFamily = Family()
    static var selectedParent = Person()
    static var selectedFather = Person()
    static var selectedMother = Person()
    static var selectedChild = Person()
    static var selectedPerson = Person()
    
    static func readFamilyTree() {

        let defaults: UserDefaults = UserDefaults.standard
        if (defaults.object(forKey: "data") == nil) {
            GlobalData.oneTree = FamilyTree()
            let je = JSONEncoder()
            je.outputFormatting = .prettyPrinted
            let data = try? je.encode(GlobalData.oneTree)
            let dataString = String(data: data!, encoding: .utf8)!
            defaults.set(dataString as String, forKey: "data")
            defaults.synchronize()
        } else {
            let dataString = defaults.object(forKey: "data") as! String
            let jd = JSONDecoder()
            let tree = try? jd.decode(FamilyTree.self, from: dataString.data(using: .utf8)!)
            GlobalData.oneTree = tree!
        }
    }
    
    static func readFamilyTree(json : Data) {
        let jd = JSONDecoder()
        let tree = try? jd.decode(FamilyTree.self, from: json)
        GlobalData.oneTree = tree!
    }
    
    static func writeFamilyTree() {
        let defaults: UserDefaults = UserDefaults.standard
        let je = JSONEncoder()
        je.outputFormatting = .prettyPrinted
        let data = try? je.encode(GlobalData.oneTree)
        let dataString = String(data: data!, encoding: .utf8)!
        defaults.set(dataString as String, forKey: "data")
        defaults.synchronize()
    }
}
