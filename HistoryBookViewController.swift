
//
//  HistoryBookViewController.swift
//  Copyright (c) 2017 Robin Reynolds. All rights reserved.
//

// color scheme: http://colorschemedesigner.com/csd-3.5/#5z42lw0w0w0w0

// TODO: create a new page for each 7 children (only 7 children fit on one page)

import UIKit

class HistoryBookViewController: UIViewController {
    
    var familypdf = "myfamily.pdf"
    var margin = 25
    var pagesize = CGRect(x: 0, y: 0, width: 550, height: 850)
    var treeColor = UIColor(red: 183/255, green: 46/255, blue: 62/255, alpha: 1.0)
    
    @IBOutlet weak var webView: UIWebView!
    
    // UIDocumentInteractionController instance is a class property
    var docController:UIDocumentInteractionController!
    
    @IBAction func openBook(_ sender: AnyObject) {
        docController.presentOptionsMenu(from: sender as! UIBarButtonItem, animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        generatePDF()
        
        let fileName = familypdf
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = paths[0] as NSString
        let pdfPathWithFileName = documentDirectory.appendingPathComponent(fileName as String)
        
        let url = URL(fileURLWithPath: pdfPathWithFileName)
        let request = URLRequest(url: url)
        webView.loadRequest(request)
        
        // retrieve URL to file in main bundle
        var bookpath = "itms-books:" + pdfPathWithFileName
        bookpath = pdfPathWithFileName
        let bookurl = URL(fileURLWithPath: bookpath)
        self.docController = UIDocumentInteractionController(url: bookurl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func generatePDF() {
        let fileName = familypdf
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = paths[0] as NSString
        let pdfPathWithFileName = documentDirectory.appendingPathComponent(fileName as String)

        
        UIGraphicsBeginPDFContextToFile(pdfPathWithFileName, CGRect.zero, nil)

        // title page
        drawTitlePage("My Family", pageSubTitle: "", pcolor: GlobalData.oneTree.me.color)
        
        // table of contents
        drawTOC()
        
        // me
        drawMe(GlobalData.oneTree.me, pcolor: GlobalData.oneTree.me.color)
        
        // families
        let families = [
            GlobalData.oneTree.parents,
            GlobalData.oneTree.grandParentsFather,
            GlobalData.oneTree.grandParentsMother,
            GlobalData.oneTree.greatGrandParentsFatherFather,
            GlobalData.oneTree.greatGrandParentsFatherMother,
            GlobalData.oneTree.greatGrandParentsMotherFather,
            GlobalData.oneTree.greatGrandParentsMotherMother
        ]
        
        for family in families {
            drawTitlePage(family.friendlyName1, pageSubTitle:family.friendlyName2, pcolor: family.color)
            drawParent(family.father, pmarriage : family.marriage, pcolor : family.color, ptype: PersonType.father)
            drawParent(family.mother, pmarriage : family.marriage, pcolor : family.color, ptype: PersonType.mother)
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
            (GlobalData.oneTree.me.name, GlobalData.oneTree.me.color),
            (GlobalData.oneTree.parents.father.name, GlobalData.oneTree.parents.color),
            (GlobalData.oneTree.parents.mother.name, GlobalData.oneTree.parents.color),
            (GlobalData.oneTree.grandParentsFather.father.name, GlobalData.oneTree.grandParentsFather.color),
            (GlobalData.oneTree.grandParentsFather.mother.name, GlobalData.oneTree.grandParentsFather.color),
            (GlobalData.oneTree.grandParentsMother.father.name, GlobalData.oneTree.grandParentsFather.color),
            (GlobalData.oneTree.grandParentsMother.mother.name, GlobalData.oneTree.grandParentsFather.color),
            (GlobalData.oneTree.greatGrandParentsFatherFather.father.name, GlobalData.oneTree.greatGrandParentsFatherFather.color),
            (GlobalData.oneTree.greatGrandParentsFatherFather.mother.name, GlobalData.oneTree.greatGrandParentsFatherFather.color),
            (GlobalData.oneTree.greatGrandParentsFatherMother.father.name, GlobalData.oneTree.greatGrandParentsFatherFather.color),
            (GlobalData.oneTree.greatGrandParentsFatherMother.mother.name, GlobalData.oneTree.greatGrandParentsFatherFather.color),
            (GlobalData.oneTree.greatGrandParentsMotherFather.father.name, GlobalData.oneTree.greatGrandParentsFatherFather.color),
            (GlobalData.oneTree.greatGrandParentsMotherFather.mother.name, GlobalData.oneTree.greatGrandParentsFatherFather.color),
            (GlobalData.oneTree.greatGrandParentsMotherMother.father.name, GlobalData.oneTree.greatGrandParentsFatherFather.color),
            (GlobalData.oneTree.greatGrandParentsMotherMother.mother.name, GlobalData.oneTree.greatGrandParentsFatherFather.color)]
        
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
        drawFamily(context, family: GlobalData.oneTree.greatGrandParentsFatherFather, left: 300, top: 110, spacing: 100)
        drawFamily(context, family: GlobalData.oneTree.greatGrandParentsFatherMother, left: 300, top: 310, spacing: 100)
        drawFamily(context, family: GlobalData.oneTree.greatGrandParentsMotherFather, left: 300, top: 510, spacing: 100)
        drawFamily(context, family: GlobalData.oneTree.greatGrandParentsMotherMother, left: 300, top: 710, spacing: 100)
        
        // draw grandparents
        drawFamily(context, family: GlobalData.oneTree.grandParentsFather, left: 200, top: 160, spacing: 200)
        drawFamily(context, family: GlobalData.oneTree.grandParentsMother, left: 200, top: 560, spacing: 200)
        
        // draw parents
        drawFamily(context, family: GlobalData.oneTree.parents, left: 105, top: 265, spacing: 400)
        

        // draw me
        drawLink(
            context,
            text: GlobalData.oneTree.me.name,
            textFrame: CGRect(x: 30, y: 470, width: 215, height: 30),
            fontSize: CGFloat(20),
            url: GlobalData.oneTree.me.name,
            backgroundFrame: CGRect(x: 25, y: 465, width: 225, height: 30),
            backgroundColor: GlobalData.oneTree.me.color)

        
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
    
    func drawLine(_ context : CGContext, from : CGPoint, to : CGPoint) {
        let mid = CGPoint(x: from.x, y: to.y)
        let plusPath = UIBezierPath()
        plusPath.lineWidth = CGFloat(3.0)
        plusPath.move(to: from)
        plusPath.addLine(to: mid)
        plusPath.addLine(to: to)
        UIColor.lightGray.setStroke()
        plusPath.stroke()
    }
    
    
    func drawFamily(_ context : CGContext, family : Family, left : Int, top : Int, spacing : Int) {
        
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
    

    var aboutAttributes: [NSAttributedStringKey: AnyObject] = [
        NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17),
        NSAttributedStringKey.foregroundColor : UIColor.black
    ]
    
    var vitalsAttributes: [NSAttributedStringKey: AnyObject] = [
        NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17),
        NSAttributedStringKey.foregroundColor : UIColor.black
    ]

    var recordsAttributes: [NSAttributedStringKey: AnyObject] = [
        NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17),
        NSAttributedStringKey.foregroundColor : UIColor.black
    ]
    

    func drawParent(_ parent : Person, pmarriage : Marriage, pcolor : UIColor, ptype : PersonType) {
        
        // start new page
        UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: 550, height: 850), nil)
        let context:CGContext = (UIGraphicsGetCurrentContext())!

        // draw header
        let name = (ptype == .father ? "Father" : "Mother")
        drawHeader(context, color: pcolor, text: name)
        
        // draw about
        let nameFrame = CGRect(x: 225, y: 125, width: 300, height: 50)
        let nameString : NSString = ("Name: " + parent.name as NSString)
        nameString.draw(in: nameFrame, withAttributes: aboutAttributes)
        
        let storiesFrame = CGRect(x: 225, y: 145, width: 300, height: 425)
        let storiesString : NSString = (parent.descriptionLabel + " " + parent.description as NSString)
        storiesString.draw(in: storiesFrame, withAttributes: aboutAttributes)
        
        // draw records
        drawRecords(context, person: parent)
        
        // draw birth, death, marriage
        drawVitalStatistics(context, person: parent, birthOnly: false, marriage: pmarriage)
        
        UIGraphicsAddPDFContextDestinationAtPoint(parent.name, CGPoint(x: 25, y: 25))

    }
    
