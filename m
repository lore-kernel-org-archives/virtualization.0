From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/2] vdpa: Support config interrupt in vhost_vdpa
Date: Sun, 26 Apr 2020 11:07:03 +0800
Message-ID: <cb656c27-22a8-3a18-9e3a-68fa0c3ff06b@redhat.com>
References: <1587722659-1300-1-git-send-email-lingshan.zhu@intel.com>
 <1587722659-1300-2-git-send-email-lingshan.zhu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1587722659-1300-2-git-send-email-lingshan.zhu@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: lulu@redhat.com, dan.daly@intel.com, cunming.liang@intel.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/4/24 =E4=B8=8B=E5=8D=886:04, Zhu Lingshan wrote:
> This commit implements config interrupt support in
> vhost_vdpa layer.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>


One should be sufficient.


> ---
>   drivers/vhost/vdpa.c             | 53 +++++++++++++++++++++++++++++++=
+++++++++
>   include/uapi/linux/vhost.h       |  2 ++
>   include/uapi/linux/vhost_types.h |  2 ++
>   3 files changed, 57 insertions(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 421f02a..f1f69bf 100644
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
> @@ -288,6 +301,42 @@ static long vhost_vdpa_get_vring_num(struct vhost_=
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
> +	vhost_config_file file;
> +	struct eventfd_ctx *ctx;
> +
> +	cb.callback =3D vhost_vdpa_config_cb;
> +	cb.private =3D v->vdpa;
> +	if (copy_from_user(&file, argp, sizeof(file)))
> +		return  -EFAULT;
> +
> +	if (file.fd =3D=3D -1) {
> +		vhost_vdpa_config_put(v);
> +		v->config_ctx =3D NULL;
> +		return PTR_ERR(v->config_ctx);
> +	}
> +
> +	ctx =3D eventfd_ctx_fdget(file.fd);


You may simply did ctx =3D f.fd =3D=3D -1 ? NULL : eventfd_ctx_fdget(f.fd=
);

Then there's no need for the specialized action for -1 above.


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
> @@ -398,6 +447,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *=
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
> @@ -734,6 +786,7 @@ static int vhost_vdpa_release(struct inode *inode, =
struct file *filep)
>   	vhost_dev_stop(&v->vdev);
>   	vhost_vdpa_iotlb_free(v);
>   	vhost_vdpa_free_domain(v);
> +	vhost_vdpa_config_put(v);
>   	vhost_dev_cleanup(&v->vdev);
>   	kfree(v->vdev.vqs);
>   	mutex_unlock(&d->mutex);
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index 9fe72e4..c474a35 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -140,4 +140,6 @@
>   /* Get the max ring size. */
>   #define VHOST_VDPA_GET_VRING_NUM	_IOR(VHOST_VIRTIO, 0x76, __u16)
>  =20
> +/* Set event fd for config interrupt*/
> +#define VHOST_VDPA_SET_CONFIG_CALL	_IOW(VHOST_VIRTIO, 0x77, vhost_conf=
ig_file)
>   #endif
> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhos=
t_types.h
> index 669457c..6759aefb 100644
> --- a/include/uapi/linux/vhost_types.h
> +++ b/include/uapi/linux/vhost_types.h
> @@ -27,6 +27,8 @@ struct vhost_vring_file {
>  =20
>   };
>  =20
> +typedef struct vhost_vring_file vhost_config_file;
> +


I wonder maybe this is the best approach. Maybe it's better to use=20
vhost_vring_file or just use a int (but need document the -1 action).

Thanks


>   struct vhost_vring_addr {
>   	unsigned int index;
>   	/* Option flags. */
