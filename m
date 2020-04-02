From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio/test: fix up after IOTLB changes
Date: Thu, 2 Apr 2020 12:01:56 +0800
Message-ID: <921fe999-e183-058d-722a-1a6a6ab066e0@redhat.com>
References: <20200401165100.276039-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200401165100.276039-1-mst@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


On 2020/4/2 =E4=B8=8A=E5=8D=8812:51, Michael S. Tsirkin wrote:
> Allow building vringh without IOTLB (that's the case for userspace
> builds, will be useful for CAIF/VOD down the road too).
> Update for API tweaks.
> Don't include vringh with kernel builds.


I'm not quite sure we need this.

E.g the userspace accessor is not used by CAIF/VOP.


>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   drivers/vhost/test.c   | 4 ++--
>   drivers/vhost/vringh.c | 5 +++++
>   include/linux/vringh.h | 2 ++
>   tools/virtio/Makefile  | 3 ++-
>   4 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
> index 394e2e5c772d..9a3a09005e03 100644
> --- a/drivers/vhost/test.c
> +++ b/drivers/vhost/test.c
> @@ -120,7 +120,7 @@ static int vhost_test_open(struct inode *inode, str=
uct file *f)
>   	vqs[VHOST_TEST_VQ] =3D &n->vqs[VHOST_TEST_VQ];
>   	n->vqs[VHOST_TEST_VQ].handle_kick =3D handle_vq_kick;
>   	vhost_dev_init(dev, vqs, VHOST_TEST_VQ_MAX, UIO_MAXIOV,
> -		       VHOST_TEST_PKT_WEIGHT, VHOST_TEST_WEIGHT);
> +		       VHOST_TEST_PKT_WEIGHT, VHOST_TEST_WEIGHT, NULL);
>  =20
>   	f->private_data =3D n;
>  =20
> @@ -225,7 +225,7 @@ static long vhost_test_reset_owner(struct vhost_tes=
t *n)
>   {
>   	void *priv =3D NULL;
>   	long err;
> -	struct vhost_umem *umem;
> +	struct vhost_iotlb *umem;
>  =20
>   	mutex_lock(&n->dev.mutex);
>   	err =3D vhost_dev_check_owner(&n->dev);
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index ee0491f579ac..878e565dfffe 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -13,9 +13,11 @@
>   #include <linux/uaccess.h>
>   #include <linux/slab.h>
>   #include <linux/export.h>
> +#ifdef VHOST_IOTLB


Kbuild bot reports build issues with this.

It looks to me we should use #if IS_ENABLED(CONFIG_VHOST_IOTLB) here and=20
following checks.

Thanks


>   #include <linux/bvec.h>
>   #include <linux/highmem.h>
>   #include <linux/vhost_iotlb.h>
> +#endif
>   #include <uapi/linux/virtio_config.h>
>  =20
>   static __printf(1,2) __cold void vringh_bad(const char *fmt, ...)
> @@ -1059,6 +1061,8 @@ int vringh_need_notify_kern(struct vringh *vrh)
>   }
>   EXPORT_SYMBOL(vringh_need_notify_kern);
>  =20
> +#ifdef VHOST_IOTLB
> +
>   static int iotlb_translate(const struct vringh *vrh,
>   			   u64 addr, u64 len, struct bio_vec iov[],
>   			   int iov_size, u32 perm)
> @@ -1416,5 +1420,6 @@ int vringh_need_notify_iotlb(struct vringh *vrh)
>   }
>   EXPORT_SYMBOL(vringh_need_notify_iotlb);
>  =20
> +#endif
>  =20
>   MODULE_LICENSE("GPL");
> diff --git a/include/linux/vringh.h b/include/linux/vringh.h
> index bd0503ca6f8f..ebff121c0b02 100644
> --- a/include/linux/vringh.h
> +++ b/include/linux/vringh.h
> @@ -14,8 +14,10 @@
>   #include <linux/virtio_byteorder.h>
>   #include <linux/uio.h>
>   #include <linux/slab.h>
> +#ifdef VHOST_IOTLB
>   #include <linux/dma-direction.h>
>   #include <linux/vhost_iotlb.h>
> +#endif
>   #include <asm/barrier.h>
>  =20
>   /* virtio_ring with information needed for host access. */
> diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
> index f33f32f1d208..d3f152f4660b 100644
> --- a/tools/virtio/Makefile
> +++ b/tools/virtio/Makefile
> @@ -22,7 +22,8 @@ OOT_CONFIGS=3D\
>   	CONFIG_VHOST=3Dm \
>   	CONFIG_VHOST_NET=3Dn \
>   	CONFIG_VHOST_SCSI=3Dn \
> -	CONFIG_VHOST_VSOCK=3Dn
> +	CONFIG_VHOST_VSOCK=3Dn \
> +	CONFIG_VHOST_RING=3Dn
>   OOT_BUILD=3DKCFLAGS=3D"-I "${OOT_VHOST} ${MAKE} -C ${OOT_KSRC} V=3D${=
V}
>   oot-build:
>   	echo "UNSUPPORTED! Don't use the resulting modules in production!"
