//
//  ViewController.swift
//  AMDragDrop
//
//  Created by Antonino Francesco Musolino on 11/15/2016.
//  Copyright (c) 2016 Antonino Francesco Musolino. All rights reserved.
//

import UIKit
import AMDragDrop

class ViewController: UIViewController, AMDragDropDelegate
{
   
    @IBOutlet weak var otherDropView: AMDragDropView!
    @IBOutlet weak var dragView: AMDragDropView!
    @IBOutlet weak var dropView: UIView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        dragView.enableDragging(dragDelegate: self, dropViews: [(dropView)])
        otherDropView.enableDragging(dragDelegate: self, dropViews: nil)
        otherDropView.saveInitialPosition(flag: true)
        otherDropView.modify(DragMode: .RestrictX)
        otherDropView.modifyAnimation(withDuration: 1)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func view(_ view: UIView, wasDroppedOnDrop drop: UIView!)
    {
        print("I was dropped on a Drop View")
    }
    
    func viewShouldReturn(ToInitialPosition view: UIView) -> Bool
    {
        return true
    }

}

