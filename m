From: Jan Kiszka <jan.kiszka@web.de>
Subject: Re: Using virtio for inter-VM communication
Date: Tue, 17 Jun 2014 07:57:34 +0200
Message-ID: <539FD8CE.2060203__6826.3376866982$1402984685$gmane$org@web.de>
References: <20140610184818.2e490419@nbschild1>	<87r42uq2v8.fsf@rustcorp.com.au>	<53993B7B.7010404@siemens.com>	<87fvj9prdi.fsf@rustcorp.com.au>	<539A98D3.3070601@siemens.com>
	<539ABA41.3070701@redhat.com> <539D3B35.2010706@web.de>
	<539FD124.6050007@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3821470519871055791=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <539FD124.6050007@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>, Henning Schild <henning.schild@siemens.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
Cc: Jailhouse <jailhouse-dev@googlegroups.com>
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============3821470519871055791==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="A817odVqqmbK587n7bbQNXJQ7ctjh1l0H"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--A817odVqqmbK587n7bbQNXJQ7ctjh1l0H
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2014-06-17 07:24, Paolo Bonzini wrote:
> Il 15/06/2014 08:20, Jan Kiszka ha scritto:
>>> > I think implementing Xen hypercalls in jailhouse for grant table an=
d
>>> > event channels would actually make a lot of sense.  The Xen
>>> > implementation is 2.5kLOC and I think it should be possible to comp=
act
>>> > it noticeably, especially if you limit yourself to 64-bit guests.
>> At least the grant table model seems unsuited for Jailhouse. It allows=
 a
>> guest to influence the mapping of another guest during runtime. This w=
e
>> want (or even have) to avoid in Jailhouse.
>=20
> IIRC implementing the grant table hypercalls with copies is inefficient=

> but valid.

Back to #1: This is what Rusty is suggesting for virtio. Nothing to win
with grant tables then. And if we really have to copy, I would prefer to
use a standard.

I guess we need to play with prototypes to assess feasibility and impact
on existing code.

Jan



--A817odVqqmbK587n7bbQNXJQ7ctjh1l0H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOf2NQACgkQitSsb3rl5xQSywCcC4X+1ALJQ7pBL5onu/3ADVyw
5+kAnR/VbN7Rit0t0D9FX1o/FxnG0Co2
=YbQW
-----END PGP SIGNATURE-----

--A817odVqqmbK587n7bbQNXJQ7ctjh1l0H--

--===============3821470519871055791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3821470519871055791==--
