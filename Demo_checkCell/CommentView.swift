//
//  CommentView.swift
//  Demo_checkCell
//
//  Created by 李春波 on 16/8/22.
//  Copyright © 2016年 lcb. All rights reserved.
//

import UIKit

class CommentView: UIView {
    var nameLabel = UILabel()
    var commentLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
        self.nameLabel.frame = CGRectMake(0,2,60,20)
        self.nameLabel.textAlignment = .Left
        self.nameLabel.font = UIFont.systemFontOfSize(15)
        self.commentLabel.frame = CGRectMake(65,2,200,20)
        self.commentLabel.font = UIFont.systemFontOfSize(15)
        self.nameLabel.textColor = UIColor.blueColor()
        self.commentLabel.textAlignment = .Left
        self.addSubview(nameLabel)
        self.addSubview(commentLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
