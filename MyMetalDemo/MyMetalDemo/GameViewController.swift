//
//  ViewController.swift
//  HelloMetal
//
//  Created by Main Account on 7/17/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import UIKit
import Metal
import QuartzCore

class GameViewController: UIViewController {
    
    var device: MTLDevice! = nil
    var metalLayer: CAMetalLayer! = nil
    var pipelineState: MTLRenderPipelineState! = nil
    var vertexBuffer: MTLBuffer! = nil
    var commandQueue: MTLCommandQueue! = nil
    var timer: CADisplayLink! = nil
    
    let vertexData:[Float] = [
        0.0, 1.0, 0.0,
        -1.0, -1.0, 0.0,
        1.0, -1.0, 0.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        device = MTLCreateSystemDefaultDevice()
        
        metalLayer = CAMetalLayer()          // 1
        metalLayer.device = device           // 2
        metalLayer.pixelFormat = .bgra8Unorm // 3
        metalLayer.framebufferOnly = true    // 4
        metalLayer.frame = view.layer.frame  // 5
        view.layer.addSublayer(metalLayer)   // 6
        
        // 1
        let dataSize = vertexData.count * MemoryLayout.size(ofValue: vertexData[0])
        // 2
        vertexBuffer = device.makeBuffer(bytes: vertexData, length: dataSize, options: MTLResourceOptions.cpuCacheModeWriteCombined)//在GPU创建一个新的buffer，从CPU里输送data
        
        // 1
        let defaultLibrary = device.newDefaultLibrary()!
        let fragmentProgram = defaultLibrary.makeFunction(name: "basic_fragment")
        let vertexProgram = defaultLibrary.makeFunction(name: "basic_vertex")
        
        // 2
        let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
        pipelineStateDescriptor.vertexFunction = vertexProgram
        pipelineStateDescriptor.fragmentFunction = fragmentProgram
        pipelineStateDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        
        // 3
        do {//把这个pipeline 配置编译到一个pipeline 状态(state)中，让它使用起来有效率
            try pipelineState = device.makeRenderPipelineState(descriptor: pipelineStateDescriptor)
        }catch let error {
            print("Failed to create pipeline state, error \(error)")
        }
        
        commandQueue = device.makeCommandQueue()
        
        timer = CADisplayLink(target: self, selector: #selector(ViewController.gameloop))
        timer.frameInterval = 60
        timer.add(to: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
    }
    
    func render() {
        
        let drawable = metalLayer.nextDrawable()
        
        let renderPassDescriptor = MTLRenderPassDescriptor()
        renderPassDescriptor.colorAttachments[0].texture = drawable?.texture
        renderPassDescriptor.colorAttachments[0].loadAction = .clear
        renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColor(red: 0.0, green: 104.0/255.0, blue: 5.0/255.0, alpha: 1.0)
        renderPassDescriptor.colorAttachments[0].storeAction = .store
        
        let commandBuffer = commandQueue.makeCommandBuffer()
        
        let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        renderEncoder.setRenderPipelineState(pipelineState)
        renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, at: 0)
        renderEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 3, instanceCount: 1)
        renderEncoder.endEncoding()
        
        commandBuffer.present(drawable!)
        commandBuffer.commit()
        
    }
    
    func gameloop() {
        autoreleasepool {
            self.render()
        }
    }
    
    
}

