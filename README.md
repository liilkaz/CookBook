# CookBook - кулинарное приложение 

* Проект на Swift 5, минимальная поддерживаемая iOS – 14, только iPhone, портретная ориентация экрана.
* Верстка на UIKit кодом.
* Архитектура - MVC.
* Дополнительные библиотки не использовались.
* API - https://spoonacular.com/food-api
* **Проект выполнен в рамках второго челленджа марафона "SWIFT MARATHON 6.0"** --> https://t.me/swiftmarathon

---

## Описание проекта

На старте нас встречает Экран запуска.
<p>
<img src="https://user-images.githubusercontent.com/86955276/224558493-a3c055f0-6e53-4a11-ba7a-c48a0afbacf4.png" width="300">
</p>

В приложении реализован таббар с 4 вкладками: **Home, Сategories, Search, Favorite**

**Главный экран** создан с помощью CompositionLayout+CollectionView.

Здесь отображаются популярные рецепты и история - последние просмотренные.
<p>
<img src="https://user-images.githubusercontent.com/86955276/224558475-17c622fa-dac7-44b5-af7e-2d7873695e31.png" width="300">
</p>

**Сохранение** реализовано в двух местах - в истории и в избранном, сохраняется Id рецепта через **userDefaults**

На экране **рецепта** у нас отображается название блюда, изображение, теги(если есть), кнопка для сохранения в избранное, количество ингредиентов, время приготовления и сами ингредиенты в формате toDoList
<p>
<img src="https://user-images.githubusercontent.com/86955276/224558477-9302ceef-880d-4e36-a226-cc8528635380.png" width="300">
</p>

Вкладка **«Сategories»**
Экран реализован с помощью CollectionView
<p>
<img src="https://user-images.githubusercontent.com/86955276/224558498-7b5c00dc-9a73-4727-aaa4-842594c50c5a.png" width="300">
</p>

Переходим в категорию - здесь отображается таблица (TableView) с рецептами одной категории
<p>
<img src="https://user-images.githubusercontent.com/86955276/224558494-b8f213ed-0171-4f06-a045-ff52f27b5b4f.png" width="300">
</p>


Вкладка **"Search"**.
Здесь можно найти любой интересующий рецепт
Если ввод некорректен, появяется предупреждающее сообщение
<p>
<img src="https://user-images.githubusercontent.com/86955276/224558495-c9927f20-e49d-4926-a58c-341f4a8c1aa9.png" width="300">
<img src="https://user-images.githubusercontent.com/86955276/224558479-8ec85b10-3b79-492f-8ecc-fa994510275a.png" width="300">
<img src="https://user-images.githubusercontent.com/86955276/224558496-0ecc5483-bc49-4fe2-aa19-7d41f894cf80.png" width="300">
</p>


Вкладка **"Favorite"**
Здесь отображаются все сохраненные рецепты, мы можем также их удалить
<p>
<img src="https://user-images.githubusercontent.com/86955276/224558481-2a704a28-15b9-4461-af22-ae7a28ebe891.png" width="300">
<img src="https://user-images.githubusercontent.com/86955276/224558492-7d43c7c8-b1e0-4dba-bb7e-96e46584660b.png" width="300">
</p>

### Над проектом работали:

+ [Liliya](https://github.com/liilkaz) (Тимлид команды)
+ [Vladimir](https://github.com/V-Vladimir)
+ [Artur](https://github.com/arturimkh)
+ [Leonid](https://github.com/theheleos)
+ [Hurshid](https://github.com/Meddor12)
+ [Dmitrii](https://github.com/wiagb)
+ [Evgeniy](https://github.com/mikhaylovevg)

