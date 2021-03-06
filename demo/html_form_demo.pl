:- module(html_form_demo, []).

:- use_module(library(http/http_dispatch)).
:- use_module(library(http/html_write)).
:- use_module(weblog(html_form/html_form)).
:- use_module(weblog(html_form/radio)).

:- http_handler(root(testform) , test_form_page_handler, [id(testform)]).

test_form_page_handler(Request) :-
	validated_form(
	    reply_html_page(
		[title('Form Page')],
		\(html_form_demo:test_form_content(Request))),
	    reply_html_page(
		[title('Thanks')],
		\(html_form_demo:test_landing_page_content(Request)))).

test_form_content(_Request) -->
	{
	 debug(html_form, 'in test_form_content~n', [])
	},
     html([
      h1('Validated Form'),
      p('This is the usual sort of validated form. You must enter a name of length >3 and an age over 14 for it to be accepted'),
      style(['.oops {    color: #F00; } ']),
      form([action='/testform', method='POST'], [
	       p([
	          label([for=name],'Name:'),
	          \error_message([for=name], p([class=oops],
					  'You need to type your name in here')),
	          \form_field(Request, length_input_minmax(3, '>'),
			 input([name=name, type=textarea], []))]),
	       p([
	          label([for=age], 'Age:'),
	          \error_message([for=age], p([class=oops], 'Age under 14 or not a number')),
	          \form_field(Request, numeric_minmax(14, '>'),
			 input([name=age, type=textarea], []))]),
	       p([
	           input([type=submit, name=submit, value='Wholy smokes'], [])
	       ])])]).

test_landing_page_content(_Request) -->
	html([
	    p('Well, that worked')
	     ]).

:- http_handler(root(testcontrols) ,
		test_controls_page_handler,
		[id(testcontrols)]).

test_controls_page_handler(_Request) :-
	reply_html_page(
	    [title('Controls')],
	    [
	       h1('Some Controls'),
	       p('radio buttons using images'),
	       form([action='/testcontrols'], [
		   \image_radio_set(radio_info),
		   input([type=submit, name=submitt, value=submitt], [])
					      ])

	    ]).

radio_info(set_name(demoset)).
radio_info(id(reddot)).
radio_info(id(greendot)).
radio_info(id(bluedot)).
radio_info(image(reddot, '/icons/reddot.png')).
radio_info(selected_image(reddot, '/icons/reddotsel.png')).
radio_info(image(greendot, '/icons/greendot.png')).
radio_info(selected_image(greendot, '/icons/greendotsel.png')).
radio_info(image(bluedot, '/icons/bluedot.png')).
radio_info(selected_image(bluedot, '/icons/bluedotsel.png')).
radio_info(default(reddot)).
