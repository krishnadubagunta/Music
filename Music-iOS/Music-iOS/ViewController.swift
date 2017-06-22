//
//  ViewController.swift
//  Music-iOS
//
//  Created by Sai Krishna Dubagunta on 6/8/17.
//  Copyright © 2017 Sai Krishna Dubagunta. All rights reserved.
//

import UIKit
import Material
import MediaPlayer
import RealmSwift

class ViewController: UIViewController, MPMediaPickerControllerDelegate{
    internal lazy var heights = [IndexPath: CGFloat]()
    
    var playlists  : Results<Playlist>!
    var songs : MPMediaQuery!
    fileprivate var menuButton: IconButton!
    fileprivate var starButton: IconButton!
    fileprivate var realm = try! Realm()
    fileprivate var buttons = [Button]()
    fileprivate var tabBar: TabBar!
    static var notificationToken : NotificationToken?
    static var realm : Realm!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        preparePageTabBarItem()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        preparePageTabBarItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Color.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        override func viewWillDisappear(_ animated: Bool) {
    }
    
}

extension ViewController {
    fileprivate func preparePageTabBarItem(){
        pageTabBarItem.image = #imageLiteral(resourceName: "audio_wave")
        pageTabBarItem.depthPreset = .depth4
    }
}


