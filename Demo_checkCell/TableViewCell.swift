//
//  TableViewCell.swift
//  Demo_checkCell
//
//  Created by 李春波 on 16/8/10.
//  Copyright © 2016年 lcb. All rights reserved.
//

import UIKit

typealias heightChange = (cellFlag:Bool) -> Void
typealias likeChange = (cellFlag:Bool) -> Void
typealias commentChange = () -> Void

class defalutTableViewCell: UITableViewCell {
    var flag = true
    var show = false
    var likeflag = true
    var nameLabel = UILabel()
    var avatorImage:UIImageView!
    let pbVC = PhotoBrowser()
    var contentLabel = UILabel()
    let displayView = DisplayView()
    var remoteThumbImage = [NSIndexPath:[String]]()
    var remoteImage :[String] = []
    var timeLabel = UILabel()
    var btn = UIButton()
    let menuview = Menu()
    var zhankaiBtn:UIButton!
    var collectionViewFrame = CGRectMake(0, 0, 0, 0)
    var cellflag1 = false
    var heightZhi:heightChange?
    var likechange:likeChange?
    var commentchange:commentChange?
    var likeView = Comment_Like_View()
    
    var likeLabelArray:[String] = []
    var commentView = pingLunFun()
    var commentNameLabel = UILabel()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if avatorImage == nil{
            avatorImage = UIImageView(frame: CGRectMake(8, 10, 40, 40))
            self.contentView.addSubview(avatorImage)
        }
        nameLabel.frame = CGRectMake(55, 8, 60, 17)
        nameLabel.textColor = UIColor(red: 74/255, green: 83/255, blue: 130/255, alpha: 1)
        nameLabel.font = UIFont.boldSystemFontOfSize(14)
        self.contentView.addSubview(nameLabel)
        contentLabel.numberOfLines = 0
        contentLabel.textColor = UIColor.blackColor()
        contentLabel.font = UIFont.systemFontOfSize(13)
        contentLabel.textAlignment = .Justified
        contentLabel.sizeToFit()
        timeLabel.font = UIFont.systemFontOfSize(12)
        timeLabel.textColor = UIColor.grayColor()
        timeLabel.text = "两小时前"
        btn.setImage(UIImage(named:"menu"), forState: .Normal)
        btn.addTarget(self, action: #selector(defalutTableViewCell.click), forControlEvents: .TouchUpInside)
        
        self.contentView.addSubview(contentLabel)
        self.contentView.addSubview(displayView)
        self.contentView.addSubview(timeLabel)
        self.contentView.addSubview(btn)
        
    }
    