    func drawVitalStatistics(_ context : CGContext, person : Person, birthOnly : Bool, marriage : Marriage) {
        // draw birth, death, marriage
        let birthDateFrame = CGRect(x: 225, y: 655, width: 300, height: 50)
        let birthPlaceFrame = CGRect(x: 225, y: 675, width: 300, height: 50)
        let birthDateString : NSString = ("Birth date: " + person.birth.date as NSString)
        let birthPlaceString : NSString = ("Place: " + person.birth.place as NSString)
        birthDateString.draw(in: birthDateFrame, withAttributes: vitalsAttributes)
        birthPlaceString.draw(in: birthPlaceFrame, withAttributes: vitalsAttributes)
        
        if (!birthOnly) {
            let deathDateFrame = CGRect(x: 225, y: 695, width: 300, height: 50)
            let deathPlaceFrame = CGRect(x: 225, y: 715, width: 300, height: 50)
            let deathDateString : NSString = ("Death date: " + person.death.date as NSString)
            let deathPlaceString : NSString = ("Place: " + person.death.place as NSString)
            deathDateString.draw(in: deathDateFrame, withAttributes: vitalsAttributes)
            deathPlaceString.draw(in: deathPlaceFrame, withAttributes: vitalsAttributes)
        
            let marriageDateFrame = CGRect(x: 225, y: 760, width: 300, height: 50)
            let marriagePlaceFrame = CGRect(x: 225, y: 780, width: 300, height: 50)
            let marriageDateString : NSString = ("Marriage date: " + marriage.wedding.date as NSString)
            let marriagePlaceString : NSString = ("Place: " + marriage.wedding.place as NSString)
            marriageDateString.draw(in: marriageDateFrame, withAttributes: vitalsAttributes)
            marriagePlaceString.draw(in: marriagePlaceFrame, withAttributes: vitalsAttributes)
            drawDottedLine(CGPoint(x: 25, y: 750), toPt: CGPoint(x: 525, y: 750))
        }

        drawDottedLine(CGPoint(x: 25, y: 650), toPt: CGPoint(x: 525, y: 650))

    }
    
