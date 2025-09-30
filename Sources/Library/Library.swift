import Android
import AndroidAssets
import Java
import JavaRuntime
import Synchronization
import TranslationLayer

@_silgen_name("Java_org_company_app_MainActivity_message")
public func message(environment: JNIEnvironment, activity: jobject?) -> jstring? {
    guard let activity = activity else { return nil }
    Task { @MainActor in
        print("main thread")
    }
    do {
        let activity = try MainActivity(jni: activity, in: environment)
        let assets = try activity.getAssets()
        
        let string = try activity.string()
        print("from Java in Swift:", string)
        
        guard let pointer = AAssetManager_fromJava(environment, assets.holder.reference) else { return nil }
        let asset = try Asset(AssetManager(pointer), name: "document.txt").bytes
        
        let document = String(decoding: asset, as: UTF8.self)
        return document.jni(in: environment)
    } catch {
        return "\(error)".jni(in: environment)
    }
}

@_silgen_name("Java_org_company_app_MainActivity_toggle")
public func toggle(environment: JNIEnvironment, activity: jobject?) {
    guard let activity = activity else { return }
    do {
        let activity = try MainActivity(jni: activity, in: environment)
        try activity.toggleKeyboard()
    } catch {
        print(error)
    }
}

nonisolated(unsafe)
var isKeyboardVisible: Bool = false

extension Activity {
    func toggleKeyboard() throws {
        if isKeyboardVisible {
            try hideKeyboard()
        } else {
            try showKeyboard()
        }
        isKeyboardVisible.toggle()
    }
    
    func showKeyboard() throws {
        let view = try getWindow().getDecorView()
        
        let service = Context[environment, "INPUT_METHOD_SERVICE"] as String
        
        try getSystemService(service).as(InputMethodManager.self)!.showSoftInput(view)
    }

    func hideKeyboard() throws {
        let binder = try getWindow().getDecorView().getWindowToken()
        
        let service = Context[environment, "INPUT_METHOD_SERVICE"] as String
        
        try getSystemService(service).as(InputMethodManager.self)!.hideSoftInputFromWindow(binder)
    }
}
