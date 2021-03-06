:- module(wl_windows_demo, []).
/** <module> Demo page for windowing

*/
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/html_write)).

:- use_module(weblog(formatting/wl_windows)).


:- http_handler(root(wl_windows), windows_handler, [id(wl_windows)]).

windows_handler(_Request) :-
	reply_html_page(
	    title('Windows Demo'),
	    [
	       h1('Windows Demo'),
	       h2('Clickable Popup'),
	       \popup(click_popup_options,
		     p('click me'),
		     div(p('some random information'))),

	       h2('Rollover Popup'),
	       \popup(rollover_popup_options,
		     p('roll over me'),
		     div(p('other random info'))),
	       h2('Footnote Popup'),
		p(['This is a footnote.',
	            \popup(footnote_options,
		       '3',
		       'some misc info'),
		   'It seems academic.']),
		p(['High density of footnotes was reported by Ogborn',
		   \popup(footnote_options, '4',
			  a(href('http://www.google.com'),
		  'Effect of footnote density on academic advancement, Jrnl Improb. Results 7-5')), ' to have a positive effect on academic tenure']),
		p(['Foonblat shows that laying down produces superior rest in sleep study subjects compared to standing position',
		   \popup(footnote_options, '5',
			  a(href('http://www.google.com'),
		  'Study of prone vs standing position on efficacy of sleep, Jrnl Irreprod. Results 17-3'))]),
		p(['Feendly, conversely argues that erect posture is better',
		   \popup(footnote_options, '6',
			  a(href('http://www.google.com'),
		  'A longitudinal, transgenerational, intercultural, bigendered, long winded investigation of many sleeping postures, including vertical bipedal stance, supine, and reverse Trendelenburg, and other postures on occurance of REM sleep in a sleep laboratory setting, Feendly, James, PhD, LoveDoc, Lawrence, PhD, HallOvit, Gustfor, MD, et al, Jrnl Irreprod. Results 18-13'))])

	    ]).

click_popup_options(open_on(click)).

rollover_popup_options(open_time(100)).
rollover_popup_options(close_time(500)).
rollover_popup_options(close_method(bounce)).
footnote_options(footnote).



