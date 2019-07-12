//
//  secoundViewController.swift
//  Tips
//
//  Created by 小西壮 on 2019/05/29.
//  Copyright © 2019 小西壮. All rights reserved.
//

import UIKit

class secoundViewController: UIViewController{

    let displayTips = DisplayTips()
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var betTextField: UITextField!
    
    @IBOutlet weak var tipsView: UIView!
    var gapX:CGFloat = 0.0  // x座標
    var gapY:CGFloat = 0.0  // y座標
    var positioni = 0
    var price:Int!
    var betPrice:Int!
    var restPrice:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func inputBtn(_ sender: UIButton) {

        priceLabel.text = priceTextField.text
        price = Int(priceTextField.text!)
        
        if priceTextField.text != "" {
        
            positioni = 0
            
            displayTips.insertTips(tipsNum: price!/1000, imageName: "Tips_$25", tipsView: tipsView,positionX: 100, positionY: 400, positioni: positioni)
            
            positioni += price!/1000
            print(positioni)
            
            displayTips.insertTips(tipsNum: price!%1000/100, imageName: "Tips_$100", tipsView: tipsView,positionX: 100, positionY: 400,positioni: positioni)
            
            positioni += price!%1000/100
            print(positioni)
            
            displayTips.insertTips(tipsNum: price!%100/10, imageName: "Tips_$50", tipsView: tipsView, positionX: 100, positionY: 400, positioni: positioni)
        
        }

    }
    
