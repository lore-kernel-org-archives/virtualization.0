From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 34/37] docs: fix locations of several documents that
	got moved
Date: Wed, 19 Oct 2016 12:34:42 +0200
Message-ID: <20161019103442.GD1461__10319.7624128827$1476873307$gmane$org@amd>
References: <cover.1476801354.git.mchehab@s-opensource.com>
	<28c1f5d3867174a7017e3f3d9e9e4ebb096ceed8.1476801354.git.mchehab@s-opensource.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5464703155517790997=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <28c1f5d3867174a7017e3f3d9e9e4ebb096ceed8.1476801354.git.mchehab@s-opensource.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Chris Metcalf <cmetcalf@ezchip.com>, Peter Loeffler <peter.loeffler@guruz.at>, Finn Thain <fthain@telegraphics.com.au>, Yaowei Bai <baiyaowei@cmss.chinamobile.com>, Jakub Wilk <jwilk@jwilk.net>, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Guenter Roeck <linux@roeck-us.net>, Petr Mladek <pmladek@suse.com>, Jean Delvare <jdelvare@suse.com>, linux-pm@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Karsten Keil <isdn@linux-pingi.de>, Jiri Kosina <jkosina@suse.cz>, "seokhoon.yoon" <iamyooon@gmail.com>, Li Zefan <lizefan@huawei.com>, Ryan Swan <ryan@ryanswan.com>, Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>, Mark
List-Id: virtualization@lists.linuxfoundation.org


--===============5464703155517790997==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Km1U/tdNT/EmXiR1"
Content-Disposition: inline


--Km1U/tdNT/EmXiR1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


> --- a/Documentation/ABI/testing/sysfs-kernel-slab
> +++ b/Documentation/ABI/testing/sysfs-kernel-slab
> @@ -347,7 +347,7 @@ Description:
>  		because of fragmentation, SLUB will retry with the minimum order
>  		possible depending on its characteristics.
>  		When debug_guardpage_minorder=3DN (N > 0) parameter is specified
> -		(see Documentation/kernel-parameters.txt), the minimum possible
> +		(see Documentation/admin-guide/kernel-parameters.rst), the minimum pos=
sible
>  		order is used and this sysfs entry can not be used to change
>  		the order at run time.

Dunno, but kernel-parameters.txt was already quite long... for a file
that is referenced quite often. Adding admin-guide/ into the path does
not really help.

Maybe admin-guide should go directly into Documentation/ , as that's
what our users are interested in?

Plus, I'm not sure how many developers will figure out that process/
is what describes kernel patch submission process. We have processes
in the kernel, after all...

Could we leave symlinks in place? People say "please follow
CodingStyle" when reviewing patches. Saying "please follow
process/conding-style.rst" ... somehow I don't think that's going to
happen.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Km1U/tdNT/EmXiR1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgHTEIACgkQMOfwapXb+vIOHQCffkWad/67/hPT1um2PTOxE/VH
cGcAn2DSAakkiqxfcuv58QhQpk7mN3cQ
=PJG5
-----END PGP SIGNATURE-----

--Km1U/tdNT/EmXiR1--

--===============5464703155517790997==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5464703155517790997==--
