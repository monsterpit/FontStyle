//
//  UnderLineView.swift
//  FontStyle
//
//  Created by Vikas Salian on 8/30/19.
//  Copyright © 2019 MB. All rights reserved.
//

import UIKit

class UnderLineView : UILabel{
    
    
    //Keeps track of all UnderLine Views
    private var underline_Views : [UIView] = []
    
    //Variable that keeps track of underline color set during " createUnderLineViews "
    private var underLineColor : UIColor = #colorLiteral(red: 0.9891870618, green: 0.7692108154, blue: 0.7603701353, alpha: 1)
    
    private var animationDuration : Double = 0.5
    
    private  var isRemoving : Bool = false
    
    private var isAdding : Bool = false
    
    private var displayingUnderLineViews : [UIView] = []
    
    private var currentIndex : Int = 0
    
    private var isAnimating : Bool = false
    


    
    /**
     This method set's up text, font , color and aligment of text in our label of UnderLineView
     
     - Parameters:
     - withText: The text for the label , default is ""
     - withFont: The font for the text , default is UIFont.systemFont(ofSize: 15)
     - withColor: The color of the text , default is black
     - withAlignment: The alignment of text , default is .natural
     
     
     */
    func setupTextForLabel(withText text : String? = "",withFont font : UIFont = UIFont.systemFont(ofSize: 15),withColor color : UIColor = .black,withAlignment alignment : NSTextAlignment? = .natural,withFontSize fontSize : CGFloat = 16){
        
        self.numberOfLines = 0
        
        if fontSize == 16{
            self.font = font
            
        }
        else{
            self.font = UIFont.init(name: "D-DIN-Bold", size: fontSize)  ?? UIFont.systemFont(ofSize: fontSize)
        }
        
        self.text = text
        self.textColor = color
        self.textAlignment = alignment!
        
        
    }
    
    
    func setupTextForLabel(withText text : NSAttributedString? = NSAttributedString(string: ""),withFont font : UIFont = UIFont.systemFont(ofSize: 15),withColor color : UIColor = .black,withAlignment alignment : NSTextAlignment? = .natural,withFontSize fontSize : CGFloat = 16){
        
        if fontSize == 16{
            self.font = font
            
        }
        else{
            self.font = UIFont.init(name: "D-DIN-Bold", size: fontSize)  ?? UIFont.systemFont(ofSize: fontSize)
        }
        
        self.attributedText = text
        self.textColor = color
        self.textAlignment = alignment!
        
        
    }
    
    
    
    
    
    /**
     Takes in color and creates the underline with specified color. Use in viewDidAppear or on tap events
     
     - Parameters:
     - withColor: The color of the underline default colorr is pink
     - withHeight: The height of the underline default height is labelText.font.descender
     
     */
    func createUnderLineViews(withColor color : UIColor = #colorLiteral(red: 0.9891870618, green: 0.7692108154, blue: 0.7603701353, alpha: 1) ,withHeight height : CGFloat = 0,withDuration duration : Double = 0.5,animation : Bool = false){
        
        print("isRemoving \(isRemoving)")
        print("isAdding \(isAdding)")
        
        isAnimating = animation
        
        if underline_Views.isEmpty {
            
            animationDuration = duration
            
            underLineColor = color
            
            createUnderLineViews(withHeight : height)
            
        }
        
        
        if isAdding{
            return
        }
        else{
            //            if displayingUnderLineViews.isEmpty{
            //
            //                    isAdding = true
            //                    animateComingOfUnderLine()
            //
            //
            //            }
            if displayingUnderLineViews.count == underline_Views.count{
                isAdding = false
                return
            }
            else {
                
                isAdding = true
                animateComingOfUnderLine(index: currentIndex)
                
                
            }
        }
        
    }
    
    
    
