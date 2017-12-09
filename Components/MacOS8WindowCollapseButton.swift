//
//  MacOS8WindowCollapseButton.swift
//  ClassicUIKit
//
//  Created by Mateus Maso on 2016-08-06.
//  Copyright © 2016 Purabucha. All rights reserved.
//

import Cocoa

class MacOS8WindowCollapseButton: MacOS8Button {
  
  override init() {
    super.init()
    self.title = ""
    self.isBordered = false
    self.image = NSImage(named: "MacOS8 Window Titlebar Collapse")
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
