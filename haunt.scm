(use-modules (haunt site)
             (haunt builder blog)
             (haunt builder assets)
             (web uri))

;; Edit this for your slides. Change the themes in haunt-reveal for now.
(define %slides
  `((section
     (h2 "Using Haunt with reveal.js"))

    ;; Slide 1.
    (section
     (a (img (@ (src "https://dthompson.us/images/haunt/logo.png"))))
     (p (a (@ (href "https://dthompson.us/projects/haunt.html"))
	   "Haunt")
	" is a static website builder written in Guile Scheme."))

    ;; Slide 2.
    (section
     (p "This is an example Haunt configuration:")
     (pre (code (@ (class "scheme") (data-trim "") (data-line-numbers "|1-5|7-16"))
"(use-modules (haunt site)
	     (haunt reader)
	     (haunt builder blog)
	     (haunt builder atom)
	     (haunt builder assets))

(site #:title \"Built with Guile\"
      #:domain \"example.com\"
      #:default-metadata
      '((author . \"Eva Luator\")
	(email  . \"eva@example.com\"))
      #:readers (list sxml-reader html-reader)
      #:builders (list (blog)
		       (atom-feed)
		       (atom-feeds-by-tag)
		       (static-directory \"images\")))")))

    ;; Slide 3.
    (section
     (a (img (@ (src "https://static.slid.es/reveal/logo-v1/reveal-white-text.svg"))))
     (p "reveal.js is a javascript library for HTML presentations")
     (p (@ (class fragment)) "Presentations are written in HTML or in languages that generate HTML (like this!)"))

    ;; Slide 4.
    (section
     (p "These slides are only to showcase the code. Have fun."))
    ))

(define %init-reveal
  '((script (@ (src "/haunt/initialize-reveal.js")))))

(define (script-local relpath)
  `((script (@ (src ,relpath)))))

(define (stylesheet-local relpath)
  `(link (@ (rel "stylesheet")
            (href ,relpath))))

(define haunt-revealed
  (theme #:name "Haunt-revealed"
         #:layout
         (lambda (site title body)
           `((doctype "html")
             (head
              (meta (@ (charset "utf-8")))
              (title ,(string-append title " — " (site-title site)))
	      ,(stylesheet-local "/dist/reset.css")
	      ,(stylesheet-local "/dist/reveal.css")
	      ;; Main theme.  Change this if you want.
	      ,(stylesheet-local "/dist/theme/black.css")
	      ;; Source code highlight. Change this if you want.
	      ,(stylesheet-local "/plugin/highlight/monokai.css"))
	     (body
	      (div (@ (class "reveal"))
		   (div (@ (class "slides"))
			,%slides))
	      ,(script-local "/dist/reveal.js")
	      ,(script-local "/plugin/zoom/zoom.js")
	      ,(script-local "/plugin/notes/notes.js")
	      ,(script-local "/plugin/search/search.js")
	      ,(script-local "/plugin/markdown/markdown.js")
	      ,(script-local "/plugin/highlight/highlight.js")
	      ,%init-reveal
	      )))))

(site #:title "The Author"
      #:domain "example.org"
      #:default-metadata
      '((author . "The Author")
        (email  . "author@example.org"))
      #:builders (list (blog #:theme haunt-revealed)
		       (static-directory "css")
		       (static-directory "dist")
		       (static-directory "haunt")
		       (static-directory "js")
		       (static-directory "plugin")))
