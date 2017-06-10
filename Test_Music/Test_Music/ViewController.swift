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

class ViewController: UIViewController {
    
    var playlists  : Results<Playlist>!
    var songs : MPMediaQuery!
    fileprivate var menuButton: IconButton!
    fileprivate var starButton: IconButton!
    fileprivate var searchButton: IconButton!
    fileprivate var realm = try! Realm()
    var playlist = Playlist()
    let label  = UILabel(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.playlists = retrieveData()
        prepareMenuButton()
        prepareStarButton()
        prepareSearchButton()
        prepareNavigation()
        
        self.view.addSubview(label)
        
        
        MPMediaLibrary.requestAuthorization { (status) in
            if status == MPMediaLibraryAuthorizationStatus.authorized {
                self.songs = MPMediaQuery.songs()
            }
        }
        
        if (MPMediaLibrary.authorizationStatus() == MPMediaLibraryAuthorizationStatus.authorized) {
            self.songs = MPMediaQuery.songs()
        }
        
        let predicate = MPMediaPropertyPredicate(value: (songs?.items?.first)?.persistentID, forProperty: MPMediaItemPropertyPersistentID)
        songs?.addFilterPredicate(predicate)
        print(songs?.items?.first?.albumArtist ?? "Nil")
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc fileprivate func addSongs() {
        
        let alert = UIAlertController(title: "Playlist Name", message: "", preferredStyle: .alert)
        let view = alertView(frame: alert.view.frame)
        view.tag = 45
        alert.addTextField { (textField) in
            return
        }
        alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: { (action) in
            
            let playlistName = alert.textFields?[0].text
            self.playlist = Playlist()
            self.playlist.name = playlistName!
            
                let picker = MPMediaPickerController.init(mediaTypes: .music)
                picker.allowsPickingMultipleItems = true
                picker.showsCloudItems = true
                self.present(picker, animated: true, completion: nil)
            
        }))
        self.present(alert, animated: true, completion:nil)
    }

    public func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection){
        let items = mediaItemCollection.items
        addToRealm(playlist: self.playlist, mediaItems: items)
    }

    
    func addToRealm(playlist : Playlist, mediaItems : [MPMediaItem]) {
        for item in mediaItems {
            let image = item.artwork?.image(at: CGSize(width: 100, height: 100))
            let imageData = UIImagePNGRepresentation(image!)
            playlist.songs.append(Song(value: ["imageData" : imageData?.base64EncodedString(options: .endLineWithCarriageReturn), "presistenID" : "\(item.persistentID)","songName":item.title,"artistName" : item.albumArtist]))
        }
        try! realm.write {
            realm.create(Playlist.self, value: ["name":playlist.name,"songs":playlist.songs], update: true)
        }
        
        
        
        self.playlists = self.retrieveData()
    }
    
    func retrieveData() -> Results<Playlist> {
        let playlists = realm.objects(Playlist.self)
        print(playlists)
        self.label.text = "\(playlists.count)"
        return playlists
    }
    
}

extension ViewController {
    fileprivate func prepareNavigation() {
        navigationItem.title = "Playlists"
        navigationItem.titleLabel.textColor = Color.colorPrimary
        navigationItem.leftViews = [searchButton]
        navigationItem.rightViews = [starButton]
    }
    
    fileprivate func prepareMenuButton() {
        menuButton = IconButton(image: Icon.cm.menu)
        menuButton.tintColor = Color.colorPrimary
    }
    
    fileprivate func prepareStarButton() {
        starButton = IconButton(image: Icon.cm.add)
        starButton.tintColor = Color.colorPrimary
        starButton.addTarget(self, action: #selector(addSongs), for: .touchUpInside)
    }
    
    fileprivate func prepareSearchButton() {
        searchButton = IconButton(image: Icon.cm.search)
        searchButton.tintColor = Color.colorPrimary
    }
}
