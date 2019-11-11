From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] virtiofs: Use static const, not const static
Date: Mon, 11 Nov 2019 11:37:18 +0000
Message-ID: <20191111113718.GG442334@stefanha-x1.localdomain>
References: <1573464401-4917-1-git-send-email-zhengbin13@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7674181846225458674=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1573464401-4917-1-git-send-email-zhengbin13@huawei.com>
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

--===============7674181846225458674==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="APlYHCtpeOhspHkB"
Content-Disposition: inline

--APlYHCtpeOhspHkB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2019 at 05:26:41PM +0800, zhengbin wrote:
> Move the static keyword to the front of declarations.

Please mention why this change is necessary in the commit description.

>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>
> ---
>  fs/fuse/virtio_fs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index b77acea..2ac6818 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -684,12 +684,12 @@ static int virtio_fs_restore(struct virtio_device *=
vdev)
>  }
>  #endif /* CONFIG_PM_SLEEP */
>=20
> -const static struct virtio_device_id id_table[] =3D {
> +static const struct virtio_device_id id_table[] =3D {
>  =09{ VIRTIO_ID_FS, VIRTIO_DEV_ANY_ID },
>  =09{},
>  };
>=20
> -const static unsigned int feature_table[] =3D {};
> +static const unsigned int feature_table[] =3D {};
>=20
>  static struct virtio_driver virtio_fs_driver =3D {
>  =09.driver.name=09=09=3D KBUILD_MODNAME,
> @@ -1026,7 +1026,7 @@ __releases(fiq->lock)
>  =09}
>  }
>=20
> -const static struct fuse_iqueue_ops virtio_fs_fiq_ops =3D {
> +static const struct fuse_iqueue_ops virtio_fs_fiq_ops =3D {
>  =09.wake_forget_and_unlock=09=09=3D virtio_fs_wake_forget_and_unlock,
>  =09.wake_interrupt_and_unlock=09=3D virtio_fs_wake_interrupt_and_unlock,
>  =09.wake_pending_and_unlock=09=3D virtio_fs_wake_pending_and_unlock,
> --
> 2.7.4
>=20

--APlYHCtpeOhspHkB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3JR+4ACgkQnKSrs4Gr
c8gGrQgAiUk45Og7Sz14vxdo8xHlcsLPekKa5syDhdvKdMTEvk0+dTmW+FcE1N5M
EC7U13dTSLzKzBA5GWJ/3Wbj2nW5q38Kv8Ix4YDh+wX25e0DT+jrDDzpL9qQFUSq
hn06s6VJtwDVhDBh1B2Uflu6C8D+4B2nKgQJlNeHQArlvTCLMy50+kk6gVm+iJFu
Q71bIG7HEU7Hu3L/8xAPvQURVg9r5Mzcgq5ZXJI4Y/oMmfoYXdKSP5tvMzyyPaIh
rY1XYhsr6O3Jbv1cKAW1eg9lpbsH0kq6TnrtY2kKFDfzc3YWAPIWpN4nNxNJ1nPJ
LFU1K1nfHAr4Gl49rAPP1T36fImaxQ==
=bTfD
-----END PGP SIGNATURE-----

--APlYHCtpeOhspHkB--


--===============7674181846225458674==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7674181846225458674==--
