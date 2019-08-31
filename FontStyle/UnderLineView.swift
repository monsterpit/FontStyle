//
//  UnderLineView.swift
//  FontStyle
//
//  Created by MyGlamm on 8/30/19.
//  Copyright © 2019 MyGlamm. All rights reserved.
//

import UIKit

class UnderLineView : UIView{
    
    private var labelText = UILabel()
    
    private var underline_Views : [UIView] = []

    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setupLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabel()
    }
    
    

    
    
    
    private func setupLabel(){
        
       // setupTextForLabel()
        
        //backgroundColor = .red
        
        labelText.numberOfLines = 0
        
        
        
        
        //Add label
        addSubview(labelText)
        
        
        labelText.translatesAutoresizingMaskIntoConstraints = false
        
        labelText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        labelText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        
        labelText.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        
        labelText.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        
        
    }
    
    
    func setupTextForLabel(withText text : String? = "",withFont font : UIFont = UIFont.systemFont(ofSize: 15),withColor color : UIColor = .black,withAlignment alignment : NSTextAlignment? = .natural){
        
        labelText.font = font
        labelText.text = text
        labelText.textColor = color
        labelText.textAlignment = alignment!
        
    
    }

    
    
    
    /**
     Takes in color and creates the underline with specified color. Use in viewDidLayoutSubViews or on tap events
     
     - Parameters:
     - withColor: The color of the underline default colorr is pink
     - withHeight: The height of the underline default height is labelText.font.descender

     */
    func createUnderLineViews(withColor color : UIColor = #colorLiteral(red: 0.9891870618, green: 0.7692108154, blue: 0.7603701353, alpha: 1) ,withHeight height : CGFloat = 0){

        let lines = labelText.getLinesArrayOfString()

        print(lines)

        
        for (index,line) in lines.enumerated(){
            
            let lineSize = (line as NSString).size(withAttributes: [.font: labelText.font!])

            
            let underLine_View : UIView = UIView(frame: CGRect(x: labelText.frame.minX, y: ( ( labelText.frame.minY  + (labelText.font.lineHeight ) * CGFloat(index+1) ) - labelText.font.leading ), width: lineSize.width, height: (height != 0 ? height : (labelText.font.descender * CGFloat(1.5) ))))
            
            underLine_View.backgroundColor = color
            
            
            
            addSubview(underLine_View)
            
            //label1.layer.zPosition = 1
            
            bringSubviewToFront(labelText)
            
            
            
        }
        
    
    }
    
}
