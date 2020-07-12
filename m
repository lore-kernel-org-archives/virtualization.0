From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [RFC]: mm,power: introduce MADV_WIPEONSUSPEND
Date: Sun, 12 Jul 2020 09:22:28 +0200
Message-ID: <20200712072228.GB4721@duo.ucw.cz>
References: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com>
 <20200703113026.GT18446@dhcp22.suse.cz>
 <CAG48ez2O2z4L=n57Omwy6s1sWQkdTkPKiikhbfdVhiyd_TGRRw@mail.gmail.com>
 <20200707073823.GA3820@dhcp22.suse.cz>
 <20200707080726.GA32357@amd>
 <20200707085847.GA5913@dhcp22.suse.cz>
 <20200707163758.GA1947@amd>
 <E6B41570-E206-4458-921B-465B9EF74949@amazon.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E6B41570-E206-4458-921B-465B9EF74949-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Colm MacCarthaigh <colmmacc-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>
Cc: Michal Hocko <mhocko-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "Catangiu, Adrian Costin" <acatan-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org, wad-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bonzini-mXXj517/zsQ@public.gmane.org, "Graf (AWS), Alexander" <graf-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org>, "Singh, Balbir" <sblbir-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>, "Sandu, Andrei" <sandreim-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>, "Brooker, Marc" <mbrooker-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>, "Weiss, Radu" <raduweis-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>, "Manwaring, Derek" <derekmn-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2020-07-07 12:00:41, Colm MacCarthaigh wrote:
>=20
>=20
> On 7 Jul 2020, at 9:37, Pavel Machek wrote:
> > Please go through the thread and try to understand it.
> >=20
> > You'd need syscalls per get_randomness(), not per migration.
>=20
> I think one check per get_randomness() is sufficient, though putting it at
> the end of the critical section rather than the beginning helps.

Yeah, well, one syscall is still enough to make it useless.

Best regards,
								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXwq6NAAKCRAw5/Bqldv6
8uuCAJ9LrEaAGhXBNhJwHuvAzGcY9PEKpACgo6pz2brnyUlPHZvcCAbvR8lQRLk=
=jD89
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
