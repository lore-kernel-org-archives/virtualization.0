From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] vsock/virtio: annotate 'the_virtio_vsock' RCU pointer
Date: Mon, 13 Jul 2020 10:28:39 +0100
Message-ID: <20200713092839.GD28639@stefanha-x1.localdomain>
References: <20200710121243.120096-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YToU2i3Vx8H2dn7O"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200710121243.120096-1-sgarzare@redhat.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: davem@davemloft.net, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

--YToU2i3Vx8H2dn7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2020 at 02:12:43PM +0200, Stefano Garzarella wrote:
> Commit 0deab087b16a ("vsock/virtio: use RCU to avoid use-after-free
> on the_virtio_vsock") starts to use RCU to protect 'the_virtio_vsock'
> pointer, but we forgot to annotate it.
>=20
> This patch adds the annotation to fix the following sparse errors:
>=20
>     net/vmw_vsock/virtio_transport.c:73:17: error: incompatible types in =
comparison expression (different address spaces):
>     net/vmw_vsock/virtio_transport.c:73:17:    struct virtio_vsock [noder=
ef] __rcu *
>     net/vmw_vsock/virtio_transport.c:73:17:    struct virtio_vsock *
>     net/vmw_vsock/virtio_transport.c:171:17: error: incompatible types in=
 comparison expression (different address spaces):
>     net/vmw_vsock/virtio_transport.c:171:17:    struct virtio_vsock [node=
ref] __rcu *
>     net/vmw_vsock/virtio_transport.c:171:17:    struct virtio_vsock *
>     net/vmw_vsock/virtio_transport.c:207:17: error: incompatible types in=
 comparison expression (different address spaces):
>     net/vmw_vsock/virtio_transport.c:207:17:    struct virtio_vsock [node=
ref] __rcu *
>     net/vmw_vsock/virtio_transport.c:207:17:    struct virtio_vsock *
>     net/vmw_vsock/virtio_transport.c:561:13: error: incompatible types in=
 comparison expression (different address spaces):
>     net/vmw_vsock/virtio_transport.c:561:13:    struct virtio_vsock [node=
ref] __rcu *
>     net/vmw_vsock/virtio_transport.c:561:13:    struct virtio_vsock *
>     net/vmw_vsock/virtio_transport.c:612:9: error: incompatible types in =
comparison expression (different address spaces):
>     net/vmw_vsock/virtio_transport.c:612:9:    struct virtio_vsock [noder=
ef] __rcu *
>     net/vmw_vsock/virtio_transport.c:612:9:    struct virtio_vsock *
>     net/vmw_vsock/virtio_transport.c:631:9: error: incompatible types in =
comparison expression (different address spaces):
>     net/vmw_vsock/virtio_transport.c:631:9:    struct virtio_vsock [noder=
ef] __rcu *
>     net/vmw_vsock/virtio_transport.c:631:9:    struct virtio_vsock *
>=20
> Fixes: 0deab087b16a ("vsock/virtio: use RCU to avoid use-after-free on th=
e_virtio_vsock")
> Reported-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--YToU2i3Vx8H2dn7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8MKUcACgkQnKSrs4Gr
c8iLnAf9E+pOReZB1uxaaxHt2z9HjKmxjs6nY1gK0E/aNHGD4C4ZQFpkMMYrgACn
mTAJbmWJG/694IDC1i803aGbRKIq0VIyrezJtZWH7e8KTMG77U1YEDUr/T6yTAqf
MYrz9ylRKbEHjzAmRQtnQGJ/YtshXFVHISJf6maySSPuHHInz+n/rUlXFxxmrOme
x8cvGFTQ71RZUEWpIQxTL2vp4BEob1aIvrrFREvqgR9Xh4W1ZV641dP50QqjkJf9
ebLfHIpb+n9ZrYNa/+WwEZvMhw8r+hWA3giUXEuSwkGZkoi9s5d6WfZYeU7Lcbr7
0VLfCa/y5QsWouWZkkMZ7nLfxrMEsg==
=2Mf5
-----END PGP SIGNATURE-----

--YToU2i3Vx8H2dn7O--
