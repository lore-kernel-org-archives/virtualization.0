From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v4 2/5] vsock/virtio: reduce credit update messages
Date: Mon, 22 Jul 2019 09:36:40 +0100
Message-ID: <20190722083640.GB24934__26183.0543213122$1563784622$gmane$org@stefanha-x1.localdomain>
References: <20190717113030.163499-1-sgarzare@redhat.com>
	<20190717113030.163499-3-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5773362539808652197=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190717113030.163499-3-sgarzare@redhat.com>
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


--===============5773362539808652197==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2019 at 01:30:27PM +0200, Stefano Garzarella wrote:
> In order to reduce the number of credit update messages,
> we send them only when the space available seen by the
> transmitter is less than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  include/linux/virtio_vsock.h            |  1 +
>  net/vmw_vsock/virtio_transport_common.c | 16 +++++++++++++---
>  2 files changed, 14 insertions(+), 3 deletions(-)

It's an arbitrary limit but the risk of regressions is low since the
credit update traffic was so excessive:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl01dZgACgkQnKSrs4Gr
c8h/oQgAuTo0CerV6R9QtoxW4hcg6Tkq8sm7tBtXxSlRDhm5cvCYY3GKnhq1R/d0
Kg0hqcHUpqMsLT0yNza3j2F2USkvoxFm3wMgKijp5A0L15YVUQ+qZOwxVfBw9wDe
RXeY5bMyEHE5MFFtMfGDAiNyL1umrZ0Cy2RSYdzc+JhvZEkFyvwqE/za5PmXhofP
hF5u98zTLSjIxjxMAl7I7obkZIaJmU4A5XDUWwucqQm4wBP4QFQQqocM91RlQ7Gz
slJK7JiLWEpd2ka1VDVK9AfgE6R0dnT6tZ1r306NaG0moJmgts9gm3ETffKce8bn
OlHQa8PxT//6DYE3ghoFPTOpYxFqLw==
=G3Rg
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--

--===============5773362539808652197==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5773362539808652197==--
