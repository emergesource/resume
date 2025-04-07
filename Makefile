all: resume.html resume.pdf resume.txt resume.css ColinCampbellResume.zip

resume.html: resume.md resume.css
	pandoc resume.md -o resume.html -f markdown+hard_line_breaks --standalone --css=resume.css --lua-filter=filter.lua

resume.pdf: resume.html
	wkhtmltopdf --dpi 96 --enable-local-file-access --no-footer-line --print-media-type --encoding "UTF-8" --no-background resume.html resume.pdf

resume.txt: resume.md
	pandoc --standalone --from markdown --to plain -o resume.txt resume.md

ColinCampbellResume.zip: resume.md resume.pdf resume.html resume.txt
	zip ColinCampbell.zip resume.md resume.pdf resume.html resume.txt

clean:
	rm -f *.html *.pdf *.txt *.zip

