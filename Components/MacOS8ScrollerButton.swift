//
//  MacOS8ScrollerButton.swift
//  ClassicUIKit
//
//  Created by Mateus Maso on 2016-08-05.
//  Copyright © 2016 Purabucha. All rights reserved.
//

import Cocoa

class MacOS8ScrollerButton: MacOS8Button {
  
  init(arrow: Int) {
    super.init()
    self.title = ""
    self.isBordered = false
    
    if arrow == 0 {
      self.image = NSImage(named: "MacOS8 Scrollbar Scroller Arrow Left")
    } else {
      self.image = NSImage(named: "MacOS8 Scrollbar Scroller Arrow Right")
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
