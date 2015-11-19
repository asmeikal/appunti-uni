
CURR_DIR = .

UNI = $(CURR_DIR)/uni

FRST_SEM = I-semestre
SCND_SEM = II-semestre

FRST_YEAR = $(UNI)/I-anno
SCND_YEAR = $(UNI)/II-anno
THRD_YEAR = $(UNI)/III-anno

SUBDIRS = 	$(FRST_YEAR)/$(SCND_SEM)/calcolo-integrale/ \
			$(THRD_YEAR)/$(FRST_SEM)/combinatoria/ \
			$(THRD_YEAR)/$(FRST_SEM)/automi/

.PHONY: subdirs $(SUBDIRS)

subdirs: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@
