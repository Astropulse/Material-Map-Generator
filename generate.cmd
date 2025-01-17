@echo off

set conda_env_name=mmg

set paths=%ProgramData%\miniconda3
set paths=%paths%;%USERPROFILE%\miniconda3
set paths=%paths%;%ProgramData%\anaconda3
set paths=%paths%;%USERPROFILE%\anaconda3

for %%a in (%paths%) do (
 IF NOT "%custom_conda_path%"=="" (
   set paths=%custom_conda_path%;%paths%
 )
)

for %%a in (%paths%) do ( 
 if EXIST "%%a\Scripts\activate.bat" (
    SET CONDA_PATH=%%a
    echo anaconda3/miniconda3 detected in %%a
    goto :foundPath
 )
)

IF "%CONDA_PATH%"=="" (
  echo anaconda3/miniconda3 not found. Install from here https://docs.conda.io/en/latest/miniconda.html
  exit /b 1
)

:foundPath
call "%CONDA_PATH%\Scripts\activate.bat"
call conda env create -n "%conda_env_name%" -f environment.yaml
:: call conda env update -n "%conda_env_name%" --file environment.yaml --prune
call "%CONDA_PATH%\Scripts\activate.bat" "%conda_env_name%"
python "%CD%"\generate.py --seamless
