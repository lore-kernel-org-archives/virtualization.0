From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH RFC 3/4] vsock/virtio: change the maximum packet size
	allowed
Date: Mon, 8 Apr 2019 10:37:23 +0100
Message-ID: <20190408093723.GP15001__37833.7253978074$1554716258$gmane$org@stefanha-x1.localdomain>
References: <20190404105838.101559-1-sgarzare@redhat.com>
	<20190404105838.101559-4-sgarzare@redhat.com>
	<20190405082447.GD25152@stefanha-x1.localdomain>
	<20190405100747.dbwi3sjaudp3d2wa@steredhat>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5123958262122737656=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190405100747.dbwi3sjaudp3d2wa@steredhat>
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
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org


--===============5123958262122737656==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R3SAtXwgGp429mN7"
Content-Disposition: inline


--R3SAtXwgGp429mN7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2019 at 12:07:47PM +0200, Stefano Garzarella wrote:
> On Fri, Apr 05, 2019 at 09:24:47AM +0100, Stefan Hajnoczi wrote:
> > On Thu, Apr 04, 2019 at 12:58:37PM +0200, Stefano Garzarella wrote:
> > > Since now we are able to split packets, we can avoid limiting
> > > their sizes to VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE.
> > > Instead, we can use VIRTIO_VSOCK_MAX_PKT_BUF_SIZE as the max
> > > packet size.
> > >=20
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > ---
> > >  net/vmw_vsock/virtio_transport_common.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/=
virtio_transport_common.c
> > > index f32301d823f5..822e5d07a4ec 100644
> > > --- a/net/vmw_vsock/virtio_transport_common.c
> > > +++ b/net/vmw_vsock/virtio_transport_common.c
> > > @@ -167,8 +167,8 @@ static int virtio_transport_send_pkt_info(struct =
vsock_sock *vsk,
> > >  	vvs =3D vsk->trans;
> > > =20
> > >  	/* we can send less than pkt_len bytes */
> > > -	if (pkt_len > VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE)
> > > -		pkt_len =3D VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;
> > > +	if (pkt_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
> > > +		pkt_len =3D VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
> >=20
> > The next line limits pkt_len based on available credits:
> >=20
> >   /* virtio_transport_get_credit might return less than pkt_len credit =
*/
> >   pkt_len =3D virtio_transport_get_credit(vvs, pkt_len);
> >=20
> > I think drivers/vhost/vsock.c:vhost_transport_do_send_pkt() now works
> > correctly even with pkt_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE.
>=20
> Correct.
>=20
> >=20
> > The other ->send_pkt() callback is
> > net/vmw_vsock/virtio_transport.c:virtio_transport_send_pkt_work() and it
> > can already send any size packet.
> >=20
> > Do you remember why VIRTIO_VSOCK_MAX_PKT_BUF_SIZE still needs to be the
> > limit?  I'm wondering if we can get rid of it now and just limit packets
> > to the available credits.
>=20
> There are 2 reasons why I left this limit:
> 1. When the host receives a packets, it must be <=3D
>    VIRTIO_VSOCK_MAX_PKT_BUF_SIZE [drivers/vhost/vsock.c:vhost_vsock_alloc=
_pkt()]
>    So in this way we can limit the packets sent from the guest.

The general intent is to prevent the guest from sending huge buffers.
This is good.

However, the guest must already obey the credit limit advertized by the
host.  Therefore I think we should be checking against that instead of
an arbitrary constant limit.

So I think the limit should be the receive buffer size, not
VIRTIO_VSOCK_MAX_PKT_BUF_SIZE.  But at this point the code doesn't know
which connection the packet is associated with and cannot check the
receive buffer size. :(

Anyway, any change to this behavior requires compatibility so new guest
drivers work with old vhost_vsock.ko.  Therefore we should probably just
leave the limit for now.

> 2. When the host send packets, it help us to increase the parallelism
>    (especially if the guest has 64 KB RX buffers) because the user thread
>    will split packets, calling multiple times transport->stream_enqueue()
>    in net/vmw_vsock/af_vsock.c:vsock_stream_sendmsg() while the
>    vhost_transport_send_pkt_work() send them to the guest.

Sorry, I don't understand the reasoning.  Overall this creates more
work.  Are you saying the benefit is that
vhost_transport_send_pkt_work() can run "early" and notify the guest of
partial rx data before all of it has been enqueued?

Stefan

--R3SAtXwgGp429mN7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcqxZTAAoJEJykq7OBq3PIjDMH/0mW2RMt9MmR8x9kN886jFZQ
PP5AEzRl/JPaqRtzo2ckvFJrgIbbRx5f8Behl2zOX5UlqNFz0HKW8LH3x/Ex+bpB
rPnvD6T4zkZ9GRunB2Pew99Kg3p0fb8WzIQlnoDobepystkcxTHKxC0QMSosOPXT
o9RMU2KwAD38E9l74FrnrODMKnYyrnjpMzSRECg7yvF2jN7yu1QNjlBDX4c5SanL
NivUhHTx7o16bs6Zt+ClLw+zel3GkM6jlgsjiX7tchDct3Q6TCW+L2NYRXxPrnuz
vi0fY9CRvMA3lUui4bIE4i/5BgBJc1YxVbR3DNNnJUU39NKG66flMf7YDPRPzyE=
=E+n0
-----END PGP SIGNATURE-----

--R3SAtXwgGp429mN7--

--===============5123958262122737656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5123958262122737656==--
