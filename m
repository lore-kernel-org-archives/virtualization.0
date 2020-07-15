From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH RFC don't apply] vdpa_sim: endian-ness for config space
Date: Wed, 15 Jul 2020 22:02:32 +0800
Message-ID: <8f39dcc1-0899-7ed8-8a6e-75672417b9e3@redhat.com>
References: <20200715135540.22832-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200715135540.22832-1-mst@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


On 2020/7/15 下午9:58, Michael S. Tsirkin wrote:
> VDPA sim stores config space as native endian, but that
> is wrong: modern guests expect LE.
> I coded up the following to fix it up, but it is wrong too:
> vdpasim_create is called before guest features are known.
>
> So what should we do? New ioctl to specify the interface used?
> More ideas?
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


Can we do the endian conversion in set_config/get_config()?

Thanks


>
>
> ---
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index a9bc5e0fb353..cc754ae0ec15 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -24,6 +24,7 @@
>   #include <linux/etherdevice.h>
>   #include <linux/vringh.h>
>   #include <linux/vdpa.h>
> +#include <linux/virtio_byteorder.h>
>   #include <linux/vhost_iotlb.h>
>   #include <uapi/linux/virtio_config.h>
>   #include <uapi/linux/virtio_net.h>
> @@ -72,6 +73,23 @@ struct vdpasim {
>   	u64 features;
>   };
>   
> +/* TODO: cross-endian support */
> +static inline bool vdpasim_is_little_endian(struct vdpasim *vdpasim)
> +{
> +	return virtio_legacy_is_little_endian() ||
> +		(vdpasim->features & (1ULL << VIRTIO_F_VERSION_1));
> +}
> +
> +static inline u16 vdpasim16_to_cpu(struct vdpasim *vdpasim, __virtio16 val)
> +{
> +	return __virtio16_to_cpu(vdpasim_is_little_endian(vdpasim), val);
> +}
> +
> +static inline __virtio16 cpu_to_vdpasim16(struct vdpasim *vdpasim, u16 val)
> +{
> +	return __cpu_to_virtio16(vdpasim_is_little_endian(vdpasim), val);
> +}
> +
>   static struct vdpasim *vdpasim_dev;
>   
>   static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
> @@ -332,8 +350,8 @@ static struct vdpasim *vdpasim_create(void)
>   		goto err_iommu;
>   
>   	config = &vdpasim->config;
> -	config->mtu = 1500;
> -	config->status = VIRTIO_NET_S_LINK_UP;
> +	config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
> +	config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
>   	eth_random_addr(config->mac);
>   
>   	vringh_set_iotlb(&vdpasim->vqs[0].vring, vdpasim->iommu);
