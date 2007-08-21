From: Laurent Vivier <Laurent.Vivier@bull.net>
Subject: Re: =?iso-8859-1?q?R=E9f=2E_=3A_Re=3A_=5BPATCH_0/4=5D_Virtual_Mac?=
 =?iso-8859-1?q?hine_Time_Accounting?=
Date: Tue, 21 Aug 2007 09:45:53 +0200
Message-ID: <46CA9831.4080309__17119.9367069223$1187682548$gmane$org@bull.net>
References: <OF945F7B1F.FF4B4672-ONC125733D.006266E7-C125733D.00626843@frec.bull.fr>
	<5d6222a80708201334q27fc6cbcr7ce6a9d7147437a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6813289615414869828=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5d6222a80708201334q27fc6cbcr7ce6a9d7147437a2@mail.gmail.com>
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
To: Glauber de Oliveira Costa <glommer@gmail.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, John Stoffel <john@stoffel.org>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============6813289615414869828==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4E28FF2019D37A8E3FBFDFA8"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4E28FF2019D37A8E3FBFDFA8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Glauber de Oliveira Costa wrote:
>> by doing this at kernel level, we can:
>> - measure exactly the guest time,
>> - move this part of system time to user time (as you think it should b=
e
>> user time),
>> - have consistency between system, user and guest time,
>> - report values in /proc/state and /proc/<pid>/state, at system wide l=
evel
>>
>> I'm not sure we can measure the guest time at the qemu user level.
>>
>> Perhaps Rusty can say what he thinks about this ?
>>
> Even if we cannot _now_, isn't that an easier, and safer change? (and
> I don't think we lose anything by design).

Could you explain ? How should I do this ?
I'm _sure_ it is not easier to do that at qemu level.

I don't like to patch kernel (it is the last thing I do to solve a proble=
m: I
know there is always at least one guy to not agree the patch :-P ) but in=
 this
case I think this is the best way to do that.

I think the virtualization notion should be introduced at the kernel leve=
l, at
least in the kernel statistics: it is generic, it can be used by other
virtualization tools. As I said, until know CPUs have got only two states=

reflected in statistics by "user time" and "system time". Since recently,=
 they
have introduced a third state, the virtual CPU, that, in my opinion, shou=
ld be
also reflected in the CPU statistics as the "guest time".

>=20
> Although I don't know KVM to a that deep level, I think it should be
> possible to keep the virtual cpus in different process (or threads),
> and take the accounting time from there. Perfectly possible to know
> the time we spent running (user time), and the time the hypervisor
> spent doing things on our behalf (system time).

But we have always user time accounted as system time. CPU stats are wron=
g if we
do not modify the kernel. Can you live with wrong statistics ? (yes, I th=
ink,
you can, but perhaps someone else not)

Laurent
--=20
------------- Laurent.Vivier@bull.net  --------------
          "Software is hard" - Donald Knuth


--------------enig4E28FF2019D37A8E3FBFDFA8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFGypg19Kffa9pFVzwRAh/rAJ4gRO+jIoCW3YunaSuWka1NIDRGTACfYcPO
ITXJR0IHlYzs5DNekLzHEaA=
=kv8o
-----END PGP SIGNATURE-----

--------------enig4E28FF2019D37A8E3FBFDFA8--

--===============6813289615414869828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============6813289615414869828==--
