From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [RFC]: mm,power: introduce MADV_WIPEONSUSPEND
Date: Sat, 4 Jul 2020 00:34:53 +0200
Message-ID: <20200703223453.GA25072@amd>
References: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com>
 <20200703113026.GT18446@dhcp22.suse.cz>
 <CAG48ez2O2z4L=n57Omwy6s1sWQkdTkPKiikhbfdVhiyd_TGRRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAG48ez2O2z4L=n57Omwy6s1sWQkdTkPKiikhbfdVhiyd_TGRRw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Michal Hocko <mhocko-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Catangiu, Adrian Costin" <acatan-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org" <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>, "wad-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <wad-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "bonzini-mXXj517/zsQ@public.gmane.org" <bonzini-mXXj517/zsQ@public.gmane.org>, "Graf (AWS), Alexander" <graf-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2020-07-03 15:29:22, Jann Horn wrote:
> On Fri, Jul 3, 2020 at 1:30 PM Michal Hocko <mhocko-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > On Fri 03-07-20 10:34:09, Catangiu, Adrian Costin wrote:
> > > This patch adds logic to the kernel power code to zero out contents of
> > > all MADV_WIPEONSUSPEND VMAs present in the system during its transiti=
on
> > > to any suspend state equal or greater/deeper than Suspend-to-memory,
> > > known as S3.
> >
> > How does the application learn that its memory got wiped? S2disk is an
> > async operation and it can happen at any time during the task execution.
> > So how does the application work to prevent from corrupted state - e.g.
> > when suspended between two memory loads?
>=20
> You can do it seqlock-style, kind of - you reserve the first byte of
> the page or so as a "is this page initialized" marker, and after every
> read from the page, you do a compiler barrier and check whether that
> byte has been

That would also need smp cpu barriers, and guarantee that first byte
is always ... cleared first, and matching barriers in kernel space,
too, no?

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7/so0ACgkQMOfwapXb+vKdqwCdHbxhUjXRK2lyMx90kTRewpgH
sy8An1fvpOxBo4ol1ZYLjYYj+LThkGbw
=Ci2L
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
