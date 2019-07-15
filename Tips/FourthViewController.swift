//
//  FourthViewController.swift
//  Tips
//
//  Created by 小西壮 on 2019/06/08.
//  Copyright © 2019 小西壮. All rights reserved.
//

import UIKit
import RealmSwift

class FourthViewController: UIViewController {

    var num = 1
    let tipsDatabase = TipsDatabase()
    let displayTips = DisplayTips()
    
    @IBOutlet weak var table1: UIView!
    @IBOutlet weak var table2: UIView!
    @IBOutlet weak var table3: UIView!
    @IBOutlet weak var table4: UIView!
    @IBOutlet weak var table5: UIView!
    @IBOutlet weak var table6: UIView!
    @IBOutlet weak var maintable: UIView!
    
    @IBOutlet weak var pocketView1: UIView!
    @IBOutlet weak var pocketView2: UIView!
    @IBOutlet weak var pocketView3: UIView!
    @IBOutlet weak var pocketView4: UIView!
    @IBOutlet weak var pocketView5: UIView!
    @IBOutlet weak var pocketView6: UIView!
    
    var tableArray:[UIView] = []
    var pocketArray:[UIView] = []
    
    @IBOutlet var playerListView: UIView!
    @IBOutlet var betTipsView: UIView!
    @IBOutlet weak var verticalSlider: UISlider!
    
    var refreshControl = UIRefreshControl()
    @IBOutlet weak var playerTableView: UITableView!
    
    var gapX:CGFloat = 0.0  // x座標
    var gapY:CGFloat = 0.0  // y座標
    var positioni = 0
    var price:Int!
    var betPrice:Int!
    var playerbetPrice:Int!
    var restPrice:Int!
    var floatPrice:Float!
    var tagvar:Int!
    var betbox:[Int] = [0,0,0,0,0,0]
    var podSumPrice:Int!
    
    @IBOutlet weak var maxPriceLabel: UILabel!
    @IBOutlet weak var minPriceLabel: UILabel!
    @IBOutlet weak var betPriceLabel: UILabel!
    @IBOutlet weak var mainPocketLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableArray = [table1,table2,table3,table4,table5,table6]
        pocketArray = [pocketView1,pocketView2,pocketView3,pocketView4,pocketView5,pocketView6]

