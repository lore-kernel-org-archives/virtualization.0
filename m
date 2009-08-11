From: Gregory Haskins <gregory.haskins@gmail.com>
Subject: Re: [PATCHv2 0/2] vhost: a kernel-level virtio server
Date: Tue, 11 Aug 2009 19:49:37 -0400
Message-ID: <4A820391.1090404__1820.03071900017$1250034709$gmane$org@gmail.com>
References: <20090811212743.GA26309@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1783051391357135529=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090811212743.GA26309@redhat.com>
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
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, hpa@zytor.com, mingo@elte.hu, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============1783051391357135529==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA223C963729B04B1689E60E6"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA223C963729B04B1689E60E6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Michael S. Tsirkin wrote:
> This implements vhost: a kernel-level backend for virtio,
> The main motivation for this work is to reduce virtualization
> overhead for virtio by removing system calls on data path,
> without guest changes. For virtio-net, this removes up to
> 4 system calls per packet: vm exit for kick, reentry for kick,
> iothread wakeup for packet, interrupt injection for packet.
>=20
> Some more detailed description attached to the patch itself.
>=20
> The patches are against 2.6.31-rc4.  I'd like them to go into linux-nex=
t
> and down the road 2.6.32 if possible.  Please comment.

I will add this series to my benchmark run in the next day or so.  Any
specific instructions on how to set it up and run?

Regards,
-Greg


--------------enigA223C963729B04B1689E60E6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.11 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkqCA5EACgkQP5K2CMvXmqHIvQCfYcoxCyKZvGg3C6EAOrpAEwIH
JmkAnRmvb/eJZIoYNF9JHmDPGvTAdvT/
=dirP
-----END PGP SIGNATURE-----

--------------enigA223C963729B04B1689E60E6--

--===============1783051391357135529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============1783051391357135529==--
