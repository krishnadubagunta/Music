//
//  ViewController.swift
//  Test_Music
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
    fileprivate var searchButton: IconButton!
    fileprivate var realm = try! Realm()
    static var notificationToken : NotificationToken?
    var playlist = Playlist()
    var tableView : playListTableView! = playListTableView()
    static var realm : Realm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareStarButton()
        prepareSearchButton()
        prepareNavigation()
        setupRealm()
        prepareTableView()
        displayRealm()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupRealm() {
        self.reloadObjects()
        ViewController.notificationToken = realm.addNotificationBlock { (notification, realm) in
           self.reloadObjects()
            print(self.playlists.count)
        }
        
    }
    
    func reloadObjects () {
        self.playlists = realm.objects(Playlist.self)
        tableView.data = playlists.sorted(byKeyPath: "id", ascending: false).reversed()
    }
    
    
    @objc fileprivate func addSongs() {
        
        let alert = UIAlertController(title: "Playlist Name", message: "", preferredStyle: .alert)
        let view = alertView(frame: alert.view.frame)
        view.tag = 45
        alert.addTextField { (textField) in
            return
        }
        alert.addAction(UIAlertAction(title: "Done", style: .destructive, handler: { (action) in
            
            let playlistName = alert.textFields?[0].text
            if playlistName != "" {
                self.playlist = Playlist()
                self.playlist.name = playlistName!
                
                let picker = MPMediaPickerController.init(mediaTypes: .music)
                picker.allowsPickingMultipleItems = true
                picker.showsCloudItems = true
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
                
            }
            else{
                alert.dismiss(animated: true, completion: nil)
            }
        }))
        self.present(alert, animated: true, completion:nil)
    }


    public func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection){
        let items = mediaItemCollection.items
        mediaPicker.dismiss(animated: true, completion: nil)
        addToRealm(playlist: self.playlist, mediaItems: items)
    }

    func displayRealm(){
        print(playlists.count)
    }
    
    func addToRealm(playlist : Playlist, mediaItems : [MPMediaItem]) {
        for item in mediaItems {
            let image = item.artwork?.image(at: (item.artwork?.bounds.size)!)
            let imageData = UIImagePNGRepresentation(image!)
            playlist.songs.append(Song(value: ["imageData" : imageData?.base64EncodedString(options: .endLineWithCarriageReturn), "presistenID" : "\(item.persistentID)","songName":item.title,"artistName" : item.albumArtist]))
        }
        realm.beginWrite()
        realm.create(Playlist.self , value : ["name" : playlist.name,"songs":playlist.songs,"id":playlists.count+1], update : true)
        try! realm.commitWrite()
        displayRealm()
    }
    
    
}

extension ViewController {
    
    fileprivate func prepareNavigation() {
        navigationItem.title = "Playlists"
        navigationItem.titleLabel.textColor = Color.colorPrimary
        navigationItem.leftViews = [searchButton]
        navigationItem.rightViews = [starButton]
    }
    
    fileprivate func prepareStarButton() {
        starButton = IconButton(image: Icon.cm.add)
        starButton.tintColor = Color.colorPrimary
        starButton.pulseColor = Color.colorPrimary
        starButton.addTarget(self, action: #selector(addSongs), for: .touchUpInside)
    }
    
    fileprivate func prepareSearchButton() {
        searchButton = IconButton(image: Icon.cm.search)
        searchButton.tintColor = Color.colorPrimary
        searchButton.pulseColor = Color.colorPrimary
    }
    
    fileprivate func prepareTableView() {
        tableView = playListTableView()
        view.layout(tableView).edges()
        tableView.data = playlists.sorted(byKeyPath: "id", ascending: false).reversed()
        
    }
}
