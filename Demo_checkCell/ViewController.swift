		//
//  ViewController.swift
//  Demo_checkCell
//
//  Created by 李春波 on 16/8/9.
//  Copyright © 2016年 lcb. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate,UITextFieldDelegate {
    
    
    var tableView:UITableView?
    var refreshControl = UIRefreshControl()
    let imagePicView = UIView()
    let imagePic = UIImageView()
    let nameLable = UILabel()
    let avatorImage = UIImageView()
    var biaozhi = true
    var selectItems: [Bool] = []
    var likeItems:[Bool] = []
    var replyViewDraw:CGFloat!
    var test = UITextField()
    var commentView = pingLunFun()
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 0...dataItem.count{
            selectItems.append(false)
            likeItems.append(false)
        }
        test.delegate = self
        self.commentView.commentTextField.delegate = self
        refreshControl.addTarget(self, action: #selector(ViewController.refreshData),
            forControlEvents: UIControlEvents.ValueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新数据")
        self.tableView = UITableView(frame: self.view.frame, style:UITableViewStyle.Grouped)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView?.tableHeaderView = headerView()
        self.tableView?.contentInset = UIEdgeInsets(top: 50,left: 0,bottom: 0,right: 0)
        self.view.addSubview(self.tableView!)
        self.tableView?.addSubview(refreshControl)
        self.tableView!.allowsMultipleSelection = true
        self.view.backgroundColor = UIColor.whiteColor()
        commentView.frame = CGRectMake(0,0,self.view.bounds.width,30)
        commentView.hidden = true
        self.view.addSubview(self.commentView)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap(_:))))
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(ViewController.keyBoardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(ViewController.keyBoardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil)
    }
    
    func refreshData() {
        print("123")
        biaozhi = true
        refreshControl.endRefreshing()
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataItem.count
    }
    
    override func viewDidLayoutSubviews() {
        self.tableView?.separatorInset = UIEdgeInsetsZero
        self.tableView?.layoutMargins = UIEdgeInsetsZero
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath){
        cell.layoutMargins = UIEdgeInsetsZero
        cell.separatorInset = UIEdgeInsetsZero
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell
    {
        let identify:String = "SwiftCell\(indexPath.row)"
        //禁止重用机制
        var cell:defalutTableViewCell? = tableView.cellForRowAtIndexPath(indexPath) as? defalutTableViewCell
        if cell == nil{
            cell = defalutTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
        }
        cell!.setData(dataItem[indexPath.row]["name"]! as! String, imagePic: dataItem[indexPath.row]["avator"]! as! String,content: dataItem[indexPath.row]["content"]! as! String,imgData: dataItem[indexPath.row]["imageUrls"]! as! [String],indexRow:indexPath,selectItem: selectItems[indexPath.row],like:goodComm[indexPath.row]["good"]!,likeItem:likeItems[indexPath.row],CommentNameArray:goodComm[indexPath.row]["commentName"]! ,CommentArray:goodComm[indexPath.row]["comment"]! )
        cell!.displayView.tapedImageV = {[unowned self] index in
            cell!.pbVC.show(inVC: self,index: index)
        }
        cell!.selectionStyle = .None
        
        cell!.heightZhi = { cellflag in
            self.selectItems[indexPath.row] = cellflag
            self.tableView?.reloadData()
        }
        cell!.likechange = { cellflag in
            self.likeItems[indexPath.row] = cellflag
            self.tableView?.reloadData()
        }
        cell!.commentchange = { _ in
            self.replyViewDraw = cell!.convertRect(cell!.bounds,toView:self.view.window).origin.y + cell!.frame.size.height
            self.commentView.commentTextField.becomeFirstResponder()
            self.commentView.sendBtn.addTarget(self, action: #selector(ViewController.sendComment(_:)), forControlEvents:.TouchUpInside)
            self.commentView.sendBtn.tag = indexPath.row
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        var h_content = cellHeightByData(dataItem[indexPath.row]["content"]! as! String)
        let h_image = cellHeightByData1(dataItem[indexPath.row]["imageUrls"]!.count)
        var h_like:CGFloat = 0.0
        let h_comment = cellHeightByCommentNum(goodComm[indexPath.row]["commentName"]!.count)
        if h_content>13*5{
            if !self.selectItems[indexPath.row]{
                h_content = 13*5
            }
        }
        if goodComm[indexPath.row]["good"]!.count > 0{
            h_like = 40
        }
        return h_content + h_image + 50 + 20 + h_like + h_comment
    }

    func headerView() ->UIView{
        
        imagePicView.frame = CGRectMake(0, 0, self.view.bounds.width, 225)
        imagePic.frame = CGRectMake(0, 0, self.view.bounds.width, 200)
        imagePic.image = UIImage(named: "background")
        imagePicView.addSubview(imagePic)
        imagePic.clipsToBounds = true
        self.nameLable.frame = CGRectMake(0, 170, 60, 18)
        self.nameLable.frame.origin.x = self.view.bounds.width - 140
        self.nameLable.text = "胖大海"
        self.nameLable.font = UIFont.systemFontOfSize(16)
        self.nameLable.textColor = UIColor.whiteColor()
        self.avatorImage.frame = CGRectMake(0, 150, 70, 70)
        self.avatorImage.frame.origin.x = self.view.bounds.width - 80
        self.avatorImage.image = UIImage(named: "avatorImage")
        self.avatorImage.layer.borderWidth = 2
        self.avatorImage.layer.borderColor = UIColor.whiteColor().CGColor
        let view:UIView = UIView(frame: CGRectMake(0, 200, self.view.bounds.width, 26))
        view.backgroundColor = UIColor.whiteColor()
        imagePicView.addSubview(nameLable)
        imagePicView.addSubview(view)
        imagePicView.addSubview(avatorImage)
        return imagePicView
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView){
        let offset:CGPoint = scrollView.contentOffset
        
        if (offset.y < 0) {
            var rect:CGRect = imagePic.frame
            rect.origin.y = offset.y
            rect.size.height = 200 - offset.y
            imagePic.frame = rect
        }
    }
    
    func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .Ended {
            self.commentView.commentTextField.resignFirstResponder()
        }
        sender.cancelsTouchesInView = false
    }
    
    func keyBoardWillShow(note:NSNotification)
    {
        
        let userInfo  = note.userInfo as! NSDictionary
        let keyBoardBounds = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let deltaY = keyBoardBounds.size.height
        let commentY = self.view.frame.height - deltaY
        var frame = self.commentView.frame
        let animations:(() -> Void) = {
            self.commentView.hidden = false
            self.commentView.frame.origin.y = commentY - 30
            frame.origin.y = commentY
            var point:CGPoint = self.tableView!.contentOffset
            point.y -= (frame.origin.y - self.replyViewDraw)
            self.tableView!.contentOffset = point
        }
        
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).integerValue << 16))
            UIView.animateWithDuration(duration, delay: 0, options:options, animations: animations, completion: nil)
        }else{
            animations()
        }
    }
    
    func keyBoardWillHide(note:NSNotification)
    {
        
        let userInfo  = note.userInfo as! NSDictionary
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let animations:(() -> Void) = {
            self.commentView.hidden = true
            self.commentView.transform = CGAffineTransformIdentity
            self.tableView!.frame.origin.y = 0
        }
        
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).integerValue << 16))
            
            UIView.animateWithDuration(duration, delay: 0, options:options, animations: animations, completion: nil)
            
        }else{
            animations()
        }
    }
    
    func sendComment(sender:UIButton){
        goodComm[sender.tag]["commentName"]!.append("胖大海")
        goodComm[sender.tag]["comment"]!.append(commentView.commentTextField.text!)
        self.commentView.commentTextField.resignFirstResponder()
        self.tableView?.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}