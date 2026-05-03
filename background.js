// Tüm istekleri var olmayan bir proxy'ye yönlendir
// Bu sayede Firefox kendi gerçek hata sayfasını gösterir
// URL çubuğunda gerçek adres kalır ve sayfa doğal olarak yavaş yüklenir
browser.proxy.onRequest.addListener(
  function (details) {
    return { type: "http", host: "127.0.0.1", port: 1 };
  },
  { urls: ["<all_urls>"] }
);
