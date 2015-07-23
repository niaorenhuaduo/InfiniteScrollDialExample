//
//  InfiniteScrollUnit.swift
//  InfiniteScrollDial
//
//  Created by konhondros on 30/6/15.
//  Copyright (c) 2015 http://www.konhondros.com All rights reserved.
//

import Foundation
import Cocoa

class InfiniteScrollUnit: NSView {
    
    
    // MARK: - Properties
    
    var value: Int! {
        didSet {
            self.needsDisplay = true
        }
    }
    
    
    // MARK: - Initializers
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    // MARK: - Methods
    
    
    // MARK: - Draw Content
    
    override func drawRect(dirtyRect: NSRect) {
        
        // Colors
        
        //let color = NSColor(calibratedRed: 0.405, green: 0.694, blue: 0.914, alpha: 1)
        let color = NSColor.whiteColor()
        
        // Get current context
        let context = NSGraphicsContext.currentContext()!.CGContext
        
        
        
        // Rectangle Drawing
        
        let rectanglePath = NSBezierPath(rect: NSMakeRect(0, 0, self.frame.width, self.frame.height))
        color.setFill()
        rectanglePath.fill()
        
        
        let ticks: CGFloat = 10
        let space = self.frame.width / ticks
        
        var tickColor:NSColor!
        var tickHeight:CGFloat = 0
        var tickWidth:CGFloat = 0
        
        for i in 0...Int(ticks) {
            if i != Int(ticks) / 2 {
                tickHeight = self.frame.height * 0.2
                tickWidth = 2
                tickColor = NSColor.orangeColor()
            } else {
                tickHeight = self.frame.height * 0.3
                tickWidth = 2
                tickColor = NSColor.blackColor()
            }
            
            self.drawTick(context, pointX: CGFloat(i) * space, width: tickWidth, height: tickHeight, color: tickColor)
        }
        
        //// Text Drawing
        if self.value != nil {
            let textRect = NSMakeRect(self.frame.width / 2 - 40, self.frame.height * 0.4, 80, 40)
            
            let textTextContent = NSString(string: String(self.value))
            let textStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
            textStyle.alignment = NSTextAlignment.CenterTextAlignment
            
            let textFontAttributes = [NSFontAttributeName: NSFont.systemFontOfSize(25), NSForegroundColorAttributeName: NSColor.blackColor(), NSParagraphStyleAttributeName: textStyle]
            
            let textTextHeight: CGFloat = textTextContent.boundingRectWithSize(NSMakeSize(textRect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: textFontAttributes).size.height
            let textTextRect: NSRect = NSMakeRect(textRect.minX, textRect.minY + (textRect.height - textTextHeight) / 2, textRect.width, textTextHeight)
            
            NSGraphicsContext.saveGraphicsState()
            NSRectClip(textRect)
            textTextContent.drawInRect(NSOffsetRect(textTextRect, 0, 0), withAttributes: textFontAttributes)
            NSGraphicsContext.restoreGraphicsState()
        }
    }
    
    func drawTick(context: CGContextRef, pointX: CGFloat, width: CGFloat, height: CGFloat, color: NSColor) {
        
        CGContextSetStrokeColorWithColor(context, color.CGColor)
        CGContextSetLineWidth(context, width)
        CGContextSetLineCap(context, kCGLineCapRound)
        CGContextMoveToPoint(context, pointX, 0)
        CGContextAddLineToPoint(context, pointX , height)
        CGContextStrokePath(context)
    }

}