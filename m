From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v3 1/5] vsock/virtio: limit the memory used per-socket
Date: Mon, 10 Jun 2019 14:44:07 +0100
Message-ID: <20190610134407.GM14257__46540.6979479425$1560174262$gmane$org@stefanha-x1.localdomain>
References: <20190531133954.122567-1-sgarzare@redhat.com>
	<20190531133954.122567-2-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8446837325855411614=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190531133954.122567-2-sgarzare@redhat.com>
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


--===============8446837325855411614==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hdhkc9EpVJoq6PQ6"
Content-Disposition: inline


--hdhkc9EpVJoq6PQ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2019 at 03:39:50PM +0200, Stefano Garzarella wrote:
> Since virtio-vsock was introduced, the buffers filled by the host
> and pushed to the guest using the vring, are directly queued in
> a per-socket list. These buffers are preallocated by the guest
> with a fixed size (4 KB).
>=20
> The maximum amount of memory used by each socket should be
> controlled by the credit mechanism.
> The default credit available per-socket is 256 KB, but if we use
> only 1 byte per packet, the guest can queue up to 262144 of 4 KB
> buffers, using up to 1 GB of memory per-socket. In addition, the
> guest will continue to fill the vring with new 4 KB free buffers
> to avoid starvation of other sockets.
>=20
> This patch mitigates this issue copying the payload of small
> packets (< 128 bytes) into the buffer of last packet queued, in
> order to avoid wasting memory.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  drivers/vhost/vsock.c                   |  2 +
>  include/linux/virtio_vsock.h            |  1 +
>  net/vmw_vsock/virtio_transport.c        |  1 +
>  net/vmw_vsock/virtio_transport_common.c | 60 +++++++++++++++++++++----
>  4 files changed, 55 insertions(+), 9 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--hdhkc9EpVJoq6PQ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlz+XqcACgkQnKSrs4Gr
c8i67gf+IaHwIE70u0NAFbNbt2B8lH5vRZt1H3I0PmFUqoxPIhZ6wFj4rL1mPDD8
W6mT6mla/sDPZQpeYKNJKg1tZ0N4rsl1hH/bW3huwjAGBlk7x9mP0LWUWailXE5P
efL35fpqoiaVvqMDFCwwZFkoba7gB1jcYzzQJfbMz9k1UNRkypvhJyVD4Hs3JI+O
C23eoQb5zO+9Z6aeFnsEj29zR4Abyw+f4kRVKPaJIETKUiMhK3x7fTaEXAkyW4R+
bl1D7xPH+VCInPAbSdkGKp7xbWTAzASEfEPrq14jRNwt6mDAKY3Q51l3Ia0l19NY
DMP6ErcemmdNksPZvxl0YWYTOD9pCg==
=Jzyw
-----END PGP SIGNATURE-----

--hdhkc9EpVJoq6PQ6--

--===============8446837325855411614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8446837325855411614==--
