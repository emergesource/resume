all: resume.html resume.pdf resume.txt resume.css

resume.html: resume.md resume.css
	pandoc --standalone -c resume.css --from markdown --to html -o resume.html resume.md

resume.pdf: resume.html
	wkhtmltopdf --enable-local-file-access resume.html resume.pdf

resume.txt: resume.md
	pandoc --standalone --from markdown --to plain -o resume.txt resume.md

clean:
	rm -f *.html *.pdf *.txt

