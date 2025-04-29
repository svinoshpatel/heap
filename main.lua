local heap = require("heap")

-- Вивід бінарного дерева у вигляді піраміди
local function printHeapAsTree(A)
    local level = 0
    local index = 1
    local n = #A

    while index <= n do
        local count = 2 ^ level
        local values = {}

        for i = 0, count - 1 do
            if index + i <= n then
                table.insert(values, tostring(A[index + i]))
            end
        end

        -- Відступи для центрування
        local padding = string.rep(" ", (2 ^ (math.floor(math.log(n, 2)) - level)) * 2)
        print(padding .. table.concat(values, padding))
        index = index + count
        level = level + 1
    end
end

-- Меню
local function main()
    local A = {}

    while true do
        print("\n==== Меню ====")
        print("1. Ввести масив")
        print("2. Побудувати MaxHeap")
        print("3. Побудувати MinHeap")
        print("4. Сортувати за зростанням")
        print("5. Сортувати за спаданням")
        print("6. Показати як піраміду")
        print("0. Вийти")
        io.write("Ваш вибір: ")
        local choice = tonumber(io.read())

        if choice == 1 then
            A = {}
            io.write("Введіть елементи масиву через пробіл: ")
            for num in io.read():gmatch("%S+") do
                table.insert(A, tonumber(num))
            end
        elseif choice == 2 then
            heap.BuildMaxHeap(A)
            print("Побудовано MaxHeap")
        elseif choice == 3 then
            heap.BuildMinHeap(A)
            print("Побудовано MinHeap")
        elseif choice == 4 then
            heap.HeapSort(A, true)
            print("Відсортовано за зростанням")
        elseif choice == 5 then
            heap.HeapSort(A, false)
            print("Відсортовано за спаданням")
        elseif choice == 6 then
            print("Піраміда:")
            printHeapAsTree(A)
        elseif choice == 0 then
            break
        else
            print("Невірний вибір")
        end
    end
end

main()
