From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] virtiofs: Remove set but not used variable 'fc'
Date: Wed, 23 Oct 2019 15:33:01 +0100
Message-ID: <20191023143301.GG9574@stefanha-x1.localdomain>
References: <1571796169-61061-1-git-send-email-zhengbin13@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0603743247367033290=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1571796169-61061-1-git-send-email-zhengbin13@huawei.com>
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

--===============0603743247367033290==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3xoW37o/FfUZJwQG"
Content-Disposition: inline

--3xoW37o/FfUZJwQG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2019 at 10:02:49AM +0800, zhengbin wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
>=20
> fs/fuse/virtio_fs.c: In function virtio_fs_wake_pending_and_unlock:
> fs/fuse/virtio_fs.c:983:20: warning: variable fc set but not used [-Wunus=
ed-but-set-variable]
>=20
> It is not used since commit 7ee1e2e631db ("virtiofs:
> No need to check fpq->connected state")
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>
> ---
>  fs/fuse/virtio_fs.c | 2 --
>  1 file changed, 2 deletions(-)

Only affects the linux-next tree, not virtio-fs-dev or linux.git/master.
Same as "[PATCH -next] virtiofs: remove unused variable 'fc'"
(<20191023062130.23068-1-yuehaibing@huawei.com>).

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--3xoW37o/FfUZJwQG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2wZJ0ACgkQnKSrs4Gr
c8jhWggAplRLEXTbMxEBBB5hAMuW2PcDsqSSuI5e+v70h1j8C/mzw4Z/QC3H/WQm
0IVc8kYWZQekjSx3t8oFsLOmiRLJ64wDG5ZimbbMt0GqE/IOkadGGEd45tGZIXMm
YHlvjfEROOsT5W+G0oGwnAfqEqgUiQ2dNvpYpvJqYGF1tSGyjqunT4uyFrywtG9W
2fPGZkaZTAJTOl5p2dm31bep4QUc5NmsovkfB8wCXk9PcunV9OlGrzJTZoWMKvJE
NeHQSl3L83M2TmdrU3r+1lu7ns9lyxkPa55V8JP77mtwbCARgzdwmhpih2vjRvIa
laHxW2WsAK11RTb3twS9EJhqWSDGAw==
=RixM
-----END PGP SIGNATURE-----

--3xoW37o/FfUZJwQG--


--===============0603743247367033290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0603743247367033290==--
