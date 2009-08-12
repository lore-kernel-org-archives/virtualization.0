From: Gregory Haskins <gregory.haskins@gmail.com>
Subject: Re: [PATCH 0/3] qemu-kvm: vhost net support
Date: Wed, 12 Aug 2009 16:27:44 -0400
Message-ID: <4A8325C0.7060001__19585.9152976938$1250109060$gmane$org@gmail.com>
References: <20090810192304.GA16781@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5980405439314225649=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090810192304.GA16781@redhat.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: avi@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============5980405439314225649==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig04D3B631DE66BB6847FC53C7"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig04D3B631DE66BB6847FC53C7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Michael S. Tsirkin wrote:
> This adds support for vhost-net virtio kernel backend.
>=20
> This is RFC, but works without issues for me.
>=20
> Still needs to be split up, tested and benchmarked properly,
> but posting it here in case people want to test drive
> the kernel bits I posted.

This has a large degree of rejects against qemu-kvm.git/master.  What
tree does this apply to?

-Greg


--------------enig04D3B631DE66BB6847FC53C7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.11 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkqDJcAACgkQP5K2CMvXmqHecgCcCM8bW3ZyaVV4KICO6aihdnhn
jtAAn27DYLBwBwnvSR4//wZ5WfW8xZZE
=PDoY
-----END PGP SIGNATURE-----

--------------enig04D3B631DE66BB6847FC53C7--

--===============5980405439314225649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============5980405439314225649==--
