From: Laurent Vivier <Laurent.Vivier@bull.net>
Subject: Re: [kvm-devel] [PATCH 0/2][KVM] guest time accounting
Date: Mon, 13 Aug 2007 10:13:28 +0200
Message-ID: <46C012A8.2040908__43325.1385730275$1186992925$gmane$org@bull.net>
References: <46BC8B39.6050202@bull.net> <46C00FC1.1070306@qumranet.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7976684398958984660=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46C00FC1.1070306@qumranet.com>
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
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============7976684398958984660==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5333B5AA9AC76FDCEB9D8930"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5333B5AA9AC76FDCEB9D8930
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Avi Kivity wrote:
> Laurent Vivier wrote:
>> The aim of these two patches is to measure the CPU time used by a virt=
ual
>> machine. All comments are welcome... I'm not sure it's the good way to=

>> do that.
>>
>> [PATCH 1/2] introduce a new field, "guest", in cpustat to store the
>> time used by
>> the CPU to run virtual CPU. Modify /proc/stat to display this new fiel=
d.
>>
>> [PATCH 2/2] modify account_system_time() to add cputime to
>> cpustat->guest if we
>> are running a VCPU. We add this cputime to  cpustat->user instead of
>> cpustat->system because this part of KVM code is in fact user code
>> although it
>> is executed in the kernel. We duplicate VCPU time between guest and
>> user to
>> allow an unmodified "top(1)" to display correct value. A modified
>> "top(1)" is
>> able to display good cpu user time and cpu guest time by subtracting
>> cpu guest
>> time from cpu user time.
>>  =20
>=20
> [copying Ingo and Rusty]
>=20
> The patches look good.  A couple of comments:
>=20
> - perhaps the new fields should be guarded by a #ifdef CONFIG_HYPERVISO=
R
> (selected by CONFIG_KVM)?  that way the (minor) additional overhead is
> only incurred if it can possibly be used.  I imagine that our canine
> cousin will want to use this as well.

There is also a CONFIG_VIRTUALIZATION and a CONFIG_VIRT_CPU_ACCOUNTING (f=
rom
s390 and powerpc) Which one to use ?

I'm wondering if we can have a more accurate accounting:

- For the moment we add all system time since the previous entering to th=
e VCPU
to the guest time (and I guess there is some real system time in it ???)

- Perhaps we can sum nanoseconds spent in the VCPU and add it to cpustat =
when
these ns are greater than 1 ms ? (I'm trying to make something in this wa=
y)

> - I think that there is per-task accounting of user time and system
> time; that should be extended as well.

it should be easy to do too...

Laurent
--=20
------------- Laurent.Vivier@bull.net  --------------
          "Software is hard" - Donald Knuth


--------------enig5333B5AA9AC76FDCEB9D8930
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFGwBKr9Kffa9pFVzwRAqJZAKCxIzVK7c92NSJ5eitJdobVjVosWwCgqBSv
5eIVLJXurjSqJvX2Gx38EIU=
=t4hl
-----END PGP SIGNATURE-----

--------------enig5333B5AA9AC76FDCEB9D8930--

--===============7976684398958984660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============7976684398958984660==--
