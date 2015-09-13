
CURR_DIR = .

UNI = $(CURR_DIR)/uni

FRST_SEM = I-semestre
SCND_SEM = II-semestre

FRST_YEAR = $(UNI)/I-anno
SCND_YEAR = $(UNI)/II-anno
THRD_YEAR = $(UNI)/III-anno

SUBDIRS = 	$(SCND_YEAR)/$(SCND_SEM)/calcolo-integrale/

.PHONY: subdirs $(SUBDIRS)

subdirs: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@
