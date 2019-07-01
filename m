From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v2 3/3] vsock/virtio: fix flush of works during the
	.remove()
Date: Mon, 1 Jul 2019 16:09:30 +0100
Message-ID: <20190701150930.GC11900@stefanha-x1.localdomain>
References: <20190628123659.139576-1-sgarzare@redhat.com>
	<20190628123659.139576-4-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8536416661845978402=="
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


--===============8536416661845978402==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Content-Disposition: inline


--s9fJI615cBHmzTOP
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
>=20
> Before the vdev->config->del_vqs(vdev), workers can be scheduled
> by VQ callbacks, so we must flush them after del_vqs(), to avoid
> use-after-free of 'vsock' object.

Nevermind, I looked back at Patch 2 and saw the send_pkt and loopback
work functions were also updated.  Thanks!

Stefan

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0aIioACgkQnKSrs4Gr
c8gVvwgAlt7pHdcde/naMvD5PfdMiGprB/OgOkcK9tf8VKz5xBE7qoJwvBTlAhve
22I66Q75nW7fhsMkGMn6g1wkNQDxc0aG/jPhVy1JHx/Y3NDmXvqHF0joilOYNSsm
ryxStJrhsY+0+Jpff3uPnmNKgbBJzWdzGnmn3fXIl+E3PrkvLy672DebqpaoXOr0
ISdOZG+VUuVtoVkUl90lc2uzXMY6j4s986/zPdAwnGZsI4N+GGx6Sbnb03C8h6xP
3ovvhQMqwltt+5w6qDXKpowK7L62a7EkaSPrF4Zt+y9sJudpQ6ZXMQ+J1EsbdMx/
rzsxB4KWcyBsQm2kzgSa2FmwBOPiow==
=w4hz
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--

--===============8536416661845978402==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8536416661845978402==--
