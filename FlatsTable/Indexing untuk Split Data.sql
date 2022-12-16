--indexing untuk split data
create index saktiksl.BPK_ASTJURNAL_221023_KDBA on saktiksl.BPK_AST_T_JURNAL_220930_221023(substr(KODE_UAKPB,1,3));
create index saktiksl.BPK_ASTJURNAL_221023_KDBAES1 on saktiksl.BPK_AST_T_JURNAL_220930_221023(substr(KODE_UAKPB,1,5));
create index saktiksl.BPK_glpcoa_221023_KDBA on saktiksl.BPK_GLP_COA_220930_221023(KODE_BA_SATKER);
create index saktiksl.BPK_glpcoa_221023_KDBAES1 on saktiksl.BPK_GLP_COA_220930_221023(KODE_BA_SATKER||kode_eselon1_satker);
create index saktiksl.BPK_glpcoaP_221023_KDBA on saktiksl.BPK_GLP_COA_PAJAK_220930_221023(KODE_BA_SATKER);
create index saktiksl.BPK_glpcoaP_221023_KDBAES1 on saktiksl.BPK_GLP_COA_PAJAK_220930_221023(KODE_BA_SATKER||kode_eselon1_satker);
create index saktiksl.BPK_NRCCOBA_221023_KDBA on saktiksl.BPK_GLP_NRC_COBA_220930_221023(KODE_BA_SATKER);
create index saktiksl.BPK_NRCCOBA_221023_KDBAES1 on saktiksl.BPK_GLP_NRC_COBA_220930_221023(KODE_BA_SATKER||kode_eselon1_satker);
create index saktiksl.BPK_NRCCOBA_220731_KDBA on saktiksl.BPK_GLP_NRC_SAWAL_220731(substr(KDBAES1,1,3));
create index saktiksl.BPK_NRCCOBA_220731_KDBAES1 on saktiksl.BPK_GLP_NRC_SAWAL_220731(KDBAES1);