From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2] virtiofs: Use static const, not const static
Date: Tue, 12 Nov 2019 10:33:31 +0000
Message-ID: <20191112103331.GE463128@stefanha-x1.localdomain>
References: <1573474545-37037-1-git-send-email-zhengbin13@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2133633367245864343=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1573474545-37037-1-git-send-email-zhengbin13@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: zhengbin <zhengbin13@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, vgoyal@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

--===============2133633367245864343==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6Vw0j8UKbyX0bfpA"
Content-Disposition: inline

--6Vw0j8UKbyX0bfpA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2019 at 08:15:45PM +0800, zhengbin wrote:
> Move the static keyword to the front of declarations, which resolves
> compiler warnings when building with "W=3D1":
>=20
> fs/fuse/virtio_fs.c:687:1: warning: =E2=80=98static=E2=80=99 is not at be=
ginning of declaration [-Wold-style-declaration]
>  const static struct virtio_device_id id_table[] =3D {
>  ^
> fs/fuse/virtio_fs.c:692:1: warning: =E2=80=98static=E2=80=99 is not at be=
ginning of declaration [-Wold-style-declaration]
>  const static unsigned int feature_table[] =3D {};
>  ^
> fs/fuse/virtio_fs.c:1029:1: warning: =E2=80=98static=E2=80=99 is not at b=
eginning of declaration [-Wold-style-declaration]
>  const static struct fuse_iqueue_ops virtio_fs_fiq_ops =3D {
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>
> ---
> v1->v2: modify comment
>  fs/fuse/virtio_fs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6Vw0j8UKbyX0bfpA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3KinsACgkQnKSrs4Gr
c8iVvAf+KcM0juc41tqI7xOrSt9zxcuq5KCxeQURRRWcUAPCKs2XgqNswQfg7yzx
ZDfiOV0zS9TJpfNDffpeZl9GiGMNHOZdsvOiJWMJIlydpZA5TrgWoRlrM+z/42iY
04Junb5gUk7sMeOPKU/HRHyMyoPUd2mbaxET+Zv2fPvWt3u2QTmW3R2puEHFiFo/
aG1ijnb2XYCWjolOS3wzDuhIhi4O+UMh9utzwYjlDV9GJH+7av4NBPS0DF5yUJfS
d062MA39xdIsNZdrliamIvrBV1QKpY7a+GaT7wAQvOcUbLf8YF6uNDyiRrVvj8K9
SRDgt9Kbr4GpQ8R6cJSnEIBe6mof+g==
=hbuN
-----END PGP SIGNATURE-----

--6Vw0j8UKbyX0bfpA--


--===============2133633367245864343==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2133633367245864343==--
