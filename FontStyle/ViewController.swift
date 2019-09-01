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

        
        
        underLineView.setupTextForLabel(withText: "Horizontal Video Slider Horizontal Video Slider Horizontal Video Slider  ", withFont: UIFont(name: "D-DIN", size: 32)!, withColor: .blue,withAlignment: .natural)
 
       

    }
    
    override func viewDidAppear(_ animated: Bool) {
        //underLineView.createUnderLineViews()
          print( "underLineView.frame ", underLineView.frame)
    }


    @IBAction func buttonTapped(_ sender: UIButton) {
        underLineView.createUnderLineViews()
       
    }
    

    @IBAction func remove(_ sender: UIButton) {
        
        underLineView.removeunderLineViews()
    }
}

