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

        
        
        underLineView.setupTextForLabel(withText: "Horizontal Video Slider Horizontal Video S Horizontal Video Slider Horizontal Video S", withFont: UIFont(name: "D-DIN", size: 24)!, withColor: .blue)
 
       

    }
    

    

    @IBAction func buttonTapped(_ sender: UIButton) {
        underLineView.createUnderLineViews()
    }
    

}

