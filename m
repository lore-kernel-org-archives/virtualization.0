From: Laurent Vivier <Laurent.Vivier@bull.net>
Subject: Re: [kvm-devel] [PATCH 2/4] Introduce a new fields "gtime"
 and	"cgtime" in task_struct and signal_struct
Date: Mon, 20 Aug 2007 16:17:06 +0200
Message-ID: <46C9A262.2030305__32183.0101464458$1187619529$gmane$org@bull.net>
References: <46C99392.3050205@bull.net>
	<200708201552.57617.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7021204767014112366=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200708201552.57617.borntraeger@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kvm-devel@lists.sourceforge.net, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============7021204767014112366==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB7C4CEF00D92095640E9C9A9"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB7C4CEF00D92095640E9C9A9
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Christian Borntraeger wrote:
> Am Montag, 20. August 2007 schrieb Laurent Vivier:
>> Index: kvm/fs/proc/array.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- kvm.orig/fs/proc/array.c    2007-08-20 11:11:30.000000000 +0200
>> +++ kvm/fs/proc/array.c 2007-08-20 13:04:03.000000000 +0200
>=20
> Just a heads up, this patch collides with this fix in mm:
> http://marc.info/?l=3Dlinux-mm-commits&m=3D118737949222362&w=3D2
>=20
> If Ingo accepts this fix, your patch should be adopted in array.c to us=
e=20
> cputime_t for gtime as well. Lets see what Ingo thinks.

Thank you for the comment. No problem for me to rewrite the patch accordi=
ng the
fix in the mm.

Laurent
--=20
------------- Laurent.Vivier@bull.net  --------------
          "Software is hard" - Donald Knuth


--------------enigB7C4CEF00D92095640E9C9A9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFGyaJl9Kffa9pFVzwRApCjAKCe61UmAJONVpmruC2jQ0iSfzAQDACgv7h3
hREWrJDr8F+ByyK8/OVNiHo=
=MOyq
-----END PGP SIGNATURE-----

--------------enigB7C4CEF00D92095640E9C9A9--

--===============7021204767014112366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============7021204767014112366==--
