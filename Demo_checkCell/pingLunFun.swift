//
//  pingLunFun.swift
//  Demo_checkCell
//
//  Created by 李春波 on 16/8/19.
//  Copyright © 2016年 lcb. All rights reserved.
//

import UIKit

class pingLunFun: UIView {
    
    let commentTextField = UITextField()
    let sendBtn = UIButton()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1).CGColor
        
        self.commentTextField.frame = CGRectMake(5,2,UIScreen.mainScreen().bounds.width - 80,26)
        self.commentTextField.placeholder = "评论"
        self.commentTextField.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
        self.commentTextField.setValue(UIColor(red: 160/255, green: 160/255, blue: 154/255, alpha: 1), forKeyPath: "_placeholderLabel.textColor")
        self.commentTextField.setValue(UIFont.systemFontOfSize(13), forKeyPath: "_placeholderLabel.font")
        self.commentTextField.layer.cornerRadius = 5
        self.commentTextField.layer.masksToBounds = true
        self.commentTextField.layer.borderWidth = 1
        self.commentTextField.layer.borderColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1).CGColor
        self.commentTextField.contentVerticalAlignment = .Bottom
        self.sendBtn.frame = CGRectMake(0,2,60,26)
        self.sendBtn.frame.origin.x = UIScreen.mainScreen().bounds.width - 70
        self.sendBtn.setTitle("发送", forState: .Normal)
        
        self.sendBtn.layer.borderWidth = 1
        self.sendBtn.layer.cornerRadius = 5
        self.sendBtn.layer.masksToBounds = true
        self.sendBtn.layer.borderColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1).CGColor
        self.sendBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        self.sendBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.sendBtn.backgroundColor = UIColor.blackColor()
        self.addSubview(commentTextField)
        self.addSubview(sendBtn)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
