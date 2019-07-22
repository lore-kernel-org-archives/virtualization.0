From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v4 5/5] vsock/virtio: change the maximum packet size
	allowed
Date: Mon, 22 Jul 2019 10:07:30 +0100
Message-ID: <20190722090730.GE24934__25866.1575194978$1563786465$gmane$org@stefanha-x1.localdomain>
References: <20190717113030.163499-1-sgarzare@redhat.com>
	<20190717113030.163499-6-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2140561293501717578=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190717113030.163499-6-sgarzare@redhat.com>
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
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org


--===============2140561293501717578==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Qz2CZ664xQdCRdPu"
Content-Disposition: inline


--Qz2CZ664xQdCRdPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2019 at 01:30:30PM +0200, Stefano Garzarella wrote:
> Since now we are able to split packets, we can avoid limiting
> their sizes to VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE.
> Instead, we can use VIRTIO_VSOCK_MAX_PKT_BUF_SIZE as the max
> packet size.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Qz2CZ664xQdCRdPu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl01fNIACgkQnKSrs4Gr
c8jlPwf+K8D7nnRfxW5Y5W22bqktswfcGjAt29NMC9KGkYjL0hM745Dg5G6LG8tD
FuJQqW0Daerwk5vC3b0d9iyF1MtAQlMCm4XhIEHi0aGS2blFtrra2M9IpTqnQ/t+
sGwMqmUWbCjBAFZQb1QNCgLXxwMXIabNCgSFY/cBsHMWyOKbTlTVaGstCA8Tp3RW
TKqUGWseTe9K1WQcX2el2klhhir+K+XMN4iIxmtJks7dRB6wci+G2JDKaYtjm6t3
0kdIjyRhhj4I4WOHq7vvZyHYAj0oT4odRHTKF8aNa+oUhoo8PHJ5VeHah3+wciCp
MDed3Aanbck3Tmyq/YcOBNMozk1KcQ==
=xu6B
-----END PGP SIGNATURE-----

--Qz2CZ664xQdCRdPu--

--===============2140561293501717578==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2140561293501717578==--
