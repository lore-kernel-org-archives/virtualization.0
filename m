From: Laurent Vivier <Laurent.Vivier@bull.net>
Subject: Re: [kvm-devel] [PATCH 4/4] Modify KVM to update guest
	time	accounting.
Date: Mon, 20 Aug 2007 16:22:05 +0200
Message-ID: <46C9A38D.6090509__22352.1761400209$1187619827$gmane$org@bull.net>
References: <46C993A6.3060001@bull.net>
	<46C999C8.4080307@qumranet.com>	<46C99C05.90701@bull.net>
	<46C9A057.6060303@qumranet.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1783962937733519771=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46C9A057.6060303@qumranet.com>
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
--===============1783962937733519771==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4CA1BD24A2EA73E7114FD475"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4CA1BD24A2EA73E7114FD475
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Avi Kivity wrote:
> Laurent Vivier wrote:
>> Avi Kivity wrote:
>>  =20
>>> Laurent Vivier wrote:
>>>    =20
>>>> [PATCH 4/4] Modify KVM to update guest time accounting.
>>>>
>>>>  =20
>>>>      =20
>>>> Index: kvm/drivers/kvm/kvm.h
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> --- kvm.orig/drivers/kvm/kvm.h    2007-08-20 13:23:53.000000000 +020=
0
>>>> +++ kvm/drivers/kvm/kvm.h    2007-08-20 13:23:58.000000000 +0200
>>>> @@ -589,6 +589,17 @@ void kvm_mmu_unload(struct kvm_vcpu *vcp
>>>> =20
>>>>  int kvm_hypercall(struct kvm_vcpu *vcpu, struct kvm_run *run);
>>>> =20
>>>> +static inline void kvm_guest_enter(void)
>>>> +{
>>>> +#ifdef CONFIG_GUEST_ACCOUNTING
>>>> +    current->flags |=3D PF_VCPU;
>>>> +#endif
>>>>  =20
>>>>      =20
>>> Since you select GUEST_ACCOUNTING, the #ifdef is always true?
>>>    =20
>> It is just to avoid error if we compile kvm module outside of the kern=
el, with
>> kernel without support of guest accounting. Can be removed if you want=
=2E
>>
>>  =20
>=20
> Ah okay.  We take care of the external module in=20
> external-module-compat.h (in this case, we can #define PF_VCPU to 0 if =

> it is undefined).

OK

>>>> +}
>>>> +
>>>> +static inline void kvm_guest_exit(void)
>>>> +{
>>>>  =20
>>>>      =20
>>> Missing content?
>>>    =20
>> No, empty function.
>>
>> It is just to introduce "symmetry" in code, the VCPU code begins with
>> "kvm_guest_start()" and ends with "kvm_guest_exit()". And we have no o=
peration
>> to do in kvm_guest_exit() (the PF_VCPU is cleared by account_system_ti=
me()), so
>> "empty function", removed by the optimizer (I hope).
>>  =20
>=20
> But what if account_system_time() is not called (because we exited=20
> before the timer interrupt hit)?

account_system_time() is called by the scheduler on tick. If we clear PF_=
VCPU in
kvm_guest_exit(), the flag is always cleared when account_system_time() i=
s
executed, so we account "0", if we call account_system_time() directly fr=
om
kvm_guest_exit() we account "1", so we subtract 1 to system time, and we =
have
perhaps not used 1 tick in system: in my opinion this implies wrong resul=
ts.

Laurent
--=20
------------- Laurent.Vivier@bull.net  --------------
          "Software is hard" - Donald Knuth


--------------enig4CA1BD24A2EA73E7114FD475
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFGyaON9Kffa9pFVzwRAiZBAKCjIrPZ45pCUxY3DBByFsTxzjdE0wCfYUVe
m6tAzCpP/yiMXV1etLLs1EQ=
=IQR8
-----END PGP SIGNATURE-----

--------------enig4CA1BD24A2EA73E7114FD475--

--===============1783962937733519771==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============1783962937733519771==--
