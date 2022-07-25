import Foundation
import PathKit
import SwagGenKit
import SwiftCLI

let version = "4.7.0"
let generateCommand = GenerateCommand()
let cli = CLI(name: "swaggen", version: version, description: "Swagger code generator", commands: [generateCommand])
cli.go(with: ["generate", "https://petstore3.swagger.io/api/v3/openapi.json" , "-c", "all"])
