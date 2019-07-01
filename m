From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v2 3/3] vsock/virtio: fix flush of works during the
	.remove()
Date: Mon, 1 Jul 2019 16:08:34 +0100
Message-ID: <20190701150834.GB11900@stefanha-x1.localdomain>
References: <20190628123659.139576-1-sgarzare@redhat.com>
	<20190628123659.139576-4-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5623369206675976036=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190628123659.139576-4-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org


--===============5623369206675976036==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2019 at 02:36:59PM +0200, Stefano Garzarella wrote:
> This patch moves the flush of works after vdev->config->del_vqs(vdev),
> because we need to be sure that no workers run before to free the
> 'vsock' object.
>=20
> Since we stopped the workers using the [tx|rx|event]_run flags,
> we are sure no one is accessing the device while we are calling
> vdev->config->reset(vdev), so we can safely move the workers' flush.

What about send_pkt and loopback work?  How were they stopped safely?

For example, if send_pkt work executes then we're in trouble since it
accesses the tx virtqueue which is deleted by ->del_vqs().

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0aIfIACgkQnKSrs4Gr
c8iHxwf/f/ztZPmFyV30cfT2/l/WmLT+ofdX6M4X2Z7eEb3qolhp0sYuGZjAXdAP
FrEZY0n5LGLBskjM4s3HThB2uyV/ByLZPDBKuA7SszFKZWGbB/VgR7Z2BzDCaaz2
7HnJPZoeE7KzeCygCEQ7dneriR+/HgqEW6VZFlaOYX31Nv4X7hUYerrqwmcP9qS+
tMXxWcsEMjZi9bQFxr+MCZqEJoK/Xct0Yt0ssNUxNz6Uv/KAG7XIaRXP/f+GjHXy
Uyw/MJKpC4T3N+YwpR9xfGWvLK7NZqvuorr4JGqB8R49AODaYBJepjdxnd6OD8bY
qmeew3QFothoW6phvjI3A4uKJVsYvw==
=KE3u
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--

--===============5623369206675976036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5623369206675976036==--
