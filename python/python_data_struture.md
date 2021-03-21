# python - data structure

> 简单记录一下Python的基础数据结构使用


## 堆

https://docs.python.org/3/library/heapq.html

```
heap_list = []
heappush(heap_list, (5, 'write code'))
heappush(heap_list, (7, 'release product'))
heappush(heap_list, (1, 'write spec'))
heappush(heap_list, (3, 'create tests'))
heappop(heap_list)
```

### 大根堆/小根堆

- 默认是小根堆
- 使用 nsmallest/nlargest 可指定具体的 sorted_key （`key=str.lower`）
Equivalent to: `sorted(iterable, key=key, reverse=True)[:n]`

```
from heapq import heappush, nlargest, nsmallest
heap_list = []
heappush(heap_list, (5, 'write code'))
heappush(heap_list, (7, 'release product'))
heappush(heap_list, (1, 'write spec'))
heappush(heap_list, (3, 'create tests'))
nlargest(4, heap_list, key=lambda x: x[0])
nsmallest(4, heap_list, key=lambda x: x[1])
```

### 堆排序

```
def heapsort(iterable):
    h = []
    for value in iterable:
        heappush(h, value)
    return [heappop(h) for i in range(len(h))]

heapsort([1, 3, 5, 7, 9, 2, 4, 6, 8, 0])
[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
```


### 优先队列

[Difference between a heap and a priority queue](https://softwareengineering.stackexchange.com/questions/254947/difference-between-a-heap-and-a-priority-queue)
概念：优先队列是指实现了insert, findMin and deleteMin 等函数，具体底层的依赖的数据结构可以是堆或者列表（线性查找）


## 栈

```
a_list = []
for i in range(10):
    a_list.append(i)

for i in range(10):
    print(a_list.pop())
```

## 队列
https://docs.python.org/3/library/queue.html
```
import threading, queue

q = queue.Queue()

def worker():
    while True:
        item = q.get()
        print(f'Working on {item}')
        print(f'Finished {item}')
        q.task_done()

# turn-on the worker thread
threading.Thread(target=worker, daemon=True).start()

# send thirty task requests to the worker
for item in range(30):
    q.put(item)
print('All task requests sent\n', end='')

# block until all tasks are done
q.join()
print('All work completed')
```