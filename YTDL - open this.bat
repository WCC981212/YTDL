@ECHO off
setlocal EnableDelayedExpansion
cd bin

set output_file=C:\Users\%USERNAME%\Downloads\YTDL\

echo Welcome to use YTDL.
echo Default output folder is %output_file%
echo.

:rerun
echo Which format you want to download? 
echo 1. Playlist - mp3
echo 2. Playlist - mp4
echo 3. Single - mp3
echo 4. Single - mp4
SET /p choose=Number: 
echo.

IF "!choose!"=="1" GOTO musiclist
IF "!choose!"=="2" GOTO videolist
IF "!choose!"=="3" GOTO musicsingle
IF "!choose!"=="4" GOTO videosingle
GOTO error

:: -------------------------------------- MP4 - Playlist --------------------------------------
:videolist
cls
echo Download format: Playlist - MP4
SET /p id=Enter ID: 

youtube-dl -i -f "bestvideo[ext=mp4][height<=720]+bestaudio[ext=m4a]" --merge-output-format mp4 --output "%%output_file%%%%(title)s.%%(ext)s" --yes-playlist --playlist-start 1 --playlist-end last !id!

CHOICE /M "Do you want to quit"
IF ERRORLEVEL 2 GOTO videolist
IF ERRORLEVEL 1 GOTO end

:: -------------------------------------- MP3 - Playlist --------------------------------------
:musiclist
cls
echo Download format: Playlist - MP3
SET /p id=Enter ID: 
echo.
echo Select
echo 1. Download all
echo 2. Start index and End index
echo 3. Any index
SET /p choose=Number: 
echo.
IF "!choose!"=="1" (
youtube-dl -i -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 --output "%%output_file%%%%(title)s.%%(ext)s" --yes-playlist !id!
)
IF "!choose!"=="2" (
SET /p start_index=Start index: 
SET /p end_index=End index: 
youtube-dl -i -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 --output "%%output_file%%%%(title)s.%%(ext)s" --playlist-start !start_index! --playlist-end !end_index! --yes-playlist !id!
)
IF "!choose!"=="3" (
ECHO Enter index eg: 1,3-5,7
SET /p item_index=Item index: 
youtube-dl -i -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 --output "%%output_file%%%%(title)s.%%(ext)s" --yes-playlist --playlist-items !item_index! !id!
)
CHOICE /M "Do you want to quit"
IF ERRORLEVEL 2 GOTO musiclist
IF ERRORLEVEL 1 GOTO end

:: -------------------------------------- MP4 - Single --------------------------------------
:videosingle
cls
echo Download format: Single - MP4
SET /p id=Enter ID: 

youtube-dl -i -f "bestvideo[ext=mp4][height<=720]+bestaudio[ext=m4a]" --merge-output-format mp4 --output "%%output_file%%%%(title)s.%%(ext)s" !id!

CHOICE /M "Do you want to quit"
IF ERRORLEVEL 2 GOTO videosingle
IF ERRORLEVEL 1 GOTO end

:: -------------------------------------- MP3 - Single --------------------------------------
:musicsingle
cls
echo Download format: Single - MP3
SET /p id=Enter ID: 

youtube-dl -i -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 --output "%%output_file%%%%(title)s.%%(ext)s" !id!

CHOICE /M "Do you want to quit"
IF ERRORLEVEL 2 GOTO musicsingle
IF ERRORLEVEL 1 GOTO end

:: -------------------------------------- Rerun program --------------------------------------
:error
ECHO Your input is wrong...
ECHO Please enter again...
echo.

GOTO rerun

PAUSE
GOTO end

:: -------------------------------------- End program --------------------------------------
:end
EXIT