#!/bin/bash

# ==============================================================================
# Script Name: exec-frontend.sh
# Description: Khởi tạo môi trường QA và truy cập vào Bash Shell của Container
# ==============================================================================

set -e # Dừng ngay lập tức nếu xảy ra lỗi

echo "=== [1/3] Dọn dẹp container cũ (nếu có) ==="
if docker ps -a --format '{{.Names}}' | grep -Eq "^rikkei-frontend-qa$"; then
    echo "Đang xóa container cũ..."
    docker rm -f rikkei-frontend-qa
fi

echo "=== [2/3] Khởi tạo Frontend QA Container với Biến Môi Trường ==="
docker run -d \
  --name rikkei-frontend-qa \
  -e API_ENDPOINT=https://qa-api.rikkei.edu.vn \
  nginx

echo "=== [3/3] Đang mở giao diện Bash Shell bên trong Container ==="
echo "GỢI Ý: Hãy gõ lệnh 'echo \$API_ENDPOINT' để kiểm tra kết quả, sau đó gõ 'exit' để thoát."
echo "----------------------------------------------------------------"

# Mở shell tương tác
docker exec -it rikkei-frontend-qa /bin/bash
