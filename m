From: Jerome Marchand <jmarchan@redhat.com>
Subject: Re: [PATCH] virtio_pci: fix use after free on release
Date: Thu, 14 Jan 2016 15:55:39 +0100
Message-ID: <5697B6EB.8040903__26564.16120376$1452785135$gmane$org@redhat.com>
References: <1452780236-27981-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4071439139827230397=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1452780236-27981-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Sasha Levin <sasha.levin@oracle.com>, stable@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============4071439139827230397==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ESLEVhqAwAWkR2bMksF3JJfTvKChn7RlV"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ESLEVhqAwAWkR2bMksF3JJfTvKChn7RlV
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 01/14/2016 03:04 PM, Michael S. Tsirkin wrote:
> KASan detected a use-after-free error in virtio-pci remove code. In
> virtio_pci_remove(), vp_dev is still used after being freed in
> unregister_virtio_device() (in virtio_pci_release_dev() more
> precisely).
>=20
> To fix, keep a reference until cleanup is done.

That does make KASan happy.

>=20
> Fixes: 63bd62a08ca4 ("virtio_pci: defer kfree until release callback")
> Reported-by: Jerome Marchand <jmarchan@redhat.com>
> Cc: stable@vger.kernel.org
> Cc: Sasha Levin <sasha.levin@oracle.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Tested-by: Jerome Marchand <jmarchan@redhat.com>

Thanks,
Jerome

> ---
>  drivers/virtio/virtio_pci_common.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio=
_pci_common.c
> index 36205c2..f6bed86 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -545,6 +545,7 @@ err_enable_device:
>  static void virtio_pci_remove(struct pci_dev *pci_dev)
>  {
>  	struct virtio_pci_device *vp_dev =3D pci_get_drvdata(pci_dev);
> +	struct device *dev =3D get_device(&vp_dev->vdev.dev);
> =20
>  	unregister_virtio_device(&vp_dev->vdev);
> =20
> @@ -554,6 +555,7 @@ static void virtio_pci_remove(struct pci_dev *pci_d=
ev)
>  		virtio_pci_modern_remove(vp_dev);
> =20
>  	pci_disable_device(pci_dev);
> +	put_device(dev);
>  }
> =20
>  static struct pci_driver virtio_pci_driver =3D {
>=20



--ESLEVhqAwAWkR2bMksF3JJfTvKChn7RlV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWl7brAAoJEHTzHJCtsuoCl7QIAIRNzfwlJwKUx7P4XibmENCU
GizvEcwbVfgyc2Eb1EnOhFpWrPOvpglHuphPFEq1sg9rXbrj8CBO6ICPtDll9MBm
RhP1bLAMwe7yFuwaZm1pBsM8NXB66BCioJgbnYrFjwe2Fb+EDu7d9A+Vgk2dwbKd
KfjjiUa5OQirLIkTuexZPwPvZS8uLhcTGW7OcrENBOpYdS2S9jA05EAr/cNa8+Qd
hGezhcy397xYuZBAEVZbH8MpWRt6SiKDE8Is0HSqQ1mDR1ROaCAjMc8GVQe0jK2o
sTu/ldIC3q1l4eaZQstQdF9deg8KN8yk8y7pykPGvOtXgA6N+QibjysGOryEXts=
=5K4x
-----END PGP SIGNATURE-----

--ESLEVhqAwAWkR2bMksF3JJfTvKChn7RlV--

--===============4071439139827230397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4071439139827230397==--
