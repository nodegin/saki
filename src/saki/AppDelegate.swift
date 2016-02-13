//
//  AppDelegate.swift
//
//  part of project saki
//  Copyright 2016 nodegin. All rights reserved.
//

import Cocoa
import WebKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet var window: NSWindow!
    @IBOutlet var popover : NSPopover!
    @IBOutlet var webview: WebView!
    @IBAction func click(sender: NSButton) {
        NSApp.terminate(self)
    }
    private let icon: IconView
    
    override init()
    {
        let bar = NSStatusBar.systemStatusBar();
        
        let length: CGFloat = -1 //NSVariableStatusItemLength
        let item = bar.statusItemWithLength(length);
        
        self.icon = IconView(imageName: "icon", item: item);
        item.view = icon;
        
        super.init();
    }
    
    func applicationDidFinishLaunching(aNotification: NSNotification)
    {
        // Configure the window and webview
        // Window levels:
        // @see: http://stackoverflow.com/questions/4612422
        // @see: http://stackoverflow.com/questions/28829659
        window.level = Int(CGWindowLevelForKey(CGWindowLevelKey.MaximumWindowLevelKey))
        let screenRect: NSRect = NSScreen.mainScreen()!.frame
        window.backgroundColor = NSColor(red: 0, green: 0, blue: 0, alpha: 0)
        window.styleMask = NSBorderlessWindowMask
        window.ignoresMouseEvents = true
        window.setFrame(NSMakeRect(0, 0, screenRect.width, screenRect.height), display: true)
        window.contentView = webview
        webview.drawsBackground = false
        let url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("sakura", ofType: "html")!)
        webview.mainFrame.loadRequest(NSURLRequest(URL: url))
    }
    
    func applicationWillTerminate(aNotification: NSNotification)
    {
        // Insert code here to tear down your application
    }

    override func awakeFromNib()
    {
        let edge = NSRectEdge.MinY
        let icon = self.icon
        let rect = icon.frame
        icon.onMouseDown = {
            if (icon.isSelected)
            {
                self.popover.showRelativeToRect(rect, ofView: icon, preferredEdge: edge);
                return
            }
            self.popover.close()
        }
    }

}

