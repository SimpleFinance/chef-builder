# Builder
Builder is a cookbook which configures jenkins masters/slaves for building and
deploying projects and services, JVM-based in particular.

## Usage
By default, the Builder cookbook will install a sane Ruby, Java, Python, and
Clojure build environment by utilizing the [polyglot](https://github.com/SimpleFinance/chef-polyglot) 
cookbook. Enable one of your instances as a Jenkins master by running `builder::master`. 
From there, add as many build slaves as you please by running `builder::slave`. That's it!

If you don't want Builder to configure Ruby, as an example, just set
`node.override[:polyglot][:ruby][:enable] = false`. You can do the same for Java, Python,
Clojure, and Android (disabled by default).

## Author
Simple Finance <ops@simple.com>

## License
Apache License, Version 2.0

