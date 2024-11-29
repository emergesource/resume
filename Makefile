all: resume.html resume.pdf resume.txt resume.css

resume.html: resume.md resume.css
	pandoc --standalone --lua-filter=filter.lua -c resume.css --from markdown --to html -o resume.html resume.md 

resume.pdf: resume.html
	wkhtmltopdf --enable-local-file-access --print-media-type --no-pdf-compression --encoding "UTF-8" --no-background resume.html resume.pdf

resume.txt: resume.md
	pandoc --standalone --from markdown --to plain -o resume.txt resume.md

clean:
	rm -f *.html *.pdf *.txt

