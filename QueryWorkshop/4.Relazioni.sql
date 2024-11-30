// Creazione relazioni base
// Query 1 - Relazione base wishlist
RELATE dipendente:1 -> wishlist:ulid() -> progetto:1;

// Query 2 - Relazione con SET
RELATE dipendente:2 -> assegnazione:ulid() -> progetto:2
SET data_assegnazione = time::now();

// Query 3 - Relazione con CONTENT e riferimenti
RELATE dipendente:3 -> responsabile:ulid() -> progetto:3
CONTENT {
    ruolo: "team_leader",
    nome_progetto: ->progetto.name,
    competenze_richieste: ["Python", "JavaScript"],
    data_inizio: time::now()
};


// Relazioni tra due tabelle
// Query 4 - Auto-relazione per gerarchia
RELATE dipendente:1 -> supervisione:ulid() -> dipendente:2;

// Query 5 - Auto-relazione con dettagli
RELATE dipendente:2 -> mentoring:ulid() -> dipendente:4
CONTENT {
    area: "sviluppo",
    durata_mesi: 6
};


// Inserimento multiple relazioni
// Query 6 - INSERT RELATION
INSERT RELATION INTO collaborazione [
    {
        id: collaborazione:1,
        in: dipendente:1,
        out: progetto:1
    },
    {
        id: collaborazione:2,
        in: dipendente:2,
        out: progetto:1
    }
];

// Query 7 - Relazioni multiple con parametri
LET $dipendenti = (SELECT VALUE id FROM dipendente LIMIT 3);
LET $progetti = (SELECT VALUE id FROM progetto LIMIT 2);

RELATE $dipendenti->partecipazione->$progetti TIMEOUT 2s;


// Operazioni CRUD con relazioni
// Query 8 - Select con relazioni
SELECT 
    <-dipendente.name AS nome_dipendente,
    ->progetto.name AS nome_progetto,
    data_assegnazione
FROM assegnazione;

// Query 9 - Update con relazioni
UPDATE responsabile
SET team_size = array::len(<-dipendente.team);

// Query 10 - Delete con relazioni
DELETE collaborazione
WHERE ->progetto.stato = "completato";
