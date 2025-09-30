import Android
import AndroidAssets
import Java
import JavaRuntime
import Synchronization

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
        let asset = try Asset(.init(pointer), name: "document.txt").bytes
        
        let document = String(decoding: asset, as: UTF8.self)
        return document.jni(in: environment)
    } catch {
        return "\(error)".jni(in: environment)
    }
}

public class Context: JavaObject {
    override public class var javaClassName: String {
        "android.content.Context"
    }
}

public class Activity: Context {
    override public class var javaClassName: String {
        "android.app.Activity"
    }
}

public extension Activity {
    func getAssets() throws -> AssetManager {
        try call(method: "getAssets")
    }
}

public class MainActivity: Activity {
    override public class var javaClassName: String {
        "org.company.app.MainActivity"
    }
}

public extension MainActivity {
    func string() throws -> String {
        try call(method: "string")
    }
}

public class AssetManager: JavaObject {
    override public class var javaClassName: String {
        "android.content.res.AssetManager"
    }
}
