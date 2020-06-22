From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH V2] drivers/block: Use kobj_to_dev() API
Date: Mon, 22 Jun 2020 10:56:49 +0100
Message-ID: <20200622095649.GA6675@stefanha-x1.localdomain>
References: <1592618024-28990-1-git-send-email-wangqing@vivo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1592618024-28990-1-git-send-email-wangqing@vivo.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Wang Qing <wangqing@vivo.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 20, 2020 at 09:53:43AM +0800, Wang Qing wrote:
> Use kobj_to_dev() API instead of container_of().
>=20
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7wgGEACgkQnKSrs4Gr
c8jiqwf+NDwvJrqVQacgMbfslm7ctFkXeq127ECemWo6fBJHJ0v01REWrK2Uw9U+
envftxXJjZBtRea5aPUC2NBHfyVQoBuM3q5F2vbmSOOtOv+BHq0oDp16mUqsUD7k
Jg//Y4VKXMFykxC2cHsq1AkyJxUvvU1eLyjs0T6AtbtW7rFysXeT95p7n0bd72ah
G9yxU3htdGZUWygJKbCPYZXM/4uCfZpuiMq0GFdyBNH27aP/XvuD/pRJ4ag5Q9JZ
wq5JtUbs7EqdAGQokCfY0/tk6emgN0MW7GPClOUA0kBcCUoOZivS6/igsjk5FF22
UzBcDoKiDUf2nZhjEPcv1Wqqjkd5xw==
=PUEf
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
