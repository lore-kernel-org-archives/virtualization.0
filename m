From: Laurent Vivier <Laurent.Vivier@bull.net>
Subject: Re: [kvm-devel] [PATCH 4/4] Modify KVM to update guest time
	accounting.
Date: Mon, 20 Aug 2007 15:49:57 +0200
Message-ID: <46C99C05.90701__26705.2428368062$1187618864$gmane$org@bull.net>
References: <46C993A6.3060001@bull.net> <46C999C8.4080307@qumranet.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2427840772798960077=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46C999C8.4080307@qumranet.com>
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
--===============2427840772798960077==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig48ADE0736957CFF903179F09"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig48ADE0736957CFF903179F09
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Avi Kivity wrote:
> Laurent Vivier wrote:
>> [PATCH 4/4] Modify KVM to update guest time accounting.
>>
>>  =20
>=20
>> Index: kvm/drivers/kvm/kvm.h
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- kvm.orig/drivers/kvm/kvm.h    2007-08-20 13:23:53.000000000 +0200
>> +++ kvm/drivers/kvm/kvm.h    2007-08-20 13:23:58.000000000 +0200
>> @@ -589,6 +589,17 @@ void kvm_mmu_unload(struct kvm_vcpu *vcp
>> =20
>>  int kvm_hypercall(struct kvm_vcpu *vcpu, struct kvm_run *run);
>> =20
>> +static inline void kvm_guest_enter(void)
>> +{
>> +#ifdef CONFIG_GUEST_ACCOUNTING
>> +    current->flags |=3D PF_VCPU;
>> +#endif
>>  =20
>=20
> Since you select GUEST_ACCOUNTING, the #ifdef is always true?

It is just to avoid error if we compile kvm module outside of the kernel,=
 with
kernel without support of guest accounting. Can be removed if you want.

>> +}
>> +
>> +static inline void kvm_guest_exit(void)
>> +{
>>  =20
>=20
> Missing content?

No, empty function.

It is just to introduce "symmetry" in code, the VCPU code begins with
"kvm_guest_start()" and ends with "kvm_guest_exit()". And we have no oper=
ation
to do in kvm_guest_exit() (the PF_VCPU is cleared by account_system_time(=
)), so
"empty function", removed by the optimizer (I hope).

Laurent
--=20
------------- Laurent.Vivier@bull.net  --------------
          "Software is hard" - Donald Knuth


--------------enig48ADE0736957CFF903179F09
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFGyZwJ9Kffa9pFVzwRAmaUAJ9vgVP8WlZHk6vrSM3A+b+kA9/8JQCgq2a9
KmWrAEpAeNpiBwP+ItVrY9I=
=/vf8
-----END PGP SIGNATURE-----

--------------enig48ADE0736957CFF903179F09--

--===============2427840772798960077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============2427840772798960077==--
