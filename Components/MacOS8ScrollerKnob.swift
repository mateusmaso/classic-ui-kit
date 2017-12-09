//
//  MacOS8ScrollerKnob.swift
//  ClassicUIKit
//
//  Created by Mateus Maso on 2016-08-07.
//  Copyright © 2016 Purabucha. All rights reserved.
//

import Cocoa

class MacOS8ScrollerKnob: MacOS8Button {
  
  override init() {
    super.init()
    self.title = ""
    self.isBordered = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func mouseDown(with event: NSEvent) {
    self.superview!.mouseDown(with: event.copy() as! NSEvent)
  }
  
  override func draw(_ dirtyRect: NSRect) {
    let dragLeft = NSImage(named: "MacOS8 Scrollbar Scroller Knob Left")!
    var dragLeftRect = NSZeroRect
    dragLeftRect.origin = NSPoint(x: 0, y: 0)
    dragLeftRect.size = dragLeft.size
    dragLeft.draw(in: dragLeftRect)
    
    let dragRight = NSImage(named: "MacOS8 Scrollbar Scroller Knob Right")!
    var dragRightRect = NSZeroRect
    dragRightRect.origin = NSPoint(
      x: self.frame.size.width - dragRight.size.width,
      y: 0
    )
    dragRightRect.size = dragRight.size
    dragRight.draw(in: dragRightRect)
    
    let dragCenter = NSImage(named: "MacOS8 Scrollbar Scroller Knob Center")!
    var centerOriginX = dragLeft.size.width
    
    while (centerOriginX < (self.frame.size.width - dragRight.size.width)) {
      var dragCenterRect = NSZeroRect
      dragCenterRect.origin = NSPoint(
        x: centerOriginX,
        y: 0
      )
      dragCenterRect.size = dragRight.size
      dragCenter.draw(in: dragCenterRect)
      centerOriginX = centerOriginX + 1
    }

    let stripe = NSImage(named: "MacOS8 Scrollbar Scroller Knob Stripe")!
    var stripeRect = NSZeroRect
    stripeRect.origin = NSPoint(
      x: (self.frame.size.width/2) - (stripe.size.width/2),
      y: (self.frame.size.height/2) - (stripe.size.height/2)
    )
    stripeRect.size = stripe.size
    stripe.draw(in: stripeRect)
  }
  
}
