# NLP-APP, FastAPI

Bu proje, **FastAPI** kullanarak geliştirilmiş bir API uygulamasıdır. Hızlı, modern ve asenkron API geliştirme için FastAPI'nin gücünden faydalanmaktadır.

## 🎯 Amaç

- Hızlı ve verimli bir API geliştirme
- RESTful API mimarisi
- JSON veri ile işlem yapabilme
- Asenkron işlem desteği

## 🛠 Teknolojiler

- **FastAPI** – Web framework
- **Python** – Backend dili
- **Uvicorn** – ASGI sunucusu (FastAPI uygulamaları için)
- **Pydantic** – Veri doğrulama
- **Transformers**: Hugging Face'in transformers kütüphanesi, metin işleme boru hatları için kullanıldı.

---

## 📁 Klasör ve Dosya Yapısı

### 1. `main.py`

- **Açıklama**: FastAPI uygulamasının ana dosyasıdır. API'nin başlatıldığı ve temel yapılandırmalarının yapıldığı yerdir. Ayrıca, ana rotaya (`/`) gelen istekler için basit bir mesaj döndürür.

### 2. `services/processor.py`

- **Yol**: `services/processor.py`
- **Açıklama**: Kullanıcıdan alınan metni işlemek için farklı işlemleri yöneten fonksiyonları içerir. `process_text` fonksiyonu, gelen `operation` parametresine göre doğru işlemi çağırarak metni işler.

### 3. `routers/nlp_router.py`

- **Açıklama**: Bu dosya, API'nin rotalarını tanımlar. `/nlp` ile başlayan istekler, burada tanımlanan işlemleri kullanarak metin işlemleri yapabilir. `POST /process-text` rotası, metin işleme isteklerini kabul eder.

### 4. `models/message_processing.py`

- **Açıklama**: Pydantic modelleri içerir. `TextInput` ve `TextOutput` modelleri, API'ye gönderilecek ve API'den alınacak verilerin şemasını tanımlar.

### 5. `pipelines/`

- **Açıklama**: Her NLP görevine ait işlem boru hatları (pipeline) burada tanımlıdır. Bu boru hatları, transformer modelleri ve benzeri NLP araçları kullanarak metni işler. yani modeller ve algoritmalar burada tanımlanır ve işleme yapılacak veriyi alır.

### 6. `logic/`

- **Açıklama**: Her NLP görevi için özel iş mantığını barındıran dosyalar bulunur.  Veriyi işleyerek doğru pipeline'ı seçer ve bu pipeline ile işlemi gerçekleştirir.

- Her bir dosya bir NLP işlemine karşılık gelir:

- tokenizer – Cümleyi kelimelere veya cümlelere ayırma işlemi.
- sentiment – Duygu analizi yapar (olumlu/olumsuz/nötr).
- translation – Metni farklı dillere çevirir.
- question_answer – Soru-Cevap işlemi yapar.
- named_entity_recognition – Metinden özel adları (kişi, yer, organizasyon) çıkarır.
- text_classification – Metni etiketlere göre sınıflandırır.
- summarizer – Uzun metinleri özetler.

### 6.`models/text_request_model.py`

- **Açıklama**: Gelen isteklerdeki veri yapısını tanımlar (Pydantic modeli).

## Rotalar

- **GET `/`**: Ana sayfa mesajı döndürür.
    - **Cevap**: `{"message": "NLP FastAPI çalışıyor!"}`

- **POST `/nlp/process-text`**: Metin üzerinde belirtilen işlemi gerçekleştirir.
    - **Girdi**: `TextInput` (input_text, operation)
    - **Çıktı**: `TextOutput` (output_text)

---
## Postman'den atilan post görselleri ve json yapıları

<p align="center">
    <img src="fast_api/images/translate.png" alt="translate" width="300" />
    <img src="fast_api/images/entitiy.png" alt="ner" width="300" />
    <img src="fast_api/images/sentiment.png" alt="sentiment" width="300" />
    <img src="fast_api/images/classify.png" alt="text classification" width="300" />
    <img src="fast_api/images/tokenization.png" alt="tokenization" width="300" />
    <img src="fast_api/images/summary.png" alt="text summarization" width="300" />
    <img src="fast_api/images/qa.png" alt="Question and answer" width="300" />
</p>
