//
//  MacOS8WindowZoomButton.swift
//  ClassicUIKit
//
//  Created by Mateus Maso on 2016-08-06.
//  Copyright © 2016 Purabucha. All rights reserved.
//

import Cocoa

class MacOS8WindowZoomButton: MacOS8Button {
  
  override init() {
    super.init()
    self.title = ""
    self.isBordered = false
    self.image = NSImage(named: "MacOS8 Window Titlebar Zoom")
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
