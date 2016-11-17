//
//  AMDragDrop.swift
//  Pods
//
//  Created by Musolino, Antonino Francesco on 15/11/16.
//
//

import Foundation
import UIKit

public enum AMDragDropMode
{
    case Normal
    case RestrictY
    case RestrictX
}

@objc public protocol AMDragDropDelegate
{
    func view(_ view: UIView, wasDroppedOnDrop drop: UIView!)
    @objc optional func viewShouldReturn(ToInitialPosition view: UIView) -> Bool
    @objc optional func viewDidReturnToInitialPosition()
    @objc optional func draggingBegin(forView view:UIView)
    @objc optional func draggingEnd(forView view:UIView)
}

public protocol AMHoverDelegate
{
    func view(_ view:UIView, didHover dropView:UIView)
    func view(_ view:UIView, didUnhover dropView:UIView)
}

open class AMDragDropView: UIView
{
    var dragDelegate: AMDragDropDelegate?
    var hoverDelegate: AMHoverDelegate?
    private var dragMode: AMDragDropMode = .Normal
    private var dropViews: [UIView]?
    private var animationDuration: Float = 0.5
    private var saveInitialPosition = false
    private var isHovering = false
    private var initialPosition: (x:CGFloat,y:CGFloat)?
    
    open func enableDragging()
    {
        enableDragging(dragDelegate: nil, dropViews: nil)
    }
    
    
    /// Enable the dragging on your view
    ///  @params
    ///     delegate: an AMDragDropDelegate
    ///     viewArray: an Array containing your Drop UIView
    open func enableDragging(dragDelegate delegate:AMDragDropDelegate?, dropViews viewArray:[UIView]?)
    {
        dragDelegate = delegate
        dropViews = viewArray
        
        addPanGesture()
    }
    
    /// Disable the dragging for your view
    open func stopDragging()
    {
        dragDelegate = nil
        dropViews = nil
        
        removePanGesture()
    }
    
    /// Change the Drag mode
    /// @params
    ///     newMode: New AMDragDropMode
    open func modify(DragMode newMode:AMDragDropMode)
    {
        dragMode = newMode
    }
    
    /// Change the Drop Views
    /// @params
    ///     newArray: An Array of UIView
    open func modify(DropViews newArray:[UIView])
    {
        dropViews = newArray
    }
    
    /// Modify the duration in seconds of the return to initial position animation
    /// @params
    ///     duration: Seconds
    open func modifyAnimation(withDuration duration:Float)
    {
        animationDuration = duration
    }
    
    /// Flag if you want to save the initial position of your draggable view, the default is *false*
    open func saveInitialPosition(flag:Bool)
    {
        saveInitialPosition = flag
    }
    
    /// This method move your draggable view to its initial position
    open func returnToInitialPosition()
    {
        removePanGesture()
        UIView.animate(withDuration: TimeInterval(animationDuration),
                       animations: {
                        self.center = CGPoint(x:(self.initialPosition?.x)!, y:(self.initialPosition?.y)!)},
                       completion: {_ in
                        self.dragDelegate?.viewDidReturnToInitialPosition?()
                        self.addPanGesture()
                        })
        
    }
    
    private func addPanGesture()
    {
        let recognizer = UIPanGestureRecognizer(target: self, action:#selector(draggingHandler(recognizer:)))
        self.addGestureRecognizer(recognizer)
    }
    
    private func removePanGesture()
    {
        for recognizer in self.gestureRecognizers!
        {
            self.removeGestureRecognizer(recognizer)
        }
    }
    
    @objc private func draggingHandler(recognizer:UIPanGestureRecognizer)
    {
        switch recognizer.state
        {
            case .began:

                dragDelegate?.draggingBegin?(forView: self)
                
                if saveInitialPosition
                {
                    if initialPosition == nil
                    {
                        initialPosition = (x: self.center.x, y:self.center.y)
                    }
                }
                else
                {
                    initialPosition = (x: self.center.x, y:self.center.y)
                }
        case .changed:
            let translation = recognizer.translation(in: self.superview)
            var newCenterX = self.center.x
            var newCenterY = self.center.y
            
            if dragMode == .Normal || dragMode == .RestrictY
            {
                newCenterY += translation.y
            }
            if dragMode == .Normal || dragMode == .RestrictX
            {
                newCenterX += translation.x
            }
            self.center = CGPoint(x: newCenterX, y: newCenterY)
            if dropViews != nil
            {
                for dropView in dropViews!
                {
                    if self.frame.intersects(dropView.frame)
                    {
                        if !isHovering
                        {
                            hoverDelegate?.view(self, didHover: dropView)
                            isHovering = true
                        }
                        else
                        {
                            hoverDelegate?.view(self, didUnhover: dropView)
                            isHovering = false
                        }
    
                    }
                }
            }
            recognizer.setTranslation(CGPoint.zero, in: self.superview)
        case .ended:
            if dropViews != nil
            {
                for dropView in dropViews!
                {
                    if self.frame.intersects(dropView.frame)
                    {
                        dragDelegate?.view(self, wasDroppedOnDrop: dropView)
                    }
                    else
                    {
                        dragDelegate?.draggingEnd?(forView: self)
                    }
                }
            }
            let returnBack = dragDelegate?.viewShouldReturn?(ToInitialPosition: self) ?? false
            if returnBack
            {
                UIView.animate(withDuration: TimeInterval(animationDuration),
                               animations: {
                                self.center = CGPoint(x:(self.initialPosition?.x)!, y:(self.initialPosition?.y)!)
                })
            }
        default:
                break
        }
    }
    
}
