Delete dipendente;


// Gli id dei record possono essere generati dinamicamente
create dipendente;


// O possiamo impostarlo noi
    // Specificandolo sul record che stiamo creando
    create dipendente:1;


    // Oppure specificandolo come campo
    create dipendente set id = 2;


// Gli id possono essere di molti tipi
create dipendente:Cavalieri;
create dipendente:`Nicholas Mantovani`;


// Anche di tipi complessi
create dipendente:{name: Nicholas, minorenne: true};
create dipendente:{name: Nicholas, minorenne: false};