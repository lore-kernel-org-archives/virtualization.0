From: Laurent Vivier <Laurent.Vivier@bull.net>
Subject: Re: [PATCH 0/4] Virtual Machine Time Accounting
Date: Mon, 20 Aug 2007 16:39:39 +0200
Message-ID: <46C9A7AB.1030003__14124.2152466022$1187620976$gmane$org@bull.net>
References: <46C99371.7070705@bull.net> <18121.39541.790665.686081@stoffel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8641982310065125699=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <18121.39541.790665.686081@stoffel.org>
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
To: John Stoffel <john@stoffel.org>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============8641982310065125699==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7C4697859CD76F6581AFFD24"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7C4697859CD76F6581AFFD24
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi John,

John Stoffel wrote:
>=20
> Laurent> The aim of these four patches is to introduce Virtual Machine
> Laurent> time accounting.
>=20
> So what does this buy us?  What increased functionality? =20
>=20

functionnalities:

- allow to measure time spent by a CPU in a virtual CPU.
- allow to display in /proc/state this value by CPU
- allow to display in /proc/<pid>/state this value by process
- allow KVM to use these 3 previous functionnalities

> Laurent> [PATCH 1/4] as recent CPUs introduce a third running state,
> Laurent> after "user" and "system", we need a new field, "guest", in
> Laurent> cpustat to store the time used by the CPU to run virtual
> Laurent> CPU. Modify /proc/stat to display this new field.
>=20
> What happens when you have multiple guests, is this state cummulative? =
=20

Yes, like system time and user time are.

> I've glanced over these patches and the #ifdefs are ugly..., esp since

#ifdefs are ugly, I agree... I can remove them.
But "#ifdef" allows to save space and time (and it is not a beauty show).=


> the overhead seems to exist even if you don't run any Guest CPUs.  Or
> whatever you're doing here.

Can you explain ?

> Please justify this patch more in terms of what it provides and why
> it's a good thing to have. =20

Well... it provides the time spent by CPUs in virtual CPUs.
It is usefull only if you run Virtual Machine on your host (like KVM, lgu=
est,
kqemu...) to know how many time your CPUs dedicate to virtual machine exe=
cution.
It's a good thing to have like user time and system time are good things =
to
have... do you use 'top' or 'time' sometime ?


Laurent
--=20
------------- Laurent.Vivier@bull.net  --------------
          "Software is hard" - Donald Knuth


--------------enig7C4697859CD76F6581AFFD24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFGyaeu9Kffa9pFVzwRAqydAKCSG136gnCONpBpMj0/gsaNEcAsJACgjSd4
HVdzGjIUyh0DKiOBnidtZjU=
=vVLG
-----END PGP SIGNATURE-----

--------------enig7C4697859CD76F6581AFFD24--

--===============8641982310065125699==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============8641982310065125699==--
