From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 5/5] vdpasim: vDPA device simulator
Date: Thu, 16 Jan 2020 15:47:01 +0000
Message-ID: <20200116154658.GJ20978@mellanox.com>
References: <20200116124231.20253-1-jasowang@redhat.com>
 <20200116124231.20253-6-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200116124231.20253-6-jasowang@redhat.com>
Content-Language: en-US
Content-ID: <2168E1773A68F84989C86DC2620C0247@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "tiwei.bie@intel.com" <tiwei.bie@intel.com>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>, "cunming.liang@intel.com" <cunming.liang@intel.com>, "zhihong.wang@intel.com" <zhihong.wang@intel.com>, "rob.miller@broadcom.com" <rob.miller@broadcom.com>, "xiao.w.wang@intel.com" <xiao.w.wang@intel.com>, "haotian.wang@sifive.com" <haotian.wang@sifive.com>, "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "lulu@redhat.com" <lulu@redhat.co>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 16, 2020 at 08:42:31PM +0800, Jason Wang wrote:
> This patch implements a software vDPA networking device. The datapath
> is implemented through vringh and workqueue. The device has an on-chip
> IOMMU which translates IOVA to PA. For kernel virtio drivers, vDPA
> simulator driver provides dma_ops. For vhost driers, set_map() methods
> of vdpa_config_ops is implemented to accept mappings from vhost.
>=20
> A sysfs based management interface is implemented, devices are
> created and removed through:
>=20
> /sys/devices/virtual/vdpa_simulator/netdev/{create|remove}

This is very gross, creating a class just to get a create/remove and
then not using the class for anything else? Yuk.

> Netlink based lifecycle management could be implemented for vDPA
> simulator as well.

This is just begging for a netlink based approach.

Certainly netlink driven removal should be an agreeable standard for
all devices, I think.

> +struct vdpasim_virtqueue {
> +	struct vringh vring;
> +	struct vringh_kiov iov;
> +	unsigned short head;
> +	bool ready;
> +	u64 desc_addr;
> +	u64 device_addr;
> +	u64 driver_addr;
> +	u32 num;
> +	void *private;
> +	irqreturn_t (*cb)(void *data);
> +};
> +
> +#define VDPASIM_QUEUE_ALIGN PAGE_SIZE
> +#define VDPASIM_QUEUE_MAX 256
> +#define VDPASIM_DEVICE_ID 0x1
> +#define VDPASIM_VENDOR_ID 0
> +#define VDPASIM_VQ_NUM 0x2
> +#define VDPASIM_CLASS_NAME "vdpa_simulator"
> +#define VDPASIM_NAME "netdev"
> +
> +u64 vdpasim_features =3D (1ULL << VIRTIO_F_ANY_LAYOUT) |
> +		       (1ULL << VIRTIO_F_VERSION_1)  |
> +		       (1ULL << VIRTIO_F_IOMMU_PLATFORM);

Is not using static here intentional?

> +static void vdpasim_release_dev(struct device *_d)
> +{
> +	struct vdpa_device *vdpa =3D dev_to_vdpa(_d);
> +	struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
> +
> +	sysfs_remove_link(vdpasim_dev->devices_kobj, vdpasim->name);
> +
> +	mutex_lock(&vsim_list_lock);
> +	list_del(&vdpasim->next);
> +	mutex_unlock(&vsim_list_lock);
> +
> +	kfree(vdpasim->buffer);
> +	kfree(vdpasim);
> +}

It is again a bit weird to see a realease function in a driver. This
stuff is usually in the remove remove function.

> +static int vdpasim_create(const guid_t *uuid)
> +{
> +	struct vdpasim *vdpasim, *tmp;
> +	struct virtio_net_config *config;
> +	struct vdpa_device *vdpa;
> +	struct device *dev;
> +	int ret =3D -ENOMEM;
> +
> +	mutex_lock(&vsim_list_lock);
> +	list_for_each_entry(tmp, &vsim_devices_list, next) {
> +		if (guid_equal(&tmp->uuid, uuid)) {
> +			mutex_unlock(&vsim_list_lock);
> +			return -EEXIST;
> +		}
> +	}
> +
> +	vdpasim =3D kzalloc(sizeof(*vdpasim), GFP_KERNEL);
> +	if (!vdpasim)
> +		goto err_vdpa_alloc;
> +
> +	vdpasim->buffer =3D kmalloc(PAGE_SIZE, GFP_KERNEL);
> +	if (!vdpasim->buffer)
> +		goto err_buffer_alloc;
> +
> +	vdpasim->iommu =3D vhost_iotlb_alloc(2048, 0);
> +	if (!vdpasim->iommu)
> +		goto err_iotlb;
> +
> +	config =3D &vdpasim->config;
> +	config->mtu =3D 1500;
> +	config->status =3D VIRTIO_NET_S_LINK_UP;
> +	eth_random_addr(config->mac);
> +
> +	INIT_WORK(&vdpasim->work, vdpasim_work);
> +	spin_lock_init(&vdpasim->lock);
> +
> +	guid_copy(&vdpasim->uuid, uuid);
> +
> +	list_add(&vdpasim->next, &vsim_devices_list);
> +	vdpa =3D &vdpasim->vdpa;
> +
> +	mutex_unlock(&vsim_list_lock);
> +
> +	vdpa =3D &vdpasim->vdpa;
> +	vdpa->config =3D &vdpasim_net_config_ops;
> +	vdpa_set_parent(vdpa, &vdpasim_dev->dev);
> +	vdpa->dev.release =3D vdpasim_release_dev;
> +
> +	vringh_set_iotlb(&vdpasim->vqs[0].vring, vdpasim->iommu);
> +	vringh_set_iotlb(&vdpasim->vqs[1].vring, vdpasim->iommu);
> +
> +	dev =3D &vdpa->dev;
> +	dev->coherent_dma_mask =3D DMA_BIT_MASK(64);
> +	set_dma_ops(dev, &vdpasim_dma_ops);
> +
> +	ret =3D register_vdpa_device(vdpa);
> +	if (ret)
> +		goto err_register;
> +
> +	sprintf(vdpasim->name, "%pU", uuid);
>+
> +	ret =3D sysfs_create_link(vdpasim_dev->devices_kobj, &vdpa->dev.kobj,
> +				vdpasim->name);
> +	if (ret)
> +		goto err_link;

The goto err_link does the wrong unwind, once register is completed
the error unwind is unregister & put_device, not kfree. This is why I
recommend to always initalize the device early, and always using
put_device during error unwinds.

This whole guid thing seems unncessary when the device is immediately
assigned a vdpa index from the ida. If you were not using syfs you'd
just return that index from the creation netlink.

Jason
