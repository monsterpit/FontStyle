//
//  UnderLineView.swift
//  FontStyle
//
//  Created by Vikas Salian on 8/30/19.
//  Copyright © 2019 MB. All rights reserved.
//

import UIKit

class UnderLineView : UIView{
    
    //label which has whole text
    private var labelText = UILabel()
    
    //Keeps track of all UnderLine Views
    private var underline_Views : [UIView] = []

    //Variable that keeps track of underline color set during " createUnderLineViews "
    private var underLineColor : UIColor = #colorLiteral(red: 0.9891870618, green: 0.7692108154, blue: 0.7603701353, alpha: 1)
    
    private var animationDuration : Double = 0.5
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setupLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabel()
    }

    //Used to setup  constraints label in our custom UnderLineView view (which contains 1 label and array of underlineView)
    private func setupLabel(){

        
        labelText.numberOfLines = 0

        addSubview(labelText)
        
        
        labelText.translatesAutoresizingMaskIntoConstraints = false
        
        labelText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        labelText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        
        labelText.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        
        labelText.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        
        
    }
    
    
    /**
     This method set's up text, font , color and aligment of text in our label of UnderLineView
     
     - Parameters:
     - withText: The text for the label , default is ""
     - withFont: The font for the text , default is UIFont.systemFont(ofSize: 15)
     - withColor: The color of the text , default is black
     - withAlignment: The alignment of text , default is .natural
     
     
     */
    func setupTextForLabel(withText text : String? = "",withFont font : UIFont = UIFont.systemFont(ofSize: 15),withColor color : UIColor = .black,withAlignment alignment : NSTextAlignment? = .natural){
        
        labelText.font = font
        labelText.text = text
        labelText.textColor = color
        labelText.textAlignment = alignment!
        
    
    }

    
    
    
    /**
     Takes in color and creates the underline with specified color. Use in viewDidAppear or on tap events
     
     - Parameters:
     - withColor: The color of the underline default colorr is pink
     - withHeight: The height of the underline default height is labelText.font.descender

     */
    func createUnderLineViews(withColor color : UIColor = #colorLiteral(red: 0.9891870618, green: 0.7692108154, blue: 0.7603701353, alpha: 1) ,withHeight height : CGFloat = 0,withDuration duration : Double = 0.5){
        
        if underline_Views.isEmpty {
     
        animationDuration = duration
            
        underLineColor = color
        
            createUnderLineViews(withHeight : height)

            animateComingOfUnderLine(animatingView : underline_Views,colorOfUnderLine : underLineColor)
            
        }
        
        else {
            
            if isRemoving{
                
                let currentIndex = (underline_Views.count)
                
                isRemoving = false
                
                createUnderLineViews(withHeight : height)
                
                animateComingOfUnderLine(animatingView : underline_Views,colorOfUnderLine : underLineColor,index: currentIndex)
            }
            
            
        }
    
    }
    
    private func createUnderLineViews(withHeight height : CGFloat){
        
        
        
        let lines = labelText.getLinesArrayOfString()
        
        print(lines)
        
        for (index,line) in lines.enumerated(){
            
            let lineSize = (line as NSString).size(withAttributes: [.font: labelText.font!])
            
            var underLine_View : UIView!
            
            
            
            switch labelText.textAlignment {
            case .center:
                underLine_View = UIView(frame: CGRect(x: (labelText.frame.midX - (lineSize.width/2)), y: ( ( labelText.frame.minY  + (labelText.font.lineHeight ) * CGFloat(index+1) ) - labelText.font.leading ), width: lineSize.width, height: (height != 0 ? height : (labelText.font.descender * CGFloat(1.5) ))))
                
            case .right:
                underLine_View = UIView(frame: CGRect(x: (labelText.frame.maxX - lineSize.width), y: ( ( labelText.frame.minY  + (labelText.font.lineHeight ) * CGFloat(index+1) ) - labelText.font.leading ), width: lineSize.width, height: (height != 0 ? height : (labelText.font.descender * CGFloat(1.5) ))))
                
            default:
                underLine_View = UIView(frame: CGRect(x: labelText.frame.minX, y: ( ( labelText.frame.minY  + (labelText.font.lineHeight ) * CGFloat(index+1) ) - labelText.font.leading ), width: lineSize.width, height: (height != 0 ? height : (labelText.font.descender * CGFloat(1.5) ))))
            }
            
            underline_Views.append(underLine_View)
            
            
        }
        
    }
    
    /**
     Takes array of UIView which animate from left to right (using gradient and CABasicAnimation and  CATransaction for Completion)and takes color for underline
     
     - Parameters:
     - animatingView: Array of UIViews for animation
     - colorOfUnderLine: Color of Underline
     - index : index of view in underline_Views
     */
    private func animateComingOfUnderLine(animatingView : [UIView],colorOfUnderLine : UIColor = .red,index : Int = 0){
        
        if !isRemoving {
        
        addSubview(animatingView[index])
        

        //label1.layer.zPosition = 1
        
        bringSubviewToFront(labelText)
        
        
        CATransaction.begin()
        
        let gradient = CAGradientLayer(layer: animatingView[index].layer)
        let startLocations = [0, 0]
        let endLocations = [1, 1]
        
        gradient.colors = [colorOfUnderLine.cgColor, UIColor.clear.cgColor]
        gradient.frame = self.frame
        gradient.locations = startLocations as [NSNumber]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = animatingView[index].bounds

        animatingView[index].layer.addSublayer(gradient)
        
        
        let anim = CABasicAnimation(keyPath: "locations")
        anim.fromValue = startLocations
        anim.toValue = endLocations
        anim.duration = animationDuration
      
        // Callback function
        CATransaction.setCompletionBlock {  [weak self] in
            print("added underline number \(index + 1) ")
            print("animatingViews \(animatingView.count)")
            if (index + 1) < animatingView.count{
                self?.animateComingOfUnderLine(animatingView : animatingView,colorOfUnderLine : colorOfUnderLine,index: (index + 1))
            }
            
            print()
        }
       
        gradient.add(anim, forKey: "underLineAddition")
        gradient.locations = endLocations as [NSNumber]

        
        CATransaction.commit()
        
        }
    }
    

    
    /**
     This method animate the removal of underline ,by first removing previously added layer then adding the animating layer and then finally removing that view

     */
    
    var isRemoving : Bool = false
    func removeunderLineViews(){
        
        if !isRemoving{
            isRemoving = true
            animateRemovingOfUnderLine(index: (underline_Views.count - 1) )
        }
    }
    
    
    /**
     Takes array of UIView which animate from right to left (using gradient and CABasicAnimation and  CATransaction for Completion)and takes color for underline, that is it goes from color to clear
     
     - Parameters:
     - index : index of view in underline_Views which goes from last count to zero
     */
    private func animateRemovingOfUnderLine(index : Int = 0){
        
 
        if !underline_Views.isEmpty {
            
            CATransaction.begin()
            
            let gradient = CAGradientLayer(layer: underline_Views[index].layer)
            let startLocations = [1, 1]
            let endLocations = [0, 0]
            
            gradient.colors = [underLineColor.cgColor, UIColor.clear.cgColor]
            gradient.frame = self.frame
            gradient.locations = startLocations as [NSNumber]
            gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradient.frame = underline_Views[index].bounds
            
            
            _ = underline_Views[index].layer.sublayers?.popLast()
            underline_Views[index].layer.addSublayer(gradient)
            
            
            let anim = CABasicAnimation(keyPath: "locations")
            anim.fromValue = startLocations
            anim.toValue = endLocations
            anim.duration = animationDuration
            
            // Callback function
            CATransaction.setCompletionBlock {  [weak self] in
                print("removed underline number \(index + 1) ")
                self?.underline_Views[index].removeFromSuperview()
                self?.underline_Views.remove(at: index)
                if (index - 1) >= 0{
                    
                    self?.animateRemovingOfUnderLine(index: (index - 1))
                    
                    if (index - 1 ) == 0{
                        self?.isRemoving = false
                    }
                }
                
            }
            
            gradient.add(anim, forKey: "underLineRemoval")
            gradient.locations = endLocations as [NSNumber]
            
            
            CATransaction.commit()
            
        }
        
        
    }
    
    
}
