
//
//  HistoryBookViewController.swift
//  FamilyPhone
//
//  Created by Robin Reynolds on 7/3/15.
//  Copyright (c) 2015 Robin Reynolds. All rights reserved.
//

// color scheme: http://colorschemedesigner.com/csd-3.5/#5z42lw0w0w0w0

// TODO: create a new page for each 7 children

import UIKit

class HistoryBookViewController: UIViewController {
    
    var familypdf = "myfamily.pdf"
    var margin = 25
    var pagesize = CGRect(x: 0, y: 0, width: 550, height: 850)
    var treeColor = UIColor(red: 183/255, green: 46/255, blue: 62/255, alpha: 1.0)
    

    @IBOutlet weak var webView: UIWebView!
    
    // UIDocumentInteractionController instance is a class property
    var docController:UIDocumentInteractionController!
    
    @IBAction func openBook(sender: AnyObject) {
        docController.presentOptionsMenuFromBarButtonItem(sender as! UIBarButtonItem, animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        generatePDF()
        
        let fileName: NSString = familypdf
        let path:NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentDirectory: AnyObject = path.objectAtIndex(0)
        let pdfPathWithFileName = documentDirectory.stringByAppendingPathComponent(fileName as String)
        let url = NSURL(fileURLWithPath: pdfPathWithFileName)
        let request = NSURLRequest(URL: url)
        webView.loadRequest(request)
        
        // retrieve URL to file in main bundle
        var bookpath = "itms-books:" + pdfPathWithFileName
        bookpath = pdfPathWithFileName
        let bookurl = NSURL(fileURLWithPath: bookpath)
        self.docController = UIDocumentInteractionController(URL: bookurl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func generatePDF() {
        let fileName: NSString = familypdf
        let path:NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentDirectory: AnyObject = path.objectAtIndex(0)
        let pdfPathWithFileName = documentDirectory.stringByAppendingPathComponent(fileName as String)
        
        UIGraphicsBeginPDFContextToFile(pdfPathWithFileName, CGRectZero, nil)

        // title page
        drawTitlePage("My Family", pageSubTitle: "", pcolor: FamilyTree.me.color)
        
        // table of contents
        drawTOC()
        
        // me
        drawMe(FamilyTree.me, pcolor: FamilyTree.me.color)
        
        // families
        let families = [
            FamilyTree.parents,
            FamilyTree.grandParentsFather,
            FamilyTree.grandParentsMother,
            FamilyTree.greatGrandParentsFatherFather,
            FamilyTree.greatGrandParentsFatherMother,
            FamilyTree.greatGrandParentsMotherFather,
            FamilyTree.greatGrandParentsMotherMother
        ]
        
        for family in families {
            drawTitlePage(family.friendlyName1, pageSubTitle:family.friendlyName2, pcolor: family.color)
            drawParent(family.father, pmarriage : family.marriage, pcolor : family.color, ptype: PersonType.Father)
            drawParent(family.mother, pmarriage : family.marriage, pcolor : family.color, ptype: PersonType.Mother)
            drawChildren(family.children, pcolor: family.color)
        }
        
        // family tree
        drawFamilyTree()
        
        UIGraphicsEndPDFContext()
    }
    

    func drawTOC() {
        // start new page
        UIGraphicsBeginPDFPageWithInfo(pagesize, nil)
        //let context:CGContextRef = UIGraphicsGetCurrentContext()
        let context = UIGraphicsGetCurrentContext()
        
        // draw header
        drawHeader(context!, color: treeColor, text: "Table of Contents")
        
        let people : [(name: String, color: UIColor)] = [
            (FamilyTree.me.name, FamilyTree.me.color),
            (FamilyTree.parents.father.name, FamilyTree.parents.color),
            (FamilyTree.parents.mother.name, FamilyTree.parents.color),
            (FamilyTree.grandParentsFather.father.name, FamilyTree.grandParentsFather.color),
            (FamilyTree.grandParentsFather.mother.name, FamilyTree.grandParentsFather.color),
            (FamilyTree.grandParentsMother.father.name, FamilyTree.grandParentsFather.color),
            (FamilyTree.grandParentsMother.mother.name, FamilyTree.grandParentsFather.color),
            (FamilyTree.greatGrandParentsFatherFather.father.name, FamilyTree.greatGrandParentsFatherFather.color),
            (FamilyTree.greatGrandParentsFatherFather.mother.name, FamilyTree.greatGrandParentsFatherFather.color),
            (FamilyTree.greatGrandParentsFatherMother.father.name, FamilyTree.greatGrandParentsFatherFather.color),
            (FamilyTree.greatGrandParentsFatherMother.mother.name, FamilyTree.greatGrandParentsFatherFather.color),
            (FamilyTree.greatGrandParentsMotherFather.father.name, FamilyTree.greatGrandParentsFatherFather.color),
            (FamilyTree.greatGrandParentsMotherFather.mother.name, FamilyTree.greatGrandParentsFatherFather.color),
            (FamilyTree.greatGrandParentsMotherMother.father.name, FamilyTree.greatGrandParentsFatherFather.color),
            (FamilyTree.greatGrandParentsMotherMother.mother.name, FamilyTree.greatGrandParentsFatherFather.color)]
        
        // draw the people
        var start = 115
        for (name, color) in people {
            drawLink(
                context!,
                text: name,
                textFrame: CGRect(x: 50, y: start + 10, width: 300, height: 60),
                fontSize: CGFloat(20),
                url: name,
                backgroundFrame: CGRect(x: 25, y: start, width: 500, height: 40),
                backgroundColor: color)
            start += 45
        }
        
        // add a link to the family tree
        drawLink(
            context!,
            text: "Family Tree",
            textFrame: CGRect(x: 50, y: start + 10, width: 300, height: 60),
            fontSize: CGFloat(20),
            url: "Family Tree",
            backgroundFrame: CGRect(x: 25, y: start, width: 500, height: 40),
            backgroundColor: treeColor)
    }
    
    
    func drawFamilyTree() {
        // start new page
        UIGraphicsBeginPDFPageWithInfo(pagesize, nil)
        let context = (UIGraphicsGetCurrentContext())!
        
        // draw header
        drawHeader(context, color: treeColor, text: "My Family Tree")
        
        // draw greatgrandparents
        drawFamily(context, family: FamilyTree.greatGrandParentsFatherFather, left: 300, top: 110, spacing: 100)
        drawFamily(context, family: FamilyTree.greatGrandParentsFatherMother, left: 300, top: 310, spacing: 100)
        drawFamily(context, family: FamilyTree.greatGrandParentsMotherFather, left: 300, top: 510, spacing: 100)
        drawFamily(context, family: FamilyTree.greatGrandParentsMotherMother, left: 300, top: 710, spacing: 100)
        
        // draw grandparents
        drawFamily(context, family: FamilyTree.grandParentsFather, left: 200, top: 160, spacing: 200)
        drawFamily(context, family: FamilyTree.grandParentsMother, left: 200, top: 560, spacing: 200)
        
        // draw parents
        drawFamily(context, family: FamilyTree.parents, left: 105, top: 265, spacing: 400)
        

        // draw me
        drawLink(
            context,
            text: FamilyTree.me.name,
            textFrame: CGRect(x: 30, y: 470, width: 215, height: 30),
            fontSize: CGFloat(20),
            url: FamilyTree.me.name,
            backgroundFrame: CGRect(x: 25, y: 465, width: 225, height: 30),
            backgroundColor: FamilyTree.me.color)

        
        // draw lines
        

        // me - father
        drawLine(context, from: CGPoint(x: 35, y: 465), to: CGPoint(x: 105, y: 280))
        // me - mother
        drawLine(context, from: CGPoint(x: 35, y: 495), to: CGPoint(x: 105, y: 680))
        
        // father - grandparents
        drawLine(context, from: CGPoint(x: 115, y: 265), to: CGPoint(x: 200, y: 175))
        drawLine(context, from: CGPoint(x: 115, y: 295), to: CGPoint(x: 200, y: 375))
        
        
        // mother - grandparents
        drawLine(context, from: CGPoint(x: 115, y: 665), to: CGPoint(x: 200, y: 575))
        drawLine(context, from: CGPoint(x: 115, y: 695), to: CGPoint(x: 200, y: 775))
        
        // grandparents - greatgrandparents
        drawLine(context, from: CGPoint(x: 210, y: 160), to: CGPoint(x: 300, y: 125))
        drawLine(context, from: CGPoint(x: 210, y: 190), to: CGPoint(x: 300, y: 225))

        drawLine(context, from: CGPoint(x: 210, y: 360), to: CGPoint(x: 300, y: 325))
        drawLine(context, from: CGPoint(x: 210, y: 390), to: CGPoint(x: 300, y: 425))
        
        drawLine(context, from: CGPoint(x: 210, y: 560), to: CGPoint(x: 300, y: 525))
        drawLine(context, from: CGPoint(x: 210, y: 590), to: CGPoint(x: 300, y: 625))
        
        drawLine(context, from: CGPoint(x: 210, y: 760), to: CGPoint(x: 300, y: 725))
        drawLine(context, from: CGPoint(x: 210, y: 790), to: CGPoint(x: 300, y: 825))
        
        UIGraphicsAddPDFContextDestinationAtPoint("Family Tree", CGPoint(x: 0, y: 0))
        
    }
    
    func drawLine(context : CGContextRef, from : CGPoint, to : CGPoint) {
        let mid = CGPoint(x: from.x, y: to.y)
        let plusPath = UIBezierPath()
        plusPath.lineWidth = CGFloat(3.0)
        plusPath.moveToPoint(from)
        plusPath.addLineToPoint(mid)
        plusPath.addLineToPoint(to)
        UIColor.lightGrayColor().setStroke()
        plusPath.stroke()
    }
    
    
    func drawFamily(context : CGContextRef, family : Family, left : Int, top : Int, spacing : Int) {
        
        // draw father
        drawLink(
            context,
            text: family.father.name,
            textFrame: CGRect(x: left + 5, y: top + 5, width: 215, height: 30),
            fontSize: CGFloat(20),
            url: family.father.name,
            backgroundFrame: CGRect(x: left, y: top, width: 225, height: 30),
            backgroundColor: family.color)
        
        // draw mother
        drawLink(
            context,
            text: family.mother.name,
            textFrame: CGRect(x: left + 5, y: top + spacing + 5, width: 215, height: 30),
            fontSize: 20,
            url: family.mother.name,
            backgroundFrame: CGRect(x: left, y: top + spacing, width: 225, height: 30),
            backgroundColor: family.color)
    }
    

    var aboutAttributes: [String: AnyObject] = [
        NSFontAttributeName : UIFont.systemFontOfSize(17),
        NSForegroundColorAttributeName : UIColor.blackColor()
    ]
    
    var vitalsAttributes: [String: AnyObject] = [
        NSFontAttributeName : UIFont.systemFontOfSize(17),
        NSForegroundColorAttributeName : UIColor.blackColor()
    ]

    var recordsAttributes: [String: AnyObject] = [
        NSFontAttributeName : UIFont.systemFontOfSize(17),
        NSForegroundColorAttributeName : UIColor.blackColor()
    ]
    

    func drawParent(parent : Person, pmarriage : Marriage, pcolor : UIColor, ptype : PersonType) {
        // start new page
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 550, 850), nil)
        let context:CGContextRef = (UIGraphicsGetCurrentContext())!

        // draw header
        let name = (ptype == .Father ? "Father" : "Mother")
        drawHeader(context, color: pcolor, text: name)
        
        // draw about
        let nameFrame = CGRect(x: 225, y: 125, width: 300, height: 50)
        let nameString : NSString = ("Name: " + parent.name)
        nameString.drawInRect(nameFrame, withAttributes: aboutAttributes)

        let storiesFrame = CGRect(x: 225, y: 145, width: 300, height: 425)
        let storiesString : NSString = (parent.descriptionLabel + " " + parent.description)
        storiesString.drawInRect(storiesFrame, withAttributes: aboutAttributes)
        
        // draw records
        drawRecords(context, person: parent)
        
        // draw birth, death, marriage
        drawVitalStatistics(context, person: parent, birthOnly: false, marriage: pmarriage)
        
        UIGraphicsAddPDFContextDestinationAtPoint(parent.name, CGPoint(x: 25, y: 25))

    }
    
    func drawVitalStatistics(context : CGContextRef, person : Person, birthOnly : Bool, marriage : Marriage) {
        // draw birth, death, marriage
        let birthDateFrame = CGRect(x: 225, y: 655, width: 300, height: 50)
        let birthPlaceFrame = CGRect(x: 225, y: 675, width: 300, height: 50)
        let birthDateString : NSString = ("Birth date: " + person.birthDate)
        let birthPlaceString : NSString = ("Place: " + person.birthPlace)
        birthDateString.drawInRect(birthDateFrame, withAttributes: vitalsAttributes)
        birthPlaceString.drawInRect(birthPlaceFrame, withAttributes: vitalsAttributes)
        
        if (!birthOnly) {
            let deathDateFrame = CGRect(x: 225, y: 695, width: 300, height: 50)
            let deathPlaceFrame = CGRect(x: 225, y: 715, width: 300, height: 50)
            let deathDateString : NSString = ("Deate date: " + person.deathDate)
            let deathPlaceString : NSString = ("Place: " + person.deathPlace)
            deathDateString.drawInRect(deathDateFrame, withAttributes: vitalsAttributes)
            deathPlaceString.drawInRect(deathPlaceFrame, withAttributes: vitalsAttributes)
        
            let marriageDateFrame = CGRect(x: 225, y: 760, width: 300, height: 50)
            let marriagePlaceFrame = CGRect(x: 225, y: 780, width: 300, height: 50)
            let marriageDateString : NSString = ("Marriage date: " + marriage.date)
            let marriagePlaceString : NSString = ("Place: " + marriage.place)
            marriageDateString.drawInRect(marriageDateFrame, withAttributes: vitalsAttributes)
            marriagePlaceString.drawInRect(marriagePlaceFrame, withAttributes: vitalsAttributes)
            drawDottedLine(CGPoint(x: 25, y: 750), toPt: CGPoint(x: 525, y: 750))
        }

        drawDottedLine(CGPoint(x: 25, y: 650), toPt: CGPoint(x: 525, y: 650))

    }
    
    func drawRecords(context: CGContextRef, person : Person) {
        // draw records
        let recordsFrame = CGRect(x: 25, y: 125, width: 175, height: 500)
        let lightGray = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).CGColor
        CGContextSetFillColorWithColor(context, lightGray)
        CGContextFillRect(context, recordsFrame)
        
        let photoString : NSString = "Place photo here"
        let photoFrame = CGRect(x: 25, y: 125, width: 150, height: 50)
        let width = person.image?.size.width
        let height = person.image?.size.height
        let ratio = height! / width!
        person.image?.drawInRect(CGRect(x: 50, y: 160, width: 120, height: 120 * ratio))
        photoString.drawInRect(photoFrame, withAttributes: recordsAttributes)
                
        drawDottedLine(CGPoint(x: 25, y: 350), toPt: CGPoint(x: 200, y: 350))
        drawDottedLine(CGPoint(x: 25, y: 475), toPt: CGPoint(x: 200, y: 475))

    }
    
    
    func drawTitlePage(pageTitle: String, pageSubTitle: String, pcolor : UIColor) {
        // start new page
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 550, 850), nil)
        let context:CGContextRef = (UIGraphicsGetCurrentContext())!

        // draw background
        let headerFrame = CGRect(x: 25, y: 25, width: 500, height: 800)
        CGContextSetFillColorWithColor(context, pcolor.CGColor)
        CGContextFillRect(context, headerFrame)

        // draw title
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.alignment = NSTextAlignment.Center

        let title : NSString = pageTitle
        let headerAttributes: [String: AnyObject] = [
            NSFontAttributeName : UIFont.systemFontOfSize(60, weight: 5),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSParagraphStyleAttributeName : paraStyle
        ]
        let textFrame = CGRect(x: 50, y: 325, width: 450, height: 150)
        title.drawInRect(textFrame, withAttributes: headerAttributes)

        // draw subtitle
        let subtitle : NSString = pageSubTitle
        let subtitleAttributes: [String: AnyObject] = [
            NSFontAttributeName : UIFont.systemFontOfSize(45, weight: 5),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSParagraphStyleAttributeName : paraStyle
        ]
        let subTitleFrame = CGRect(x: 50, y: 500, width: 450, height: 300)
        subtitle.drawInRect(subTitleFrame, withAttributes: subtitleAttributes)
    
    }

    
    
    func drawMe(me : Person, pcolor : UIColor) {
        // start new page
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 550, 850), nil)
        let context:CGContextRef = (UIGraphicsGetCurrentContext())!
        
        // draw header
        drawHeader(context, color: pcolor, text: "Me")
        
        // draw about
        let nameFrame = CGRect(x: 225, y: 125, width: 300, height: 50)
        let nameString : NSString = ("Name: " + me.name)
        nameString.drawInRect(nameFrame, withAttributes: aboutAttributes)

        let learnFrame = CGRect(x: 225, y: 145, width: 300, height: 425)
        let learnString : NSString = (me.descriptionLabel + " " + me.description)
        learnString.drawInRect(learnFrame, withAttributes: aboutAttributes)

        // draw records
        drawRecords(context, person: me)
        
        // draw birth, death, marriage
        drawVitalStatistics(context, person: me, birthOnly: true, marriage: Marriage())
        
        UIGraphicsAddPDFContextDestinationAtPoint(FamilyTree.me.name, CGPoint(x: 0, y: 0))
    }

    
    func drawChildren(children : [Person], pcolor : UIColor) {
        // start new page
        var pagelength = 850
        if (children.count > 7) {
            pagelength += (children.count - 7) * 100
        }
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 550, CGFloat(pagelength)), nil)
        let context:CGContextRef = (UIGraphicsGetCurrentContext())!

        // draw header
        drawHeader(context, color: pcolor, text: "Children")

        var offset = 0
        for child in children {
            // draw birth, death, marriage
            let nameFrame = CGRect(x: 100, y: 125 + offset, width: 300, height: 50)
            let nameString : NSString = ("Name: " + child.name)
            nameString.drawInRect(nameFrame, withAttributes: vitalsAttributes)

            let birthDateFrame = CGRect(x: 100, y: 145 + offset, width: 300, height: 50)
            let birthPlaceFrame = CGRect(x: 300, y: 145 + offset, width: 300, height: 50)
            let birthDateString : NSString = ("Birth date: " + child.birthDate)
            let birthPlaceString : NSString = ("Place: " + child.birthPlace)
            birthDateString.drawInRect(birthDateFrame, withAttributes: vitalsAttributes)
            birthPlaceString.drawInRect(birthPlaceFrame, withAttributes: vitalsAttributes)
            
            
            let deathDateFrame = CGRect(x: 100, y: 165 + offset, width: 300, height: 50)
            let deathPlaceFrame = CGRect(x: 300, y: 165 + offset, width: 300, height: 50)
            let deathDateString : NSString = ("Death date: " + child.deathDate)
            let deathPlaceString : NSString = ("Place: " + child.deathPlace)
            deathDateString.drawInRect(deathDateFrame, withAttributes: vitalsAttributes)
            deathPlaceString.drawInRect(deathPlaceFrame, withAttributes: vitalsAttributes)
            
            drawDottedLine(CGPoint(x: 25, y: 205 + offset), toPt: CGPoint(x: 525, y: 205 + offset))
            offset += 100
        }
    }
    
    
    func drawDottedLine(fromPt: CGPoint, toPt: CGPoint) {
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: fromPt.x + 2, y: fromPt.y))
        path.addLineToPoint(CGPoint(x: toPt.x + 2, y: toPt.y))
        path.lineWidth = 4
        let dashes: [CGFloat] = [ path.lineWidth * 0, path.lineWidth * 2 ]
        path.setLineDash(dashes, count: dashes.count, phase: 0)
        //path.lineCapStyle = .kCGLineCapRound
        path.lineCapStyle = .Round
        let context:CGContextRef = (UIGraphicsGetCurrentContext())!
        CGContextSetStrokeColorWithColor(context, UIColor.lightGrayColor().CGColor)
        path.stroke()
    }
    
    func drawHeader(context : CGContextRef, color : UIColor, text : String) {
        let headerFrame = CGRect(x: 25, y: 25, width: 500, height: 75)
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, headerFrame)
        let title : NSString = text
        let headerAttributes: [String: AnyObject] = [
            NSFontAttributeName : UIFont.systemFontOfSize(50),
            NSForegroundColorAttributeName : UIColor.whiteColor()
        ]
        let titleFrame = CGRect(x: 50, y: 35, width: 450, height: 60)
        title.drawInRect(titleFrame, withAttributes: headerAttributes)
    }
    
    
    func drawLink(context: CGContextRef, text: String, textFrame: CGRect, fontSize: CGFloat, url: String, backgroundFrame : CGRect, backgroundColor : UIColor) {
        //var frame = CGRect(x: location.x, y: location.y, width: 500, height: 40)
        CGContextSetFillColorWithColor(context, backgroundColor.CGColor)
        CGContextFillRect(context, backgroundFrame)
        let textNS : NSString = text
        
        let attributes: [String: AnyObject] = [
            NSFontAttributeName : UIFont.systemFontOfSize(fontSize),
            NSForegroundColorAttributeName : UIColor.whiteColor()
        ]
        textNS.drawInRect(textFrame, withAttributes: attributes)
        
        let linkFrame = CGRect(x: backgroundFrame.origin.x, y: 850 - backgroundFrame.origin.y - 40, width: backgroundFrame.width, height: backgroundFrame.height)
        UIGraphicsSetPDFContextDestinationForRect(url, linkFrame)
    }
    

}
