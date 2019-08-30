From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/2] vhost/test: fix build for vhost test
Date: Fri, 30 Aug 2019 11:37:24 +0800
Message-ID: <f44555de-6a9d-256f-5526-9457607e6a47__11769.9383570411$1567136356$gmane$org@redhat.com>
References: <20190828053700.26022-1-tiwei.bie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------8E2AB2F168E0B8F9B8B7B5E9"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190828053700.26022-1-tiwei.bie@intel.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tiwei Bie <tiwei.bie@intel.com>, mst@redhat.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------8E2AB2F168E0B8F9B8B7B5E9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 2019/8/28 =E4=B8=8B=E5=8D=881:36, Tiwei Bie wrote:
> Since below commit, callers need to specify the iov_limit in
> vhost_dev_init() explicitly.
>
> Fixes: b46a0bf78ad7 ("vhost: fix OOB in get_rx_bufs()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> ---
>  drivers/vhost/test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
> index 9e90e969af55..ac4f762c4f65 100644
> --- a/drivers/vhost/test.c
> +++ b/drivers/vhost/test.c
> @@ -115,7 +115,7 @@ static int vhost_test_open(struct inode *inode, str=
uct file *f)
>  	dev =3D &n->dev;
>  	vqs[VHOST_TEST_VQ] =3D &n->vqs[VHOST_TEST_VQ];
>  	n->vqs[VHOST_TEST_VQ].handle_kick =3D handle_vq_kick;
> -	vhost_dev_init(dev, vqs, VHOST_TEST_VQ_MAX);
> +	vhost_dev_init(dev, vqs, VHOST_TEST_VQ_MAX, UIO_MAXIOV);
> =20
>  	f->private_data =3D n;
> =20


Acked-by: Jason Wang <jasowang@redhat.com>



--------------8E2AB2F168E0B8F9B8B7B5E9
Content-Type: application/pgp-keys;
 name="pEpkey.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pEpkey.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
JJaQ8I7hEjBpmSTF4uR0ETUJmQbCBynU
=3DCBPY
-----END PGP PUBLIC KEY BLOCK-----

--------------8E2AB2F168E0B8F9B8B7B5E9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--------------8E2AB2F168E0B8F9B8B7B5E9--
