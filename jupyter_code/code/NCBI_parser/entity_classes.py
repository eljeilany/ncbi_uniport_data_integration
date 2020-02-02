class NCBI_ENTRY:
    def __init__(self, gene_id, symbol, description, type_of_gene,
                    symbol_from_nomenclature_authority, 
                     full_name_from_nomenclature_authority):
        self.gene_id = int(gene_id)
        self.symbol = symbol
        self.description = description
        self.type_of_gene = type_of_gene
        self.symbol_from_nomenclature_authority = symbol_from_nomenclature_authority
        self.full_name_from_nomenclature_authority = full_name_from_nomenclature_authority
        
    def insertToDB (self, cur, commit= True):
        
        cur.execute("""
            INSERT INTO NCBI_ENTRY (gene_id, symbol, description, type_of_gene,
                symbol_from_nomenclature_authority, full_name_from_nomenclature_authority)
            VALUES (%s, %s, %s, %s, %s, %s);
            """,
            (self.gene_id , self.symbol , self.description, self.type_of_gene,
            self.symbol_from_nomenclature_authority, self.full_name_from_nomenclature_authority ))
        if commit:
            cur.connection.commit()

        
class NCBI_SYNONYMS:
    def __init__(self, synonym):
        self.synonym = str(synonym)
        
    def insertToDB (self, cur, commit= True):
        
        cur.execute("""
            INSERT INTO NCBI_SYNONYMS (synonym)
            VALUES (%s) ON CONFLICT DO NOTHING;
            """,
            (self.synonym,))
        if commit:
            cur.connection.commit()
                 
class NCBI_SYNONYMS_TO_NCBI_ENTRY:
    def __init__(self, gene_id, synonym):
        self.gene_id = int(gene_id)
        self.synonym = synonym
        
    def insertToDB (self, cur, commit= True):
        
        cur.execute("""
            INSERT INTO NCBI_SYNONYMS_TO_NCBI_ENTRY (gene_id, synonym)
            VALUES (%s, %s);
            """,
            (self.gene_id  , self.synonym))
        if commit:
            cur.connection.commit()
            
class NCBI_CHROMOSOMES:
    def __init__(self, chromosome):
        self.chromosome = chromosome
        
    def insertToDB (self, cur, commit= True):
        
        cur.execute("""
            INSERT INTO NCBI_CHROMOSOMES (chromosome)
            VALUES (%s) ON CONFLICT DO NOTHING;
            """,
            (self.chromosome,))
        if commit:
            cur.connection.commit()
                 
class NCBI_CHROMOSOMES_TO_NCBI_ENTRY:
    def __init__(self, gene_id, chromosome):
        self.gene_id = int(gene_id)
        self.chromosome = chromosome
        
    def insertToDB (self, cur, commit= True):
        
        cur.execute("""
            INSERT INTO NCBI_CHROMOSOMES_TO_NCBI_ENTRY (gene_id, chromosome)
            VALUES (%s, %s);
            """,
            (self.gene_id  , self.chromosome))
        if commit:
            cur.connection.commit()
            
class DR:
    def __init__(self, mim_id, refrence_type=""):
        self.mim_id = mim_id
        self.refrence_type = refrence_type
        
    def insertToDB (self, cur, commit= True):
        
        cur.execute("""
            INSERT INTO DR(mim_id, refrence_type)
            VALUES (%s, %s) ON CONFLICT DO NOTHING;
            """,
            (self.mim_id  , self.refrence_type))
        if commit:
            cur.connection.commit()

            
class DR_TO_NCBI_ENTRY:
    def __init__(self, gene_id, mim_id):
        self.gene_id = int(gene_id)
        self.mim_id = mim_id
        
    def insertToDB (self, cur, commit= True):
        
        cur.execute("""
            INSERT INTO DR_TO_NCBI_ENTRY (gene_id, mim_id)
            VALUES (%s, %s);
            """,
            (self.gene_id  , self.mim_id))
        if commit:
            cur.connection.commit()
            
class NCBI_MAPLOC:
    def __init__(self, loc):
        self.loc = loc
        
    def insertToDB (self, cur, commit= True):
        
        cur.execute("""
            INSERT INTO NCBI_MAPLOC ( loc)
            VALUES (%s) ON CONFLICT DO NOTHING;
            """,
            (self.loc,))
        if commit:
            cur.connection.commit()
            
class NCBI_MAPLOC_TO_NCBI_ENTRY:
    def __init__(self, gene_id, loc):
        self.gene_id = int(gene_id)
        self.loc = loc
        
    def insertToDB (self, cur, commit= True):
        
        cur.execute("""
            INSERT INTO NCBI_MAPLOC_TO_NCBI_ENTRY (gene_id, loc)
            VALUES (%s, %s) ON CONFLICT DO NOTHING;
            """,
            (self.gene_id  , self.loc))
        if commit:
            cur.connection.commit()
            
class NCBI_OTHER_GENE_NAMES:
    def __init__(self, gene_id, gene_name):
        self.gene_id = int(gene_id)
        self.gene_name = gene_name
        
    def insertToDB (self, cur, commit= True):
        
        cur.execute("""
            INSERT INTO NCBI_OTHER_GENE_NAMES (gene_id, gene_name)
            VALUES (%s, %s);
            """,
            (self.gene_id  , self.gene_name))
        if commit:
            cur.connection.commit()