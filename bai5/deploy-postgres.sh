#!/bin/bash

# ==============================================================================
# Script Name: deploy-postgres.sh
# Description: Triển khai PostgreSQL với cấu hình lưu trữ bền vững (Persistent)
# ==============================================================================

set -e # Dừng script nếu xảy ra lỗi

echo "=== [1/4] Tạo thư mục lưu trữ bền vững trên máy Host ==="
# Cần dùng sudo vì /opt/ thường yêu cầu quyền quản trị
sudo mkdir -p /opt/rikkei/pg-data

echo "=== [2/4] Dọn dẹp container cũ (nếu có) ==="
if docker ps -a --format '{{.Names}}' | grep -Eq "^rikkei-db$"; then
    echo "Phát hiện container rikkei-db. Đang xóa..."
    docker rm -f rikkei-db
fi

echo "=== [3/4] Khởi chạy container PostgreSQL (Lần 1) ==="
docker run -d \
  --name rikkei-db \
  -e POSTGRES_PASSWORD=Rikkei@2026 \
  -v /opt/rikkei/pg-data:/var/lib/postgresql/data \
  postgres:13

echo "Đang chờ 5 giây để PostgreSQL khởi tạo hệ thống file cơ sở dữ liệu..."
sleep 5

echo "=== [4/4] Kiểm thử tính bền vững của dữ liệu ==="
echo "Thực hiện mô phỏng sự cố: Cưỡng chế xóa container rikkei-db..."
docker rm -f rikkei-db

echo "Khôi phục lại hệ thống: Chạy lại container rikkei-db mới với cùng cấu hình..."
docker run -d \
  --name rikkei-db \
  -e POSTGRES_PASSWORD=Rikkei@2026 \
  -v /opt/rikkei/pg-data:/var/lib/postgresql/data \
  postgres:13

echo "--------------------------------------------------------------------------------"
echo "=== KẾT QUẢ KIỂM TRA HỆ THỐNG FILE TRÊN MÁY HOST ==="
# Kiểm tra nội dung thư mục trên máy host
sudo ls -l /opt/rikkei/pg-data
echo "--------------------------------------------------------------------------------"
echo "Thiết lập thành công! Dữ liệu đã được lưu trữ an toàn trên Host."
