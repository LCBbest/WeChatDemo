//
//  CommentView.swift
//  Demo_checkCell
//
//  Created by 李春波 on 16/8/18.
//  Copyright © 2016年 lcb. All rights reserved.
//

import UIKit

class Comment_Like_View: UIView {

    let likeViewBackImage = UIImageView()
    var likeImage = UIImageView()
    var likeLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
        self.likeImage.image = UIImage(named: "likewhite")
        self.likeViewBackImage.image = UIImage(named:"comment")
        self.likeImage.frame = CGRectMake(2,2,20,20)
        self.likeViewBackImage.frame = CGRectMake(0,-6,60,20)
        self.likeLabel.frame = CGRectMake(25,2,UIScreen.mainScreen().bounds.width - 10 - 55 - 15 - 27,20)
        self.likeLabel.font = UIFont.systemFontOfSize(15)
        self.addSubview(likeViewBackImage)
        self.addSubview(likeImage)
        self.addSubview(likeLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    
    
    
    
    
    
}
