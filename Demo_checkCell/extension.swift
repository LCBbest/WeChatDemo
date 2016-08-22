//
//  extension.swift
//  Demo_checkCell
//
//  Created by 李春波 on 16/8/10.
//  Copyright © 2016年 lcb. All rights reserved.
//

import UIKit

extension String{
    
    //MARK:获得string内容高度
    
    func stringHeightWith(fontSize:CGFloat,width:CGFloat)->CGFloat{
        
        let font = UIFont.systemFontOfSize(fontSize)
        
        let size = CGSizeMake(width,CGFloat.max)
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineBreakMode = .ByWordWrapping;
        
        let attributes = [NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy()]
        
        let text = self as NSString
        
        let rect = text.boundingRectWithSize(size, options:.UsesLineFragmentOrigin, attributes: attributes, context:nil)
        
        return rect.size.height
        
    }//funcstringHeightWith
    
}//extension end

func cellHeightByData(data:String)->CGFloat{
    
    let content = data
    let height=content.stringHeightWith(13,width: UIScreen.mainScreen().bounds.width - 55 - 10)
    return  height
    
}

func cellHeightByData1(imageNum:Int)->CGFloat{
    
    let lines:CGFloat = (CGFloat(imageNum))/3
    var picHeight:CGFloat = 0
    switch lines{
    case 0...1:
        picHeight = 80
        break
    case 1...2:
        picHeight = 155
        break
    case 2...3:
        picHeight = 230
        break
    default:
        picHeight = 0
    }
    return picHeight
    
}

func cellHeightByCommentNum(Comment:Int)->CGFloat{
    return CGFloat(Comment * 20)
}


