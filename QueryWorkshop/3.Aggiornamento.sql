
// Update con INSERT
// Query 1 - Update tramite INSERT con ON DUPLICATE KEY
INSERT INTO dipendente (id, skills) 
VALUES (4, ["Python", "Rust"]), (4, ["Go", "Rust"])
ON DUPLICATE KEY UPDATE skills = $input.skills;

// I quattro metodi di aggiornamento
// Query 2 - Update con SET (sintassi SQL)
UPDATE dipendente SET ruolo = "sviluppatore";

// Query 3 - Update con MERGE (sintassi JSON)
UPDATE dipendente MERGE {
    ruolo: "sviluppatore",
    "data.aggiornamento": time::now()
};

// Query 4 - Update con PATCH (JSON Patch specification)
UPDATE dipendente PATCH [{
    op: "replace",
    path: "ruolo",
    value: "sviluppatore"
}];

// Query 5 - Update con CONTENT (sostituzione completa)
UPDATE dipendente:4 CONTENT {
    name: "Marco",
    eta: 28,
    ruolo: "sviluppatore",
    skills: ["Python", "JavaScript"]
};

// Esempi pratici di aggiornamento
// Query 6 - Aggiornamento singolo record con SET
UPDATE dipendente:4 SET
    skills -= "Python",
    skills += "TypeScript",
    data_aggiornamento = time::now();

// Query 7 - Stesso aggiornamento con PATCH
UPDATE dipendente:4 PATCH [
    {
        op: "remove",
        path: "skills/0"
    },
    {
        op: "add",
        path: "skills/-",
        value: "TypeScript"
    },
    {
        op: "replace",
        path: "data_aggiornamento",
        value: time::now()
    }
];

// Aggiornamento range di record
// Query 8 - Update range con ID (metodo consigliato)
UPDATE dipendente:1..=3 SET ruolo = "junior";

// Query 9 - Update con WHERE
UPDATE dipendente 
SET ruolo = "senior" 
WHERE eta >= 30
OR name="Nicholas";