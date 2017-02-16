//
//  ViewController.swift
//  finalCode
//
//  Created by 楊世暐 on 2017/2/13.
//  Copyright © 2017年 tony. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.endEditing(true)
        //self.numText.resignFirstResponder()
        //按鈕邊匡圓弧
        self.guest.layer.cornerRadius=30;
        self.clear1.layer.cornerRadius=30;
        self.restart1.layer.cornerRadius=20;
        //numText.placeholder = "50"
        //numText.returnKeyType = .done
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //鍵盤隱藏(return)
    @IBAction func keyboardCancel(sender: UITextField) {
        sender.resignFirstResponder()
    }
    //隱藏鍵盤(點擊空白區)
    @IBAction func touchDown(_ sender: UIControl) {
        numText.resignFirstResponder()
    }
    
    @IBOutlet weak var numText: UITextField!
    @IBOutlet weak var ansTips: UILabel!
    @IBOutlet weak var numTips: UILabel!
    @IBOutlet weak var guest: UIButton!
    @IBOutlet weak var clear1: UIButton!
    @IBOutlet weak var restart1: UIButton!
    
    var realAns = Int(arc4random_uniform(100) + 1)
    var guestNum = 0
    var top: Int = 100
    var bottle :Int = 0
    var got_flag: Int = 0
    
    @IBAction func guestguest(){
        guestNum += 1
        let Ans = Int(numText.text!)
        
        if Ans == realAns {
            ansTips.text = "恭喜答對了!"
            got_flag = 1
        }
        else if numText.text == "" {
            ansTips.text = "請輸入數字!"
            guestNum -= 1
            got_flag = 0
        }
        else if (Ans! > 100 || Ans! < 0) {
            ansTips.text = "數字超出範圍了啦"
            guestNum -= 1
        }
        else if realAns < Ans! {
            
            if Ans! < top{
                top = Ans!
                ansTips.text = "數字範圍 \(bottle) - \(top)"
            }
            else{
                guestNum -= 1
                ansTips.text = "數字範圍是 \(bottle) - \(top)，別亂猜!"
            }
        }
        else if realAns > Ans! {
            
            if Ans! > bottle{
                bottle = Ans!
                ansTips.text = "數字範圍 \(bottle) - \(top)"
            }
            else{
                guestNum -= 1
                ansTips.text = "數字範圍是 \(bottle) - \(top)，別亂猜!"
            }
            
        }
            
        
        switch guestNum{
        case 6:
            if got_flag == 0{
                numTips.text = "猜了\(guestNum)次還猜不到，game over!"
                guest.isEnabled = false
            }else{
                numTips.text = "剛好用完\(guestNum)次機會!"
            }
            break
        default:
            if got_flag == 1{
                numTips.text = "你只猜了\(guestNum)次!"
            }else{
                numTips.text = "你已經猜了\(guestNum)次，還剩下\(6 - guestNum)次機會"
            }
            break
        }
    }
    
    @IBAction func restart(){
        
        let alertController = UIAlertController(
            title: "再來一局",
            message: "確定重來?",
            preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(
            UIAlertAction(
                title: "No",
                style: UIAlertActionStyle.default,
                handler: nil))
        
        alertController.addAction(
            UIAlertAction(
                title: "Yes",
                style: UIAlertActionStyle.default,
                handler: {
                    (action: UIAlertAction!) -> Void in
                    self.reset()
            }))
        
        self.present(
            alertController,
            animated: true,
            completion: nil)


    }
    
     func reset(){
        realAns = Int(arc4random_uniform(100) + 1)
        guestNum = 0
        top = 100
        bottle = 0
        numText.text = ""
        ansTips.text = ""
        numTips.text = ""
        guest.isEnabled = true
        got_flag = 0
    }
    
    @IBAction func clear(){
        numText.text = ""
    }


}

