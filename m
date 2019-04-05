From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH RFC 4/4] vsock/virtio: increase RX buffer size to 64 KiB
Date: Fri, 5 Apr 2019 09:44:14 +0100
Message-ID: <20190405084414.GE25152__3186.07459064282$1554453892$gmane$org@stefanha-x1.localdomain>
References: <20190404105838.101559-1-sgarzare@redhat.com>
	<20190404105838.101559-5-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1578847784214087880=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190404105838.101559-5-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, Stefano Garzarella <sgarzare@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============1578847784214087880==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h56sxpGKRmy85csR"
Content-Disposition: inline


--h56sxpGKRmy85csR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2019 at 12:58:38PM +0200, Stefano Garzarella wrote:
> In order to increase host -> guest throughput with large packets,
> we can use 64 KiB RX buffers.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  include/linux/virtio_vsock.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> index 6d7a22cc20bf..43cce304408e 100644
> --- a/include/linux/virtio_vsock.h
> +++ b/include/linux/virtio_vsock.h
> @@ -10,7 +10,7 @@
>  #define VIRTIO_VSOCK_DEFAULT_MIN_BUF_SIZE	128
>  #define VIRTIO_VSOCK_DEFAULT_BUF_SIZE		(1024 * 256)
>  #define VIRTIO_VSOCK_DEFAULT_MAX_BUF_SIZE	(1024 * 256)
> -#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(1024 * 4)
> +#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(1024 * 64)

This patch raises rx ring memory consumption from 128 * 4KB =3D 512KB to
128 * 64KB =3D 8MB.

Michael, Jason: Any advice regarding rx/tx ring sizes and buffer sizes?

Depending on rx ring size and the workload's packet size, different
values might be preferred.

This could become a tunable in the future.  It determines the size of
the guest driver's rx buffers.

--h56sxpGKRmy85csR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcpxVeAAoJEJykq7OBq3PIhtsIAIxorF0RmP5eAJziHtgy2yLQ
MlHya7rpnvkF6xSqnCmYAATiZRsnWrPr2hCF/EvYsISlH2Tb+1obPERpSkfdgs0D
LX1QekHhiGKo3fHeWRsKWFVXaFTCyVEQxgngBf0tiYAbYIxFuj54cyUm3tI0OwAi
7JHueqlDJ9HyFVHT2Sdob3NhRyb67aHw/hNKH/ocAduD0NmTx/5V8/0gIxy91ojS
sho3R/CPRJm1mNFUTgiwQWJH3TFrSa5KGu5t2fO8NcXDjAd/5hwgSMtgU3ypSYas
bCTyFBsO7srrP1wzz5YLVLcc5VFQBGrakOLKtmL4GeoyMTl4VZCCWbtN2VQpwWE=
=pBj5
-----END PGP SIGNATURE-----

--h56sxpGKRmy85csR--

--===============1578847784214087880==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1578847784214087880==--
