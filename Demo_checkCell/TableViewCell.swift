//
//  TableViewCell.swift
//  Demo_checkCell
//
//  Created by 李春波 on 16/8/10.
//  Copyright © 2016年 lcb. All rights reserved.
//

import UIKit

typealias heightChange = (cellFlag:Bool) -> Void

class defalutTableViewCell: UITableViewCell {
    var flag = true
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
    var cellflag1 = true
    var heightZhi:heightChange?
    var likeView = UIView()
    let likeViewBackImage = UIImageView()
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
        self.contentView.addSubview(self.menuview)
        //self.likeViewBackImage.image = UIImage(named:"comment")
        self.likeView.backgroundColor = UIColor(patternImage: UIImage(named:"comment")!)
        //self.likeView.addSubview(self.likeViewBackImage)
        //self.contentView.addSubview(self.likeViewBackImage)
        self.contentView.addSubview(self.likeView)
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
    
    func setData(name:String,imagePic:String,content:String,imgData:[String],indexRow:NSIndexPath,selectItem:Bool,like:[String]){
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
        self.menuview.likeBtn.setTitle("赞", forState: .Normal)
        self.menuview.likeBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        self.menuview.commentBtn.setImage(UIImage(named: "c"), forState: .Normal)
        self.menuview.commentBtn.setTitle("评论", forState: .Normal)
        self.menuview.commentBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
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
        //模型数据数组
        for i in 0 ..< self.remoteThumbImage[indexRow]!.count{
            let model = PhotoBrowser.PhotoModel(hostHDImgURL:self.remoteThumbImage[indexRow]![i], hostThumbnailImg: (displayView.subviews[i] as! UIImageView).image, titleStr: "", descStr: "", sourceView: displayView.subviews[i])
            models.append(model)
        }
        /**  设置数据  */
        pbVC.photoModels = models
        if like.count > 0{
            self.likeView.frame = CGRectMake(55,h2+15,60,15)
            self.likeViewBackImage.frame = self.likeView.frame
        }
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

}
