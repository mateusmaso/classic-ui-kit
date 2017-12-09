//
//  MacOS8WindowStripeView.swift
//  ClassicUIKit
//
//  Created by Mateus Maso on 2016-08-05.
//  Copyright © 2016 Purabucha. All rights reserved.
//

import Cocoa

class MacOS8WindowStripeView: NSView {
      
  override func draw(_ dirtyRect: NSRect) {
    super.draw(dirtyRect)

    let stripeLeft = NSImage(named: "MacOS8 Window Titlebar Stripe Left")!
    stripeLeft.draw(
      at: NSPoint(x: 0, y: 0),
      from: dirtyRect,
      operation: NSCompositingOperation.sourceOver,
      fraction: 1
    )
    
    let stripeRight = NSImage(named: "MacOS8 Window Titlebar Stripe Right")!
    stripeRight.draw(
      at: NSPoint(x: dirtyRect.size.width - stripeRight.size.width, y: 0),
      from: dirtyRect,
      operation: NSCompositingOperation.sourceOver,
      fraction: 1
    )
    
    let stripeCenter = NSImage(named: "MacOS8 Window Titlebar Stripe Center")!
    var stripeCenterOriginX = stripeLeft.size.width
    
    while (stripeCenterOriginX < (dirtyRect.size.width - stripeRight.size.width)) {
      stripeCenter.draw(
        at: NSPoint(x: stripeCenterOriginX, y: 0),
        from: dirtyRect,
        operation: NSCompositingOperation.sourceOver,
        fraction: 1
      )
      
      stripeCenterOriginX = stripeCenterOriginX + 1
    }
  }
  
}
