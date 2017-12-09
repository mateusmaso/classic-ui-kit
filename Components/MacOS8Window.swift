//
//  MacOS8Window.swift
//  ClassicUIKit
//
//  Created by Mateus Maso on 2016-08-04.
//  Copyright © 2016 Purabucha. All rights reserved.
//

import Cocoa
import SnapKit

class MacOS8Window: NSWindow {
  
  var shrinked: Bool = true
  var collapsed: Bool = false

  internal var lastFrame: NSRect?

  init() {
    let contentView = MacOS8WindowView()
    
    super.init(
      contentRect: NSZeroRect,
      styleMask: [NSBorderlessWindowMask, NSResizableWindowMask],
      backing: .buffered,
      defer: false
    )
    
    self.title = "Window"
    self.contentView = contentView
    self.isMovableByWindowBackground = true
    self.hasShadow = false
    
    NotificationCenter.default.addObserver(
      forName: NSNotification.Name.NSWindowDidResize,
      object: self,
      queue: nil,
      using: { _ in
        if !self.collapsed {
          self.lastFrame = self.frame
        }
      }
    )
    
    contentView.titlebar.closeButton.target = self
    contentView.titlebar.closeButton.action = #selector(self.close)
    
    contentView.titlebar.collapseButton.target = self
    contentView.titlebar.collapseButton.action = #selector(self.collapse)
    
    contentView.titlebar.zoomButton.target = self
    contentView.titlebar.zoomButton.action = #selector(self.zoom)
  }
  
  func collapse(_ sender: AnyObject?) {
    if self.collapsed {
      self.collapsed = false
    } else {
      self.collapsed = true
    }
    
    self.contentView!.display()
    self.contentView!.updateConstraints()
  }
  
  func shrink(_ sender: AnyObject?) {
    if self.shrinked {
      self.shrinked = false
    } else {
      self.shrinked = true
    }
    
    self.contentView!.display()
    self.contentView!.updateConstraints()
  }
  
}

internal class MacOS8WindowContentView: NSView {
  
  override func draw(_ dirtyRect: NSRect) {
    super.draw(dirtyRect)
    
    NSColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1).setFill()
    NSRectFill(dirtyRect)
    
    let upperLeftCorner = NSImage(named: "MacOS8 Window Content Corner Upper Left")!
    upperLeftCorner.draw(
      at: NSPoint(x: 0, y: dirtyRect.size.height - upperLeftCorner.size.height),
      from: dirtyRect,
      operation: NSCompositingOperation.sourceOver,
      fraction: 1
    )
    
    let upperRightCorner = NSImage(named: "MacOS8 Window Content Corner Upper Right")!
    upperRightCorner.draw(
      at: NSPoint(x: dirtyRect.size.width - upperRightCorner.size.width, y: dirtyRect.size.height - upperLeftCorner.size.height),
      from: dirtyRect,
      operation: NSCompositingOperation.sourceOver,
      fraction: 1
    )
    
    let top = NSImage(named: "MacOS8 Window Content Border Top")!
    var topOriginX = upperLeftCorner.size.width
    
    while (topOriginX < (dirtyRect.size.width - upperRightCorner.size.width)) {
      top.draw(
        at: NSPoint(x: topOriginX, y: dirtyRect.size.height - top.size.height),
        from: dirtyRect,
        operation: NSCompositingOperation.sourceOver,
        fraction: 1
      )
      
      topOriginX = topOriginX + 1
    }
    
    let lowerLeftCorner = NSImage(named: "MacOS8 Window Content Corner Lower Left")!
    lowerLeftCorner.draw(
      at: NSPoint(x: 0, y: 0),
      from: dirtyRect,
      operation: NSCompositingOperation.sourceOver,
      fraction: 1
    )
    
    let lowerRightCorner = NSImage(named: "MacOS8 Window Content Corner Lower Right Resize")!
    lowerRightCorner.draw(
      at: NSPoint(x: dirtyRect.size.width - lowerRightCorner.size.width, y: 0),
      from: dirtyRect,
      operation: NSCompositingOperation.sourceOver,
      fraction: 1
    )
    
    let bottom = NSImage(named: "MacOS8 Window Content Border Bottom")!
    var bottomOriginX = lowerLeftCorner.size.width
    
    while (bottomOriginX < (dirtyRect.size.width - lowerRightCorner.size.width)) {
      bottom.draw(
        at: NSPoint(x: bottomOriginX, y: 0),
        from: dirtyRect,
        operation: NSCompositingOperation.sourceOver,
        fraction: 1
      )
      
      bottomOriginX = bottomOriginX + 1
    }
    
    let left = NSImage(named: "MacOS8 Window Content Border Left")!
    var leftOriginY = lowerLeftCorner.size.height
    
    while (leftOriginY < (dirtyRect.size.height - upperLeftCorner.size.height)) {
      left.draw(
        at: NSPoint(x: 0, y: leftOriginY),
        from: dirtyRect,
        operation: NSCompositingOperation.sourceOver,
        fraction: 1
      )
      
      leftOriginY = leftOriginY + 1
    }
    
    let right = NSImage(named: "MacOS8 Window Content Border Right")!
    var rightOriginY = lowerRightCorner.size.height
    
    while (rightOriginY < (dirtyRect.size.height - upperRightCorner.size.height)) {
      right.draw(
        at: NSPoint(x: dirtyRect.size.width - right.size.width, y: rightOriginY),
        from: dirtyRect,
        operation: NSCompositingOperation.sourceOver,
        fraction: 1
      )
      
      rightOriginY = rightOriginY + 1
    }
  }
  
}

internal class MacOS8WindowView: NSView {
  
  var titlebar: MacOS8WindowTitlebar
  var contentView: MacOS8WindowContentView

  override init(frame frameRect: NSRect) {
    self.titlebar = MacOS8WindowTitlebar()
    self.contentView = MacOS8WindowContentView()

    super.init(frame: frameRect)
    
    self.addSubview(self.titlebar)
    self.addSubview(self.contentView)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func updateConstraints() {
    let window = self.window! as! MacOS8Window

    self.titlebar.titleView.stringValue = self.window!.title

    self.titlebar.snp.remakeConstraints { make in
      make.top.left.right.equalTo(self)
      make.height.equalTo(22)
      make.width.greaterThanOrEqualTo(200)
      
      if window.collapsed {
        make.bottom.equalTo(self)
      }
    }
    
    if window.collapsed {
      self.contentView.isHidden = true
      self.contentView.snp.removeConstraints()
    } else {
      self.contentView.isHidden = false
      self.contentView.snp.remakeConstraints { make in
        make.top.equalTo(self.titlebar.snp.bottom)
        make.left.equalTo(self)
        make.right.equalTo(self)
        make.bottom.equalTo(self)
        make.height.greaterThanOrEqualTo(40)
      }
    }
  
    super.updateConstraints()
  }
  
}
