//
//  ViewController.swift
//  MyMetalDemo
//
//  Created by 罗源 on 2017/3/17.
//  Copyright © 2017年 com.greenEarth. All rights reserved.
//

import UIKit
import Metal
//import MetalKit
import QuartzCore
class ViewController: UIViewController {
    var device : MTLDevice! = nil
    var metalLayer : CAMetalLayer! = nil
    let vertexData : [Float] = [0.0, 1.0, 0.0,
                                -1.0,-1.0,0.0,
                                1.0,-1.0,0.0]//这在CPU创建一个浮点数数组——你需要通过把它移动到一个叫MTLBuffer的东西，来发送这些数据到GPU。
    var vertexBuffer : MTLBuffer! = nil
    var pipelineState: MTLRenderPipelineState! = nil
    var commandQueue: MTLCommandQueue! = nil
    var timer: CADisplayLink! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        device = MTLCreateSystemDefaultDevice()
        guard device != nil else {
            print("Metal is not supported on this device")
            self.view = UIView(frame: self.view.frame)
            return
        }
        metalLayer = CAMetalLayer()
        metalLayer.device = device
        metalLayer.pixelFormat = .bgra8Unorm//代表”8字节代表蓝色、绿色、红色和透明度，通过在0到1之间单位化的值来表示”。
        metalLayer.framebufferOnly = true//苹果鼓励你设置framebufferOnly为true，来增强表现效率。除非你需要对从layer生成的纹理（textures）取样，或者你需要在layer绘图纹理(drawable textures)激活一些计算内核，否则你不需要设置。（大部分情况下你不用设置）
        metalLayer.frame = view.layer.frame
        view.layer.addSublayer(metalLayer)
        
        let dataSize = vertexData.count * MemoryLayout.size(ofValue: vertexData[0])//需要获取vertex data的字节大小。你通过把第一个元素的大小和数组元素个数相乘来得到
        vertexBuffer = device.makeBuffer(bytes: vertexData, length: dataSize, options: MTLResourceOptions.cpuCacheModeWriteCombined)//在GPU创建一个新的buffer，从CPU里输送data
        
        //创建一个Render Pipeline  包含你想要使用的shaders、颜色附件（color attachment）的像素格式(pixel format)。（例如：你渲染到的输入缓冲区，也就是CAMetalLayer）
        let defaultLibrary = device.newDefaultLibrary()!
        let fragmentProgram = defaultLibrary.makeFunction(name: "basic_fragment")
        let vertexProgram = defaultLibrary.makeFunction(name: "basic_vertex")
        let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
        pipelineStateDescriptor.vertexFunction = vertexProgram
        pipelineStateDescriptor.fragmentFunction = fragmentProgram
        pipelineStateDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        
        do {//把这个pipeline 配置编译到一个pipeline 状态(state)中，让它使用起来有效率
            try pipelineState = device.makeRenderPipelineState(descriptor: pipelineStateDescriptor)
        }catch let error {
            print("Failed to create pipeline state, error \(error)")
        }
        
        //创建一个Command Queue, 把这个想象成是一个列表装载着你告诉GPU一次要执行的命令。
        commandQueue = device.makeCommandQueue()
        
        //
        timer = CADisplayLink(target: self, selector: #selector(ViewController.gameloop))
        timer.frameInterval = 60
        timer.add(to: RunLoop.current, forMode: .defaultRunLoopMode)
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func render(){
        let drawable = metalLayer.nextDrawable()!
        let renderPassDescriptor = MTLRenderPassDescriptor()
        renderPassDescriptor.colorAttachments[0].texture = drawable.texture
        renderPassDescriptor.colorAttachments[0].loadAction = .clear
        renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColor(red: 0.0, green: 104.0/255.0, blue: 5.0/255.0, alpha: 1.0)
        renderPassDescriptor.colorAttachments[0].storeAction = .store
        //创建一个command buffer。你可以把它想象为一系列这一帧想要执行的渲染命令。
        let commandBuffer = commandQueue.makeCommandBuffer()
        //创建一个渲染命令编码器(Render Command Encoder)
        let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        renderEncoder.setRenderPipelineState(pipelineState)
        renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, at: 0)
        renderEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 3, instanceCount: 1)
        renderEncoder.endEncoding()//这里你创建一个command encoder，并指定你之前创建的pipeline和顶点     drawPrimitives(vertexStart:vertexCount:instanceCount:)这里你你告诉GPU，让它基于vertex buffer画一系列的三角形。每个三角形由三个顶点组成，从vertex buffer 下标为0的顶点开始，总共有一个三角形。当你完成后，你只要调用 endEncoding()
        
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
    func gameloop(){
        autoreleasepool {
            self.render()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

