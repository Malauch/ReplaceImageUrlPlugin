# ReplaceImageUrl plugin for Publish
A [Publish](https://github.com/johnsundell/publish.git) plugin that replaces pattern with provided string in all images paths during parsing markdown files.

## Use-case
In Publish paths for post and image files looks like that: 
- post: `MyBlog/Content/posts/post.md` ,
- image: `MyBlog/Resources/images/image.png`.

On deployed website there translate to:
- post `https://example.com/posts/post.md`
- image `https://example.com/images/image.png`

However Publish doesn't parse images paths used in markdown files in any way. Therefore you have to use final images paths when writing posts. However, then there is no image preview in you markdown editor. Workaround for it is to upload images to the website before and use full path `https://example.com/images/image.png`. However this approach is inconvenient and doesn't work offline. 

ReplaceImageUrl solves this problem by providing simple way to *find and replace* over images paths. It is possible to use local path in markdown files, which are later translated to remote paths when deploying website.

## Installation
To install plugin into your [Publish](https://github.com/johnsundell/publish) package, add it as a dependency within your `Package.swift`:
    
```swift
let package = Package(
    ...
    dependencies: [
        ...
        .package(name: "ReplaceImageUrlPlugin", url: "https://gitlab.com/Malauch/ReplaceImageUrlPlugin.git", from: "0.1.0")
    ],
    targets: [
        .target(
            ...
            dependencies: [
                ...
                "ReplaceImageURL"
            ]
        )
    ]
    ...
)
```

Then import ReplaceImageUrlPlugin wherever you’d like to use it:
    
    import ReplaceImageUrlPlugin

To install the plugin, add it to your site's publishing steps:

```swift
try MyBlog().publish(withTheme: .myTheme, plugins: [
	.replaceImageUrl()  // uses default configuration
	// ...
])
```

## Usage

