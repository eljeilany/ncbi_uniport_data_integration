CREATE TABLE UP_ENTRY
(
    entry_id varchar(100) NOT NULL,
    length int not null,
    reviewed bool not null, 
    CONSTRAINT PK_UP_ENTRY PRIMARY KEY (entry_id)
);

CREATE TABLE UP_AC
(
    entry_id varchar(100) NOT NULL,
    accession varchar(10) NOT NULL,
    CONSTRAINT PK_UP_AC PRIMARY KEY (accession, entry_id),
    CONSTRAINT FK_UP_AC_UP_ENTRY FOREIGN KEY(entry_id) REFERENCES UP_ENTRY(entry_id)
);

CREATE TABLE UP_GENE
(
    entry_id varchar(100) NOT NULL,
    gene_id varchar(200) NOT NULL,
    CONSTRAINT PK_UP_GENE PRIMARY KEY (gene_id),
    CONSTRAINT FK_UP_GENE_UP_ENTRY FOREIGN KEY(entry_id) REFERENCES UP_ENTRY(entry_id)
);

CREATE TABLE UP_GENE_NAMES (
	gene_id VARCHAR(200) NOT NULL, 
    gene_name VARCHAR(200), 
    name_type VARCHAR(100), 
    CONSTRAINT PK_UP_GENE_NAME PRIMARY KEY (gene_name,name_type),
    CONSTRAINT FK_NAME_UP_GENE FOREIGN KEY(gene_id) REFERENCES UP_GENE(gene_id)
);

CREATE TABLE UP_PROTEIN
(
    protein_id SERIAL,
    entry_id varchar(100) NOT NULL,
    flags varchar(100) NOT NULL,
    CONSTRAINT PK_UP_PROTEIN PRIMARY KEY (protein_id),
    CONSTRAINT FK_UP_PROTEIN_UP_ENTRY FOREIGN KEY(entry_id) REFERENCES UP_ENTRY(entry_id)
);

CREATE TABLE UP_PROTEIN_NAMES 
(
	protein_id SERIAL NOT NULL,
    protein_name VARCHAR(200), 
    protein_type VARCHAR(100),
    name_format VARCHAR(100), 
    CONSTRAINT PK_UP_PROTEIN_NAME PRIMARY KEY (protein_name,protein_type),
    CONSTRAINT FK_NAME_UP_PROTEIN FOREIGN KEY(protein_id) REFERENCES UP_PROTEIN(protein_id)
);

CREATE TABLE UP_KW 
(
    keyword_id SERIAL,
	keyword VARCHAR(100) NOT NULL,
    CONSTRAINT PK_UP_KW PRIMARY KEY (keyword_id)
);

CREATE TABLE UP_ENTRY_TO_UP_KW
(
	entry_id VARCHAR(100),
    keyword_id integer,
    CONSTRAINT PK_UP_ENTRY_UP_KW PRIMARY KEY (entry_id, keyword_id),
    CONSTRAINT FK_UP_ENTRY_UP_KW_UP_KW FOREIGN KEY(keyword_id) REFERENCES UP_KW(keyword_id),
    CONSTRAINT FK_UP_ENTRY_UP_KW_UP_ENTRY FOREIGN KEY(entry_id) REFERENCES UP_ENTRY(entry_id)
);

CREATE TABLE DR
(
	mim_id VARCHAR(32),
    refrence_type VARCHAR(32),
    CONSTRAINT PK_DR PRIMARY KEY (mim_id)
);

CREATE TABLE DR_TO_UP_ENTRY
(
	mim_id VARCHAR(32) NOT NULL,
    entry_id VARCHAR(100) NOT NULL,
    CONSTRAINT PK_DR_UP_ENTRY PRIMARY KEY (mim_id, entry_id),
    CONSTRAINT FK_DR_UP_ENTRY_DR FOREIGN KEY(mim_id) REFERENCES DR(mim_id),
    CONSTRAINT FK_DR_UP_ENTRY_UP_ENTRY FOREIGN KEY(entry_id) REFERENCES UP_ENTRY(entry_id)
);

/*
 *  NCBI
*/

