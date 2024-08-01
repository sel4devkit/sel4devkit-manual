# Introduction

This Package forms part of the seL4 Developer Kit. It contains the seL4
Developer Kit Documentation. Further, it provides the automated capability to
publish this material on the seL4 Developer Kit Git Hub Page.

# Usage

The seL4 Developer Kit Documentation is maintained as a mdBook. This permits
documentation to be written in simple Markdown, and automatically presented as
a structured static web site:
* https://rust-lang.github.io/mdBook/

It is highly recommended to view the seL4 Developer Kit Documentation as its
presented structured static web site. It is possible to view the documentation
directly within Git Hub (as it also adopts Markdown) however it can be
difficult to navigate the overall structure.

The most immediate solution would be to visit the seL4 Developer Kit site:
* https://sel4devkit.github.io

Alternatively, the site may be created via this repository.

Must be invoked inside the following:
* sel4devkit-maaxboard-microkit-docker-dev-env

Show usage instructions:
```
make
```

Build site:
```
make get
make all
```

# Maintenance

Presents detailed technical aspects relevant to understanding and maintaining
this Package.

## Publish

To build and publish the site:
```
make get
make publish
```
