From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] drivers\block: Use kobj_to_dev() API
Date: Fri, 19 Jun 2020 13:49:38 +0100
Message-ID: <20200619124938.GA2424182@stefanha-x1.localdomain>
References: <1591945856-14749-1-git-send-email-wangqing@vivo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6003003601213530443=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1591945856-14749-1-git-send-email-wangqing@vivo.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Wang Qing <wangqing@vivo.com>
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

--===============6003003601213530443==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2020 at 03:10:56PM +0800, Wang Qing wrote:
> Use kobj_to_dev() API instead of container_of().
>=20
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  mode change 100644 =3D> 100755 drivers/block/virtio_blk.c

Please fix the '\' -> '/' in the commit message. Looks good otherwise:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7stGIACgkQnKSrs4Gr
c8iKlgf/f+yvjTB2iqqDHAxkMDvnIu83CmaNspZ6bGF/0hEaFtWKGCIiJ+uyD2ow
HeS/6wRfIYMFpEcrwpEPWssIh/+US/957FmjIVeUU8b7jIER7VHH1BcAZq8DDKe3
yIxlUtJPOFRUz8GyddfoWDycsSL5SCGjP8eRTJkIy93yBlw308K8h/Y0keIN3ToJ
QYnuq143Mm0XmVk7RgkIMIM6iiDgxrU+qU5wIRg4f5UVzGWFAHIugGHEN+BMEUfv
hXpS0Akw5CkVFSTkOewu15i52Hp4TDRyQn+A0DldsPdjnjebGaygbRH5In8NzqX/
AACpzHtUyBhoDiAf2Ml3OAh86QIIEA==
=eGvO
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--


--===============6003003601213530443==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6003003601213530443==--
