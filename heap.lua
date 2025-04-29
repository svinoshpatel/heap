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

return heap
