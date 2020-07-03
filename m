From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [RFC]: mm,power: introduce MADV_WIPEONSUSPEND
Date: Sat, 4 Jul 2020 00:44:11 +0200
Message-ID: <20200703224411.GC25072@amd>
References: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <B7793B7A-3660-4769-9B9A-FFCF250728BB-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Catangiu, Adrian Costin" <acatan-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>
Cc: "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "mhocko-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <mhocko-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org" <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>, "wad-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <wad-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "bonzini-mXXj517/zsQ@public.gmane.org" <bonzini-mXXj517/zsQ@public.gmane.org>, "Graf (AWS), Alexander" <graf-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org>, "MacCarthaigh, Colm" <colmmacc-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Cryptographic libraries carry pseudo random number generators to
> quickly provide randomness when needed. If such a random pool gets
> cloned, secrets may get revealed, as the same random number may get
> used multiple times. For fork, this was fixed using the WIPEONFORK
> madvise flag [1].

> Unfortunately, the same problem surfaces when a virtual machine gets
> cloned. The existing flag does not help there. This patch introduces a
> new flag to automatically clear memory contents on VM suspend/resume,
> which will allow random number generators to reseed when virtual
> machines get cloned.

Umm. If this is real problem, should kernel provide such rng in the
vsdo page using vsyscalls? Kernel can have special interface to its
vsyscalls, but we may not want to offer this functionality to rest of
userland...

>  - Provides a simple mechanism to avoid RAM exfiltration during
>    traditional sleep/hibernate on a laptop or desktop when memory,
>    and thus secrets, are vulnerable to offline tampering or
>    inspection.

This second use has nothing to do with RNGs, right?

And I don't think we should do this in kernel.

It is userspace that initiates the suspend transition. Userspace
should lock the screen _before_ starting it, for example. Userspace
should also get rid of any secrets, first...

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7/tLsACgkQMOfwapXb+vKLKwCeJYf9jINarjpOcvkWGapwUdIa
uagAnjDEdee4JzvzUfcuKH+WBY/IbjHX
=2u6r
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--
