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
### Default configuration
Plugin by default uses `#"^(.*?Resources)"#` as a regular expression which matching every character from the beginning of the path to the end of Resources word and replaces it with empty string `""`.

This makes possible to use local path in markdown like this.

```markdown   
![Image](./../../Resources/images/image.png)
```

Which is later translated to html as a relative path to the image:

```html
<img src="/images/image.png" alt="Image"/>
```

### Custom configuration
Is it possible to provide custom regular expression to find pattern in image path and custom string as replace with.

To provide custom values you need to provide `ReplaceLocalPathConfig` struct instance for `.init(config:ReplaceLocalPathConfig)` plugin initializer.

```swift
let config = ReplaceLocalPathConfig(pathRegex: #"replace\d*this"#, with: "newPath")

try MyBlog().publish(withTheme: .myTheme, plugins: [
	.replaceImageUrl(config: config)
	// ...
])
```

This example translates markdown like this:

```markdown    
![Image](/a/b/Resources/replace123this/images/image.png)
```

into html like this:

```html
<img src="/a/b/Resources/newPath/images/image.png" alt="Image"/>
```

## Contribution
If you noticed any bugs or points for improvement, feel free to create Pull Request (Merge Request).