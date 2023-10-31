	Select concat(substring(BookISBN, 1,3), 
			'-', substring(BookISBN, 4,1),
			'-', substring(BookISBN, 5,5),
			'-', substring(BookISBN, 10,3),
			'-', substring(BookISBN, 13,1)) 'ISBN',
			BookTitle 'Название',
			BookDescription 'Описание',
			(Select group_concat(GenreTitle separator ', ') 
				from bookgenredetails 
				join bookgenres on bookgenredetails.BookGenreDetailIdGenre = bookgenres.GenreId 
                where BookGenreDetailISBN = books.BookISBN) 'Жанры', 
			(Select group_concat(concat(substring(AuthorName, 1, 1), '. ', substring(AuthorPatronymic, 1, 1), '. ', AuthorSurname) separator ', ')
				from bookauthordetails join bookAuthors on bookAuthors.AuthorId = bookAuthorDetails.BookAuthorDetailIdAuthor where bookauthordetails.BookAuthorDetailISBN = Books.BookISBN)
            'Авторы',
            SerieTitle 'Серия',
            BookCirculation 'Тираж',
            concat(PublisherId, ', ', PublisherTitle, ', ', PublisherRegeon) 'Издатель',
            BindingTitle 'Обложка',
            BookSize 'Размер',
            BookPageCount 'Количество страниц',
            BookPrice 'Цена за экземпляр',
            BookDiscount 'Скидка',
            round(BookPrice - (BookPrice * (BookDiscount / 100)), 2) 'Цена со скидкой',
            concat(BooksQuantityInNetwork, ' шт.') 'Количество в системе'
	from books
    left join bookSeries on books.BookIdSeries = bookseries.SerieId
    join bookPublishers on BookIdPublisher = bookPublishers.PublisherId
	join bookbindings on Books.BookIdBinding = bookBindings.BindingId
	order by substring(BookISBN, 10, 3);