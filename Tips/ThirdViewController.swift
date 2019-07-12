//
//  ThirdViewController.swift
//  Tips
//
//  Created by 小西壮 on 2019/06/04.
//  Copyright © 2019 小西壮. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    let displayTips = DisplayTips()
    
    @IBOutlet weak var atButton: UIButton!
    @IBOutlet var betTipsView: UIView!
    @IBOutlet weak var verticalSlider: UISlider!
    
    @IBOutlet weak var priceLabel1: UILabel!
    @IBOutlet weak var priceTextField1: UITextField!
    
    @IBOutlet weak var tipsView1: UIView!
    
    @IBOutlet weak var maxPriceLabel: UILabel!
    @IBOutlet weak var minPriceLabel: UILabel!
    @IBOutlet weak var betPriceLabel: UILabel!
    
    var gapX:CGFloat = 0.0  // x座標
    var gapY:CGFloat = 0.0  // y座標
    var positioni = 0
    var price:Int!
    var betPrice:Int!
    var restPrice:Int!
    var floatPrice:Float!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        verticalSlider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
        verticalSlider.setThumbImage(UIImage(named: "ThumbSlider.png"), for:.normal)
        
    }

    @IBAction func didTapButton(_ sender: UIButton) {
        
        self.view.addSubview(betTipsView)
        betTipsView.center = self.view.center
        betTipsView.layer.cornerRadius = 5
        betTipsView.layer.masksToBounds = true
        
        maxPriceLabel.text = priceTextField1.text
        minPriceLabel.text = "0"
        betPriceLabel.text = "0"
        
    }
    
    @IBAction func inputBtn(_ sender: UIButton) {
    
        priceLabel1.text = priceTextField1.text
        price = Int(priceTextField1.text!)
        print(price)

        if priceTextField1.text != "" {
            
            positioni = 0
            
            displayTips.insertTips(tipsNum: price!/1000, imageName: "Tips_$25", tipsView: tipsView1,positionX: 100,positionY:100, positioni: positioni)
            
            positioni += price!/1000
            print(positioni)
            
            displayTips.insertTips(tipsNum: price!%1000/100, imageName: "Tips_$100", tipsView: tipsView1,positionX: 100, positionY: 100,positioni: positioni)
            
            positioni += price!%1000/100
            print(positioni)
            
            displayTips.insertTips(tipsNum: price!%100/10, imageName: "Tips_$50", tipsView: tipsView1, positionX: 100, positionY: 100, positioni: positioni)
            
        }
        
    }
    
    @IBAction func betSlider(_ sender: UISlider) {
        
        floatPrice = Float(price)
        betPrice = Int(sender.value * floatPrice)
        betPriceLabel.text = String(betPrice)
        
        let subViews = self.betTipsView.subviews
        for subview in subViews{
            if subview.tag == 1 {
                subview.removeFromSuperview()
            }
        }
        
        if priceTextField1.text != "" {
            
            positioni = 0
            
            displayTips.insertTips(tipsNum: betPrice/1000, imageName: "Tips_$25", tipsView: betTipsView,positionX: 300,positionY:150, positioni: positioni)
            
            positioni += betPrice/1000
            print(positioni)
            
            displayTips.insertTips(tipsNum: betPrice%1000/100, imageName: "Tips_$100", tipsView: betTipsView,positionX: 300, positionY: 150,positioni: positioni)
            
            positioni += betPrice%1000/100
            print(positioni)
            
            displayTips.insertTips(tipsNum: betPrice%100/10, imageName: "Tips_$50", tipsView: betTipsView, positionX: 300, positionY: 150, positioni: positioni)
            
        }
        
        
    }
    
    @IBAction func betBtn(_ sender: UIButton) {
    
//        if betTextField.text != "" {
        
        let subViews = self.tipsView1.subviews
        for subview in subViews{
            if subview.tag == 1{
                subview.removeFromSuperview()
            }
        }
        
        restPrice = price! - betPrice!
        priceLabel1.text = String(restPrice)
        positioni = 0
        
//        removeAllSubviews(parentView: tipsView1)
        
        displayTips.insertTips(tipsNum: restPrice/1000, imageName: "Tips_$25", tipsView: tipsView1,positionX: 100, positionY: 100, positioni: positioni)
        
        positioni += restPrice/1000
        
        displayTips.insertTips(tipsNum: restPrice!%1000/100, imageName: "Tips_$100", tipsView: tipsView1,positionX: 100, positionY: 100, positioni: positioni)
        
        positioni += restPrice!%1000/100
        
        displayTips.insertTips(tipsNum: restPrice!%100/10, imageName: "Tips_$50", tipsView: tipsView1,positionX: 100, positionY: 100, positioni: positioni)
        
        positioni = 0
        
        displayTips.insertTips(tipsNum: betPrice!/1000, imageName: "Tips_$25", tipsView: tipsView1,positionX: 200, positionY: 100, positioni: positioni)
        
        positioni = betPrice!/1000
        
        displayTips.insertTips(tipsNum: betPrice!%1000/100, imageName: "Tips_$100", tipsView: tipsView1,positionX: 200, positionY: 100, positioni: positioni)
        
        positioni = betPrice!%100/10
        
        displayTips.insertTips(tipsNum: betPrice!%100/10, imageName: "Tips_$50", tipsView: tipsView1,positionX: 200, positionY: 100, positioni: positioni)
            
//        }
        self.betTipsView.removeFromSuperview()
    }
    
    func removeAllSubviews(parentView: UIView){
        let subviews = parentView.subviews
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 最初にタッチした指のみ取得
        if let touch = touches.first {
            // タッチしたビューをviewプロパティで取得する
            if let touchedView = touch.view {
                // tagでおじさんかそうでないかを判断する
                if touchedView.tag == 1 {
                    // タッチした場所とタッチしたビューの中心座標がどうずれているか？
                    gapX = touch.location(in: view).x - touchedView.center.x
                    gapY = touch.location(in: view).y - touchedView.center.y
                    // 例えば、タッチしたビューの中心のxが50、タッチした場所のxが60→中心から10ずれ
                    // この場合、指を100に持って行ったらビューの中心は90にしたい
                    // ビューの中心90 = 持って行った場所100 - ずれ10
                    touchedView.center = CGPoint(x: touch.location(in: view).x - gapX, y: touch.location(in: view).y - gapY)
                }
            }
        }
        
        self.view.endEditing(true)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // touchesBeganと同じ処理だが、gapXとgapYはタッチ中で同じものを使い続ける
        // 最初にタッチした指のみ取得
        if let touch = touches.first {
            // タッチしたビューをviewプロパティで取得する
            if let touchedView = touch.view {
                // tagでおじさんかそうでないかを判断する
                if touchedView.tag == 1 {
                    // gapX,gapYの取得は行わない
                    touchedView.center = CGPoint(x: touch.location(in: view).x - gapX, y: touch.location(in: view).y - gapY)
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // gapXとgapYの初期化
        gapX = 0.0
        gapY = 0.0
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        // touchesEndedと同じ処理
        self.touchesEnded(touches, with: event)
    }
}
