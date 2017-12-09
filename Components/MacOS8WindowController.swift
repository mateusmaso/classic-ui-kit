//
//  MacOS8WindowController.swift
//  ClassicUIKit
//
//  Created by Mateus Maso on 2016-08-04.
//  Copyright © 2016 Purabucha. All rights reserved.
//

import Cocoa

class MacOS8WindowController: NSWindowController, NSWindowDelegate, NSTableViewDataSource, NSTableViewDelegate {
  
  init() {
    super.init(window: MacOS8Window())
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
