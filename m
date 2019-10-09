From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC PATCH 05/13] vsock/virtio: add transport parameter to the
	virtio_transport_reset_no_sock()
Date: Wed, 9 Oct 2019 12:52:31 +0100
Message-ID: <20191009115231.GF5747__23391.9895182893$1570621971$gmane$org@stefanha-x1.localdomain>
References: <20190927112703.17745-1-sgarzare@redhat.com>
	<20190927112703.17745-6-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9004108802409798419=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190927112703.17745-6-sgarzare@redhat.com>
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
Cc: Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============9004108802409798419==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yRA+Bmk8aPhU85Qt"
Content-Disposition: inline


--yRA+Bmk8aPhU85Qt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2019 at 01:26:55PM +0200, Stefano Garzarella wrote:
> We are going to add 'struct vsock_sock *' parameter to
> virtio_transport_get_ops().
>=20
> In some cases, like in the virtio_transport_reset_no_sock(),
> we don't have any socket assigned to the packet received,
> so we can't use the virtio_transport_get_ops().
>=20
> In order to allow virtio_transport_reset_no_sock() to use the
> '.send_pkt' callback from the 'vhost_transport' or 'virtio_transport',
> we add the 'struct virtio_transport *' to it and to its caller:
> virtio_transport_recv_pkt().
>=20
> We moved the 'vhost_transport' and 'virtio_transport' definition,
> to pass their address to the virtio_transport_recv_pkt().
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  drivers/vhost/vsock.c                   |  94 +++++++-------
>  include/linux/virtio_vsock.h            |   3 +-
>  net/vmw_vsock/virtio_transport.c        | 160 ++++++++++++------------
>  net/vmw_vsock/virtio_transport_common.c |  12 +-
>  4 files changed, 135 insertions(+), 134 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--yRA+Bmk8aPhU85Qt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2dyf8ACgkQnKSrs4Gr
c8ipQAf+N9DOIP9BQ9hDc3C/yWPRdpws712iHQbOHVNiBXDKyxZsYFY51fCC7KyF
9YxSDHJ+9RDm2jzHdItNAwmxXaSpULxrORIVG2c67hxwahN9r90kpWe+yp90NJR9
WPk9aEgIxgSbypf1nzAbI4ZqJDmTXq7zd3yG6QngmvRhrYF0s81JSSYeVo+rN96G
qFFiYYEEA7nlESBV9INveLYF1W9qtNIyy0IgxM3gCrWOkNbRYTWDNAnBEipM/siE
apf48ghnlNeD77gwbjk0SREQStWdle319cCM03Fw1kYT4WoUOOulI2B2opJ2N0qt
eDpkxHTBrmJpGg+NU9sLUblRs7Rikg==
=d4Pb
-----END PGP SIGNATURE-----

--yRA+Bmk8aPhU85Qt--

--===============9004108802409798419==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============9004108802409798419==--
