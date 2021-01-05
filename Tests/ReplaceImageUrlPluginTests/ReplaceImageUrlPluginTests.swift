import XCTest
import Ink

@testable import ReplaceImageUrlPlugin

final class ReplaceImageUrlPluginTests: XCTestCase {
	func testReplacingLocalPathForRemote_withDefultConfig() {
		let parser = MarkdownParser(modifiers: [.replaceImageUrlPlugin()])
		
		let md = """
      Some text
         
      ![Image](./../../Resources/images/image.png)
      			
      More text
      """
		
		let outputHtml = parser.html(from: md)

		let expectedHtml = """
		<p>Some text<br><img src="/images/image.png" alt="Image"/> More text</p>
		"""
		
		XCTAssertEqual(expectedHtml, outputHtml)
	}
	
	func testReplacingLocalPathForRemote_withCustomConfig() {
		let config = ReplaceLocalPathConfig(pathRegex: #"replace\d*this"#, with: "newPath")
		
		let parser = MarkdownParser(modifiers: [.replaceImageUrlPlugin(config: config)])
		
		let md = """
      Some text
         
      ![Image](/a/b/Resources/replace123this/images/image.png)
      			
      More text
      """
		
		let outputHtml = parser.html(from: md)
		
		let expectedHtml = """
		<p>Some text<br><img src="/a/b/Resources/newPath/images/image.png" alt="Image"/> More text</p>
		"""
		
		XCTAssertEqual(expectedHtml, outputHtml)
	}
}
