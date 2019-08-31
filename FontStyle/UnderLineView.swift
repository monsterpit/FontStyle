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
        
        
        //NSLayoutConstraint
        //        NSLayoutConstraint(item: label4,
        //                           attribute: .leading,
        //                           relatedBy: .equal,
        //                           toItem: label4.superview,
        //                           attribute: .leading,
        //                           multiplier: 1,
        //                           constant: 50).isActive = true
        //
        //
        //        NSLayoutConstraint(item: label4,
        //                           attribute: .trailing,
        //                           relatedBy: .equal,
        //                           toItem: label4.superview,
        //                           attribute: .trailing,
        //                           multiplier: 1,
        //                           constant: -50).isActive = true
        //
        //        NSLayoutConstraint(item: label4,
        //                           attribute: .top,
        //                           relatedBy: .equal,
        //                           toItem: label4.superview,
        //                           attribute: .top,
        //                           multiplier: 1,
        //                           constant: 50).isActive = true
        //
        //        NSLayoutConstraint(item: label4,
        //                           attribute: .bottom,
        //                           relatedBy: .equal,
        //                           toItem: label4.superview,
        //                           attribute: .bottom,
        //                           multiplier: 1,
        //                           constant: -50).isActive = true
        
        
        //method 2  NSLayoutAnchor
        
//        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
//
//        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
//
//        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
//
//        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50).isActive = true
        
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50).isActive = true
        
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50).isActive = true
        
    }
    
    
    
}
