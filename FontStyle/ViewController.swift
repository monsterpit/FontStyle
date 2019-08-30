//
//  ViewController.swift
//  FontStyle
//
//  Created by MyGlamm on 8/30/19.
//  Copyright © 2019 MyGlamm. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        print(label1.frame.height)
        
        print(label1.font.lineHeight)
        
        
        print(label1.font.leading)
        
        print(label1.frame.height/label1.font.lineHeight)
        
        print(label1.font.ascender)
    
        
        print(label1.textAlignment.rawValue)
        
        let lines: [String] = getLinesArrayOfString(in: label1)
        
        
        
        print(lines)
        
        
        var textWidth : [CGSize] = []
        
        for (index,line) in lines.enumerated(){
            
            let label2 = UILabel()
            label2.text = line
            textWidth.append( label2.text!.size(withAttributes: [.font: label1.font!]))
            

            
            let view1 : UIView = UIView(frame: CGRect(x: label1.frame.minX, y: (label1.frame.minY  + (label1.font.lineHeight - label1.font.leading) * CGFloat(index+1) - 2 ), width: textWidth[index].width, height: label1.font.descender))
            
            view1.backgroundColor = #colorLiteral(red: 0.9891870618, green: 0.7692108154, blue: 0.7603701353, alpha: 1)
            
            
            
            view.addSubview(view1)
            
            //label1.layer.zPosition = 1
            
            self.view.bringSubviewToFront(label1)
            
        }
        
        


    }
    

    
    func getLinesArrayOfString(in label: UILabel) -> [String] {
        
        /// An empty string's array
        var linesArray = [String]()
        
        guard let text = label.text, let font = label.font else {return linesArray}
        
        let rect = label.frame
        
        let myFont: CTFont = CTFontCreateWithName(font.fontName as CFString, font.pointSize, nil)
        let attStr = NSMutableAttributedString(string: text)
        attStr.addAttribute(kCTFontAttributeName as NSAttributedString.Key, value: myFont, range: NSRange(location: 0, length: attStr.length))
        
        let frameSetter: CTFramesetter = CTFramesetterCreateWithAttributedString(attStr as CFAttributedString)
        let path: CGMutablePath = CGMutablePath()
        path.addRect(CGRect(x: 0, y: 0, width: rect.size.width, height: 100000), transform: .identity)
    
        
        let frame: CTFrame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, nil)
        guard let lines = CTFrameGetLines(frame) as? [Any] else {return linesArray}
        for line in lines {
            let lineRef = line as! CTLine
            let lineRange: CFRange = CTLineGetStringRange(lineRef)
            let range = NSRange(location: lineRange.location, length: lineRange.length)
            let lineString: String = (text as NSString).substring(with: range)
            linesArray.append(lineString)
        }
        return linesArray
    }


}

