all: resume.html resume.pdf resume.txt resume.css ColinCampbell.zip

resume.html: resume.md resume.css
	pandoc --standalone --lua-filter=filter.lua -c resume.css --from markdown --to html -o resume.html resume.md 

resume.pdf: resume.html
	wkhtmltopdf --dpi 96 --enable-local-file-access --no-footer-line --print-media-type --encoding "UTF-8" --no-background resume.html resume.pdf

resume.txt: resume.md
	pandoc --standalone --from markdown --to plain -o resume.txt resume.md

ColinCampbell.zip: resume.md resume.pdf resume.html resume.txt
	zip ColinCampbell.zip resume.md resume.pdf resume.html resume.txt

clean:
	rm -f *.html *.pdf *.txt