    @IBAction func betBtn(_ sender: UIButton) {
        
        betPrice = Int(betTextField.text!)
        
        if betTextField.text != "" {
        
            restPrice = price! - betPrice!
            priceLabel.text = String(restPrice)
            positioni = 0
            
            removeAllSubviews(parentView: tipsView)
            
            displayTips.insertTips(tipsNum: restPrice/1000, imageName: "Tips_$25", tipsView: tipsView,positionX: 100, positionY: 400, positioni: positioni)
            
            positioni += restPrice/1000
            
            displayTips.insertTips(tipsNum: restPrice!%1000/100, imageName: "Tips_$100", tipsView: tipsView,positionX: 100, positionY: 400, positioni: positioni)
            
            positioni += restPrice!%1000/100
            
            displayTips.insertTips(tipsNum: restPrice!%100/10, imageName: "Tips_$50", tipsView: tipsView,positionX: 100, positionY: 400, positioni: positioni)
            
            positioni = 0
            
            displayTips.insertTips(tipsNum: betPrice!/1000, imageName: "Tips_$25", tipsView: tipsView,positionX: 200, positionY: 400, positioni: positioni)
            
            positioni = betPrice!/1000
            
            displayTips.insertTips(tipsNum: betPrice!%1000/100, imageName: "Tips_$100", tipsView: tipsView,positionX: 200, positionY: 400, positioni: positioni)
            
            positioni = betPrice!%100/10
            
            displayTips.insertTips(tipsNum: betPrice!%100/10, imageName: "Tips_$100", tipsView: tipsView,positionX: 200, positionY: 400, positioni: positioni)
            
        }
        
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



//            if price!/1000 != 0{
//                for i in 1...price!/1000{
//                    let tipsImage25 = UIImageView(image: UIImage(named: "Tips_$25"))
//                    tipsImage25.frame = CGRect(x: 100, y: 400 - 4*i, width: 50, height: 50)
//                    tipsImage25.isUserInteractionEnabled = true
//                    tipsImage25.tag = 1
//                    tipsView.addSubview(tipsImage25)
//                }
//                positioni += price!/1000
//            }
//            if price!%1000/100 != 0{
//                for i in 1...price!%1000/100{
//                    let tipsImage25 = UIImageView(image: UIImage(named: "Tips_$100"))
//                    tipsImage25.frame = CGRect(x: 100, y: 400 - 4*(i+positioni), width: 50, height: 50)
//                    tipsImage25.isUserInteractionEnabled = true
//                    tipsImage25.tag = 1
//                    tipsView.addSubview(tipsImage25)
//                }
//                positioni += price!%1000/100
//            }
//            if price!%100/10 != 0{
//                for i in 1...price!%100/10{
//                    let tipsImage25 = UIImageView(image: UIImage(named: "Tips_$50"))
//                    tipsImage25.frame = CGRect(x: 100, y: 400 - 4*(i+positioni), width: 50, height: 50)
//                    tipsImage25.isUserInteractionEnabled = true
//                    tipsImage25.tag = 1
//                    tipsView.addSubview(tipsImage25)
//                }
//                positioni += price!%100/10
//            }

//            if restPrice/1000 != 0{
//                for i in 1...restPrice!/1000{
//                    let tipsImage25 = UIImageView(image: UIImage(named: "Tips_$25"))
//                    tipsImage25.frame = CGRect(x: 100, y: 400 - 4*i, width: 50, height: 50)
//                    tipsImage25.isUserInteractionEnabled = true
//                    tipsImage25.tag = 1
//                    tipsView.addSubview(tipsImage25)
//                }
//                positioni += restPrice/1000
//            }
//            if restPrice!%1000/100 != 0{
//                for i in 1...restPrice!%1000/100{
//                    let tipsImage25 = UIImageView(image: UIImage(named: "Tips_$100"))
//                    tipsImage25.frame = CGRect(x: 100, y: 400 - 4*(i+positioni), width: 50, height: 50)
//                    tipsImage25.isUserInteractionEnabled = true
//                    tipsImage25.tag = 1
//                    tipsView.addSubview(tipsImage25)
//                }
//                positioni += restPrice!%1000/100
//            }
//            if restPrice!%100/10 != 0{
//                for i in 1...restPrice!%100/10{
//                    let tipsImage25 = UIImageView(image: UIImage(named: "Tips_$50"))
//                    tipsImage25.frame = CGRect(x: 100, y: 400 - 4*(i+positioni), width: 50, height: 50)
//                    tipsImage25.isUserInteractionEnabled = true
//                    tipsImage25.tag = 1
//                    tipsView.addSubview(tipsImage25)
//                }
//                positioni += restPrice!%100/10
//            }
//
//            positioni = 0
//
//            if betPrice!/1000 != 0{
//                for i in 1...betPrice!/1000{
//                    let tipsImage25 = UIImageView(image: UIImage(named: "Tips_$25"))
//                    tipsImage25.frame = CGRect(x: 200, y: 400 - 4*i, width: 50, height: 50)
//                    tipsImage25.isUserInteractionEnabled = true
//                    tipsImage25.tag = 1
//                    tipsView.addSubview(tipsImage25)
//                }
//                positioni += betPrice!/1000
//            }
//            if betPrice!%1000/100 != 0{
//                for i in 1...betPrice!%1000/100{
//                    let tipsImage25 = UIImageView(image: UIImage(named: "Tips_$100"))
//                    tipsImage25.frame = CGRect(x: 200, y: 400 - 4*(i+positioni), width: 50, height: 50)
//                    tipsImage25.isUserInteractionEnabled = true
//                    tipsImage25.tag = 1
//                    tipsView.addSubview(tipsImage25)
//                }
//                positioni += betPrice!%1000/100
//            }
//            if betPrice!%100/10 != 0{
//                for i in 1...betPrice!%100/10{
//                    let tipsImage25 = UIImageView(image: UIImage(named: "Tips_$50"))
//                    tipsImage25.frame = CGRect(x: 200, y: 400 - 4*(i+positioni), width: 50, height: 50)
//                    tipsImage25.isUserInteractionEnabled = true
//                    tipsImage25.tag = 1
//                    tipsView.addSubview(tipsImage25)
//                }
//                positioni += betPrice!%100/10
//            }
