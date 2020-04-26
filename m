From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 1/2] vdpa: Support config interrupt in vhost_vdpa
Date: Sun, 26 Apr 2020 17:41:30 +0800
Message-ID: <ec8b274c-657f-38b0-2b7d-77ab735969c3@redhat.com>
References: <1587890572-39093-1-git-send-email-lingshan.zhu@intel.com>
 <1587890572-39093-2-git-send-email-lingshan.zhu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1587890572-39093-2-git-send-email-lingshan.zhu@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: lulu@redhat.com, dan.daly@intel.com, cunming.liang@intel.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/4/26 =E4=B8=8B=E5=8D=884:42, Zhu Lingshan wrote:
> This commit implements config interrupt support in
> vhost_vdpa layer.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>   drivers/vhost/vdpa.c       | 47 +++++++++++++++++++++++++++++++++++++=
+++++++++
>   drivers/vhost/vhost.c      |  2 +-
>   include/uapi/linux/vhost.h |  4 ++++
>   3 files changed, 52 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 421f02a..c370ec5 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -21,6 +21,7 @@
>   #include <linux/nospec.h>
>   #include <linux/vhost.h>
>   #include <linux/virtio_net.h>
> +#include <linux/kernel.h>
>  =20
>   #include "vhost.h"
>  =20
> @@ -70,6 +71,7 @@ struct vhost_vdpa {
>   	int nvqs;
>   	int virtio_id;
>   	int minor;
> +	struct eventfd_ctx *config_ctx;
>   };
>  =20
>   static DEFINE_IDA(vhost_vdpa_ida);
> @@ -101,6 +103,17 @@ static irqreturn_t vhost_vdpa_virtqueue_cb(void *p=
rivate)
>   	return IRQ_HANDLED;
>   }
>  =20
> +static irqreturn_t vhost_vdpa_config_cb(void *private)
> +{
> +	struct vhost_vdpa *v =3D private;
> +	struct eventfd_ctx *config_ctx =3D v->config_ctx;
> +
> +	if (config_ctx)
> +		eventfd_signal(config_ctx, 1);
> +
> +	return IRQ_HANDLED;
> +}
> +
>   static void vhost_vdpa_reset(struct vhost_vdpa *v)
>   {
>   	struct vdpa_device *vdpa =3D v->vdpa;
> @@ -288,6 +301,36 @@ static long vhost_vdpa_get_vring_num(struct vhost_=
vdpa *v, u16 __user *argp)
>   	return 0;
>   }
>  =20
> +static void vhost_vdpa_config_put(struct vhost_vdpa *v)
> +{
> +	if (v->config_ctx)
> +		eventfd_ctx_put(v->config_ctx);
> +}
> +
> +static long vhost_vdpa_set_config_call(struct vhost_vdpa *v, u32 __use=
r *argp)
> +{
> +	struct vdpa_callback cb;
> +	int fd;
> +	struct eventfd_ctx *ctx;
> +
> +	cb.callback =3D vhost_vdpa_config_cb;
> +	cb.private =3D v->vdpa;
> +	if (copy_from_user(&fd, argp, sizeof(fd)))
> +		return  -EFAULT;
> +
> +	ctx =3D fd =3D=3D VHOST_FILE_UNBIND ? NULL : eventfd_ctx_fdget(fd);
> +	swap(ctx, v->config_ctx);
> +
> +	if (!IS_ERR_OR_NULL(ctx))
> +		eventfd_ctx_put(ctx);
> +
> +	if (IS_ERR(v->config_ctx))
> +		return PTR_ERR(v->config_ctx);
> +
> +	v->vdpa->config->set_config_cb(v->vdpa, &cb);
> +
> +	return 0;
> +}
>   static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int=
 cmd,
>   				   void __user *argp)
>   {
> @@ -398,6 +441,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *=
filep,
>   	case VHOST_SET_LOG_FD:
>   		r =3D -ENOIOCTLCMD;
>   		break;
> +	case VHOST_VDPA_SET_CONFIG_CALL:
> +		r =3D vhost_vdpa_set_config_call(v, argp);
> +		break;
>   	default:
>   		r =3D vhost_dev_ioctl(&v->vdev, cmd, argp);
>   		if (r =3D=3D -ENOIOCTLCMD)
> @@ -734,6 +780,7 @@ static int vhost_vdpa_release(struct inode *inode, =
struct file *filep)
>   	vhost_dev_stop(&v->vdev);
>   	vhost_vdpa_iotlb_free(v);
>   	vhost_vdpa_free_domain(v);
> +	vhost_vdpa_config_put(v);
>   	vhost_dev_cleanup(&v->vdev);
>   	kfree(v->vdev.vqs);
>   	mutex_unlock(&d->mutex);
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index d450e16..e8f5b20 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1590,7 +1590,7 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsig=
ned int ioctl, void __user *arg
>   			r =3D -EFAULT;
>   			break;
>   		}
> -		ctx =3D f.fd =3D=3D -1 ? NULL : eventfd_ctx_fdget(f.fd);
> +		ctx =3D f.fd =3D=3D VHOST_FILE_UNBIND ? NULL : eventfd_ctx_fdget(f.f=
d);
>   		if (IS_ERR(ctx)) {
>   			r =3D PTR_ERR(ctx);
>   			break;
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index 9fe72e4..0c23496 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -15,6 +15,8 @@
>   #include <linux/types.h>
>   #include <linux/ioctl.h>
>  =20
> +#define VHOST_FILE_UNBIND -1


I think we need a separate patch for introducing this since we touches=20
vhost.c

Thanks


> +
>   /* ioctls */
>  =20
>   #define VHOST_VIRTIO 0xAF
> @@ -140,4 +142,6 @@
>   /* Get the max ring size. */
>   #define VHOST_VDPA_GET_VRING_NUM	_IOR(VHOST_VIRTIO, 0x76, __u16)
>  =20
> +/* Set event fd for config interrupt*/
> +#define VHOST_VDPA_SET_CONFIG_CALL	_IOW(VHOST_VIRTIO, 0x77, int)
>   #endif
