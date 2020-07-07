From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [RFC]: mm,power: introduce MADV_WIPEONSUSPEND
Date: Tue, 7 Jul 2020 18:37:58 +0200
Message-ID: <20200707163758.GA1947@amd>
References: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com>
 <20200703113026.GT18446@dhcp22.suse.cz>
 <CAG48ez2O2z4L=n57Omwy6s1sWQkdTkPKiikhbfdVhiyd_TGRRw@mail.gmail.com>
 <20200707073823.GA3820@dhcp22.suse.cz>
 <20200707080726.GA32357@amd>
 <20200707085847.GA5913@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200707085847.GA5913-2MMpYkNvuYDjFM9bn6wA6Q@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Hocko <mhocko-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "Catangiu, Adrian Costin" <acatan-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org" <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>, "wad-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <wad-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "bonzini-mXXj517/zsQ@public.gmane.org" <bonzini-mXXj517/zsQ@public.gmane.org>, "Graf (AWS), Alexander" <graf-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > You can do it seqlock-style, kind of - you reserve the first byte of
> > > > the page or so as a "is this page initialized" marker, and after ev=
ery
> > > > read from the page, you do a compiler barrier and check whether that
> > > > byte has been cleared.
> > >=20
> > > This is certainly possible yet wery awkwar interface to use IMHO.
> > > MADV_EXTERNALY_VOLATILE would express the actual semantic much better.
> > > I might not still understand the expected usecase but if the target
> > > application has to be changed anyway then why not simply use a
> > > transparent and proper signaling mechanism like poll on a fd. That
> >=20
> > The goal is to have cryprographically-safe get_random_number() with 0
> > syscalls.
> >=20
> > You'd need to do:
> >=20
> >    if (!poll(did_i_migrate)) {
> >          use_prng_seed();
> > 	 if (poll(did_i_migrate)) {
> > 	       /* oops_they_migrated_me_in_middle_of_computation,
> >  	          lets_redo_it() */
> >  		  goto retry:
> > 	 }
> >    }
> >=20
> > Which means two syscalls..
>=20
> Is this a real problem though? Do we have any actual numbers? E.g. how
> often does the migration happen so that 2 syscalls would be visible in
> actual workloads?

Please go through the thread and try to understand it.

You'd need syscalls per get_randomness(), not per migration.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8EpOUACgkQMOfwapXb+vIrGQCfa8t3eRPUQJN4sgdBPhRqIXIN
Md0AoL/VSUKG0fqXzutn3A1vlMnmAH5A
=B3/F
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
