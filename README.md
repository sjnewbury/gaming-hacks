# gaming-hacks
Various games with fixes and improvements

Many ebuilds in this overlay use the deprecated/banned games.eclass, including
several which were purged from the portage tree as a result.  This includes
quake3, and the ut2004 mods.

I will gradully convert them to use remove the dependency on games.eclass but
wanted to preserve them in working state.


# Update 20220210
I've made games-r.eclass and games-mods-r1.eclass which is compatible with
EAPI>5 *only*.  I'll maintain them in this Overlay.  This makes it much
easiier to maintain the ut2004 and quake3 mods and continue utilising
a "games" partition.

It does trigger a QA warning when using "/usr/games".

fs2_open is working, yay!


TODO:

~~Convert games.eclass ebuilds~~

~~Create new mod eclass' for quake3 and ut2004 etc~~

Run repoman and fix QA issues
