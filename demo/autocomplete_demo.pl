:- module(autocomplete_demo, []).
/** <module> Demo page for autocomplete widget

*/
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/html_write)).


:- use_module(weblog(html_form/autocomplete)).

:- http_handler(root(autocomplete), autocomplete_demo_page, [id(autocomplete)]).

autocomplete_demo_page(_Request) :-
	reply_html_page(
	    title('Autocomplete Demo'),
	    \autocomplete_demo_body).

autocomplete_demo_body -->
	html([
	    h1('Autocomplete Demo'),
	    form([action='#'],[
		  p([
		     label([for=athingy], 'Normal: '),
		     \autocomplete(autocomplete_opts)]),
		  p([
		     label([for=accentthingy], 'Accents: '),
		     \autocomplete(accent_opts)])
		 ])
	]).

accent_opts(accents).
accent_opts(id(accentthingy)) :- !.
accent_opts(X) :- autocomplete_opts(X).

autocomplete_opts(id(athingy)).
autocomplete_opts(choice('ActionScript')).
autocomplete_opts(choice('AppleScript')).
autocomplete_opts(choice('Asp')).
autocomplete_opts(choice('BASIC')).
autocomplete_opts(choice('C')).
autocomplete_opts(choice('C++')).
autocomplete_opts(choice('Clojure')).
autocomplete_opts(choice('COBOL')).
autocomplete_opts(choice('ColdFusion')).
autocomplete_opts(choice('Erlang')).
autocomplete_opts(choice('Fortran')).
autocomplete_opts(choice('Groovy')).
autocomplete_opts(choice('Haskell')).
autocomplete_opts(choice('Java')).
autocomplete_opts(choice('JavaScript')).
autocomplete_opts(choice('Lisp')).
autocomplete_opts(choice('Perl')).
autocomplete_opts(choice('PHP')).
autocomplete_opts(choice('Python')).
autocomplete_opts(choice('Ruby')).
autocomplete_opts(choice('Scala')).
autocomplete_opts(choice('Scheme')).

