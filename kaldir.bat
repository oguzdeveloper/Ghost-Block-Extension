@echo off
chcp 65001 >nul 2>&1
echo ============================================
echo   İnternet Yok - Eklenti Kaldırma Scripti
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
    pause
    exit /b 1
)

:: policies.json dosyasını sil
if exist "%FIREFOX_DIR%\distribution\policies.json" (
    del "%FIREFOX_DIR%\distribution\policies.json"
    echo [✓] Politika dosyası silindi
) else (
    echo [~] Politika dosyası zaten yok
)

echo.
echo ============================================
echo   KALDIRMA TAMAMLANDI!
echo ============================================
echo.
echo   Firefox'u yeniden başlatın.
echo   Eklenti artık otomatik yüklenmeyecektir.
echo ============================================
echo.
pause
