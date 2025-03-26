
# CyberAI OS

![banner](./docs/images/banner.png)

**CyberAI OS** هو نظام موحد متكامل يدمج الذكاء الاصطناعي، الأمن السيبراني، أدوات تطوير المشاريع، واختبار الاختراق، في مشروع واحد شامل قابل للتوسع، مصمم ليعمل بكفاءة على الهواتف وأجهزة Linux (مثل Kali وTermux) بدون الحاجة لحاسوب.

## الميزات الرئيسية:

- واجهة ويب AI Bots (Gemini، DeepSeek، xAI).
- مكتبة أدوات اختراق وحماية (WIFI/Hash).
- منشئ مشاريع وأكواد ذكاء اصطناعي.
- متجر تطبيقات CyberAI الذكي.
- تكامل مع GitHub, Vercel, Docker, Termux.
- سكربتات CLI ذكية للأوامر (مثل cyber init, cyber run ai...).
- دعم تلقائي لملفات JSON (bots.json, apps.json).

---

## هيكل المشروع

```bash
CyberAI-OS/
├── 1-Web_Interface/
│   ├── 1-public/           # ملفات CSS / JS / assets
│   └── 2-pages/            # صفحات HTML موزعة حسب الفئة
├── 2-CLI_Tools/            # أدوات سطر الأوامر
├── 3-Modules/              # الوحدات المنفصلة للبوتات والأمان والتطبيقات
├── 4-Integrations/         # تكاملات مع GitHub, Termux, Docker, إلخ
├── 5-Tests/                # اختبارات Unit و Integration و E2E
├── 6-Docs/                 # وثائق المستخدم و API
├── config.json             # إعدادات التطبيق
├── bots.json               # ملفات تعريف البوتات
├── apps.json               # متجر التطبيقات
├── loadBots.js             # سكربت تحميل البوتات تلقائيًا
├── chat.html               # صفحة محادثة AI
├── yagil.html              # واجهة إضافية


---

صور من الواجهة:

الصفحة الرئيسية



نظام البوتات



متجر التطبيقات الذكي




---

التثبيت (على Kali أو Termux)

git clone https://github.com/3ZOoO6/CyberAI-OS.git
cd CyberAI-OS
bash cyber-init          # أو استخدام السكربت sor.sh


---

روابط التواصل

GitHub: 3ZOoO6

Snapchat: bx90_9

Instagram: goli_soltani.412246



---

الترخيص

MIT License © Abdulaziz 2025

---

هل ترغب أضيفه مباشرة داخل `README.md` ثم أدفعه إلى GitHub لك؟ أم تريده ملف مستقل أول؟

