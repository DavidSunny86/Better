//
//  HotRecommondController.swift
//  better
//
//  Created by Hony on 2016/11/7.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit


/// 热门控制器
class HotRecommondController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "热门推荐"
        view.addSubview(tableView)
        
        DiscoverHttpHelper.requestDiscoverHot { (hot) in
            self.hotModel = hot
        }
    }
    
    
    var hotModel: SingleProdHot?{
        didSet{
            tableView.reloadData()
        }
    }
    
    
    fileprivate lazy var rowCache: [String: CGFloat] = {
        let i = [String: CGFloat]()
        return i
    }()
    
    fileprivate lazy var items: [String] = {
        let i = ["I want you leather dirty kiss in thleather dirty kiss in the scene" , "会更明白什么温柔还没跟你牵着手过荒芜的也许你会陪我看细水长流也许你会陪我看细水么温柔还没么温柔还没么温柔还没长流沙丘" , "You know that I want you And you know that I need you 你知道我要你 你知道我离不开你"];
        return i
    }()
    
    fileprivate lazy var tableView: UITableView = {
        let i = UITableView(frame: CGRect(x: 0, y: 0, width: UIConst.screenWidth, height: UIConst.screenHeight), style: .plain)
        i.separatorStyle = .none
        i.register(HotRecommondCell.self, forCellReuseIdentifier: "HotRecommondCell")
        i.delegate = self
        i.dataSource = self
        return i
    }()
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



typealias HotRecommandTableViewProtocol = HotRecommondController

extension HotRecommandTableViewProtocol : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let model = hotModel?.data?[indexPath.row]
        if let h = rowCache[(model?.id)!]{
            return h
        }else{
            let cal = model?.cellHeight
            rowCache[(model?.id)!] = cal
            return cal!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HotRecommondCell") as! HotRecommondCell
        cell.recommond = hotModel?.data?[indexPath.row]
        cell.selectionStyle = .none
        
        /// 点击事件回调
        cell.clickClosure = {(hotcell, model,type) in
            print(type)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotModel?.data?.count ?? 0
    }
}

