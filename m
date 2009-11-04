From: Gregory Haskins <gregory.haskins@gmail.com>
Subject: Re: [PATCHv8 0/3] vhost: a kernel-level virtio server
Date: Wed, 04 Nov 2009 14:15:42 -0500
Message-ID: <4AF1D2DE.10705__48883.3499061458$1257362189$gmane$org@gmail.com>
References: <20091104155234.GA32673@redhat.com> <4AF1A587.8000509@gmail.com>
	<20091104162339.GA311@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4021650794434440611=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20091104162339.GA311@redhat.com>
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
Cc: Eric Dumazet <eric.dumazet@gmail.com>, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, hpa@zytor.com, Daniel Walker <dwalker@fifo99.com>, mingo@elte.hu, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============4021650794434440611==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE41C0DE2FBFBF3E83786E82A"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE41C0DE2FBFBF3E83786E82A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Michael S. Tsirkin wrote:
> On Wed, Nov 04, 2009 at 11:02:15AM -0500, Gregory Haskins wrote:
>> Michael S. Tsirkin wrote:
>>> Ok, I think I've addressed all comments so far here.
>>> Rusty, I'd like this to go into linux-next, through your tree, and
>>> hopefully 2.6.33.  What do you think?
>> I think the benchmark data is a prerequisite for merge consideration, =
IMO.
>=20
> Shirley Ma was kind enough to send me some measurement results showing
> how kernel level acceleration helps speed up you can find them here:
> http://www.linux-kvm.org/page/VhostNet

Thanks for the pointers.  I will roll your latest v8 code into our test
matrix.  What kernel/qemu trees do they apply to?

-Greg


--------------enigE41C0DE2FBFBF3E83786E82A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.11 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkrx0t4ACgkQP5K2CMvXmqFRbgCeLpbxRPIlSPlPG7HtOurzxEQp
lWUAnjOvhcZm8LOVA2vlgoLaN/wgPdzQ
=JO1s
-----END PGP SIGNATURE-----

--------------enigE41C0DE2FBFBF3E83786E82A--

--===============4021650794434440611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============4021650794434440611==--
