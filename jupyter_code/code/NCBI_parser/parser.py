import pandas as pd
from tqdm.notebook import tqdm
from .entity_classes import NCBI_ENTRY, NCBI_SYNONYMS, NCBI_SYNONYMS_TO_NCBI_ENTRY, NCBI_CHROMOSOMES, \
                            NCBI_CHROMOSOMES_TO_NCBI_ENTRY, DR, DR_TO_NCBI_ENTRY, NCBI_MAPLOC, \
                            NCBI_MAPLOC_TO_NCBI_ENTRY, NCBI_OTHER_GENE_NAMES

def InsertRow(row, cur):
    cur.connection.commit()
    entry = NCBI_ENTRY(row.GeneID, row.Symbol, row.description, row.type_of_gene,
                  row.Symbol_from_nomenclature_authority, row.Full_name_from_nomenclature_authority)
    entry.insertToDB(cur=cur, commit=False)
    
    synonyms = [NCBI_SYNONYMS(syno) for syno in row.Synonyms.split("|")]
    for syno in synonyms:
        syno.insertToDB(cur=cur, commit=False)
    
    synonyms_to_entries = [NCBI_SYNONYMS_TO_NCBI_ENTRY(row.GeneID, syno.synonym) for syno in synonyms]
    for s2e in synonyms_to_entries:
        s2e.insertToDB(cur=cur, commit=False)
    
    chromosomes = [NCBI_CHROMOSOMES(chromo) for chromo in  row.chromosome.split("|")]
    for chromo in chromosomes:
        chromo.insertToDB(cur=cur, commit=False)
    
    chromo_to_entries = [NCBI_CHROMOSOMES_TO_NCBI_ENTRY(row.GeneID, chromo.chromosome) for chromo in chromosomes]
    for c2e in chromo_to_entries:
        c2e.insertToDB(cur=cur, commit=False)
    
    dr_refs = [DR(ref.split(":")[1]) for ref in  row.dbXrefs.split("|") if ref.split(":")[0] == "MIM"]
    for ref in dr_refs:
        ref.insertToDB(cur=cur, commit=False)
    
    dr_to_entries = [DR_TO_NCBI_ENTRY(row.GeneID, ref.mim_id) for ref in dr_refs]
    for dr2e in dr_to_entries:
        dr2e.insertToDB(cur=cur, commit=False)
    
    locs = [NCBI_MAPLOC(loc) for loc in  row.map_location.split("|") ]
    for loc in locs:
        loc.insertToDB(cur=cur, commit=False)
    
    loc_to_entries = [NCBI_MAPLOC_TO_NCBI_ENTRY(row.GeneID, loc.loc) for loc in locs]
    for loc2e in loc_to_entries:
        loc2e.insertToDB(cur=cur, commit=False)
    
    other_designations = [NCBI_OTHER_GENE_NAMES(row.GeneID, name) for name in  row.Other_designations.split("|") ]
    for name in other_designations:
        name.insertToDB(cur=cur, commit=False)
    cur.connection.commit()

def ParseAndInsertTSVintoDB(path, cur):
    """
    Parses an NCBI TSV file and insert the relavent values from it into the Database.

    Parameters
    ----------
    path: Path to NCBI TSV file
        
    cur: psycopg2 cursor.

    Returns
    -------
    None
    """
    df = pd.read_csv(path, delimiter="\t")

    for _, row in tqdm(df.iterrows()):
        InsertRow(row, cur)