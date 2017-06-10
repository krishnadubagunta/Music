//
//  PlaylistCell.swift
//  Test_Music
//
//  Created by Sai Krishna Dubagunta on 6/10/17.
//  Copyright © 2017 Sai Krishna Dubagunta. All rights reserved.
//

import UIKit
import Material

class PlaylistCell: TableViewCell {
    private var spacing: CGFloat = 15
    
    /// A boolean that indicates whether the cell is the last cell.
    public var isLast = false
    
    public lazy var card: PresenterCard = PresenterCard()
    
    /// Toolbar views.
    private var toolbar: Toolbar!
    
    /// Presenter area.
    private var presenterImageView: UIImageView!
    
    
    public var data: Playlist? {
        didSet {
            layoutSubviews()
        }
    }
    
    /// Calculating dynamic height.
    open override var height: CGFloat {
        get {
            return card.height + spacing
        }
        set(value) {
            super.height = value
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let d = data else {
            return
        }
        
        toolbar.title = d.name
        let songFirst = d.songs.first
        let image = UIImage(data: Data(base64Encoded: (songFirst?.imageData)!)!)?.resize(toHeight: 100)
        if  image != nil {
            presenterImageView.height = (image?.height)!
            DispatchQueue.main.async { [weak self, image = image] in
                self?.presenterImageView.image = image
            }
        }
        
        card.x = 0
        card.y = 0
        card.width = width
        
        card.setNeedsLayout()
        card.layoutIfNeeded()
    }
    
    open override func prepare() {
        super.prepare()
        layer.rasterizationScale = Screen.scale
        layer.shouldRasterize = true
        pulseAnimation = .none
        backgroundColor = nil
        prepareToolbar()
        preparePresenterImageView()
        preparePresenterCard()
    }
    
    
    private func prepareToolbar() {
        toolbar = Toolbar()
        toolbar.heightPreset = .medium
        toolbar.contentEdgeInsetsPreset = .square3
        toolbar.titleLabel.textAlignment = .left
        toolbar.detailLabel.textAlignment = .left
        toolbar.dividerColor = Color.grey.lighten3
        toolbar.dividerAlignment = .top
    }
    
    private func preparePresenterImageView() {
        presenterImageView = UIImageView()
        presenterImageView.contentMode = .scaleAspectFill
    }
    
    
    private func preparePresenterCard() {
        card.toolbar = toolbar
        card.presenterView = presenterImageView
        card.contentViewEdgeInsetsPreset = .square3
        card.contentViewEdgeInsets.bottom = 0
        card.depthPreset = .depth5
        contentView.addSubview(card)
    }

}
