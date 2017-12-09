//
//  MacOS8Scroller.swift
//  ClassicUIKit
//
//  Created by Mateus Maso on 2016-08-05.
//  Copyright © 2016 Purabucha. All rights reserved.
//

import Cocoa

class MacOS8Scroller: NSScroller {
  
  var knob: MacOS8ScrollerKnob
  
  init() {
    self.knob = MacOS8ScrollerKnob()

    super.init(frame: NSZeroRect)
    
    self.addSubview(self.knob)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func drawKnobSlot(in slotRect: NSRect, highlight flag: Bool) {
    let knobSlotRect = NSRect(
      origin: NSPoint(x: slotRect.origin.x, y: 0),
      size: NSSize(width: slotRect.size.width, height: slotRect.size.height + 1)
    )

    var knobRect = self.rect(for: NSScrollerPart.knob)
    knobRect.origin = NSPoint(x: knobRect.origin.x, y: 0)

    let left = NSImage(named: "MacOS8 Scrollbar Scroller Knob Slot Left")!
    left.draw(
      at: NSPoint(x: 0, y: 0),
      from: knobSlotRect,
      operation: NSCompositingOperation.sourceOver,
      fraction: 1
    )
    
    let right = NSImage(named: "MacOS8 Scrollbar Scroller Knob Slot Right")!
    right.draw(
      at: NSPoint(x: knobSlotRect.size.width - right.size.width, y: 0),
      from: knobSlotRect,
      operation: NSCompositingOperation.sourceOver,
      fraction: 1
    )
    
    let center = NSImage(named: "MacOS8 Scrollbar Scroller Knob Slot Center")!
    var centerOriginX = left.size.width
    
    while (centerOriginX < (knobSlotRect.size.width - right.size.width)) {
      center.draw(
        at: NSPoint(x: centerOriginX, y: 0),
        from: knobSlotRect,
        operation: NSCompositingOperation.sourceOver,
        fraction: 1
      )
      
      centerOriginX = centerOriginX + 1
    }
    
    left.draw(
      at: NSPoint(x: knobRect.origin.x + knobRect.size.width, y: 0),
      from: knobSlotRect,
      operation: NSCompositingOperation.sourceOver,
      fraction: 1
    )
  }
  
  override func drawKnob() {
    var knobRect = self.rect(for: NSScrollerPart.knob)
    knobRect.origin = NSPoint(x: knobRect.origin.x, y: 0)    
    self.knob.frame = knobRect
  }
  
}
