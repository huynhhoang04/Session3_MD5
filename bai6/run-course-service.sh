#!/bin/bash

# ==============================================================================
# Script Name: run-course-service.sh
# Description: Khởi chạy Course-Service phiên bản Mock bằng Docker Container
# ==============================================================================

set -e # Dừng kịch bản ngay lập tức nếu có lỗi xảy ra

echo "=== [1/3] Đang dọn dẹp container cũ (nếu có) ==="
# Kiểm tra và xóa container cùng tên nếu đang tồn tại để tránh lỗi conflict tên
if docker ps -a --format '{{.Names}}' | grep -Eq "^rikkei-course-service$"; then
    echo "Phát hiện container rikkei-course-service đã tồn tại. Đang xóa..."
    docker rm -f rikkei-course-service
fi

echo "=== [2/3] Khởi chạy container nginxdemos/hello ==="
docker run -d \
  --name rikkei-course-service \
  -p 8081:80 \
  nginxdemos/hello

echo "Khởi chạy thành công. ID Container:"
docker ps -q -f name=rikkei-course-service

echo "=== [3/3] Đang đợi dịch vụ khởi động (2 giây) ==="
sleep 2

echo "=== Kiểm tra log dịch vụ cục bộ ==="
curl -s http://localhost:8081 | grep -i "Server address" || echo "Không thể kết nối đến http://localhost:8081"

echo "=== Hoàn tất kịch bản ==="
