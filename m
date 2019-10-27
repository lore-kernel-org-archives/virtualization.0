From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH net-next 07/14] vsock: handle buffer_size sockopts in the
	core
Date: Sun, 27 Oct 2019 09:08:23 +0100
Message-ID: <20191027080823.GB4472@stefanha-x1.localdomain>
References: <20191023095554.11340-1-sgarzare@redhat.com>
	<20191023095554.11340-8-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2813262763275677183=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191023095554.11340-8-sgarzare@redhat.com>
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
Cc: Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, Arnd Bergmann <arnd@arndb.de>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============2813262763275677183==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Content-Disposition: inline


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2019 at 11:55:47AM +0200, Stefano Garzarella wrote:
> virtio_transport and vmci_transport handle the buffer_size
> sockopts in a very similar way.
>=20
> In order to support multiple transports, this patch moves this
> handling in the core to allow the user to change the options
> also if the socket is not yet assigned to any transport.
>=20
> This patch also adds the '.notify_buffer_size' callback in the
> 'struct virtio_transport' in order to inform the transport,
> when the buffer_size is changed by the user. It is also useful
> to limit the 'buffer_size' requested (e.g. virtio transports).
>=20
> Acked-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> RFC -> v1:
> - changed .notify_buffer_size return to void (Stefan)
> - documented that .notify_buffer_size is called with sk_lock held (Stefan)
> ---
>  drivers/vhost/vsock.c                   |  7 +-
>  include/linux/virtio_vsock.h            | 15 +----
>  include/net/af_vsock.h                  | 15 ++---
>  net/vmw_vsock/af_vsock.c                | 43 ++++++++++---
>  net/vmw_vsock/hyperv_transport.c        | 36 -----------
>  net/vmw_vsock/virtio_transport.c        |  8 +--
>  net/vmw_vsock/virtio_transport_common.c | 79 ++++-------------------
>  net/vmw_vsock/vmci_transport.c          | 86 +++----------------------
>  net/vmw_vsock/vmci_transport.h          |  3 -
>  9 files changed, 65 insertions(+), 227 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl21UHcACgkQnKSrs4Gr
c8jf5wf6ArMyUiMMsXentQxUSlbUpCtIRf1HllqzAAYdsb4/GngX/TcZHaVU4JYg
vnMxPnYs9IatdJgEmJ2oV7Xemt2KdT67eqeqpeUuvOXzwCFTqx7gmCq0GYXPobTW
5Km+oVwrDxfzrUNVK5ZmeFhOSQuB09zbY1JhuwXTiX+nXOVOBP91Mt3i5wijc6a1
M6W2KtgysSkW1K4tf+8/c12QdNlB5bwL6HX2Tgop6bE+yTFpxmykopRkXonrLSQ7
2Ba02wkFAOakw0f9AlF0xBCJfY8OvHUNPYRvnh5g9OJc9DjvZPl2p2PLTpMv7DLm
XF8KeD/VWkSjA8RIYlUYmzUdVvshGA==
=oEzi
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--

--===============2813262763275677183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2813262763275677183==--
