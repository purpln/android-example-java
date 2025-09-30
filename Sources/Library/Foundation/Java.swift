import Java
import JavaRuntime

nonisolated(unsafe)
public var java: JavaVirtualMachine?

@_silgen_name("JNI_OnLoad")
public func JNI_OnLoad(jvm: JavaVirtualMachinePointer, reserved: UnsafeMutableRawPointer) -> CInt {
    java = JavaVirtualMachine(adopting: jvm)
    
    configureMainActorExecutor()
    
    try? LogRedirector.shared.redirectPrint()
    
    return JNI_VERSION_1_6
}