CREATE TABLE NCBI_ENTRY
(
    gene_id integer NOT NULL,
    symbol VARCHAR(32) NOT NULL,
    description VARCHAR(200) NOT NULL,
    type_of_gene VARCHAR(32) NOT NULL,
    symbol_from_nomenclature_authority	 VARCHAR(32) NOT NULL,
    full_name_from_nomenclature_authority	 VARCHAR(200) NOT NULL,
    CONSTRAINT PK_NCBI_ENTRY PRIMARY KEY (gene_id)
);

CREATE TABLE NCBI_SYNONYMS
(
    synonym VARCHAR(32) NOT NULL,
    CONSTRAINT PK_NCBI_SYNONYMS PRIMARY KEY (synonym)
);

CREATE TABLE NCBI_SYNONYMS_TO_NCBI_ENTRY
(
    gene_id integer NOT NULL,
    synonym VARCHAR(32) NOT NULL,
    CONSTRAINT PK_NCBI_SYNONYMS_TO_NCBI_ENTRY PRIMARY KEY (gene_id, synonym),
    CONSTRAINT FK_NCBI_SYNONYMS_TO_NCBI_ENTRY_NCBI_ENTRY FOREIGN KEY(gene_id) REFERENCES NCBI_ENTRY(gene_id),
    CONSTRAINT FK_NCBI_SYNONYMS_TO_NCBI_ENTRY_NCBI_SYNONYMS FOREIGN KEY(synonym) REFERENCES NCBI_SYNONYMS(synonym)
);

CREATE TABLE NCBI_CHROMOSOMES
(
    chromosome VARCHAR(4) NOT NULL,
    CONSTRAINT PK_NCBI_CHROMOSOMES PRIMARY KEY (chromosome)
);

CREATE TABLE NCBI_CHROMOSOMES_TO_NCBI_ENTRY
(
    gene_id integer NOT NULL,
    chromosome VARCHAR(4) NOT NULL,
    CONSTRAINT PK_NCBI_CHROMOSOMES_TO_NCBI_ENTRY PRIMARY KEY (gene_id, chromosome),
    CONSTRAINT FK_NCBI_CHROMOSOMES_TO_NCBI_ENTRY_NCBI_ENTRY FOREIGN KEY(gene_id) REFERENCES NCBI_ENTRY(gene_id),
    CONSTRAINT FK_NCBI_CHROMOSOMES_TO_NCBI_ENTRY_NCBI_CHROMOSOMES FOREIGN KEY(chromosome) REFERENCES NCBI_CHROMOSOMES(chromosome)
);

CREATE TABLE DR_TO_NCBI_ENTRY
(
	mim_id VARCHAR(32) NOT NULL,
    gene_id integer NOT NULL,
    CONSTRAINT PK_DR_NCBI_ENTRY PRIMARY KEY (mim_id, gene_id),
    CONSTRAINT FK_DR_NCBI_ENTRY_DR FOREIGN KEY(mim_id) REFERENCES DR(mim_id),
    CONSTRAINT FK_DR_NCBI_ENTRY_NCBI_ENTRY FOREIGN KEY(gene_id) REFERENCES NCBI_ENTRY(gene_id)
);

CREATE TABLE NCBI_MAPLOC
(
    loc VARCHAR(48) NOT NULL,
    CONSTRAINT PK_NCBI_MAPLOC PRIMARY KEY (loc)
);

CREATE TABLE NCBI_MAPLOC_TO_NCBI_ENTRY
(
    gene_id integer NOT NULL,
    loc VARCHAR(48) NOT NULL,
    CONSTRAINT PK_NCBI_MAPLOC_TO_NCBI_ENTRY PRIMARY KEY (gene_id, loc),
    CONSTRAINT FK_NCBI_MAPLOC_TO_NCBI_ENTRY_NCBI_ENTRY FOREIGN KEY(gene_id) REFERENCES NCBI_ENTRY(gene_id),
    CONSTRAINT FK_NCBI_MAPLOC_TO_NCBI_ENTRY_NCBI_MAPLOC FOREIGN KEY(loc) REFERENCES NCBI_MAPLOC(loc)
);

CREATE TABLE NCBI_OTHER_GENE_NAMES (
	gene_id integer NOT NULL,
    gene_name VARCHAR(200) NOT NULL, 
    CONSTRAINT PK_NCBI_OTHER_GENE_NAMES PRIMARY KEY (gene_id, gene_name),
    CONSTRAINT FK_NAME_NCBI_ENTRY FOREIGN KEY(gene_id) REFERENCES NCBI_ENTRY(gene_id)
);



