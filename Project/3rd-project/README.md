# Directory Scanner

My first Bash Scripting project.

The purpose of this project is to practice:

- Variables
- If / Else
- While Loop
- Case Statement
- Functions
- File Test Operators
- Positional Parameters

---

## Features

- [x] Show all files inside a directory
- [x] Show all directories inside a directory
- [x] Count files
- [x] Count directories
- [x] Search file by filename
- [x] Interactive menu
- [x] Directory validation

---

# Refactor Checklist

## Code Style

### Variable Naming

Current:

```bash
runind="false"
```

Refactor to something more meaningful.

Example:

```bash
running="false"
```

or

```bash
is_running="false"
```

---

### Empty String Check

Current:

```bash
if [[ "$folder" = "" ]]
```

Refactor to:

```bash
if [[ -z "$folder" ]]
```

---

Current:

```bash
if ! [[ "$filename" = "" ]]
```

Refactor to:

```bash
if [[ -n "$filename" ]]
```

Reason:

- easier to read
- Bash idiomatic

---

### Remove Unnecessary Quotes

Current:

```bash
count=$(...)
```

No issue.

Just remember quotes are unnecessary when assigning command substitution.

---

## Menu

Current:

No invalid option handling.

Need:

```bash
*)
    echo "Invalid Menu"
    ;;
```

---

## Performance

Current:

```bash
sleep 1
```

Remove.

Reason:

No need to delay menu rendering.

---

## Loop Improvement

Current:

```bash
for file in $(find ...)
```

Problem:

Word splitting.

Fails when filenames contain:

- spaces
- tabs
- newline

Need to learn:

```bash
while IFS= read -r file
do
    ...
done
```

---

## Function Improvement

Current:

Global variables are used everywhere.

Need to learn:

```bash
local
```

inside functions.

Example:

```bash
count_file() {

    local count=0

}
```

---

## Search Feature

Current:

Search only exact filename.

Future improvements:

- partial match
- case insensitive search
- extension search

---

## Future Features

### Version 2

- [ ] Hidden Files
- [ ] Empty Files
- [ ] Show Permissions
- [ ] Show File Size
- [ ] Biggest File
- [ ] Smallest File

---

### Version 3

- [ ] Search by Extension
- [ ] Rename File
- [ ] Copy File
- [ ] Move File
- [ ] Delete File
- [ ] Generate Report

---

### Version 4

- [ ] Duplicate File Detection
- [ ] Large File Detection
- [ ] Old File Detection
- [ ] Executable File Detection
- [ ] Owner Information

---

# Bash Topics To Learn Next

- [ ] local variables
- [ ] return codes
- [ ] while read
- [ ] arrays
- [ ] IFS
- [ ] trap
- [ ] getopt
- [ ] logging
- [ ] error handling

---

# Overall Review

Strengths

- Good project structure
- Good use of functions
- Good use of case statement
- Good understanding of loops
- Proper directory validation
- Good use of parameter expansion

Needs Improvement

- Better variable naming
- Better Bash idioms (-z / -n)
- Handle filenames safely
- Add invalid menu handling
- Reduce global variables
- Improve search functionality

---

Project Score

Overall : **8.5 / 10**

This project successfully demonstrates understanding of:

- Bash Fundamentals
- Functions
- Loops
- Conditional Statements
- File Operations

Next goal:

Create a production-quality Bash script by improving code readability, robustness, and handling edge cases.
