//
//  MacOS8WindowTitlebar.swift
//  ClassicUIKit
//
//  Created by Mateus Maso on 2016-08-07.
//  Copyright © 2016 Purabucha. All rights reserved.
//

import Cocoa

class MacOS8WindowTitlebar: NSView {

  var titleView: NSTextField
  var stripeLeft: MacOS8WindowStripeView
  var stripeRight: MacOS8WindowStripeView
  var closeButton: MacOS8WindowCloseButton
  var zoomButton: MacOS8WindowZoomButton
  var collapseButton: MacOS8WindowCollapseButton

  override init(frame frameRect: NSRect) {
    self.closeButton = MacOS8WindowCloseButton()
    self.zoomButton = MacOS8WindowZoomButton()
    self.collapseButton = MacOS8WindowCollapseButton()
   
    self.titleView = NSTextField()
    self.titleView.isBordered = false
    self.titleView.font = NSFont(name: "Charcoal", size: 12)
    self.titleView.isSelectable = false
    self.titleView.drawsBackground = false
    self.titleView.isEditable = false

    self.stripeLeft = MacOS8WindowStripeView()
    self.stripeRight = MacOS8WindowStripeView()

    super.init(frame: frameRect)
    
    self.addSubview(self.closeButton)
    self.addSubview(self.zoomButton)
    self.addSubview(self.collapseButton)
    self.addSubview(self.titleView)
    self.addSubview(self.stripeLeft)
    self.addSubview(self.stripeRight)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func updateConstraints() {
    self.closeButton.snp.remakeConstraints { make in
      make.top.left.equalTo(4)
      make.width.height.equalTo(13)
    }
    
    self.collapseButton.snp.remakeConstraints { make in
      make.top.equalTo(4)
      make.right.equalTo(-5)
      make.width.height.equalTo(13)
    }
    
    self.zoomButton.snp.remakeConstraints { make in
      make.top.equalTo(4)
      make.right.equalTo(self.collapseButton.snp.left).inset(-4)
      make.width.height.equalTo(13)
    }
    
    self.titleView.snp.remakeConstraints { make in
      make.top.equalTo(3)
      make.height.equalTo(24)
      make.width.equalTo(62)
      make.centerX.equalTo(self)
    }
    
    self.stripeLeft.snp.remakeConstraints { make in
      make.top.equalTo(5)
      make.height.equalTo(12)
      make.left.equalTo(self.closeButton.snp.right).inset(-4)
      make.right.equalTo(self.titleView.snp.left).inset(-6)
    }
    
    self.stripeRight.snp.remakeConstraints { make in
      make.top.equalTo(5)
      make.height.equalTo(12)
      make.right.equalTo(self.zoomButton.snp.left).inset(-4)
      make.left.equalTo(self.titleView.snp.right).inset(-6)
    }

    super.updateConstraints()
  }
  
  override func draw(_ dirtyRect: NSRect) {
    super.draw(dirtyRect)
    
    NSColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1).setFill()
    NSRectFill(dirtyRect)
    
    let window = self.window! as! MacOS8Window
    
    var open = ""
    
    if !window.collapsed {
      open = " Open"
    }
    
    let left = NSImage(named: "MacOS8 Window Titlebar Left\(open)")!
    left.draw(
      at: NSPoint(x: 0, y: dirtyRect.size.height - left.size.height),
      from: dirtyRect,
      operation: NSCompositingOperation.sourceOver,
      fraction: 1
    )
    
    let right = NSImage(named: "MacOS8 Window Titlebar Right\(open)")!
    right.draw(
      at: NSPoint(x: dirtyRect.size.width - right.size.width, y: dirtyRect.size.height - left.size.height),
      from: dirtyRect,
      operation: NSCompositingOperation.sourceOver,
      fraction: 1
    )
    
    let center = NSImage(named: "MacOS8 Window Titlebar Center")!
    var centerOriginX = left.size.width
    
    while (centerOriginX < (dirtyRect.size.width - right.size.width)) {
      center.draw(
        at: NSPoint(x: centerOriginX, y: dirtyRect.size.height - center.size.height),
        from: dirtyRect,
        operation: NSCompositingOperation.sourceOver,
        fraction: 1
      )
      
      centerOriginX = centerOriginX + 1
    }
  }

}
