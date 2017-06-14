//
//  playListTableView.swift
//  Test_Music
//
//  Created by Sai Krishna Dubagunta on 6/10/17.
//  Copyright © 2017 Sai Krishna Dubagunta. All rights reserved.
//

import UIKit
import Material

class playListTableView: UITableView {
    internal lazy var heights = [IndexPath: CGFloat]()
    
    public var data = [Playlist]() {
        didSet {
            reloadData()
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepare()
    }
    
    public init() {
        super.init(frame: .zero, style: .plain)
        prepare()
    }
    
    /// Prepares the tableView.
    open func prepare() {
        delegate = self
        dataSource = self
        separatorStyle = .none
        register(PlaylistCell.self, forCellReuseIdentifier: "CardTableViewCell")
    }
}

extension playListTableView: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /// Prepares the cells within the tableView.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardTableViewCell", for: indexPath) as! PlaylistCell
        cell.data = data[indexPath.row]
        cell.isLast = indexPath.row == data.count - 1
        heights[indexPath] = cell.height
        return cell
    }
}

extension playListTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heights[indexPath] ?? height
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SongsViewController.playlist = data[indexPath.row]
        SongsViewController.realm = ViewController.realm
        let vControllers = UIApplication.shared.keyWindow?.rootViewController?.childViewControllers
        let vC = vControllers?[(vControllers?.count)!-1] as? ViewController
        vC?.navigationController?.pushViewController(SongsViewController(), animated: true)
    }
}
