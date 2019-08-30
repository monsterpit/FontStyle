//
//  UnderLineView.swift
//  FontStyle
//
//  Created by MyGlamm on 8/30/19.
//  Copyright © 2019 MyGlamm. All rights reserved.
//

import UIKit

class UnderLineView : UIView{
    
    private var label = UILabel()
    
    
    var labelText = ""{
        didSet {
            label.text = labelText
        }
    }
    
    var alignment : NSTextAlignment = .natural{
        didSet{
            label.textAlignment = alignment
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    private func setupLabel(){
        
        //Add label
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
    }
    
    
    
}
