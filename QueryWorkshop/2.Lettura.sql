// Select
// Query 1 - Select di base di tutti i campi
SELECT * FROM dipendente;
// Query 2 - Select di un campo specifico
SELECT name FROM dipendente;
// Query 3 - Select con alias
SELECT name AS nome_dipendente FROM dipendente;


// Where condition 
// Query 4 - Filtraggio con where
Select * from dipendente where name = 'Nicholas';


// Group By
// Query 5 - Group by con array distinct
Select eta, array::distinct(name) from dipendente group by eta;
// Query 6 - Group by con count
Select eta, count(name) from dipendente group by eta;


// Conteggio record (Non corretto, non raggruppando, fa la count su ogni singolo record)
// Query 7 - Count errata
Select count() from dipendente;


// Conteggio record
// Query 8 - Count corretta con group all
Select count() from dipendente group all;


// Order by 
// Query 9 - Order by con group by
Select eta, array::distinct(name) from dipendente group by eta order by eta asc;


// Limitare i risultati
// Query 10 - Limit
Select name from dipendente limit 3;


// Select di un singolo record
// Query 11 - Select per ID
Select * from dipendente:1;


// Select di record tramite id (Modalità sconsigliata)
// Query 12 - Upsert primo record
Upsert dipendente:1 set name = "Luca", eta=12, password="iLoveSurrealdb", email="luca@cappuccino.com";
// Query 13 - Upsert secondo record
Upsert dipendente:2 set name = "Alessandro", eta=23, password="iLoveValueX", email="alessandro@cappuccino.com", foto;
// Query 14 - Upsert terzo record
Upsert dipendente:3 set name = "Mattia", eta=34, password="PasswordSegretissima1234!!!.", email="mattia@cappuccino.com", foto="https://randomuser.me/api/portraits/men/1.jpg";
// Query 15 - Select range di ID
Select * from dipendente where id >= dipendente:1 and id < dipendente:4;


// Select di record tramite id (Modalità consigliata)
// Query 16 - Select range di ID consigliato
Select * from dipendente:1..=3;


// Lavorare con array e oggetti
// Query 17 - Creazione record con array e oggetti
UPSERT dipendente:4 SET 
    name = "Marco", 
    eta = 28, 
    skills = ["Python", "JavaScript", "SQL"],
    contatti = {
        email: "marco@cappuccino.com",
        telefono: "123-456-789",
        social: {
            linkedin: "marco-dev",
            github: "marco-coder"
        }
    };

// Query 18 - Select elemento da array
SELECT skills[0] FROM dipendente:4;

// Query 19 - Select array completo
SELECT skills FROM dipendente:4;

// Query 20 - Select campo oggetto
SELECT contatti.email FROM dipendente:4;

// Query 21 - Select campo oggetto annidato
SELECT contatti.social.linkedin FROM dipendente:4;

// Query 22 - Utilizzo funzione array
SELECT array::len(skills) as numero_skills FROM dipendente:4;

// Query 23 - Utilizzo funzione object
SELECT object::len(contatti) as numero_campi_contatto FROM dipendente:4;

// Query 24 - Creazione record con array di oggetti
UPSERT dipendente:5 SET 
    name = "Laura",
    eta = 31,
    esperienze = [
        { azienda: "TechCorp", anni: 3 },
        { azienda: "DevInc", anni: 2 }
    ];

// Query 25 - Select array di oggetti
SELECT esperienze FROM dipendente:5;

// Query 26 - Select campo specifico da array di oggetti
SELECT esperienze.*.azienda FROM dipendente:5;

// Query 27 - Select primo elemento da array di oggetti
SELECT esperienze[0] FROM dipendente:5;


// Omissione di campi con OMIT
// Query 28 - Creazione record per esempi OMIT
UPSERT dipendente:6 SET 
    name = "Giulia",
    eta = 29,
    email = "giulia@cappuccino.com",
    password = "passwordSegreta123",
    dati_sensibili = {
        codice_fiscale: "ABC123XYZ",
        numero_carta: "1234-5678-9012"
    },
    note = "Sviluppatrice senior";

// Query 29 - OMIT singolo campo
SELECT * OMIT password FROM dipendente:6;

// Query 30 - OMIT multipli campi
SELECT * OMIT password, dati_sensibili FROM dipendente:6;

// Query 31 - OMIT campo annidato
SELECT * OMIT dati_sensibili.numero_carta FROM dipendente:6;

// Funzioni per array e deduplicazione
// Query 33 - Creazione primo record per esempi distinct/group
UPSERT dipendente:7 SET 
    name = "Paolo",
    eta = 32,
    skills = ["Python", "JavaScript", "Python", "SQL"],
    categorie = ["Backend", "Frontend"],
    dettagli = {
        progetti: ["Progetto A", "Progetto B"],
        tecnologie: ["Node.js", "React"]
    };

// Query 34 - Creazione secondo record per esempi distinct/group
UPSERT dipendente:8 SET 
    name = "Maria",
    eta = 28,
    skills = ["JavaScript", "Python", "React"],
    categorie = ["Frontend", "UI/UX"],
    dettagli = {
        progetti: ["Progetto B", "Progetto C"],
        tecnologie: ["React", "Vue.js"]
    };

// Query 35 - array::distinct su singolo record
SELECT array::distinct(skills) AS skills_uniche 
FROM dipendente:7;

// Query 36 - array::distinct su multiple records
SELECT array::distinct(skills) AS tutte_skills_uniche 
FROM dipendente 
GROUP ALL;

// Query 37 - array::group su array annidati
SELECT array::group(skills) AS tutte_skills_uniche 
FROM dipendente 
GROUP ALL;