    /**
     Takes array of UIView which animate from left to right (using gradient and CABasicAnimation and  CATransaction for Completion)and takes color for underline
     
     - Parameters:
     - animatingView: Array of UIViews for animation
     - colorOfUnderLine: Color of Underline
     - index : index of view in underline_Views
     */
    private func animateComingOfUnderLine(index : Int = 0){
        
        
        
        if isAnimating{
            
            CATransaction.begin()
            
            currentIndex = index
            
            if !isRemoving{
                
                
                
                displayingUnderLineViews = Array(underline_Views[0...currentIndex])

                superview?.addSubview(displayingUnderLineViews[currentIndex])

                superview?.bringSubviewToFront(self)

            }
            else{
                
                if let _ = displayingUnderLineViews[exist : currentIndex]{
                    _ = displayingUnderLineViews[currentIndex].layer.sublayers?.popLast()
                }
                else{
                    displayingUnderLineViews = Array(underline_Views[0...currentIndex])
                    superview?.addSubview(displayingUnderLineViews[currentIndex])

                    superview?.bringSubviewToFront(self)

                }
                
            }
            isRemoving = false
            
            
            let gradient = CAGradientLayer(layer: displayingUnderLineViews[currentIndex].layer)
            let startLocations = [0, 0]
            let endLocations = [1, 1]
            
            gradient.colors = [underLineColor.cgColor, UIColor.clear.cgColor]
            gradient.frame = self.frame
            gradient.locations = startLocations as [NSNumber]
            gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradient.frame = displayingUnderLineViews[currentIndex].bounds
            
            displayingUnderLineViews[currentIndex].layer.addSublayer(gradient)
            
            
            let anim = CABasicAnimation(keyPath: "locations")
            anim.fromValue = startLocations
            anim.toValue = endLocations
            anim.duration = animationDuration
            
            // Callback function
            CATransaction.setCompletionBlock {  [weak self] in
                
                if !(self?.isRemoving ?? false){
                    
                    print("added underline number ",((self?.currentIndex  ?? 0 ) + 1))
                    print("Total underline Views " , (self?.underline_Views.count ?? 0)  )
                    
                    
                    
                    
                    if ( (self?.currentIndex ?? 0) + 1) < (self?.underline_Views.count ?? 0){
                        self?.animateComingOfUnderLine(index: ((self?.currentIndex ?? 0 ) + 1))
                    }
                    if (self?.currentIndex ) == ((self?.underline_Views.count ?? 0) - 1){
                        self?.isAdding = false
                    }
                    
                }
                else{
                    
                    self?.isAdding = false
                    
                    
                    print("added underline number ",((self?.currentIndex  ?? 0 ) + 1))
                    print("Total underline Views " , (self?.underline_Views.count ?? 0)  )
                    
                    
                    
                }
            }
            
            gradient.add(anim, forKey: "underLineAddition")
            gradient.locations = endLocations as [NSNumber]
            
            
            CATransaction.commit()
            
            
        }
            
        else
            
        {
            for pos in (index...(underline_Views.count-1))
            {
                currentIndex = pos
                
                
                displayingUnderLineViews = Array(underline_Views[0...currentIndex])
                displayingUnderLineViews[currentIndex].backgroundColor = underLineColor
                

                superview?.addSubview(displayingUnderLineViews[currentIndex])

                superview?.bringSubviewToFront(self)

            }
            
        }
        
        
        
        
        
    }
    
    
    private func createUnderLineViews(withHeight height : CGFloat){
        
        
        
        let lines = self.getLinesArrayOfString()
        
        print(lines)
        
        for (index,line) in lines.enumerated(){
            
            let lineSize = (line as NSString).size(withAttributes: [.font: self.font!])
            
            var underLine_View : UIView!
            
            
            
            switch self.textAlignment {
            case .center:
                underLine_View = UIView(frame: CGRect(x: (self.frame.midX - (lineSize.width/2)), y: ( ( self.frame.minY  + (self.font.lineHeight ) * CGFloat(index+1) ) - self.font.leading ), width: lineSize.width, height: (height != 0 ? height : (self.font.descender * CGFloat(1.5) ))))
                
            case .right:
                underLine_View = UIView(frame: CGRect(x: (self.frame.maxX - lineSize.width), y: ( ( self.frame.minY  + (self.font.lineHeight ) * CGFloat(index+1) ) - self.font.leading ), width: lineSize.width, height: (height != 0 ? height : (self.font.descender * CGFloat(1.5) ))))
                
            default:
                underLine_View = UIView(frame: CGRect(x: self.frame.minX, y: ( ( self.frame.minY  + (self.font.lineHeight ) * CGFloat(index+1) ) - self.font.leading ), width: lineSize.width, height: (height != 0 ? height : (self.font.descender * CGFloat(1.5) ))))
            }
            
            underline_Views.append(underLine_View)
            
            
        }
        
    }
    
    
    