    func drawRecords(_ context: CGContext, person : Person) {
        // draw records
        let recordsFrame = CGRect(x: 25, y: 125, width: 175, height: 500)
        let lightGray = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
        context.setFillColor(lightGray)
        context.fill(recordsFrame)
        
        let photoString : NSString = "Place photo here"
        let photoFrame = CGRect(x: 25, y: 125, width: 150, height: 50)
        let width = person.image.size.width
        let height = person.image.size.height
        let ratio = height / width
        person.image.draw(in: CGRect(x: 50, y: 160, width: 120, height: 120 * ratio))
        photoString.draw(in: photoFrame, withAttributes: recordsAttributes)
                
        drawDottedLine(CGPoint(x: 25, y: 350), toPt: CGPoint(x: 200, y: 350))
        drawDottedLine(CGPoint(x: 25, y: 475), toPt: CGPoint(x: 200, y: 475))

    }
    
    
    func drawTitlePage(_ pageTitle: String, pageSubTitle: String, pcolor : UIColor) {
        // start new page
        UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: 550, height: 850), nil)
        let context:CGContext = (UIGraphicsGetCurrentContext())!

        // draw background
        let headerFrame = CGRect(x: 25, y: 25, width: 500, height: 800)
        context.setFillColor(pcolor.cgColor)
        context.fill(headerFrame)

        // draw title
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.alignment = NSTextAlignment.center

        let title : NSString = pageTitle as NSString
        let headerAttributes: [NSAttributedStringKey: AnyObject] = [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 60, weight: UIFont.Weight(rawValue: 5)),
            NSAttributedStringKey.foregroundColor : UIColor.white,
            NSAttributedStringKey.paragraphStyle : paraStyle
        ]
        let textFrame = CGRect(x: 50, y: 325, width: 450, height: 150)
        title.draw(in: textFrame, withAttributes: headerAttributes)

        // draw subtitle
        let subtitle : NSString = pageSubTitle as NSString
        let subtitleAttributes: [NSAttributedStringKey: AnyObject] = [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 45, weight: UIFont.Weight(rawValue: 5)),
            NSAttributedStringKey.foregroundColor : UIColor.white,
            NSAttributedStringKey.paragraphStyle : paraStyle
        ]
        let subTitleFrame = CGRect(x: 50, y: 500, width: 450, height: 300)
        subtitle.draw(in: subTitleFrame, withAttributes: subtitleAttributes)
    
    }

    
    
    func drawMe(_ me : Person, pcolor : UIColor) {
        // start new page
        UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: 550, height: 850), nil)
        let context:CGContext = (UIGraphicsGetCurrentContext())!
        
        // draw header
        drawHeader(context, color: pcolor, text: "Me")
        
        // draw about
        let nameFrame = CGRect(x: 225, y: 125, width: 300, height: 50)
        let nameString : NSString = ("Name: " + me.name as NSString)
        nameString.draw(in: nameFrame, withAttributes: aboutAttributes)

        let learnFrame = CGRect(x: 225, y: 145, width: 300, height: 425)
        let learnString : NSString = (me.descriptionLabel + " " + me.description as NSString)
        learnString.draw(in: learnFrame, withAttributes: aboutAttributes)

        // draw records
        drawRecords(context, person: me)
        
        // draw birth, death, marriage
        drawVitalStatistics(context, person: me, birthOnly: true, marriage: Marriage())
        
        UIGraphicsAddPDFContextDestinationAtPoint(GlobalData.oneTree.me.name, CGPoint(x: 0, y: 0))
    }

    
    func drawChildren(_ children : [Person], pcolor : UIColor) {
        // start new page
        var pagelength = 850
        if (children.count > 7) {
            pagelength += (children.count - 7) * 100
        }
        UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: 550, height: CGFloat(pagelength)), nil)
        let context:CGContext = (UIGraphicsGetCurrentContext())!

        // draw header
        drawHeader(context, color: pcolor, text: "Children")

        var offset = 0
        for child in children {
            // draw birth, death, marriage
            let nameFrame = CGRect(x: 100, y: 125 + offset, width: 300, height: 50)
            let nameString : NSString = ("Name: " + child.name as NSString)
            nameString.draw(in: nameFrame, withAttributes: vitalsAttributes)

            let birthDateFrame = CGRect(x: 100, y: 145 + offset, width: 300, height: 50)
            let birthPlaceFrame = CGRect(x: 300, y: 145 + offset, width: 300, height: 50)
            let birthDateString : NSString = ("Birth date: " + child.birth.date as NSString)
            let birthPlaceString : NSString = ("Place: " + child.birth.place as NSString)
            birthDateString.draw(in: birthDateFrame, withAttributes: vitalsAttributes)
            birthPlaceString.draw(in: birthPlaceFrame, withAttributes: vitalsAttributes)
            
            
            let deathDateFrame = CGRect(x: 100, y: 165 + offset, width: 300, height: 50)
            let deathPlaceFrame = CGRect(x: 300, y: 165 + offset, width: 300, height: 50)
            let deathDateString : NSString = ("Death date: " + child.death.date as NSString)
            let deathPlaceString : NSString = ("Place: " + child.death.place as NSString)
            deathDateString.draw(in: deathDateFrame, withAttributes: vitalsAttributes)
            deathPlaceString.draw(in: deathPlaceFrame, withAttributes: vitalsAttributes)
            
            drawDottedLine(CGPoint(x: 25, y: 205 + offset), toPt: CGPoint(x: 525, y: 205 + offset))
            offset += 100
        }
    }
    
    
    func drawDottedLine(_ fromPt: CGPoint, toPt: CGPoint) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: fromPt.x + 2, y: fromPt.y))
        path.addLine(to: CGPoint(x: toPt.x + 2, y: toPt.y))
        path.lineWidth = 4
        let dashes: [CGFloat] = [ path.lineWidth * 0, path.lineWidth * 2 ]
        path.setLineDash(dashes, count: dashes.count, phase: 0)
        //path.lineCapStyle = .kCGLineCapRound
        path.lineCapStyle = .round
        let context:CGContext = (UIGraphicsGetCurrentContext())!
        context.setStrokeColor(UIColor.lightGray.cgColor)
        path.stroke()
    }
    
    func drawHeader(_ context : CGContext, color : UIColor, text : String) {
        let headerFrame = CGRect(x: 25, y: 25, width: 500, height: 75)
        context.setFillColor(color.cgColor)
        context.fill(headerFrame)
        let title : NSString = text as NSString
        let headerAttributes: [NSAttributedStringKey: AnyObject] = [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 50),
            NSAttributedStringKey.foregroundColor : UIColor.white
        ]
        let titleFrame = CGRect(x: 50, y: 35, width: 450, height: 60)
        title.draw(in: titleFrame, withAttributes: headerAttributes)
    }
    
    
    func drawLink(_ context: CGContext, text: String, textFrame: CGRect, fontSize: CGFloat, url: String, backgroundFrame : CGRect, backgroundColor : UIColor) {
        //var frame = CGRect(x: location.x, y: location.y, width: 500, height: 40)
        context.setFillColor(backgroundColor.cgColor)
        context.fill(backgroundFrame)
        let textNS : NSString = text as NSString
        
        let attributes: [NSAttributedStringKey: AnyObject] = [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: fontSize),
            NSAttributedStringKey.foregroundColor : UIColor.white
        ]
        textNS.draw(in: textFrame, withAttributes: attributes)
        
        let linkFrame = CGRect(x: backgroundFrame.origin.x, y: 850 - backgroundFrame.origin.y - 40, width: backgroundFrame.width, height: backgroundFrame.height)
        UIGraphicsSetPDFContextDestinationForRect(url, linkFrame)
    }
    

}
