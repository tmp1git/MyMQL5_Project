# MT5 × GitHub Development Environment Guide

## Overview
This project documents a clean and reproducible workflow for developing MQL5 code for MetaTrader 5 (MT5) while managing source code on GitHub and editing with VS Code. The goal is to keep MT5's standard folder structure intact while publishing only self-made code to GitHub.

## Folder Structure

### MT5 Environment (Execution)
```MT5 Environment (Execution)
MQL5/
  Experts/
    MyProjects/        ← 自作EA（シンボリックリンク）
      MyEA1/
      MyEA2/
  Indicators/
    MyProjects/        ← 自作インジケータ（シンボリックリンク）
      MyIndicator1/
  Include/
    MyProjects/        ← 共通ライブラリ（シンボリックリンク）
      Common/
```
MyProjects folders are symbolic links pointing to GitHub-managed directories.

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
Run PowerShell or Command Prompt as Administrator and execute:

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