    /**
     This method animate the removal of underline ,by first removing previously added layer then adding the animating layer and then finally removing that view
     
     */
    
    
    func removeunderLineViews(){
        
        //        if !isRemoving{
        //            isRemoving = true
        //
        //        }
        
        print("isRemoving \(isRemoving)")
        print("isAdding \(isAdding)")
        
        if isRemoving{
            return
        }
        else{
            
            if displayingUnderLineViews.isEmpty{
                isRemoving = false
                return
            }
            else{
                isRemoving = true
                animateRemovingOfUnderLine(index: currentIndex )
                
            }
            
            
            
        }
        
        
    }
    
    
    /**
     Takes array of UIView which animate from right to left (using gradient and CABasicAnimation and  CATransaction for Completion)and takes color for underline, that is it goes from color to clear
     
     - Parameters:
     - index : index of view in underline_Views which goes from last count to zero
     */
    private func animateRemovingOfUnderLine(index : Int = 0){
        
        
        
        
        CATransaction.begin()
        
        currentIndex = index
        isAdding = false
        
        let gradient = CAGradientLayer(layer: displayingUnderLineViews[index].layer)
        let startLocations = [1, 1]
        let endLocations = [0, 0]
        
        gradient.colors = [underLineColor.cgColor, UIColor.clear.cgColor]
        gradient.frame = self.frame
        gradient.locations = startLocations as [NSNumber]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = displayingUnderLineViews[index].bounds
        
        
        _ = displayingUnderLineViews[index].layer.sublayers?.popLast()
        displayingUnderLineViews[index].layer.addSublayer(gradient)
        
        
        let anim = CABasicAnimation(keyPath: "locations")
        anim.fromValue = startLocations
        anim.toValue = endLocations
        anim.duration = animationDuration
        
        // Callback function
        CATransaction.setCompletionBlock {  [weak self] in
            
            if !(self?.isAdding ?? false){
                
                
                
                print("removed underline number \(self?.currentIndex) ")
                print("Total underline Views " , (self?.displayingUnderLineViews.count ?? 0)  )
                
                
                if let _ = self?.displayingUnderLineViews[exist: index] {
                    self?.displayingUnderLineViews[index].removeFromSuperview()
                    self?.displayingUnderLineViews.remove(at: index)
                }
                
                
                
                
                let nextIndex = (index - 1)
                
                if nextIndex >= 0{
                    
                    self?.animateRemovingOfUnderLine(index: nextIndex)
                }
                if nextIndex == 0{
                    self?.isRemoving = false
                }
                
            }
            else{
                
                self?.isRemoving = false

                print("added underline number ",((self?.currentIndex  ?? 0 ) + 1))
                print("Total underline Views " , (self?.underline_Views.count ?? 0)  )
                
                
            }
            
        }
        
        gradient.add(anim, forKey: "underLineRemoval")
        gradient.locations = endLocations as [NSNumber]
        
        
        CATransaction.commit()
        
    }
    
    
    
    
    
    
}
