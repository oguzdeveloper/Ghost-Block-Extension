@echo off
chcp 65001 >nul 2>&1
echo ============================================
echo   İnternet Yok - Eklenti Kurulum Scripti
echo ============================================
echo.

:: Yönetici kontrolü
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Bu script yönetici olarak çalıştırılmalıdır.
    echo     Sağ tıklayıp "Yönetici olarak çalıştır" seçin.
    echo.
    pause
    exit /b 1
)

:: Firefox klasörünü bul
set "FIREFOX_DIR="
if exist "C:\Program Files\Mozilla Firefox" (
    set "FIREFOX_DIR=C:\Program Files\Mozilla Firefox"
) else if exist "C:\Program Files (x86)\Mozilla Firefox" (
    set "FIREFOX_DIR=C:\Program Files (x86)\Mozilla Firefox"
) else (
    echo [X] Firefox bulunamadı!
    echo     Firefox yüklü olduğundan emin olun.
    pause
    exit /b 1
)

echo [✓] Firefox bulundu: %FIREFOX_DIR%

:: Eklenti dosyalarının yolunu al
set "EXT_DIR=%~dp0"

:: .xpi dosyası oluştur (zip formatında)
echo [~] Eklenti paketi oluşturuluyor...
set "XPI_PATH=%EXT_DIR%internetyok.xpi"

:: Eski xpi varsa sil
if exist "%XPI_PATH%" del "%XPI_PATH%"

:: PowerShell ile zip oluştur
powershell -Command "Compress-Archive -Path '%EXT_DIR%manifest.json', '%EXT_DIR%background.js' -DestinationPath '%XPI_PATH%.zip' -Force; if (Test-Path '%XPI_PATH%') { Remove-Item '%XPI_PATH%' }; Rename-Item '%XPI_PATH%.zip' 'internetyok.xpi'"

if not exist "%XPI_PATH%" (
    echo [X] Eklenti paketi oluşturulamadı!
    pause
    exit /b 1
)

echo [✓] Eklenti paketi oluşturuldu

:: distribution klasörünü oluştur
if not exist "%FIREFOX_DIR%\distribution" (
    mkdir "%FIREFOX_DIR%\distribution"
)

:: policies.json oluştur
echo [~] Firefox politika dosyası oluşturuluyor...

:: XPI yolundaki \ karakterlerini / ile değiştir (URL formatı)
set "XPI_URL=%XPI_PATH:\=/%"

(
echo {
echo   "policies": {
echo     "ExtensionSettings": {
echo       "internetyok@firefox": {
echo         "installation_mode": "normal_installed",
echo         "install_url": "file:///%XPI_URL%"
echo       }
echo     }
echo   }
echo }
) > "%FIREFOX_DIR%\distribution\policies.json"

echo [✓] Politika dosyası oluşturuldu
echo.
echo ============================================
echo   KURULUM TAMAMLANDI!
echo ============================================
echo.
echo   Eklenti her Firefox açılışında otomatik
echo   olarak yüklenecektir.
echo.
echo   Kendiniz kullanmak istediğinizde:
echo   1. Firefox'ta about:addons adresine gidin
echo   2. "İnternet Bağlantı Yöneticisi" eklentisini
echo      devre dışı bırakın
echo   3. İşiniz bitince tekrar etkinleştirin
echo.
echo   Tamamen kaldırmak için kaldir.bat'ı çalıştırın.
echo ============================================
echo.
pause
