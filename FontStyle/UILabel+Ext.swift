//
//  UILabel+Extension.swift
//  FontStyle
//
//  Created by MB on 8/31/19.
//  Copyright © 2019 MyGlamm. All rights reserved.
//

import UIKit

extension UILabel{
    
    /**
     Takes in label and returns the array of text in that label.
     
     - Returns: A String in each line of label.
     */
    func getLinesArrayOfString() -> [String] {
        
        guard var text = text, let font = font else { return [] }
        
        
        text = String(text[..<((text.range(of: "\n\n"))?.lowerBound ?? text.endIndex)])
       
        
        
        let ctFont = CTFontCreateWithName(font.fontName as CFString, font.pointSize, nil)
        let attStr = NSMutableAttributedString(string: text)
        attStr.addAttribute(kCTFontAttributeName as NSAttributedString.Key, value: ctFont, range: NSRange(location: 0, length: attStr.length))
        let frameSetter = CTFramesetterCreateWithAttributedString(attStr as CFAttributedString)
        let path = CGMutablePath()
        path.addRect(CGRect(x: 0, y: 0, width: self.frame.size.width, height: CGFloat.greatestFiniteMagnitude), transform: .identity)
        let frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, nil)
        guard let lines = CTFrameGetLines(frame) as? [Any] else { return [] }
        return lines.map { line in
            let lineRef = line as! CTLine
            let lineRange: CFRange = CTLineGetStringRange(lineRef)
            let range = NSRange(location: lineRange.location, length: lineRange.length)
            return (text as NSString).substring(with: range)
        }
    }
    
}



extension Collection where Indices.Iterator.Element == Index {
    subscript (exist index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}


