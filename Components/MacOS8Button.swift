//
//  MacOS8Button.swift
//  ClassicUIKit
//
//  Created by Mateus Maso on 2016-08-07.
//  Copyright © 2016 Purabucha. All rights reserved.
//

import Cocoa

class MacOS8Button: NSButton {
  
  init() {
    super.init(frame: NSZeroRect)
    self.sound = NSSound(named: "Single Click")
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    
}
