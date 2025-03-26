#!/bin/bash

# ألوان للواجهة
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# تأكد من وجود المشروع
if [ ! -f "package.json" ] && [ ! -f "pyproject.toml" ]; then
    echo -e "${RED}✘ خطأ: لم يتم العثور على مشروع في المسار الحالي${NC}"
    exit 1
fi

# إنشاء الهيكل الجديد
echo -e "${BLUE}⚡ بدء إعادة تنظيم الهيكل...${NC}"

# 1. إنشاء المجلدات الأساسية
mkdir -p apps/{frontend,backend} packages/{config,database,i18n} infrastructure/scripts .github/workflows

# 2. التعرف على نوع المشروع ونقل الملفات
if [ -d "next" ]; then
    echo -e "${YELLOW}→ تم اكتشاف مشروع Next.js${NC}"
    mv next apps/frontend
    mv cli apps/backend 2>/dev/null
elif [ -d "src" ]; then
    echo -e "${YELLOW}→ تم اكتشاف مشروع React/Vue${NC}"
    mv src apps/frontend/src
    mv public apps/frontend/public
fi

if [ -d "platform" ]; then
    echo -e "${YELLOW}→ تم اكتشاف مشروع بايثون${NC}"
    mv platform apps/backend
fi

# 3. نقل ملفات التهيئة
mv tsconfig.json packages/config/ 2>/dev/null
mv .eslintrc packages/config/ 2>/dev/null
mv docker-compose.yml infrastructure/ 2>/dev/null
mv Dockerfile infrastructure/ 2>/dev/null

# 4. التعامل مع ملفات الترجمة
if [ -d "next/public/locales" ]; then
    echo -e "${YELLOW}→ نقل ملفات الترجمة${NC}"
    mv next/public/locales packages/i18n/locales
fi

# 5. التعامل مع قاعدة البيانات
if [ -f "prisma/schema.prisma" ]; then
    echo -e "${YELLOW}→ نقل إعدادات Prisma${NC}"
    mv prisma packages/database/
fi

# 6. نقل التوثيق
if [ -d "docs" ]; then
    echo -e "${YELLOW}→ نقل التوثيق${NC}"
    mv docs/ docs.old/
    mkdir -p docs/developers
    mv docs.old/*.md docs/
    mv docs.old/developers/* docs/developers/
    rm -rf docs.old
fi

# 7. إصلاح المسارات في الملفات
echo -e "${BLUE}🔄 تحديث المسارات في الملفات...${NC}"

# تحديث مسارات Docker
find . -type f -exec sed -i 's/\.\/next/\.\/apps\/frontend/g' {} \;
find . -type f -exec sed -i 's/\.\/platform/\.\/apps\/backend/g' {} \;

# 8. إنشاء ملفات تهيئة جديدة
cat > packages/config/tsconfig.base.json <<EOL
{
  "compilerOptions": {
    "target": "es5",
    "lib": ["dom", "dom.iterable", "esnext"],
    "allowJs": true,
    "skipLibCheck": true,
    "strict": true,
    "forceConsistentCasingInFileNames": true,
    "noEmit": true,
    "esModuleInterop": true,
    "module": "esnext",
    "moduleResolution": "node",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "jsx": "preserve",
    "incremental": true,
    "baseUrl": ".",
    "paths": {
      "@/*": ["./src/*"],
      "@config/*": ["../../packages/config/*"],
      "@i18n/*": ["../../packages/i18n/*"]
    }
  },
  "include": ["**/*.ts", "**/*.tsx"],
  "exclude": ["node_modules"]
}
EOL

# 9. إعداد Monorepo
if [ ! -f "package.json" ]; then
    echo -e "${YELLOW}→ إعداد Monorepo${NC}"
    npm init -y
    jq '. += { "private": true, "workspaces": ["apps/*", "packages/*"] }' package.json > tmp.json && mv tmp.json package.json
    npm install -g turbo
    npm install --save-dev turbo
fi

# 10. النتيجة النهائية
echo -e "${GREEN}✔ تم إعادة التنظيم بنجاح!${NC}"
echo -e "\n${BLUE}الهيكل الجديد:${NC}"
tree -L 2

# إنشاء سكربت التراجع
cat > revert_reorganization.sh <<EOL
#!/bin/bash
rm -rf apps packages infrastructure .github
mv apps/frontend/next ./
mv apps/backend/platform ./
mv packages/config/tsconfig.json ./
mv packages/i18n/locales next/public/
mv packages/database/prisma ./
mv infrastructure/docker-compose.yml ./
rm -f revert_reorganization.sh
echo -e "${GREEN}✔ تم استعادة الهيكل القديم${NC}"
EOL

chmod +x revert_reorganization.sh
echo -e "${YELLOW}→ يمكنك الرجوع للتغييرات عبر تشغيل: ./revert_reorganization.sh${NC}"
