# File Organizer

My first Bash scripting project.

This project was created to practice Bash scripting fundamentals by organizing files into directories based on their file extensions.

---

## Features

- Organize files automatically
- Create directories if they do not exist
- Move files based on file extension
- Interactive command-line execution

---

## Skills Practiced

- Variables
- If / Else Statements
- For Loops
- File Test Operators
- Command Substitution
- Basic File Operations (`mv`, `mkdir`)
- Bash Scripting Fundamentals

---

## Project Structure

```
1st-project/
├── Downloads/
├── fileorganizer.sh
└── README.md
```

---

## Usage

```bash
./fileorganizer.sh <directory>
```

Example:

```bash
./fileorganizer.sh Downloads
```

---

## Example

Before:

```
Downloads/
├── image.jpg
├── music.mp3
├── report.pdf
├── notes.txt
└── script.sh
```

After:

```
Downloads/
├── Images/
│   └── image.jpg
├── Audio/
│   └── music.mp3
├── Documents/
│   ├── report.pdf
│   └── notes.txt
└── Scripts/
    └── script.sh
```

---

## Learning Goals

The purpose of this project is to understand:

- Working with directories
- Looping through files
- Conditional statements
- File manipulation using Bash
- Basic shell scripting workflow

---

## Future Improvements

- [ ] Ignore hidden files
- [ ] Handle duplicate filenames
- [ ] Organize files recursively
- [ ] Add logging
- [ ] Support custom destination folders
- [ ] Better error handling

---

## Author

Muhammad Darrell Nabiha
