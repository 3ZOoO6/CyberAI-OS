#!/bin/bash
rm -rf apps packages infrastructure .github
mv apps/frontend/next ./
mv apps/backend/platform ./
mv packages/config/tsconfig.json ./
mv packages/i18n/locales next/public/
mv packages/database/prisma ./
mv infrastructure/docker-compose.yml ./
rm -f revert_reorganization.sh
echo -e "\033[0;32m✔ تم استعادة الهيكل القديم\033[0m"
