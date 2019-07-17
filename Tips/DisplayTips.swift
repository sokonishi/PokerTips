//
//  DisplayTips.swift
//  Tips
//
//  Created by 小西壮 on 2019/06/02.
//  Copyright © 2019 小西壮. All rights reserved.
//

import Foundation
import UIKit

class DisplayTips{
    
    func insertTips(tipsNum:Int,imageName:String,tipsView:UIView,positionX:Int,positionY:Int,positioni:Int){
        
        if tipsNum != 0{
            for i in 1...tipsNum{
                let tipsImage25 = UIImageView(image: UIImage(named: imageName))
                tipsImage25.frame = CGRect(x: positionX, y: positionY - 4*(i+positioni), width: 42, height: 42)
                tipsImage25.isUserInteractionEnabled = true
                tipsImage25.tag = 11
                tipsView.addSubview(tipsImage25)
            }
        }
    }
    
    
    func showTips(price:Int,tableArrayUIView:UIView,positionX:Int,positionY:Int){
        
        var positioni = 0
        
        insertTips(tipsNum: price/1000, imageName: "Tips_$25", tipsView: tableArrayUIView,positionX: positionX,positionY:positionY, positioni: positioni)
        
        positioni += price/1000
        
        insertTips(tipsNum: price%1000/100, imageName: "Tips_$100", tipsView: tableArrayUIView,positionX: positionX, positionY: positionY,positioni: positioni)
        
        positioni += price%1000/100
        
        insertTips(tipsNum: price%100/10, imageName: "Tips_$50", tipsView: tableArrayUIView, positionX: positionX, positionY: positionY, positioni: positioni)
        
    }
    
}
