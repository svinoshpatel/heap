local heap = require("heap")

-- Візуалізація піраміди у вигляді дерева (твій варіант)
local function printHeapAsTree(A)
    local level = 0
    local index = 1
    local n = A.heap_size or #A

    while index <= n do
        local count = 2 ^ level
        local values = {}

        for i = 0, count - 1 do
            if index + i <= n then
                table.insert(values, tostring(A[index + i]))
            end
        end

        local pad = string.rep(" ", (2 ^ (math.floor(math.log(n, 2)) - level)) * 2)
        print(pad .. table.concat(values, pad))
        index = index + count
        level = level + 1
    end
end
-- Головне меню
local function main()
    local A = {}
    local mode = "max"  -- "max" або "min"

    while true do
        print("\n==== Пріоритетна черга (" .. mode:upper() .. " heap) ====")
        print("1. Ввести масив")
        print("2. Побудувати піраміду")
        print("3. Показати піраміду як масив")
        print("4. Показати піраміду як дерево")
        print("5. Показати головний елемент")
        print("6. Видалити головний елемент")
        print("7. Змінити ключ")
        print("8. Додати елемент")
        print("9. Змінити тип піраміди (MAX <-> MIN)")
        print("0. Вийти")
        io.write("Ваш вибір: ")
        local choice = tonumber(io.read())

        if choice == 1 then
            A = {}
            io.write("Введіть елементи через пробіл: ")
            for num in io.read():gmatch("%S+") do
                table.insert(A, tonumber(num))
            end
        elseif choice == 2 then
            if mode == "max" then
                heap.BuildMaxHeap(A)
            else
                heap.BuildMinHeap(A)
            end
            print("Піраміду побудовано")
        elseif choice == 3 then
            for i = 1, A.heap_size or #A do
                io.write(A[i] .. " ")
            end
            print()
        elseif choice == 4 then
            printHeapAsTree(A)
        elseif choice == 5 then
            local result = mode == "max" and heap.HeapMaximum(A) or heap.HeapMinimum(A)
            print("Головний елемент: " .. tostring(result))
        elseif choice == 6 then
            local result = mode == "max" and heap.HeapExtractMax(A) or heap.HeapExtractMin(A)
            print("Видалено: " .. tostring(result))
        elseif choice == 7 then
            io.write("Індекс: ")
            local i = tonumber(io.read())
            io.write("Нове значення: ")
            local k = tonumber(io.read())
            if mode == "max" then
                heap.HeapIncreaseKey(A, i, k)
            else
                heap.HeapDecreaseKey(A, i, k)
            end
        elseif choice == 8 then
            io.write("Ключ для вставки: ")
            local k = tonumber(io.read())
            if mode == "max" then
                heap.MaxHeapInsert(A, k)
            else
                heap.MinHeapInsert(A, k)
            end
        elseif choice == 9 then
            mode = (mode == "max") and "min" or "max"
            print("Змінено тип піраміди на " .. mode:upper())
        elseif choice == 0 then
            break
        else
            print("Невірний вибір")
        end
    end
end

main()
