//
//  Person.swift
//  Copyright © 2017 Robin Reynolds. All rights reserved.
//

import Foundation
import UIKit

enum PersonType : Int, Codable {
    
    case father, mother, me, child
    
    func toString() -> String {
        switch (self) {
        case .father : return "Father"
        case .mother : return "Mother"
        case .me : return "Me"
        case .child : return "Child"
        }
    }
    
    func descriptionLabel() -> String {
        switch (self) {
        case .father : return "Stories and memories about him:"
        case .mother : return "Stories and memories about her:"
        case .me : return "My hobbies, interests, and favorite traditions:"
        case .child : return ""
        }
    }
    
}



class Person : Codable {
    var name = ""
    var birth = Event()
    var death = Event()
    var description = ""
    var descriptionLabel = ""
    var personType = PersonType.father
    var colorComps : [CGFloat]? = CGColor(colorLiteralRed: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).components
    var imageFile = "NoPhotoSelected.png"
    
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
    
    var image : UIImage {
        get {
            if (imageFile == "NoPhotoSelected.png") {
                return UIImage(named: imageFile)!
            }

            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let documentDirectory = paths[0] as NSString
            let dataPath = documentDirectory.appendingPathComponent(imageFile as String)
            return UIImage(contentsOfFile: dataPath)!
        }
        
        set {
            // save the image to a file and get the name
            imageFile = "image-" + self.name + ".jpg"
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let documentDirectory = paths[0] as NSString
            let dataPath = documentDirectory.appendingPathComponent(imageFile as String)

            let imageData = UIImagePNGRepresentation(newValue)!
            let url = URL(fileURLWithPath: dataPath)
            do {
                try imageData.write(to: url)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    
    init() {
        
    }
    
    func lifetime() -> String {
        return "\(birth.date) - \(death.date)"
    }
    
}
