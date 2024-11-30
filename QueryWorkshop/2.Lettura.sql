// Select
SELECT * FROM dipendente;
SELECT name FROM dipendente;
SELECT name AS nome_dipendente FROM dipendente;


// Where condition 
Select * from dipendente where name = 'Nicholas';


// Group By
Select eta, array::distinct(name) from dipendente group by eta;
Select eta, count(name) from dipendente group by eta;


// Conteggio record (Non corretto, non raggruppando, fa la count su ogni singolo record)
Select count() from dipendente;


// Conteggio record
Select count() from dipendente group all;


// Order by 
Select eta, array::distinct(name) from dipendente group by eta order by eta asc;


// Limitare i risultati
Select name from dipendente limit 3;


// Select di un singolo record
Select * from dipendente:1;


// Select di record tramite id (Modalità sconsigliata)
Upsert dipendente:1 set name = "Luca", eta=12, password="iLoveSurrealdb", email="luca@cappuccino.com";
Upsert dipendente:2 set name = "Alessandro", eta=23, password="iLoveValueX", email="alessandro@cappuccino.com", foto;
Upsert dipendente:3 set name = "Mattia", eta=34, password="PasswordSegretissima1234!!!.", email="mattia@cappuccino.com", foto="https://randomuser.me/api/portraits/men/1.jpg";


Select * from dipendente where id >= dipendente:1 and id < dipendente:4;


// Select di record tramite id (Modalità consigliata)
Select * from dipendente:1..=3;


// Omissione di campi
Select name, eta from dipendente

