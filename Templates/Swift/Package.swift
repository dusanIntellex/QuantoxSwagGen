// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "{{ options.name }}",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(name: "{{ options.name }}", targets: ["{{ options.name }}"])
    ],
    dependencies: [
        {% for dependency in options.dependencies %}
        .package(url: "https://github.com/{{ dependency.github }}.git", .exact("{{ dependency.version }}")),
        {% endfor %}
    ],
    targets: [
        .target(name: "{{ options.name }}", dependencies: [
          {% for dependency in options.dependencies %}
          "{{ dependency.pod }}",
          {% endfor %}
        ], path: "Sources")
    ]
)
