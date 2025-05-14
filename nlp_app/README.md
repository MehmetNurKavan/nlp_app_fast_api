# NLP APP (Flutter)

Bu proje, Flutter ile geliştirilmiş bir **Doğal Dil İşleme (NLP)** mobil uygulamasıdır.

---

## Uygulama Görselleri

<p align="center">
    <img src="nlp_app/assets/images/home.jpg" alt="Ana Sayfa" width="300" />
    <img src="nlp_app/assets/images/translate.jpg" alt="Ana Sayfa" width="300" />
    <img src="nlp_app/assets/images/ner.jpg" alt="Ana Sayfa" width="300" />
    <img src="nlp_app/assets/images/sentiment.jpg" alt="Ana Sayfa" width="300" />
    <img src="nlp_app/assets/images/classify.jpg" alt="Ana Sayfa" width="300" />
    <img src="nlp_app/assets/images/tokenization.jpg" alt="Ana Sayfa" width="300" />
    <img src="nlp_app/assets/images/summary.jpg" alt="Ana Sayfa" width="300" />
    <img src="nlp_app/assets/images/qa.jpg" alt="Ana Sayfa" width="300" />
</p>

---

## 📁 Proje Yapısı

### `lib/`

Flutter uygulamasının ana kaynak kodu buradadır.

#### `main.dart`
- Uygulamanın başlangıç noktasıdır.
- `TextProcessingViewModel` sağlayıcısı ile başlatılır.
- Sayfa rotaları (`routes`) tanımlıdır.

#### `pages/`
- **`my_home_page.dart`**: Ana sayfa. Kullanıcıya işlem seçenekleri sunar.
- **`text_processing_page.dart`**: Belirli bir NLP işlemini uygulamak için kullanılan sayfa (örneğin: tokenization, summarization vs).

#### `viewmodels/`
- **`text_processing_viewmodel.dart`**: ViewModel katmanıdır. UI ile servis arasındaki bağlantıyı sağlar. Yükleme durumunu ve sonucu tutar.

#### `services/`
- **`text_processing_service.dart`**: Python FastAPI servisinden veri alan sınıftır. JSON dosyalarını `assets/models` içinden yükler ve metni POST ile sunucuya gönderir.

#### `models/`
- **`text_processing_models.dart`**: Her NLP işlemi için yapılandırma modelini tanımlar. JSON’dan modele dönüşüm sağlar.

#### `widgets/`
- **`custom_elevated_button.dart`**: Uygulama genelinde kullanılan özel tasarımlı buton widget'ı. Kod tekrarı yerine özelleştirilmiş bir `ElevatedButton` sunar.

---

## 📁 Assets Klasörleri

### `assets/models/`
- Her işlem için bir `.json` dosyası içerir (örnek: `tokenization.json`, `summarization.json`).
- Bu dosyalar işlem hakkında açıklama ve örnek içerir.

### `assets/images/`
- Uygulamada kullanılan görseller burada bulunur.

