//
//  FamilyTree.swift
//  FamilyPhone
//
//  Created by Robin Reynolds on 6/27/15.
//  Copyright (c) 2015 Robin Reynolds. All rights reserved.
//

import Foundation
import UIKit

var indent12 = "            "
var indent8 = "        "
var crlf = "\r\n"
var dq = "\""

class FamilyTree  {

    static var me = Person()
    static var parents = Family()
    static var grandParentsFather = Family()
    static var grandParentsMother = Family()
    static var greatGrandParentsFatherFather = Family()
    static var greatGrandParentsFatherMother = Family()
    static var greatGrandParentsMotherFather = Family()
    static var greatGrandParentsMotherMother = Family()
    static var selectedFamily = Family()
    static var selectedParent = Person()
    static var selectedFather = Person()
    static var selectedMother = Person()
    static var selectedChild = Person()
    static var selectedPerson = Person()
    static var familyData = NSDictionary()
    static var meColor = UIColor(red: 45/255, green: 208/255, blue: 0/255, alpha: 1.0)
    static var parentsColor = UIColor(red: 106/255, green: 148/255, blue: 212/255, alpha: 1.0)
    static var grandParentsColor = UIColor(red: 255/255, green: 203/255, blue: 115/255, alpha: 1.0)
    static var greatGrandParentsColor = UIColor (red: 250/255, green: 112/255, blue: 128/255, alpha: 1.0)
    
    init() {
    }
    
    static func saveData() {
        let data = FamilyTree.write()
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(data as AnyObject, forKey: "data")
        defaults.synchronize()
        
    }
    
    static func loadData() {
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if (defaults.objectForKey("data") == nil) {
            FamilyTree.loadFamilies()
            let data = FamilyTree.write()
            defaults.setObject(data as AnyObject, forKey: "data")
        } else {
            let data = defaults.objectForKey("data") as! String
            FamilyTree.loadFamilies(data)
        }
        
    }
    

    
    static func loadFamilies(content: String) {
        let data = content.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        loadFamiliesWithData(data)
    }
    
