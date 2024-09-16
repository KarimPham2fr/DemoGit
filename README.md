# Assignment 2: Automation Testing Framework
#### Author: PhongPT16 ( Phong Pham-Thanh )
============================

## Overview
This C-based project uses the Unity Testing Framework for automated testing. It includes two test cases: verifying if "automation testing" is the reverse of "gnitset nnntamotua" and checking if each number in a 10-element array (0-100) is prime. Both tests are organized in a single test suite.
For more details, please refer to this link: [Unity](https://www.throwtheswitch.org/unity)

## Features
* Simple and easy-to-use API for writing test cases and test suites
* Command-line interface for running tests
* Support for test case setup and teardown

## Prerequisites
- **Make utility** (version 3.81 or higher): for building and running the project.
- **GCC compiler** (version 6.3.0 or higher): for compiling and linking the source code.
- **Python** (version 3.6 or higher): for generating HTML reports.
- **Openpyxl**: for generating XLSX reports.
- **Unix-like tools (e.g., MSYS2, Cygwin, or Git Bash)**: Since the Makefile uses Unix commands (e.g., rm).

## Project Structure
    .
    ├── Bin
    ├── makefile
    ├── Obj
    ├── README.md
    ├── Test
    │   ├── convert_report_to_html.py
    │   ├── convert_report_to_xlsx.py
    │   ├── Generic
    │   │   ├── inc
    │   │   │   ├── prime_TC_01.h
    │   │   │   └── reverse_TC_01.h
    │   │   └── src
    │   │       ├── prime_TC_01.c
    │   │       └── reverse_TC_01.c
    │   ├── Report
    │   │   ├── Result.html
    │   │   ├── Result.txt
    │   │   └── Result.xlsx
    │   └── Specific
    │       ├── inc
    │       │   └── TestSuite01.h
    │       └── src
    │           └── TestSuite01.c
    └── Unity
        ├── unity.c
        ├── unity.h
        └── unity_internals.h

* `Bin`: Contains the compiled executable files.
* `Obj`: Contains the object files generated during the build process.
* `Test`: Contains test scripts, test cases, test suites and reports.
* `Unity`: Contains the Unity Testing Framework source files.
## Writing Tests
* **Add Test Files**: Write unit tests using Unity and place them in the Test directory. Test cases and test suites are separated into Generic and Specific directories.
## Running All
To build the project, run tests, and generate the test report, navigate to the project directory and execute:
```bash
    make all
```
## Building Project
To compile the project and build the test executable, navigate to the project directory and execute:
```bash
    make build
```
## Running Tests and Generating Reports
To generate test reports, navigate to the project directory and execute:
```bash
    make test
```
## Cleaning Project
To clean object files and binaries, execute:
```bash
    make clean
```
