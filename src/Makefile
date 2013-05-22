SCRIPTS	=	$(wildcard *.coffee)
PAGES	=	$(wildcard *.haml)
RESULTS =	$(SCRIPTS:.coffee=.js) $(PAGES:.haml=.html)

.SUFFIXES: .coffee .js .haml .html

.coffee.js:
	coffee -bc $<

.haml.html:
	haml $< $@

all: $(RESULTS)

clean:
	rm -f $(RESULTS)
