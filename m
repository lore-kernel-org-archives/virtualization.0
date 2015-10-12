From: Eric Blake <eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] kvm/x86: Hyper-V kvm exit
Date: Mon, 12 Oct 2015 07:44:28 -0600
Message-ID: <561BB93C.9050409@redhat.com>
References: <1444397988-20167-1-git-send-email-den@openvz.org>
	<1444397988-20167-3-git-send-email-den@openvz.org>
	<561BB8D2.60402@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5552721503216593530=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <561BB8D2.60402@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Denis V. Lunev" <den@openvz.org>
Cc: Gleb Natapov <gleb@kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, rkagan@virtuozzo.com, Andrey Smetanin <asmetanin@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============5552721503216593530==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ogo1k5JlpCGAGQtA36m2Dp7Cu4SbtVKcC"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ogo1k5JlpCGAGQtA36m2Dp7Cu4SbtVKcC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/12/2015 07:42 AM, Eric Blake wrote:
> On 10/09/2015 07:39 AM, Denis V. Lunev wrote:
>> From: Andrey Smetanin <asmetanin@virtuozzo.com>
>>
>> A new vcpu exit is introduced to notify the userspace of the
>> changes in Hyper-V synic configuraion triggered by guest writing to th=
e
>=20
> s/configuraion/configuration/
> Is 'synic' intended?  Is it short for something (if so, spelling it out=

> may help)?

Ah, I see it now from patch 1/2: SYNthetic Interrupt Controller.

>> +related with Hyper-V emulation. Currently used to synchronize modifie=
d
>> +Hyper-V synic state with userspace.
>=20
> Again, is 'synic' intended?  Hmm, I see it throughout the patch, so it
> looks intentional, but I keep trying to read it as a typo for 'sync'.

Don't know if SynIC would make it any easier to read?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Ogo1k5JlpCGAGQtA36m2Dp7Cu4SbtVKcC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJWG7k8AAoJEKeha0olJ0Nqj9MH/RT82h1XZWtdc8PjwdtMjlWi
pR9L5H+fAvwXnQoZSNVKyF3MR62bQv5dqG+O6xON9TR0ZsGAgEFEpfmkDsk3mtNh
hF72niHKatca1Ozle5TheiYHQas6I+u8iH+LKlLsdhPJ2v/1zbPuZWCEKgGHUhcA
a6LKg61TFH7AqYBdTKcg/5D3PAwTkgHi7gnirkD26CTwUas/kx0LbTFXlJtbLx6s
6Qvy9Ew+ll5OLufOT7pBvqUattCxr98vXH4FINsExKfF4uztLSk7Le/V6RA/3BjJ
ZKWUBl56ge7msjyvdQLORwP+TozYZrear3njWvsfmLCDJ8Ban73Sa5KXIc50Gu0=
=Xfuu
-----END PGP SIGNATURE-----

--Ogo1k5JlpCGAGQtA36m2Dp7Cu4SbtVKcC--

--===============5552721503216593530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5552721503216593530==--