        playerTableView.delegate = self
        playerTableView.dataSource = self
        playerTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(EntranceViewController.refresh(sender:)), for: .valueChanged)
        
        verticalSlider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
        verticalSlider.setThumbImage(UIImage(named: "ThumbSlider.png"), for:.normal)
        
        tipsDatabase.getAll()
        podSumPrice = 0
        
        for i in 0...tipsDatabase.database.count-1 {
                
            positioni = 0
            
            price = (tipsDatabase.database[i]["betPrice"]! as? Int)!
                
            displayTips.insertTips(tipsNum: price/1000, imageName: "Tips_$25", tipsView: tableArray[i],positionX: 100,positionY:100, positioni: positioni)

            positioni += price/1000

            displayTips.insertTips(tipsNum: price%1000/100, imageName: "Tips_$100", tipsView: tableArray[i],positionX: 100, positionY: 100,positioni: positioni)

            positioni += price%1000/100

            displayTips.insertTips(tipsNum: price%100/10, imageName: "Tips_$50", tipsView: tableArray[i], positionX: 100, positionY: 100, positioni: positioni)
            
        }

    }

    @IBAction func playerListBtn(_ sender: UIButton) {
    
        self.view.addSubview(playerListView)
        playerListView.center = self.view.center
        playerListView.layer.cornerRadius = 5
        playerListView.layer.masksToBounds = true
    
    }
    
    @IBAction func didTapBtn(_ sender: UIButton) {
    
        self.view.addSubview(betTipsView)
        betTipsView.center = self.view.center
        betTipsView.layer.cornerRadius = 5
        betTipsView.layer.masksToBounds = true
        tagvar = sender.tag-1
        
        let subViews = self.betTipsView.subviews
        for subview in subViews{
            if subview.tag == 11 {
                subview.removeFromSuperview()
            }
        }
        
        verticalSlider.value = 0
        
        playerbetPrice = tipsDatabase.database[tagvar]["betPrice"]! as? Int
        maxPriceLabel.text = String(playerbetPrice)
        minPriceLabel.text = "0"
        betPriceLabel.text = "0"
        print(tipsDatabase.database[tagvar]["betPrice"]!)
        print("タグ")
        print(sender.tag)
        
    }
    
    @IBAction func betSlider(_ sender: UISlider) {
    
        floatPrice = Float(playerbetPrice)
        betPrice = Int(sender.value * floatPrice)
        betPriceLabel.text = String(betPrice)
        
        let subViews = self.betTipsView.subviews
        for subview in subViews{
            if subview.tag == 11 {
                subview.removeFromSuperview()
            }
        }
            
        positioni = 0
        
        displayTips.insertTips(tipsNum: betPrice/1000, imageName: "Tips_$25", tipsView: betTipsView,positionX: 272,positionY:200, positioni: positioni)
        
        positioni += betPrice/1000
        
        displayTips.insertTips(tipsNum: betPrice%1000/100, imageName: "Tips_$100", tipsView: betTipsView,positionX: 272, positionY: 200,positioni: positioni)
        
        positioni += betPrice%1000/100
        
        displayTips.insertTips(tipsNum: betPrice%100/10, imageName: "Tips_$50", tipsView: betTipsView, positionX: 272, positionY: 200, positioni: positioni)
        
    }
    
    @IBAction func deleteBtn(_ sender: UIButton) {
        self.playerListView.removeFromSuperview()
        self.betTipsView.removeFromSuperview()
    }
    
    func removeAllSubviews(parentView: UIView){
        let subviews = parentView.subviews
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
    
    
    @IBAction func raiseBtn(_ sender: UIButton) {
    
        if betPrice != nil {
            
            print("a")
            let subViews = self.tableArray[tagvar].subviews
            for subview in subViews{
                if subview.tag == 11{
                    subview.removeFromSuperview()
                }
            }

            restPrice = playerbetPrice! - betPrice!
            positioni = 0

            displayTips.insertTips(tipsNum: restPrice/1000, imageName: "Tips_$25", tipsView: tableArray[tagvar],positionX: 100, positionY: 100, positioni: positioni)
            
            positioni += restPrice/1000
            
            displayTips.insertTips(tipsNum: restPrice!%1000/100, imageName: "Tips_$100", tipsView: tableArray[tagvar],positionX: 100, positionY: 100, positioni: positioni)
            
            positioni += restPrice!%1000/100
            
            displayTips.insertTips(tipsNum: restPrice!%100/10, imageName: "Tips_$50", tipsView: tableArray[tagvar],positionX: 100, positionY: 100, positioni: positioni)
            
            positioni = 0
            
            print("d")
            print(positioni)
            displayTips.insertTips(tipsNum: betPrice!/1000, imageName: "Tips_$25", tipsView: pocketArray[tagvar],positionX: 100, positionY: 30, positioni: positioni)
            
            positioni += betPrice!/1000
            print(positioni)
            displayTips.insertTips(tipsNum: betPrice!%1000/100, imageName: "Tips_$100", tipsView: pocketArray[tagvar],positionX: 100, positionY: 30, positioni: positioni)
            
            positioni += betPrice!%1000/100
            print(positioni)
            displayTips.insertTips(tipsNum: betPrice!%100/10, imageName: "Tips_$50", tipsView: pocketArray[tagvar],positionX: 100, positionY: 30, positioni: positioni)
            
            print("e")
            self.betTipsView.removeFromSuperview()
            
            betbox[tagvar] = betPrice!
            podSumPrice += betPrice!
            mainPocketLabel.text = String(podSumPrice)
            
            tipsDatabase.update(id:tipsDatabase.database[tagvar]["id"]! as! Int , betPrice: restPrice)
        
        }
    
    }
    
    @IBAction func sumBtn(_ sender: UIButton) {
    
        for i in 0...pocketArray.count-1{
            let subViews = self.pocketArray[i].subviews
            for subview in subViews{
                if subview.tag == 11{
                    subview.removeFromSuperview()
                }
            }
        }
        
        if podSumPrice != nil && podSumPrice != 0 {
            
            positioni = 0
            
//            price = (tipsDatabase.database[i]["betPrice"]! as? Int)!
            
            displayTips.insertTips(tipsNum: podSumPrice/1000, imageName: "Tips_$25", tipsView: maintable,positionX: 445,positionY:175, positioni: positioni)
            
            positioni += podSumPrice/1000
            
            displayTips.insertTips(tipsNum: podSumPrice%1000/100, imageName: "Tips_$100", tipsView: maintable,positionX: 445, positionY: 175,positioni: positioni)
            
            positioni += podSumPrice%1000/100
            
            displayTips.insertTips(tipsNum: podSumPrice%100/10, imageName: "Tips_$50", tipsView: maintable, positionX: 445, positionY: 175, positioni: positioni)
            
        }
        
        tipsDatabase.getAll()
        print(tipsDatabase)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        if let touch = touches.first {
            if let touchedView = touch.view {
                if touchedView.tag == 11 {
                    gapX = touch.location(in: view).x - touchedView.center.x
                    gapY = touch.location(in: view).y - touchedView.center.y
                    touchedView.center = CGPoint(x: touch.location(in: view).x - gapX, y: touch.location(in: view).y - gapY)
                }
            }
        }
        
        self.view.endEditing(true)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if let touchedView = touch.view {
                if touchedView.tag == 11 {
                    touchedView.center = CGPoint(x: touch.location(in: view).x - gapX, y: touch.location(in: view).y - gapY)
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        gapX = 0.0
        gapY = 0.0
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touchesEnded(touches, with: event)
    }
}

extension FourthViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tipsDatabase.database.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as? PlayerTableViewCell
        print("tableViewなう")
        print(tipsDatabase.database[indexPath.row]["betPrice"]!)
        cell?.playerNameLabel!.text = tipsDatabase.database[indexPath.row]["playerName"] as? String
        cell?.betPriceLabel!.text = String(tipsDatabase.database[indexPath.row]["betPrice"]! as! Int)
        cell?.layoutIfNeeded()
        
        return cell!
    }
    
}