    static func loadFamiliesWithData(data: NSData?){
    
        //var parseError: NSError?
        var parsedObject : AnyObject?
        do {
            parsedObject = try NSJSONSerialization.JSONObjectWithData(data!,
                options: NSJSONReadingOptions.AllowFragments)
        } catch let error as NSError {
            print(error.localizedDescription);
            return;
        }
        
        
        if let alldata = parsedObject as? NSDictionary {
            if let family = alldata["FamilyTree"] as? NSDictionary {
                if let meDict = family["Me"] as? NSDictionary {
                    me = Person(data: meDict, type: PersonType.Me)
                }
                if let parentsDict = family["Parents"] as? NSDictionary {
                    parents = Family(data: parentsDict, name: "Parents",
                        fname1: "My Parents", fname2: "")
                }
                
                if let grandParentsFathersDict = family["GrandParentsFathersSide"] as? NSDictionary {
                    grandParentsFather = Family(data: grandParentsFathersDict, name: "GrandParentsFathersSide",
                        fname1: "My Grandparents", fname2: "Father's Side")
                }
                
                if let grandParentsMothersDict = family["GrandParentsMothersSide"] as? NSDictionary {
                    grandParentsMother = Family(data: grandParentsMothersDict, name: "GrandParentsMothersSide",
                        fname1: "My Grandparents", fname2: "Mother's Side")
                }
                
                if let ggpffDict = family["GreatGrandParentsFatherFather"] as? NSDictionary {
                    greatGrandParentsFatherFather = Family(data: ggpffDict, name: "GreatGrandParentsFatherFather",
                        fname1: "My Great-Grandparents", fname2: "Father's Father's Side")
                }
                if let ggpfmDict = family["GreatGrandParentsFatherMother"] as? NSDictionary {
                    greatGrandParentsFatherMother = Family(data: ggpfmDict, name: "GreatGrandParentsFatherMother",
                        fname1: "My Great-Grandparents", fname2: "Father's Mothers's Side")
                }
                if let ggpmfDict = family["GreatGrandParentsMotherFather"] as? NSDictionary {
                    greatGrandParentsMotherFather = Family(data: ggpmfDict, name: "GreatGrandParentsMotherFather",
                        fname1: "My Great-Grandparents", fname2: "Mother's Father's Side")
                }
                if let ggpmmDict = family["GreatGrandParentsMotherMother"] as? NSDictionary {
                    greatGrandParentsMotherMother = Family(data: ggpmmDict, name: "GreatGrandParentsMotherMother",
                        fname1: "My Great-Grandparents", fname2: "Mother's Mother's Side")
                }
            }
            familyData = alldata
        }
        
        FamilyTree.me.color = meColor
        FamilyTree.parents.color = parentsColor
        FamilyTree.grandParentsFather.color = grandParentsColor
        FamilyTree.grandParentsMother.color = grandParentsColor
        FamilyTree.greatGrandParentsFatherFather.color = greatGrandParentsColor
        FamilyTree.greatGrandParentsFatherMother.color = greatGrandParentsColor
        FamilyTree.greatGrandParentsMotherFather.color = greatGrandParentsColor
        FamilyTree.greatGrandParentsMotherMother.color = greatGrandParentsColor
    }

    
    static func loadFamilies() {
        let bundle = NSBundle.mainBundle()
        let path = bundle.pathForResource("MyFamily", ofType: "json")
        var content = ""
        do {
            content = try String(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
        } catch let error as NSError {
            print(error.localizedDescription)
            return
        }
        let data = content.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        
        loadFamiliesWithData(data)
    }
    

    static func write() -> String {
        let parentsString = parents.write() + ",\r\n"
        let grandParentString =
            grandParentsFather.write() + ",\r\n" +
            grandParentsMother.write() + ",\r\n"
        let greatGrandString1 =
            greatGrandParentsFatherFather.write() + ",\r\n" +
            greatGrandParentsFatherMother.write() + ",\r\n"
        let greatGrandString2 =
            greatGrandParentsMotherFather.write() + ",\r\n" +
            greatGrandParentsMotherMother.write() + "\r\n"
        let greatGrandString =
            greatGrandString1 + greatGrandString2
        let grands = grandParentString + greatGrandString
        let allPeople =
            me.writePerson() + ",\(crlf)" +
            parentsString +
            grands

        let result =
            "{\(dq)FamilyTree\(dq) : {\(crlf)" +
            allPeople +
            "}}\(crlf)"
        return result
    }
    
}



class Person {
    var name = ""
    var birthDate = ""
    var birthPlace = ""
    var deathDate = ""
    var deathPlace = ""
    var image = UIImage(named: "NoPhotoSelected.png")
    var description = ""
    var descriptionLabel = ""
    var familySearch = false
    var personType = PersonType.Father
    var color = UIColor.blueColor()

    
    init() {
        
    }
    
    
    init(data : NSDictionary, type : PersonType) {
        self.name = data["Name"] as! String
        self.birthDate = data["BirthDate"] as! String
        self.birthPlace = data["BirthPlace"] as! String
        self.deathDate = data["DeathDate"] as! String
        self.deathPlace = data["DeathPlace"] as! String
        self.personType = type
        self.description = data["Description"] as! String
        
        if (self.personType == PersonType.Mother) {
            self.descriptionLabel = "Stories and memories about her:"
        }
        else if (self.personType == PersonType.Father) {
            self.descriptionLabel = "Stories and memories about him:"
        }
        else if (self.personType == PersonType.Me) {
            self.descriptionLabel = "My hobbies, interests, and favorite traditions:"
        }
        else if (self.personType == PersonType.Child) {
            // nothing extra for children
        }
    }

