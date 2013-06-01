/**  <module>  Maps display

    A  provider neutral maps component.

     Weblog
     Licensed under LGPL
*/

:- module(map,
	  [ geo_map_direct//2,			% +Coordinates
	    geo_map//1
	  ]).

:- use_module(library(http/html_write)).
:- use_module(library(settings)).

:- use_module(weblog(info/maps/google/gmap)).
:- use_module(weblog(info/maps/leaflet/leafletmap)).


/*    direct removed

geo_map_direct(+Options, +Coordinates)// is det.

	HTML component that shows maps  with markers at the given
	Coordinates. Coordinates is a list. Each  coordinate is a
	term point(Lat,Long), optionally followed by decorations
	separated by + signs.

        Available Decorations:
	* popup(HTML)
	add a popup (small window with text that appears when clicking the
	location icon)
	* open
	The point must already have a popup. Makes the popup open by default.

	Options:
	* provider(ProviderName(ProviderSpecificOptionList))
	map can use one of several underlying map providers.
        Currently the choice is google or leaflet. The argument is a
	list of options which are only meaningful to
	that provider. At the moment there are no such options,
	and ProvideSpecificOptionList always binds to []
	* id(Map)  set the html id of the map div. Required if there are
	multiple maps on a page.

       @deprecated Use geo_map. Probably broken



:- predicate_options(geo_map_direct//2, 1, [
	provider(oneof([google(_), leaflet(_)])),
	id(text)
	       ]).

geo_map_direct(Options , Coordinates) -->
	{
	     option(provider(P), Options, google([])),
	     P =.. [google, ProviderArgs],!,
	     select(provider(_), Options, ProviderIndependentOptions),
	     append(ProviderArgs, ProviderIndependentOptions, PassOptions)
	},
	gmap(PassOptions, Coordinates).

geo_map_direct(Options , Coordinates) -->
	{
	     option(provider(P), Options),
	     P =.. [leaflet, ProviderArgs],!,
	     select(provider(_), Options, ProviderIndependentOptions),
	     append(ProviderArgs, ProviderIndependentOptions, PassOptions)
	},
	lmap(PassOptions, Coordinates).


geo_map_direct(Options , _Coordinates) -->
	{
		throw(error(domain_error(list, Options), context(geo_map_direct//2,
				   'invalid provider')))
	},
	[].

*/

:- meta_predicate geo_map(1, ?, ?).

/**    geo_map(+Generator:closure)// is det

Geomap (map of Earth) component.

Generator is an arity n term that corresponds to an arity n+1
predicate.

geo_map//1 will repeatedly query Generator for information and build up
the map.  The final argument may be

  * provider(-Name)  one of leaflet or google. default google

  * id(-ID) The map div id and javascript variable name will be set to
  this. default lmap or gmap depending on provider. must be valid
  javascript identifier as atom.

  * zoom(Zoom) The zoom level. Provider specific how this maps to a
  viewport. Default 14

  * center(Lat, Long) center map view here. defaults to average of
  points

  * point(-Lat, -Long) A marker will be placed at this point

  * icon_for(+point(Lat, Long), -IconName) icon to use for this point.
  default is provider default icon

  * popup_for(-HTML, +point(Lat, Long))termerized HTML to put in popup

Defining icon types means binding an icon/3 for each type, then binding
all the properties

  * icon(-Name, -ImageSource, -ShadowSource) Defines an icon type name.

Defining an icon requires that the following be defined for each icon
  type name:

  * * icon_size(+Name, X, Y) size of icon image

  * * shadow_size(+Name, X, Y) size of shadow image

  * * icon_anchor(+Name, X, Y) offset from UL of image to the point
  touching the spot on the map

  * * shadow_anchor(+Name, X, Y) offset
  from UL of shadow image to the point touching the spot on map

  * * popup_anchor(+Name, X, Y) offset from the point touching map to
  where the popup appears (so, eg, Y coord is often negative)

  @tbd add an example to docs

*/
geo_map(Generator) -->
	{
	     (	 call(Generator, provider(P))
	     ;
		 P = google
	     )
	},
	make_geo_map(P, Generator).

geo_map(_Generator) -->
	{
		throw(error(domain_error(list, 'provider'), context(geo_map//2,
				   'invalid provider')))
	},
	html([p('error - cannot make map')]).


make_geo_map(leaflet, Generator) -->
	lmap(Generator).
make_geo_map(google, Generator) -->
	gmap(Generator).