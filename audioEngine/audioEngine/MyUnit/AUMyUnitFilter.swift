//
//  AUMyUnitFilter.swift
//  audioEngine
//
//  Created by TomoKikuchi on 2021/07/07.
//

import Foundation
import AudioToolbox
import AVFoundation
import CoreAudioKit

fileprivate extension AUAudioUnitPreset {
    convenience init(number: Int, name: String) {
        self.init()
        self.number = number
        self.name = name
    }
}

//AVAudioUnitを作成するために登録するクラス
public class AUMyUnitFilter: AUAudioUnit {
    private let kernelAdapter: MyUnitFilterDSPKernelAdapter

    lazy private var inputBusArray: AUAudioUnitBusArray = {
        AUAudioUnitBusArray(audioUnit: self,
                            busType: .input,
                            busses: [kernelAdapter.inputBus])
    }()

    lazy private var outputBusArray: AUAudioUnitBusArray = {
        AUAudioUnitBusArray(audioUnit: self,
                            busType: .output,
                            busses: [kernelAdapter.outputBus])
    }()

    public override var inputBusses: AUAudioUnitBusArray {
        return inputBusArray
    }

    public override var outputBusses: AUAudioUnitBusArray {
        return outputBusArray
    }

    public override var factoryPresets: [AUAudioUnitPreset] {
        return [
            AUAudioUnitPreset(number: 0, name: "Default")
        ]
    }

    private let factoryPresetValues:[(AUValue)] = [(0)]
    private var _currentPreset: AUAudioUnitPreset?
    
    public override var currentPreset: AUAudioUnitPreset? {
        get { return _currentPreset }
        set {
            guard let preset = newValue else {
                _currentPreset = nil
                return
            }
            
            // Factory presets need to always have a number >= 0.
            if preset.number >= 0 {
                _currentPreset = preset
            }
        }
    }
    
    public func setMyUnit(isMyUnit: Bool) {
        kernelAdapter.setMyUnit(isMyUnit)
    }
    
    public func resetFilterState() {
        kernelAdapter.reset()
    }

    public override init(componentDescription: AudioComponentDescription,
                         options: AudioComponentInstantiationOptions = []) throws {
        // Create adapter to communicate to underlying C++ DSP code
        kernelAdapter = MyUnitFilterDSPKernelAdapter()
        // Init super class
        try super.init(componentDescription: componentDescription, options: options)
        // Set the default preset
        currentPreset = factoryPresets.first
    }

    public override var maximumFramesToRender: AUAudioFrameCount {
        get {
            return kernelAdapter.maximumFramesToRender
        }
        set {
            if !renderResourcesAllocated {
                kernelAdapter.maximumFramesToRender = newValue
            }
        }
    }

    public override func allocateRenderResources() throws {
        try super.allocateRenderResources()
        if kernelAdapter.outputBus.format.channelCount != kernelAdapter.inputBus.format.channelCount {
            throw NSError(domain: NSOSStatusErrorDomain, code: Int(kAudioUnitErr_FailedInitialization), userInfo: nil)
        }
        kernelAdapter.allocateRenderResources()
    }

    public override func deallocateRenderResources() {
        super.deallocateRenderResources()
        kernelAdapter.deallocateRenderResources()
    }

    public override var internalRenderBlock: AUInternalRenderBlock {
        return kernelAdapter.internalRenderBlock()
    }

}
