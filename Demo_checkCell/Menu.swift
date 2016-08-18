//
//  Menu.swift
//  Demo_checkCell
//
//  Created by 李春波 on 16/8/12.
//  Copyright © 2016年 lcb. All rights reserved.
//

import Foundation
import UIKit

class Menu:UIView{
    let likeBtn = UIButton()
    let commentBtn = UIButton()
    var line = UIView()
    var show = false
    var isShowing = false
    var flag1 = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        self.show = false
        self.isShowing = false
        self.backgroundColor = UIColor(red: 60/255, green: 64/255, blue: 66/255, alpha: 1)
        self.setNeedsLayout()
        self.likeBtn.frame = CGRectMake(0, 0, 80, 35)
        //self.likeBtn.addTarget(self, action: #selector(Menu.LikeBtn), forControlEvents: .TouchUpInside)
        self.commentBtn.frame = CGRectMake(80, 0, 80, 35)
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.line = UIView(frame: CGRectMake(80,5,1,25))
        self.line.backgroundColor = UIColor(red: 50/255, green: 53/255, blue: 56/255, alpha: 1)
        self.addSubview(self.likeBtn)
        self.addSubview(self.commentBtn)
        self.addSubview(self.line)
    }
    
    func clickMenu(){
        if(self.show){
            //按钮隐藏
            menuHide()
        }
        else{
            menuShow()
        }
    }
    
    
    
    func menuShow(){
        self.show = true
        UIView.animateWithDuration(0.2, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.LayoutSubviews, animations: {
            self.frame = CGRectMake(self.frame.origin.x - 160, self.frame.origin.y, 160, 34)
            }) { (Bool) in
                
        }
    }
    
    func menuHide(){
        self.show = false
        UIView.animateWithDuration(0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.LayoutSubviews, animations: {
            self.frame = CGRectMake(self.frame.origin.x + 160, self.frame.origin.y, 0.0, 34)
        }) { (Bool) in
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}