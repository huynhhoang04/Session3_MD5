#!/bin/bash

# ==============================================================================
# Script Name: setup-workspace.sh
# Description: Thiết lập user, không gian làm việc và phân quyền cho Rikkei LMS
# ==============================================================================

set -e # Dừng script ngay lập tức nếu có bất kỳ lệnh nào gặp lỗi

echo "=== [1/4] Đang tạo người dùng 'rikkeilms' ==="
if id "rikkeilms" &>/dev/null; then
    echo "User 'rikkeilms' đã tồn tại. Bỏ qua bước tạo mới."
else
    sudo useradd -m -s /bin/bash rikkeilms
    echo "Tạo user 'rikkeilms' thành công."
fi

echo "=== [2/4] Đang tạo thư mục /opt/rikkei/course-service ==="
sudo mkdir -p /opt/rikkei/course-service

echo "=== [3/4] Cập nhật quyền sở hữu (Owner:Group) ==="
sudo chown -R rikkeilms:rikkeilms /opt/rikkei/course-service

echo "=== [4/4] Thiết lập phân quyền truy cập (755) ==="
sudo chmod 755 /opt/rikkei/course-service

echo "=== [Kiểm tra kết quả] ==="
ls -ld /opt/rikkei/course-service

echo "Thiết lập hoàn tất!"
