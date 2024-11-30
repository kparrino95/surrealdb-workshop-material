Delete dipendente, dipendente_backup, team;

// Creazione di un record semplice
Create dipendente;


// Transazioni
    // Possiamo definire un timeout alle operazioni che andiamo ad eseguire
    // le prime 2 insert vengono effettuate su 2 transazioni diverse
    Create dipendente Timeout 100ns;
    Create dipendente Timeout 2ms;


    // Con Parallel invece le operazioni vengono eseguite sulla stessa transazione
    Create dipendente, team Timeout 3ms PARALLEL;


// Statement Create

    
    // Creazione di un record json like
    Create team Content {
        name: "Allitude",
        numeroDipendenti: 10,
        posizione:{
            piano: "terra"
        }
    };
    
    
    // Creazione di un record simil sql update
    Create team set name="Arca", numeroDipendenti=20;
    
    
    // Possiamo anche utilizzare la dot notation
    Create team set name="Industry", numeroDipendenti=10, posizione.piano="primo";
    
    
    //Inserimenti multipli (Utile per creare dati randomici)
    Create |dipendente:10| content {
        name: rand::enum("Mario", "Luigi", "Peach", "Browser"),
        eta: rand::int(18,99)
    };


// Statement Insert


    // Insert sql like
    Insert into dipendente (name, eta) values ("Andrea", 18);


    // Insert sql like multiplo
    Insert into dipendente (name, eta) VALUES ('Nicholas', 11), ('Marco', 33);


    // Insert da un'altra tabella
    Insert into dipendente_backup (SELECT * FROM dipendente);


    // Ovviamente, essendo surreale possiamo anche mettere dei json like
    Insert into dipendente {
        name: "Kevin",
        eta: 5
    };


    // Per inserire più record json like possiamo usare le liste
    Insert into dipendente [
        {
            name: Tiziano,
            eta: 15-3
        },
        {
            name: Marcello,
            eta: 60
        }
    ];


    // Figo
    Insert into pokemon http::get('https://pokeapi.co/api/v2/pokemon/pikachu/');


// Statement Upsert


    // Inseriamo ad esempio un dipendente
    Insert into dipendente (id, name, eta) values (1, "Alessandro", 25);


    // Se proviamo ad inserirne un'altro con lo stesso id
    Insert into dipendente (id, name, eta) values (1, "Michele", 28);


    // Possiamo però gestire questo tipo di errore
    Insert into dipendente (id, name, eta) values (1, "Michele", 28) ON duplicate key update name = "Michele";


    // O in alternativa possiamo utilizzare il più comodo costrutto upsert
        // sql like
        Upsert dipendente:1 set name = "Michele", eta = 28;


        // o json like
        Upsert dipendente:1 content {
            name: "Michele",
            eta: 28
        }






