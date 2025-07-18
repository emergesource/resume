all: resume.html resume.pdf resume.txt resume.css ColinCampbellResume.zip

resume.html: resume.md resume.css
	pandoc --standalone  -c resume.css --from markdown --to html -o resume.html resume.md 

resume.pdf: resume.html
	wkhtmltopdf --dpi 96 --enable-local-file-access --no-footer-line --print-media-type --encoding "UTF-8" --no-background resume.html resume.pdf

resume.txt: resume.md
	pandoc --standalone --from markdown --to plain -o resume.txt resume.md

ColinCampbellResume.zip: resume.md resume.pdf resume.html resume.txt
	cp resume.md ColinCampbellResume.md
	cp resume.pdf ColinCampbellResume.pdf
	cp resume.html ColinCampbellResume.html
	cp resume.txt ColinCampbellResume.txt
	zip ColinCampbellResume.zip ColinCampbellResume.md ColinCampbellResume.pdf ColinCampbellResume.html ColinCampbellResume.txt
	rm ColinCampbellResume.md ColinCampbellResume.pdf ColinCampbellResume.html ColinCampbellResume.txt

clean:
	rm -f *.html *.pdf *.txt *.zip

