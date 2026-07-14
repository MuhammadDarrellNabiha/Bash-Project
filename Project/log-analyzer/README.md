# 📊 Log Analyzer

A simple Bash-based log analyzer that processes log files and generates useful summaries and reports.

## Features

- 📈 Display log summary
- ❌ Show all error logs
- 🔍 Search logs by keyword
- 📊 Show top error messages
- 📄 Generate analysis report
- 🖥️ Interactive menu

## Project Structure

```
.
├── analyzer.sh
├── sample_system.log
├── report.txt
└── README.md
```

## Requirements

- Bash
- grep
- sort
- uniq
- wc

## Usage

```bash
chmod +x analyzer.sh
./analyzer.sh sample_system.log
```

## Menu

```
1. Summary
2. Show Errors
3. Search Keyword
4. Top Errors
5. Generate Report
6. Exit
```

## Example Output

### Summary

```
========= Log Analyzer ==========
File        : sample_system.log
Total Logs  : 200
Info        : 120
Warning     : 45
Error       : 35
=================================
```

### Top Errors

```
5 Login Failed
3 Database Timeout
2 Permission Denied
```

## Concepts Learned

This project helped me practice:

- Bash Functions
- While Loop
- Case Statement
- Parameter Expansion
- Command Group (`{}`)
- Redirection (`>`)
- Standard Input / Standard Output
- `grep`
- `sort`
- `uniq`
- `wc`
- Interactive CLI

## Future Improvements

- [ ] Command-line options (`--summary`, `--report`)
- [ ] Colored output
- [ ] Report timestamp
- [ ] Export reports into a dedicated folder
- [ ] Support for custom log formats

## License

MIT
