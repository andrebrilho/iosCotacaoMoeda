//
//  SegmentedControll.swift
//  Cotação Moeda
//
//  Created by André Brilho on 02/01/17.
//  Copyright © 2017 Andre Brilho. All rights reserved.
//

import UIKit

@IBDesignable class SegmentedControll: UIControl {

    private var labels = [UILabel]()
    var thumbView = UIView()
    var itens:[String] = ["Item 1","Item 2","Item 3"]{
            didSet{
                setupLabels()
            }
    }
    
    var selectedIndex : Int = 0{
        didSet{
            displayNewSelectedIndex()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
       
    }

    
    func setupView(){
    
        layer.cornerRadius = frame.height / 2
        layer.borderColor = UIColor(white: 1.0, alpha: 0.5).CGColor
        layer.borderWidth = 2
        
        backgroundColor = UIColor.clearColor()
        setupLabels()
        insertSubview(thumbView, atIndex: 0)
    }
    
    
    func setupLabels(){
        for label in labels {
        label.removeFromSuperview()
    }
    labels.removeAll(keepCapacity:true)
        
        for index in 1...itens.count{
            let label = UILabel(frame: CGRectZero)
            label.text = itens[index - 1]
            label.textAlignment = .Center
            label.textColor = UIColor(white: 0.5, alpha: 1.0)
            self.addSubview(label)
            labels.append(label)
        }
    }
    
    override func layoutSubviews() {
        
        var selectedFrame = self.bounds
        let neWidht = CGRectGetWidth(selectedFrame) / CGFloat(itens.count)
        selectedFrame.size.width = neWidht
        thumbView.frame = selectedFrame
        thumbView.backgroundColor = UIColor.whiteColor()
        thumbView.layer.cornerRadius = thumbView.frame.height / 2
        
        let labelHeight = self.bounds.height
        let labelWidth = self.bounds.width / CGFloat(labels.count)
        
        for index in 0...labels.count - 1{
            var label = labels[index]
            
            let xPosition = CGFloat(index) * labelWidth
            label.frame = CGRectMake(xPosition, 0, labelWidth, labelHeight)
        }
        
    }
    
    
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        
        let location = touch.locationInView(self)
        var calculatedIndex : Int?
        for (index, item) in EnumerateSequence(labels){
            if item.frame.contains(location){
                calculatedIndex = index
            }
        }
        
        if calculatedIndex != nil {
            selectedIndex = calculatedIndex!
            sendActionsForControlEvents(.ValueChanged)
        }
        
        return false
        
    }
    
    
    
    
    func displayNewSelectedIndex(){
        var label = labels[selectedIndex]
        self.thumbView.frame = label.frame
    
    
    }
    
}
    

