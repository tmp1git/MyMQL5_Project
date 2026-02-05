# MT5 × GitHub Development Environment Guide

## Overview
This project documents a clean and reproducible workflow for developing MQL5 code for MetaTrader 5 (MT5) while managing source code on GitHub and editing with VS Code. The goal is to keep MT5's standard folder structure intact while publishing only self-made code to GitHub.

## Folder Structure

### MT5 Environment (Execution)
```MT5 Environment (Execution)
MQL5/
  Experts/
    MyProjects/        <- Symbolic Link 
      MyEA1/
      MyEA2/
  Indicators/
    MyProjects/        <- Symbolic Link
      MyIndicator1/
  Include/
    MyProjects/        <- Symbolic Link
      Common/
```
`MyProjects` folders are symbolic links pointing to GitHub-managed directories.

### GitHub Repository (Source Management)
```
MyMQL5Project/
  Experts/
    MyEA1/
    MyEA2/
  Indicators/
    MyIndicator1/
  Include/
    Common/
  README.md
  .gitignore
  MyMQL5Project.code-workspace
```


## Symbolic Link Setup (Windows 11)
Run Command Prompt as Administrator and execute:

### Experts
```Experts
mklink /D "C:\MT5_Portable\MQL5\Experts\MyProjects" "D:\MyMQL5Project\Experts"
```

### Indicators
```
mklink /D "C:\MT5_Portable\MQL5\Indicators\MyProjects" "D:\MyMQL5Project\Indicators"
```


### Include
```
mklink /D "C:\MT5_Portable\MQL5\Include\MyProjects" "D:\MyMQL5Project\Include"
```

To Verify:
```
dir C:\MT5_Portable\MQL5\Experts\
```
```
dir C:\MT5_Portable\MQL5\Indicators\
```
```
dir C:\MT5_Portable\MQL5\Include\
```
`MyProjects` should appear as `<SYMLINKD>`.

## .gitignore (Recommended)
```
# Build artifacts
*.ex5
*.ex4

# MetaEditor backups
*.mqh~
*.mq5~
*.bak

# Logs & runtime
Logs/
Tester/
Profiles/

# OS
.DS_Store
Thumbs.db

# VS Code
.vscode/
```


## Development Flow
1. Edit code in VS Code (in GitHub Repository (Source Management)).
2. MT5 compiles via symbolic links.
3. Test in MT5.
4. Commit and push to GitHub.
5. Use Copilot for review and improvement.