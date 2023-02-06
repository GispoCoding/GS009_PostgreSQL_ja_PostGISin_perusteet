DROP TABLE IF EXISTS ajoneuvorekisteri;

CREATE TABLE ajoneuvorekisteri (
    ajoneuvoluokka text,
    ensirekisterointipvm text,
    ajoneuvoryhma double precision,
    ajoneuvonkaytto text,
    variantti text,
    versio text,
    kayttoonottopvm bigint,
    vari text,
    ovienlukumaara double precision,
    korityyppi text,
    ohjaamotyyppi double precision,
    istumapaikkojenlkm double precision,
    omamassa double precision,
    teknsuursallkokmassa double precision,
    tieliiksuursallkokmassa double precision,
    ajonkokpituus double precision,
    ajonleveys double precision,
    ajonkorkeus double precision,
    kayttovoima text,
    iskutilavuus double precision,
    suurinnettoteho double precision,
    sylintereidenlkm double precision,
    ahdin boolean,
    sahkohybridi boolean,
    sahkohybridinluokka double precision,
    merkkiselvakielinen text,
    mallimerkinta text,
    vaihteisto text,
    vaihteidenlkm double precision,
    kaupallinennimi text,
    voimanvaljatehostamistapa double precision,
    tyyppihyvaksyntanro text,
    yksittaiskayttovoima text,
    kunta bigint,
    co2 double precision,
    matkamittarilukema double precision,
    valmistenumero2 text,
    jarnro bigint
);