    func click(){
        menuview.clickMenu()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(name:String,imagePic:String,content:String,imgData:[String],indexRow:NSIndexPath,selectItem:Bool,like:[String],likeItem:Bool,CommentNameArray:[String],CommentArray:[String],commentItem:Bool){
        var h = cellHeightByData(content)
        let h1 = cellHeightByData1(imgData.count)
        var h2:CGFloat = 0.0
        nameLabel.text = name
        avatorImage.image = UIImage(named: imagePic)
        if h<13*5{
            contentLabel.frame = CGRectMake(55, 25, UIScreen.mainScreen().bounds.width - 55 - 10, h)
            collectionViewFrame = CGRectMake(50, h+10+15, 230, h1)
            h2 = h1 + h + 27
        }
        else{
            if !selectItem{
                cellflag1 = !selectItem
                h = 13*5
                contentLabel.frame = CGRectMake(55, 25, UIScreen.mainScreen().bounds.width - 55 - 10, h)
                zhankaiBtn = UIButton(frame: CGRectMake(55,h+10+17,60,15))
                zhankaiBtn.setTitle("展开全文", forState: .Normal)
                zhankaiBtn.addTarget(self, action: #selector(defalutTableViewCell.clickDown(_:)), forControlEvents: .TouchUpInside)
                zhankaiBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
                zhankaiBtn.setTitleColor(UIColor(red: 74/255, green: 83/255, blue: 130/255, alpha: 1), forState: .Normal)
                self.contentView.addSubview(zhankaiBtn)
                collectionViewFrame = CGRectMake(50, h+10+15+15, 230, h1)
                h2 = h1 + h + 27 + 12
            }
            if selectItem{
                cellflag1 = !selectItem
                contentLabel.frame = CGRectMake(55, 25, UIScreen.mainScreen().bounds.width - 55 - 10, h)
                zhankaiBtn = UIButton(frame: CGRectMake(55,h+10+17,60,15))
                zhankaiBtn.setTitle("点击收起", forState: .Normal)
                zhankaiBtn.addTarget(self, action: #selector(defalutTableViewCell.clickDown(_:)), forControlEvents: .TouchUpInside)
                zhankaiBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
                zhankaiBtn.setTitleColor(UIColor(red: 74/255, green: 83/255, blue: 130/255, alpha: 1), forState: .Normal)
                self.contentView.addSubview(zhankaiBtn)
                collectionViewFrame = CGRectMake(50, h+10+15+15, 230, h1)
                h2 = h1 + h + 27 + 12
            }
        }
        contentLabel.text = content
        displayView.frame = collectionViewFrame
        timeLabel.frame = CGRectMake(55, h2, 100, 15)
        btn.frame = CGRectMake(0, h2, 15, 12)
        btn.frame.origin.x = UIScreen.mainScreen().bounds.width - 10 - 15
        self.menuview.frame = CGRectMake(0, h2 - 8, 14.5, 0)
        self.menuview.frame.origin.x = UIScreen.mainScreen().bounds.width - 10 - 15
        self.menuview.likeBtn.setImage(UIImage(named: "likewhite"), forState: .Normal)
        if !likeItem{
            self.menuview.likeBtn.setTitle("赞", forState: .Normal)
            likeflag = !likeItem
        }
        if likeItem{
            self.menuview.likeBtn.setTitle("取消赞", forState: .Normal)
            likeflag = !likeItem
        }
        
        self.menuview.likeBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        self.menuview.commentBtn.setImage(UIImage(named: "c"), forState: .Normal)
        self.menuview.commentBtn.setTitle("评论", forState: .Normal)
        self.menuview.commentBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        self.menuview.likeBtn.tag = indexRow.row
        self.menuview.likeBtn.addTarget(self, action: #selector(defalutTableViewCell.LikeBtn(_:)), forControlEvents: .TouchUpInside)
        self.menuview.commentBtn.addTarget(self, action: #selector(defalutTableViewCell.CommentBtn(_:)), forControlEvents: .TouchUpInside)
        for i in 0..<imgData.count{
            let imgUrl = imgData[i]
            self.remoteImage.append(imgUrl)
        }
        self.remoteThumbImage[indexRow] = self.remoteImage
        displayView.imgsPrepare(remoteThumbImage[indexRow]!, isLocal: false)
        pbVC.showType = .Modal
        pbVC.photoType = PhotoBrowser.PhotoType.Host
        pbVC.hideMsgForZoomAndDismissWithSingleTap = true
        var models: [PhotoBrowser.PhotoModel] = []
        for i in 0 ..< self.remoteThumbImage[indexRow]!.count{
            let model = PhotoBrowser.PhotoModel(hostHDImgURL:self.remoteThumbImage[indexRow]![i], hostThumbnailImg: (displayView.subviews[i] as! UIImageView).image, titleStr: "", descStr: "", sourceView: displayView.subviews[i])
            models.append(model)
        }
        pbVC.photoModels = models
        if like.count > 0{
            
            self.likeView.frame = CGRectMake(55,h2+19.5,UIScreen.mainScreen().bounds.width - 10 - 55 - 15,40)
            for i in 0..<like.count{
                likeLabelArray.append(like[i])
            }
            self.likeView.likeLabel.text = likeLabelArray.joinWithSeparator(",")
            self.contentView.addSubview(self.likeView)
        }
        if CommentNameArray.count>0{
            var h3 = h2+19.5+20
            if like.count == 0{
                 h3 = h2+19.5
            }
            for i in 0..<CommentNameArray.count{
                let comment_view = CommentView()
                comment_view.frame = CGRectMake(55,h3+(CGFloat(i*20)),UIScreen.mainScreen().bounds.width - 10 - 55 - 15,20)
                comment_view.nameLabel.text = CommentNameArray[i]
                comment_view.commentLabel.text = CommentArray[i]
                self.contentView.addSubview(comment_view)
            }
        }
        self.contentView.addSubview(self.menuview)
    }
        
    func clickDown(sender:UIButton){

        if flag{
            flag = false
            if self.heightZhi != nil{
                self.heightZhi!(cellFlag: self.cellflag1)
            }
            
        }
        else{
            flag = true
            if self.heightZhi != nil{
                self.heightZhi!(cellFlag: self.cellflag1)
            }
        }
        
    }
    
    func CommentBtn(sender:UIButton){
        if self.commentchange != nil{
            self.commentchange!()
        }
        menuview.menuHide()
    }

    func LikeBtn(sender:UIButton){
        
        
        if !likeflag{
            
            //服务器接口上传数据
            goodComm[sender.tag]["good"]!.removeAtIndex(goodComm[sender.tag]["good"]!.indexOf("胖大海")!)
            if self.likechange != nil{
                self.likechange!(cellFlag: self.likeflag)
            }
            menuview.menuHide()
        }
        else{
            goodComm[sender.tag]["good"]!.append("胖大海")
            if self.likechange != nil{
                self.likechange!(cellFlag: self.likeflag)
            }
            menuview.menuHide()
        }
        
    }
}
