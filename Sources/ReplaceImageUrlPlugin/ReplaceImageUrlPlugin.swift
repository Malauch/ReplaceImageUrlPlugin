import Ink
import Publish

public extension Plugin {
   static func replaceImageUrl(config: ReplaceLocalPathConfig? = .init()) -> Self {
      Plugin(name: "ReplaceImageUrl") { context in
         context.markdownParser.addModifier(.replaceImageUrl(config: config))
      }
   }
}

public extension Modifier {
   static internal func replaceImageUrl(config: ReplaceLocalPathConfig? = .init()) -> Self {
      Modifier(target: .images) { (html, markdown) -> String in
         let config = config ?? ReplaceLocalPathConfig()
         
         let pathRegex = #"(?<=src=")(.+)(?=")"#
         guard let pathRange = html.range(of: pathRegex, options: [.regularExpression]) else { return html }
         let pathString = html[pathRange]
         
			let newPath = pathString.replacingOccurrences(of: config.localPathRegex, with: config.replaceWith, options: [.regularExpression])
         
         var newHTML = html
         newHTML.replaceSubrange(pathRange, with: newPath)
         
         return newHTML
      }
   }
}

public struct ReplaceLocalPathConfig {
   public let localPathRegex: String
   public let replaceWith: String
   
   public init(pathRegex: String = #"^(.*?Resources)"#, with replacement: String = "") {
      self.localPathRegex = pathRegex
      self.replaceWith = replacement
   }
}

