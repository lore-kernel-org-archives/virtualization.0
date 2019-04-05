From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH RFC 3/4] vsock/virtio: change the maximum packet size
	allowed
Date: Fri, 5 Apr 2019 09:24:47 +0100
Message-ID: <20190405082447.GD25152__17912.188817148$1554452730$gmane$org@stefanha-x1.localdomain>
References: <20190404105838.101559-1-sgarzare@redhat.com>
	<20190404105838.101559-4-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7208995834968267357=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190404105838.101559-4-sgarzare@redhat.com>
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


--===============7208995834968267357==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yudcn1FV7Hsu/q59"
Content-Disposition: inline


--yudcn1FV7Hsu/q59
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2019 at 12:58:37PM +0200, Stefano Garzarella wrote:
> Since now we are able to split packets, we can avoid limiting
> their sizes to VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE.
> Instead, we can use VIRTIO_VSOCK_MAX_PKT_BUF_SIZE as the max
> packet size.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virt=
io_transport_common.c
> index f32301d823f5..822e5d07a4ec 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -167,8 +167,8 @@ static int virtio_transport_send_pkt_info(struct vsoc=
k_sock *vsk,
>  	vvs =3D vsk->trans;
> =20
>  	/* we can send less than pkt_len bytes */
> -	if (pkt_len > VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE)
> -		pkt_len =3D VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;
> +	if (pkt_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
> +		pkt_len =3D VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;

The next line limits pkt_len based on available credits:

  /* virtio_transport_get_credit might return less than pkt_len credit */
  pkt_len =3D virtio_transport_get_credit(vvs, pkt_len);

I think drivers/vhost/vsock.c:vhost_transport_do_send_pkt() now works
correctly even with pkt_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE.

The other ->send_pkt() callback is
net/vmw_vsock/virtio_transport.c:virtio_transport_send_pkt_work() and it
can already send any size packet.

Do you remember why VIRTIO_VSOCK_MAX_PKT_BUF_SIZE still needs to be the
limit?  I'm wondering if we can get rid of it now and just limit packets
to the available credits.

Stefan

--yudcn1FV7Hsu/q59
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcpxDPAAoJEJykq7OBq3PIkwEIAKUcFcpFXgBx1Gbs5mSd4ypd
Yi7a6mc4wSbq/FLNhVo0xVjJA+7hSNxiUvsqbwr1ajpudAHbMoV9LEuVZqtRLBmM
pj9GmjHssqWgFr83oW1zlti/BNcArOoYl0csKoqfWXMA8sBb4o0ENdjlXwPvy+rm
aQE78BhRi0vHSpFlOs+Zc/KHaaeQuH0fufyjLSi4vFhWnOC4jpoXuPhCT2NAVCJA
MEdGNJZ2ZxtPBD8cUJH/ZTziNOArXsnOc6a9YIW72JnUOywqokVvgvsBtimaKN95
lbBsBCmPxd0rY4n3OTAssfnHbUVVNwYaVoysD39pWBwwd1ZL0J3kqpP2zPh/O7g=
=xs/A
-----END PGP SIGNATURE-----

--yudcn1FV7Hsu/q59--

--===============7208995834968267357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7208995834968267357==--
