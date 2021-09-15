class Auto

    # атрибуты для получения значений
    attr_reader :brand
    attr_reader :model
    attr_reader :manifacture_year
    attr_reader :gasoline_consumption

    # метод-инициализации, который принимает марку, модель,
    # год выпуска и средний расход автомобиля и сохраняет их в переменных экземпляра.
    def initialize(brand,model,manifacture_year,gasoline_consumption)
        @brand = brand  # марка автомобиля
        @model = model  # модель автомобиля
        @manifacture_year = manifacture_year.to_i  # год выпуска автомобиля
        @gasoline_consumption = gasoline_consumption.to_f  # Средний расход бензина на 100 километров
    end

    def to_s
        return "Марка: #{@brand}\nМодель: #{@model}\nГод выпуска: #{@manifacture_year}\nСредний расход бензина на 100 километров: #{@gasoline_consumption}"
    end
end