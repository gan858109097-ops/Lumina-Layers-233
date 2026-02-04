@echo off
chcp 65001 >nul
setlocal

REM ==============================
REM 设置项目路径
REM ==============================
set PROJECT_DIR=D:\Users\G122\Desktop\pythonProject\Lumina-Layers-main
set VENV_DIR=%PROJECT_DIR%\venv

REM ==============================
REM 进入项目目录
REM ==============================
cd /d "%PROJECT_DIR%"

REM ==============================
REM 检查虚拟环境是否存在，如果不存在就创建
REM ==============================
if not exist "%VENV_DIR%\Scripts\activate" (
    echo 虚拟环境不存在，正在创建...
    python -m venv venv
    if errorlevel 1 (
        echo 创建虚拟环境失败，请检查 Python 安装
        pause
        exit /b
    )
    echo 虚拟环境已创建，请确保依赖已安装。
    pause
)

REM ==============================
REM 激活虚拟环境
REM ==============================
call "%VENV_DIR%\Scripts\activate"

REM ==============================
REM 杀掉占用7860端口的进程
REM ==============================
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :7860') do (
    echo 找到占用 7860 的 PID：%%a
    taskkill /F /PID %%a >nul 2>&1
    echo 已强制终止 PID %%a
)

REM ==============================
REM 启动项目
REM ==============================
echo 启动 Lumina-Layers 项目...
python main.py "%PROJECT_DIR%"

echo.
echo 项目已运行完毕或退出
pause
endlocal
