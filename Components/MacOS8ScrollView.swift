//
//  MacOS8ScrollView.swift
//  ClassicUIKit
//
//  Created by Mateus Maso on 2016-08-06.
//  Copyright © 2016 Purabucha. All rights reserved.
//

import Cocoa

class MacOS8ScrollView: NSScrollView {
  
  var horizontalLeftButton: MacOS8ScrollerButton
  var horizontalRightButton: MacOS8ScrollerButton
  
  init() {
    self.horizontalLeftButton = MacOS8ScrollerButton(arrow: 0)
    self.horizontalRightButton = MacOS8ScrollerButton(arrow: 1)

    super.init(frame: NSZeroRect)
    
    self.autohidesScrollers = false
    self.autoresizesSubviews = false
    self.hasVerticalScroller = false
    self.hasHorizontalScroller = true
    self.horizontalScroller = MacOS8Scroller()
    self.horizontalScrollElasticity = NSScrollElasticity.none

    self.addSubview(self.horizontalLeftButton)
    self.addSubview(self.horizontalRightButton)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func scrollWheel(with event: NSEvent) {
    if event.momentumPhase == NSEventPhase() {
      super.scrollWheel(with: event)
    }
  }
  
}
