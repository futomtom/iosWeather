//
//  MenuViewController.swift
//  SherryWeather
//
//  Created by 王卓 on 15/12/30.
//  Copyright © 2015年 xiaolei. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let MenuCellIdentifier = "MenuCellIdentifier"
    let buttonList = ["设置","关于我们"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "tapCancel:")
        // popover settings
        modalPresentationStyle = .Popover
        popoverPresentationController!.delegate = self
        self.preferredContentSize = CGSize(width:200,height:300)
    }
    
//    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
//        return UIModalPresentationStyle.None
//    }

    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.FullScreen
    }
    
    func presentationController(controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        let navigationController = UINavigationController(rootViewController: controller.presentedViewController)
        let btnDone = UIBarButtonItem(title: "Done", style: .Done, target: self, action: "dismiss")
        navigationController.topViewController!.navigationItem.rightBarButtonItem = btnDone
        return navigationController
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    // 数据源方法, 返回多少组
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    // 每组有多少行
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buttonList.count;
    }
    
    // 每行展示什么内容
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("MenuCellIdentifier", forIndexPath: indexPath) as! menuTableViewCell
        cell.textLabel!.text = buttonList[indexPath.row]
        return cell;
    }

}
