//
//  TestController.swift
//  BenkyoSpike
//
//  Created by Jason Cheladyn on 3/28/17.
//  Copyright © 2017 Liyicky. All rights reserved.
//

import UIKit

class TestController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView?
    @IBOutlet weak var pageControl: UIPageControl?
    var button1: UIButton!
    var button2: UIButton!
    var button3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let screenWidth: CGFloat = (self.scrollView?.bounds.size.width)!
        let screenHeight: CGFloat = (self.scrollView?.bounds.size.height)!
        
        self.scrollView?.contentSize = CGSize(width: screenWidth * 4, height: (self.scrollView?.bounds.size.height)!)
        scrollView?.isPagingEnabled = true
        
        self.button1 = UIButton(frame: CGRect(x: screenWidth/2, y: screenHeight/2, width: 100, height: 50))
        button1.backgroundColor = .green
        button1.setTitle("Test Button 1", for: .normal)
        
        self.button2 = UIButton(frame: CGRect(x: screenWidth*2, y: screenHeight/2, width: 100, height: 50))
        button2.backgroundColor = .green
        button2.setTitle("Test Button 2", for: .normal)
        
        self.button3 = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button3.backgroundColor = .green
        button3.setTitle("Test Button 3", for: .normal)
        
        scrollView?.addSubview(button1)
        scrollView?.addSubview(button2)
        scrollView?.addSubview(button3)
    }
    
}
