kjv1611: kjv1611.sh kjv1611.awk kjv1611.tsv
	cat kjv1611.sh > $@

	echo 'exit 0' >> $@

	echo '#EOF' >> $@
	tar czf - kjv1611.awk kjv1611.tsv >> $@

	chmod +x $@

test: kjv1611.sh
	shellcheck -s sh kjv1611.sh

.PHONY: test
