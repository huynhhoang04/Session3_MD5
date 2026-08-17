#!/bin/bash

# ==============================================================================
# Script Name: extract-logs.sh
# Description: Trích xuất log giám sát truy cập từ container rikkei-course-service
# ==============================================================================

set -e # Dừng kịch bản ngay lập tức nếu lệnh trước đó thất bại

echo "=== Đang truy xuất dữ liệu logs từ hệ thống ==="
echo "Mục tiêu: rikkei-course-service"
echo "Tham số: 15 dòng cuối, đính kèm Timestamps"
echo "--------------------------------------------------------------------------------"

# Thực thi lệnh lấy log theo yêu cầu
docker logs --tail 15 --timestamps rikkei-course-service

echo "--------------------------------------------------------------------------------"
echo "=== Truy xuất hoàn tất ==="
