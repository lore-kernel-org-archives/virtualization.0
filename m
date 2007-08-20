From: Laurent Vivier <Laurent.Vivier@bull.net>
Subject: Re: [kvm-devel] [PATCH/RFC 3/4]Introduce "account modifiers"
	mechanism
Date: Mon, 20 Aug 2007 09:30:14 +0200
Message-ID: <46C94306.8080300__16125.889393925$1187595136$gmane$org@bull.net>
References: <46C4719A.2060308@bull.net>
	<46C4720F.7030304@bull.net>		<46C4725A.4070607@bull.net>
	<46C4740F.2050701@bull.net>		<1187303955.6449.7.camel@localhost.localdomain>	<46C54FB8.7050504@bull.net>	<1187339450.6449.115.camel@localhost.localdomain>
	<46C56774.2030009@bull.net> <46C59AB1.6070505@qumranet.com>
	<46C5ACE8.2050004@bull.net> <46C7F362.80106@qumranet.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4469844729867279463=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46C7F362.80106@qumranet.com>
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============4469844729867279463==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7C737AE7EF4E858B3CFE62D6"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7C737AE7EF4E858B3CFE62D6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Avi Kivity wrote:
> Laurent Vivier wrote:
>> Avi Kivity wrote:
>> [...]
>> =20
>>> The normal user/system accounting has the same issue, no?  Whereever =
we
>>> happen to land (kernel or user) gets the whole tick.
>>>
>>> So I think it is okay to have the same limitation for guest time.
>>>
>>>    =20
>>
>> So this is how it looks like.
>> PATCH 1 and 2 are always a prerequisite.
>>
>>  =20
>=20
>> +    tmp =3D cputime_to_cputime64(cputime);
>> +    if (p->flags & PF_VCPU) {
>> +        p->utime =3D cputime_add(p->utime, cputime);
>> +        p->gtime =3D cputime_add(p->gtime, cputime);
>> +
>> +        cpustat->guest =3D cputime64_add(cpustat->guest, tmp);
>> +        cpustat->user =3D cputime64_add(cpustat->user, tmp);
>> +
>> +        p->flags &=3D ~PF_VCPU;
>> +
>> +        return;
>> +    }
>> +
>=20
> Where did CONFIG_GUEST_ACCOUNTING go?
>=20

Lost in the sea ...

Actually, I thought this modification is not enough expensive (in time an=
d
space) to justify a CONFIG_*. But if you think so I can add this in init/=
Kconfig.

Laurent
--=20
------------- Laurent.Vivier@bull.net  --------------
          "Software is hard" - Donald Knuth


--------------enig7C737AE7EF4E858B3CFE62D6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFGyUMJ9Kffa9pFVzwRAkNfAJ9N5NHDYRg6q0uL28SuPT9ifCq8GQCfZOAM
QuslB/f41g7GPG+L1cPgSqQ=
=sAZD
-----END PGP SIGNATURE-----

--------------enig7C737AE7EF4E858B3CFE62D6--

--===============4469844729867279463==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============4469844729867279463==--
