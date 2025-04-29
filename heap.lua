local heap = {}

-- Navigation functions
function heap.Parent(i)
    return math.floor(i / 2)
end

function heap.Left(i)
    return 2 * i
end

function heap.Right(i)
    return 2 * i + 1
end

-- Max heap functions
function heap.MaxHeapify(A, i)
    local l = heap.Left(i)
    local r = heap.Right(i)
    local largest = i

    if l <= A.heap_size and A[l] > A[largest] then
        largest = l
    end

    if r <= A.heap_size and A[r] > A[largest] then
        largest = r
    end

    if largest ~= i then
        A[i], A[largest] = A[largest], A[i]
        heap.MaxHeapify(A, largest)
    end
end

function heap.BuildMaxHeap(A)
    A.heap_size = #A
    for i = math.floor(#A / 2), 1, -1 do
        heap.MaxHeapify(A, i)
    end
end

-- Min heap functions
function heap.MinHeapify(A, i)
    local l = heap.Left(i)
    local r = heap.Right(i)
    local smallest = i

    if l <= A.heap_size and A[l] < A[smallest] then
        smallest = l
    end

    if r <= A.heap_size and A[r] < A[smallest] then
        smallest = r
    end

    if smallest ~= i then
        A[i], A[smallest] = A[smallest], A[i]
        heap.MinHeapify(A, smallest)
    end
end

function heap.BuildMinHeap(A)
    A.heap_size = #A
    for i = math.floor(#A / 2), 1, -1 do
        heap.MinHeapify(A, i)
    end
end

-- Heap sort function
function heap.HeapSort(A, ascending)
    if ascending then
        -- Sort ascending using max heap
        heap.BuildMaxHeap(A)
        for i = #A, 2, -1 do
            A[1], A[i] = A[i], A[1]
            A.heap_size = A.heap_size - 1
            heap.MaxHeapify(A, 1)
        end
    else
        -- Sort descending using min heap
        heap.BuildMinHeap(A)
        for i = #A, 2, -1 do
            A[1], A[i] = A[i], A[1]
            A.heap_size = A.heap_size - 1
            heap.MinHeapify(A, 1)
        end
    end
    -- Reset heap_size after sorting
    A.heap_size = #A
end

-- MaxHeap пріоритетна черга
function heap.HeapMaximum(A)
    return A[1]
end

function heap.HeapExtractMax(A)
    if A.heap_size < 1 then
        error("Черга порожня")
    end
    local max = A[1]
    A[1] = A[A.heap_size]
    A.heap_size = A.heap_size - 1
    heap.MaxHeapify(A, 1)
    return max
end

function heap.HeapIncreaseKey(A, i, key)
    if key < A[i] then
        error("Новий ключ менший за поточний")
    end
    A[i] = key
    while i > 1 and A[heap.Parent(i)] < A[i] do
        A[i], A[heap.Parent(i)] = A[heap.Parent(i)], A[i]
        i = heap.Parent(i)
    end
end

function heap.MaxHeapInsert(A, key)
    A.heap_size = A.heap_size + 1
    A[A.heap_size] = -math.huge
    heap.HeapIncreaseKey(A, A.heap_size, key)
end

function heap.HeapMinimum(A)
    return A[1]
end

function heap.HeapExtractMin(A)
    if A.heap_size < 1 then
        error("Черга порожня")
    end
    local min = A[1]
    A[1] = A[A.heap_size]
    A.heap_size = A.heap_size - 1
    heap.MinHeapify(A, 1)
    return min
end

function heap.HeapDecreaseKey(A, i, key)
    if key > A[i] then
        error("Новий ключ більший за поточний")
    end
    A[i] = key
    while i > 1 and A[heap.Parent(i)] > A[i] do
        A[i], A[heap.Parent(i)] = A[heap.Parent(i)], A[i]
        i = heap.Parent(i)
    end
end

function heap.MinHeapInsert(A, key)
    A.heap_size = A.heap_size + 1
    A[A.heap_size] = math.huge
    heap.HeapDecreaseKey(A, A.heap_size, key)
end


return heap
