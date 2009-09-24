From: Gregory Haskins <gregory.haskins@gmail.com>
Subject: Re: [PATCHv5 3/3] vhost_net: a kernel-level virtio server
Date: Thu, 24 Sep 2009 14:04:34 -0400
Message-ID: <4ABBB4B2.7050404__11075.6524526098$1253815857$gmane$org@gmail.com>
References: <4AAFACB5.9050808@redhat.com> <4AAFF437.7060100@gmail.com>
	<4AB0A070.1050400@redhat.com> <4AB0CFA5.6040104@gmail.com>
	<4AB0E2A2.3080409@redhat.com> <4AB0F1EF.5050102@gmail.com>
	<4AB10B67.2050108@redhat.com> <4AB13B09.5040308@gmail.com>
	<4AB151D7.10402@redhat.com> <4AB1A8FD.2010805@gmail.com>
	<20090921214312.GJ7182@ovro.caltech.edu>
	<4AB89C48.4020903@redhat.com> <4ABA3005.60905@gmail.com>
	<4ABA32AF.50602@redhat.com> <4ABA3A73.5090508@gmail.com>
	<4ABA61D1.80703@gmail.com> <4ABA78DC.7070604@redhat.com>
	<4ABB27B9.4050904@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3345396558063714035=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4ABB27B9.4050904@redhat.com>
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
To: Avi Kivity <avi@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, "Ira W. Snyder" <iws@ovro.caltech.edu>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, hpa@zytor.com, mingo@elte.hu, alacrityvm-devel@lists.sourceforge.net, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============3345396558063714035==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDE5D73E043EEC9B7281C9F0D"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDE5D73E043EEC9B7281C9F0D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Avi Kivity wrote:
> On 09/23/2009 10:37 PM, Avi Kivity wrote:
>>
>> Example: feature negotiation.  If it happens in userspace, it's easy
>> to limit what features we expose to the guest.  If it happens in the
>> kernel, we need to add an interface to let the kernel know which
>> features it should expose to the guest.  We also need to add an
>> interface to let userspace know which features were negotiated, if we
>> want to implement live migration.  Something fairly trivial bloats
>> rapidly.
>=20
> btw, we have this issue with kvm reporting cpuid bits to the guest.=20
> Instead of letting kvm talk directly to the hardware and the guest, kvm=

> gets the cpuid bits from the hardware, strips away features it doesn't
> support, exposes that to userspace, and expects userspace to program th=
e
> cpuid bits it wants to expose to the guest (which may be different than=

> what kvm exposed to userspace, and different from guest to guest).
>=20

This issue doesn't exist in the model I am referring to, as these are
all virtual-devices anyway.  See my last reply

-Greg


--------------enigDE5D73E043EEC9B7281C9F0D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.11 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkq7tLIACgkQP5K2CMvXmqFsrACfdMqWfjhbcD0aRdM1iWka41vU
lDkAmwWgvAoZNTrMhDRgJ/UlEl0f4Mpo
=5LFr
-----END PGP SIGNATURE-----

--------------enigDE5D73E043EEC9B7281C9F0D--

--===============3345396558063714035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============3345396558063714035==--
