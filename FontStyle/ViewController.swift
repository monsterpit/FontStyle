//
//  ViewController.swift
//  FontStyle
//
//  Created by MyGlamm on 8/30/19.
//  Copyright © 2019 MyGlamm. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

 
    
    @IBOutlet weak var underLineView: UnderLineView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        

 
        let arrayString = [
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
            "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
            "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        ]
        
        let attributedText = add(stringList: arrayString, font: underLineView.font, bullet: "")
        
        let stringTo = NSAttributedString(string: "Horizontal Video Slider Horizontal \n\n Video Slider Horizontal Video Slider ")
        
        let muta = NSMutableAttributedString()
        
        muta.append(stringTo)
        
        muta.append(attributedText)
        
        underLineView.setupTextForLabel(withText: muta, withFont: UIFont(name: "D-DIN", size: 32)!, withColor: .blue,withAlignment: .natural)
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        //underLineView.createUnderLineViews()
          print( "underLineView.frame ", underLineView.frame)
    }


    @IBAction func buttonTapped(_ sender: UIButton) {
        underLineView.createUnderLineViews(animation: true)
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
//            cell.titleLbl.createUnderLineViews()
//        })
    }
    

    @IBAction func remove(_ sender: UIButton) {
        
        underLineView.removeunderLineViews()
    }
    
    func add(stringList: [String],
             font: UIFont,
             bullet: String = "\u{2022}",
             indentation: CGFloat = 20,
             lineSpacing: CGFloat = 2,
             paragraphSpacing: CGFloat = 12,
             textColor: UIColor = .gray,
             bulletColor: UIColor = .green) -> NSAttributedString {
        
        let textAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: textColor]
        let bulletAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: bulletColor]
        
        let paragraphStyle = NSMutableParagraphStyle()
        let nonOptions = [NSTextTab.OptionKey: Any]()
        paragraphStyle.tabStops = [
            NSTextTab(textAlignment: .left, location: indentation, options: nonOptions)]
        paragraphStyle.defaultTabInterval = indentation
        //paragraphStyle.firstLineHeadIndent = 0
        //paragraphStyle.headIndent = 20
        //paragraphStyle.tailIndent = 1
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.paragraphSpacing = paragraphSpacing
        paragraphStyle.headIndent = indentation
        
        let bulletList = NSMutableAttributedString()
        for string in stringList {
            let formattedString = "\(bullet)\t\(string)\n"
            let attributedString = NSMutableAttributedString(string: formattedString)
            
            attributedString.addAttributes(
                [NSAttributedString.Key.paragraphStyle : paragraphStyle],
                range: NSMakeRange(0, attributedString.length))
            
            attributedString.addAttributes(
                textAttributes,
                range: NSMakeRange(0, attributedString.length))
            
            let string:NSString = NSString(string: formattedString)
            let rangeForBullet:NSRange = string.range(of: bullet)
            attributedString.addAttributes(bulletAttributes, range: rangeForBullet)
            bulletList.append(attributedString)
        }
        
        return bulletList
    }
    
    
}

