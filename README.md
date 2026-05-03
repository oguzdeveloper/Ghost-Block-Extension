<div align="center">

# 👻 Ghost Block

### Firefox Internet Blocker Extension | Firefox İnternet Engelleme Eklentisi

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Firefox](https://img.shields.io/badge/Firefox-Extension-FF7139?logo=firefox-browser&logoColor=white)](https://www.mozilla.org/firefox/)
[![Platform](https://img.shields.io/badge/Platform-Windows-0078D6?logo=windows&logoColor=white)](#)
[![Version](https://img.shields.io/badge/Version-1.0-green)](#)

<br>

<img src="error-icon.svg" width="120" alt="Ghost Block Icon">

<br><br>

**Ghost Block** silently blocks all internet access in Firefox by redirecting traffic through a dead proxy — making it look like there's no internet connection.

**Ghost Block**, Firefox'taki tüm internet erişimini sessizce engelleyen bir eklentidir. Trafik ölü bir proxy'ye yönlendirilir ve internet yokmuş gibi görünür.

---

[🇬🇧 English](#-english) · [🇹🇷 Türkçe](#-türkçe)

</div>

---

## 🇬🇧 English

### 🔍 What is Ghost Block?

Ghost Block is a lightweight Firefox extension that **completely blocks internet access** at the browser level. It works by redirecting all network requests to a non-existent local proxy (`127.0.0.1:1`), causing Firefox to display its native connection error page.

This makes the block **invisible** — there are no popups, no warnings, and the URL bar still shows the real address. It simply looks like the internet is down.

### ✨ Features

| Feature | Description |
|---------|-------------|
| 🔒 **Complete Block** | Blocks all HTTP/HTTPS traffic in Firefox |
| 👻 **Invisible** | Looks like a real connection error |
| ⚡ **Lightweight** | No UI, no popups — just a background script |
| 🔧 **Easy Install** | One-click install with batch script |
| 🗑️ **Easy Remove** | One-click uninstall with batch script |
| 🛡️ **Policy-Based** | Installed via Firefox Enterprise Policies |
| 🌙 **Dark Mode** | Error page supports dark mode |

### 📁 Project Structure

```
Ghost Block Extension/
├── 📄 manifest.json      # Extension manifest (Manifest V2)
├── 📄 background.js      # Core logic — proxy redirect
├── 📄 blocked.html       # Custom error page
├── 📄 error-icon.svg     # Error page icon
├── 📄 kur.bat            # Install script (Turkish)
├── 📄 kaldir.bat         # Uninstall script (Turkish)
├── 📄 LICENSE            # MIT License
└── 📄 README.md          # This file
```

### 🚀 Installation

> **Requires:** Windows + Mozilla Firefox + Administrator privileges

1. **Download** or clone this repository
2. **Right-click** `kur.bat` → **Run as Administrator**
3. **Restart** Firefox

The script will:
- Package the extension into an `.xpi` file
- Create a Firefox Enterprise Policy to auto-install the extension
- The extension loads automatically on every Firefox launch

### 🗑️ Uninstallation

1. **Right-click** `kaldir.bat` → **Run as Administrator**
2. **Restart** Firefox

### ⚙️ How It Works

```
User opens any website
        ↓
Ghost Block intercepts the request
        ↓
Redirects to proxy → 127.0.0.1:1 (dead)
        ↓
Firefox shows native connection error
        ↓
URL bar still shows the real address ✓
```

#### 1. Proxy Interception (`background.js`)

The core of Ghost Block is a single background script that hooks into Firefox's **Proxy API**:

```js
browser.proxy.onRequest.addListener(
  function (details) {
    return { type: "http", host: "127.0.0.1", port: 1 };
  },
  { urls: ["<all_urls>"] }
);
```

Every single network request Firefox makes — pages, images, scripts, APIs — gets intercepted by this listener. Instead of connecting to the real server, Firefox is told to route through `127.0.0.1:1`. Since nothing is listening on port 1 of localhost, the connection **immediately fails**. Firefox then shows its native `PR_CONNECT_RESET_ERROR` page, making it look like a genuine network problem.

> **Why a dead proxy instead of `webRequest.onBeforeRequest`?**
> Blocking via `webRequest` shows an "extension blocked" error, which reveals the trick. A dead proxy produces a **native Firefox error** — completely indistinguishable from real network failure.

#### 2. Enterprise Policy Installation (`kur.bat`)

The install script uses **Firefox Enterprise Policies** to silently deploy the extension:

1. Packages `manifest.json` + `background.js` into an `.xpi` file (ZIP format)
2. Creates `distribution/policies.json` in the Firefox install directory
3. The policy points to the local `.xpi` file with `installation_mode: "normal_installed"`

```json
{
  "policies": {
    "ExtensionSettings": {
      "internetyok@firefox": {
        "installation_mode": "normal_installed",
        "install_url": "file:///path/to/internetyok.xpi"
      }
    }
  }
}
```

This means the extension **auto-loads on every Firefox launch** and **cannot be removed** from the `about:addons` page by the user — only an admin running `kaldir.bat` can remove it.

#### 3. Error Page (`blocked.html`)

A custom error page styled to match Firefox's native error UI, complete with:
- Dark mode support via `prefers-color-scheme`
- A fake "Try Again" button that reloads (and fails again)
- Dynamic hostname display extracted from URL parameters
- The real `PR_CONNECT_RESET_ERROR` error code for authenticity

### 💡 Use Cases

- **Parental Controls** — Block internet for kids on a shared computer
- **Focus Mode** — Eliminate browser distractions while working
- **Testing** — Simulate offline behavior in Firefox
- **Kiosk Mode** — Restrict browser access on public terminals

### ⚠️ Notes

- Only affects **Firefox** — other browsers and applications are not affected
- You can temporarily disable it from `about:addons` without uninstalling
- The extension is installed via **Enterprise Policy**, so users cannot remove it from the browser UI
- Requires **Administrator** privileges to install/uninstall

---

## 🇹🇷 Türkçe

### 🔍 Ghost Block Nedir?

Ghost Block, Firefox'ta **internet erişimini tamamen engelleyen** hafif bir eklentidir. Tüm ağ isteklerini var olmayan bir yerel proxy'ye (`127.0.0.1:1`) yönlendirerek çalışır ve Firefox'un kendi bağlantı hatası sayfasını göstermesini sağlar.

Bu sayede engelleme **görünmez** olur — popup yok, uyarı yok ve URL çubuğunda gerçek adres görünmeye devam eder. Sadece internet yokmuş gibi görünür.

### ✨ Özellikler

| Özellik | Açıklama |
|---------|----------|
| 🔒 **Tam Engelleme** | Firefox'taki tüm HTTP/HTTPS trafiğini engeller |
| 👻 **Görünmez** | Gerçek bir bağlantı hatası gibi görünür |
| ⚡ **Hafif** | Arayüz yok, popup yok — sadece arka plan scripti |
| 🔧 **Kolay Kurulum** | Tek tıkla kurulum (bat dosyası) |
| 🗑️ **Kolay Kaldırma** | Tek tıkla kaldırma (bat dosyası) |
| 🛡️ **Politika Tabanlı** | Firefox Kurumsal Politikaları ile yüklenir |
| 🌙 **Karanlık Mod** | Hata sayfası karanlık modu destekler |

### 📁 Proje Yapısı

```
Ghost Block Extension/
├── 📄 manifest.json      # Eklenti manifest dosyası (Manifest V2)
├── 📄 background.js      # Ana mantık — proxy yönlendirme
├── 📄 blocked.html       # Özel hata sayfası
├── 📄 error-icon.svg     # Hata sayfası ikonu
├── 📄 kur.bat            # Kurulum scripti
├── 📄 kaldir.bat         # Kaldırma scripti
├── 📄 LICENSE            # MIT Lisansı
└── 📄 README.md          # Bu dosya
```

### 🚀 Kurulum

> **Gereksinimler:** Windows + Mozilla Firefox + Yönetici yetkileri

1. Bu repoyu **indirin** veya klonlayın
2. `kur.bat` dosyasına **sağ tıklayın** → **Yönetici olarak çalıştır**
3. Firefox'u **yeniden başlatın**

Script şunları yapacaktır:
- Eklentiyi `.xpi` dosyası olarak paketler
- Eklentinin otomatik yüklenmesi için Firefox Kurumsal Politikası oluşturur
- Eklenti her Firefox açılışında otomatik olarak yüklenir

### 🗑️ Kaldırma

1. `kaldir.bat` dosyasına **sağ tıklayın** → **Yönetici olarak çalıştır**
2. Firefox'u **yeniden başlatın**

### ⚙️ Nasıl Çalışır?

```
Kullanıcı herhangi bir siteyi açar
        ↓
Ghost Block isteği yakalar
        ↓
Proxy'ye yönlendirir → 127.0.0.1:1 (ölü)
        ↓
Firefox doğal bağlantı hatası gösterir
        ↓
URL çubuğunda gerçek adres kalır ✓
```

#### 1. Proxy Yakalama (`background.js`)

Ghost Block'un çekirdeği, Firefox'un **Proxy API**'sine bağlanan tek bir arka plan scriptidir:

```js
browser.proxy.onRequest.addListener(
  function (details) {
    return { type: "http", host: "127.0.0.1", port: 1 };
  },
  { urls: ["<all_urls>"] }
);
```

Firefox'un yaptığı her ağ isteği — sayfalar, resimler, scriptler, API çağrıları — bu dinleyici tarafından yakalanır. Gerçek sunucuya bağlanmak yerine, Firefox `127.0.0.1:1` üzerinden yönlendirilir. Localhost'un 1. portunda hiçbir şey dinlemediği için bağlantı **anında başarısız olur**. Firefox kendi doğal `PR_CONNECT_RESET_ERROR` sayfasını gösterir ve bu gerçek bir ağ sorunu gibi görünür.

> **Neden `webRequest.onBeforeRequest` yerine ölü proxy?**
> `webRequest` ile engelleme "eklenti tarafından engellendi" hatası gösterir ve hile ortaya çıkar. Ölü proxy ise **Firefox'un doğal hata sayfasını** üretir — gerçek ağ arızasından ayırt edilemez.

#### 2. Kurumsal Politika Kurulumu (`kur.bat`)

Kurulum scripti, eklentiyi sessizce yüklemek için **Firefox Kurumsal Politikalarını** kullanır:

1. `manifest.json` + `background.js` dosyalarını `.xpi` dosyası (ZIP formatı) olarak paketler
2. Firefox kurulum dizininde `distribution/policies.json` oluşturur
3. Politika, `installation_mode: "normal_installed"` ile yerel `.xpi` dosyasına işaret eder

```json
{
  "policies": {
    "ExtensionSettings": {
      "internetyok@firefox": {
        "installation_mode": "normal_installed",
        "install_url": "file:///path/to/internetyok.xpi"
      }
    }
  }
}
```

Bu sayede eklenti **her Firefox açılışında otomatik yüklenir** ve kullanıcı `about:addons` sayfasından **kaldıramaz** — sadece `kaldir.bat` çalıştıran bir yönetici kaldırabilir.

#### 3. Hata Sayfası (`blocked.html`)

Firefox'un doğal hata arayüzüne benzeyen özel bir hata sayfası:
- `prefers-color-scheme` ile **karanlık mod** desteği
- Yeniden yükleyen (ve tekrar başarısız olan) sahte **"Yeniden dene"** butonu
- URL parametrelerinden çıkarılan **dinamik hostname** gösterimi
- Gerçekçilik için asıl `PR_CONNECT_RESET_ERROR` hata kodu

### 💡 Kullanım Alanları

- **Ebeveyn Kontrolü** — Ortak kullanılan bilgisayarda çocuklar için interneti engelleme
- **Odaklanma Modu** — Çalışırken tarayıcı dikkat dağıtıcılarını ortadan kaldırma
- **Test** — Firefox'ta çevrimdışı davranışı simüle etme
- **Kiosk Modu** — Halka açık terminallerde tarayıcı erişimini kısıtlama

### ⚠️ Notlar

- Sadece **Firefox'u** etkiler — diğer tarayıcılar ve uygulamalar etkilenmez
- Kaldırmadan `about:addons` sayfasından geçici olarak devre dışı bırakabilirsiniz
- Eklenti **Kurumsal Politika** ile yüklendiği için kullanıcılar tarayıcı arayüzünden kaldıramaz
- Kurulum/kaldırma için **Yönetici** yetkileri gereklidir

---

<div align="center">

### 📜 License / Lisans

This project is licensed under the [MIT License](LICENSE).

Bu proje [MIT Lisansı](LICENSE) ile lisanslanmıştır.

---

Made with 👻 by Ghost Block

</div>
