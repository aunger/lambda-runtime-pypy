# lambda-runtime-pypy

An AWS Lambda Runtime for [PyPy](http://pypy.org)

Derived from https://github.com/iopipe/lambda-runtime-pypy3.5

## Overview

This is an AWS Lambda Runtime for PyPy. Unlike the upstream, which uses [portable-pypy](https://github.com/squeaky-pl/portable-pypy), this uses the official distro, and supports Python 2 and Python 3.

## Build

To build this runtime as a layer:

```bash
make build
```

## License

Apache 2.0
