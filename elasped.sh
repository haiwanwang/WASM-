#!/bin/bash

# ��ȡ sledgert ���̵� PID
SLEDGERT_PID=$(pgrep sledgert)

if [ -z "$SLEDGERT_PID" ]; then
  echo "sledgert process not found!"
  exit 1
fi

# ���� perf ���
sudo perf record -e cycles,instructions,cache-misses -p $SLEDGERT_PID -o perf.data &
PERF_PID=$!

# ȷ�� perf ������
sleep 0.1

# ��¼��ʼʱ�䣨���룩
start=$(date +%s%N)

# ���� HTTP ����
echo "10" | http :10000

# ��¼����ʱ�䣨���룩
end=$(date +%s%N)

# �����ʱ�����룩
elapsed=$((end - start))

# ת��Ϊ΢��
elapsed_us=$((elapsed / 1000))
echo "Elapsed time: ${elapsed_us} ?s"

# ת��Ϊ����
elapsed_ms=$((elapsed / 1000000))
echo "Elapsed time: ${elapsed_ms} ms"

# ֹͣ perf ���
sudo pkill -INT -P $PERF_PID

# �ȴ� perf д������
wait $PERF_PID

# ��ʾ perf ����
sudo perf report -i perf.data