    func writePerson() -> String {
        let name = "\(indent12)\(dq)Name\(dq) : \(dq)\(self.name)\(dq),\(crlf)"
        let birthDate = "\(indent12)\(dq)BirthDate\(dq) : \(dq)\(self.birthDate)\(dq),\(crlf)"
        let birthPlace = "\(indent12)\(dq)BirthPlace\(dq) : \(dq)\(self.birthPlace)\(dq),\(crlf)"
        let deathDate = "\(indent12)\(dq)DeathDate\(dq) : \(dq)\(self.deathDate)\(dq),\(crlf)"
        let deathPlace = "\(indent12)\(dq)DeathPlace\(dq) : \(dq)\(self.deathPlace)\(dq),\(crlf)"
        let description = "\(indent12)\(dq)Description\(dq) : \(dq)\(self.description)\(dq)\(crlf)"

        let base = name + birthDate + birthPlace + deathDate + deathPlace + description
        var result = "\(indent12){\(crlf)" +
            "\(base)\(crlf)" +
            "\(indent12)}"
        
        if (self.personType == PersonType.Me) {
            result = "    \(dq)Me\(dq) : \(crlf)" + result
        }
        else if (self.personType == PersonType.Mother) {
            result = "\(indent8)\(dq)Mother\(dq) : \(crlf)" + result
        }
        else if (self.personType == PersonType.Father) {
            result = "\(indent8)\(dq)Father\(dq) : \(crlf)" + result
        }
        return result
    }


}


enum PersonType : String {
    case Father = "Father"
    case Mother = "Mother"
    case Me = "Me"
    case Child = "Child"
}



class Marriage {
    var date = ""
    var place = ""
    
    init() {
        
    }
    
    init(data: NSDictionary) {
        self.date = data["Date"] as! String
        self.place = data["Place"] as! String
    }
    
    func write() -> String {
        let result =
            "\(indent8)\(dq)Marriage\(dq) : {\(crlf)" +
            "\(indent12)\(dq)Date\(dq) : \(dq)\(self.date)\(dq),\(crlf)" +
            "\(indent12)\(dq)Place\(dq) : \(dq)\(self.place)\(dq)\(crlf)" +
            "\(indent12)}"
        return result
    }
}

class Family {
    var father = Person()
    var mother = Person()
    var marriage = Marriage()
    var children = [Person]()
    var familyName = ""
    var friendlyName1 = ""
    var friendlyName2 = ""
    var color = UIColor.blueColor()
    
    init() {
        
    }
    
    init(data: NSDictionary, name: String, fname1 : String, fname2 : String) {
        familyName = name
        friendlyName1 = fname1
        friendlyName2 = fname2
        if let fatherDict = data["Father"] as? NSDictionary {
            self.father = Person(data: fatherDict, type: PersonType.Father)
            
        }
        
        if let motherDict = data["Mother"] as? NSDictionary {
            self.mother = Person(data: motherDict, type: PersonType.Mother)
        }
        
        if let marriageDict = data["Marriage"] as? NSDictionary {
            self.marriage = Marriage(data: marriageDict)
        }
        
        if let childrenDict = data["Children"] as? NSArray {
            // chilren are in an NSArray
            // let whole = "\(childrenDict)"
            for childDict in childrenDict as! [NSDictionary] {
                self.children.append(Person(data: childDict, type: PersonType.Child))
            }
        }
    }
    
    func write() -> String {
        var list = "\(indent8)\(dq)Children\(dq) : [\(crlf)"
        for var index = 0; index < children.count; index++ {
            list += children[index].writePerson()
            if (index < children.count - 1) {
                list += ","
            }
            list += "\(crlf)"
        }
        list += "\(indent8)]"
        
        
        var result = ""
        result =
            "    \(dq)\(familyName)\(dq) : {\(crlf)" +
            "\(father.writePerson()),\(crlf)" +
            "\(mother.writePerson()),\(crlf)" +
            "\(marriage.write()),\(crlf)" +
            "\(list)\(crlf)" +
            "    }"
        
        return result
    }
}