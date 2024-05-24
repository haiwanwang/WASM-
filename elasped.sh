#!/bin/bash

# 获取 sledgert 进程的 PID
SLEDGERT_PID=$(pgrep sledgert)

if [ -z "$SLEDGERT_PID" ]; then
  echo "sledgert process not found!"
  exit 1
fi

# 启动 perf 监控
sudo perf record -e cycles,instructions,cache-misses -p $SLEDGERT_PID -o perf.data &
PERF_PID=$!

# 确保 perf 已启动
sleep 0.1

# 记录开始时间（纳秒）
start=$(date +%s%N)

# 发送 HTTP 请求
echo "10" | http :10000

# 记录结束时间（纳秒）
end=$(date +%s%N)

# 计算耗时（纳秒）
elapsed=$((end - start))

# 转换为微秒
elapsed_us=$((elapsed / 1000))
echo "Elapsed time: ${elapsed_us} ?s"

# 转换为毫秒
elapsed_ms=$((elapsed / 1000000))
echo "Elapsed time: ${elapsed_ms} ms"

# 停止 perf 监控
sudo pkill -INT -P $PERF_PID

# 等待 perf 写入数据
wait $PERF_PID

# 显示 perf 报告
sudo perf report -i perf.data
