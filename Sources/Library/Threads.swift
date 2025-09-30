import Android
import ndk.looper

nonisolated(unsafe)
private var _mainLooper: OpaquePointer?

func configureMainActorExecutor() {
    if _mainLooper != nil {
        ALooper_release(_mainLooper)
    }
    _mainLooper = ALooper_forThread()
    ALooper_acquire(_mainLooper)
    
    let callback: ALooper_callbackFunc = { port, _, _ in
        _dispatch_main_queue_callback_4CF(nil)
        
        let capacity = 8
        let length = withUnsafeTemporaryAllocation(of: UInt8.self, capacity: capacity, {
            read(port, $0.baseAddress, capacity)
        })
        
        return length != -1 ? 1 : 0
    }
    
    let port = _dispatch_get_main_queue_port_4CF()
    ALooper_addFd(_mainLooper, port, 0, CInt(ALOOPER_EVENT_INPUT), callback, nil)
}

@_silgen_name("_dispatch_main_queue_callback_4CF")
private func _dispatch_main_queue_callback_4CF(_ msg: UnsafeMutableRawPointer?)

@_silgen_name("_dispatch_get_main_queue_port_4CF")
private func _dispatch_get_main_queue_port_4CF() -> CInt
