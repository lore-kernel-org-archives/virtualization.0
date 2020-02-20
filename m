From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH V4 5/5] vdpasim: vDPA device simulator
Date: Thu, 20 Feb 2020 15:12:18 +0000
Message-ID: <20200220151215.GU23930@mellanox.com>
References: <20200220061141.29390-1-jasowang@redhat.com>
 <20200220061141.29390-6-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200220061141.29390-6-jasowang@redhat.com>
Content-Language: en-US
Content-ID: <27D03B0CCFB76D4196FC8C2FF59A0D07@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "tiwei.bie@intel.com" <tiwei.bie@intel.com>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>, "cunming.liang@intel.com" <cunming.liang@intel.com>, "zhihong.wang@intel.com" <zhihong.wang@intel.com>, "rob.miller@broadcom.com" <rob.miller@broadcom.com>, "xiao.w.wang@intel.com" <xiao.w.wang@intel.com>, "haotian.wang@sifive.com" <haotian.wang@sifive.com>, "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "lulu@redhat.com" <lulu@redhat.co>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 20, 2020 at 02:11:41PM +0800, Jason Wang wrote:
> +static void vdpasim_device_release(struct device *dev)
> +{
> +	struct vdpasim *vdpasim =3D dev_to_sim(dev);
> +
> +	cancel_work_sync(&vdpasim->work);
> +	kfree(vdpasim->buffer);
> +	vhost_iotlb_free(vdpasim->iommu);
> +	kfree(vdpasim);
> +}
> +
> +static struct vdpasim *vdpasim_create(void)
> +{
> +	struct virtio_net_config *config;
> +	struct vhost_iotlb *iommu;
> +	struct vdpasim *vdpasim;
> +	struct device *dev;
> +	void *buffer;
> +	int ret =3D -ENOMEM;
> +
> +	iommu =3D vhost_iotlb_alloc(2048, 0);
> +	if (!iommu)
> +		goto err;
> +
> +	buffer =3D kmalloc(PAGE_SIZE, GFP_KERNEL);
> +	if (!buffer)
> +		goto err_buffer;
> +
> +	vdpasim =3D kzalloc(sizeof(*vdpasim), GFP_KERNEL);
> +	if (!vdpasim)
> +		goto err_alloc;
> +
> +	vdpasim->buffer =3D buffer;
> +	vdpasim->iommu =3D iommu;
> +
> +	config =3D &vdpasim->config;
> +	config->mtu =3D 1500;
> +	config->status =3D VIRTIO_NET_S_LINK_UP;
> +	eth_random_addr(config->mac);
> +
> +	INIT_WORK(&vdpasim->work, vdpasim_work);
> +	spin_lock_init(&vdpasim->lock);
> +
> +	vringh_set_iotlb(&vdpasim->vqs[0].vring, vdpasim->iommu);
> +	vringh_set_iotlb(&vdpasim->vqs[1].vring, vdpasim->iommu);
> +
> +	dev =3D &vdpasim->dev;
> +	dev->release =3D vdpasim_device_release;
> +	dev->coherent_dma_mask =3D DMA_BIT_MASK(64);
> +	set_dma_ops(dev, &vdpasim_dma_ops);
> +	dev_set_name(dev, "%s", VDPASIM_NAME);
> +
> +	ret =3D device_register(&vdpasim->dev);
> +	if (ret)
> +		goto err_init;

It is a bit weird to be creating this dummy parent, couldn't this be
done by just passing a NULL parent to vdpa_alloc_device, doing
set_dma_ops() on the vdpasim->vdpa->dev and setting dma_device to
vdpasim->vdpa->dev ?

> +	vdpasim->vdpa =3D vdpa_alloc_device(dev, dev, &vdpasim_net_config_ops);
> +	if (ret)
> +		goto err_vdpa;

> +	ret =3D vdpa_register_device(vdpasim->vdpa);
> +	if (ret)
> +		goto err_register;
> +
> +	return vdpasim;
> +
> +err_register:
> +	put_device(&vdpasim->vdpa->dev);
> +err_vdpa:
> +	device_del(&vdpasim->dev);
> +	goto err;
> +err_init:
> +	put_device(&vdpasim->dev);
> +	goto err;

If you do the vdmasim alloc first, and immediately do
device_initialize() then all the failure paths can do put_device
instead of having this ugly goto unwind split. Just check for
vdpasim->iommu =3D=3D NULL during release.

> +static int __init vdpasim_dev_init(void)
> +{
> +	vdpasim_dev =3D vdpasim_create();
> +
> +	if (!IS_ERR(vdpasim_dev))
> +		return 0;
> +
> +	return PTR_ERR(vdpasim_dev);
> +}
> +
> +static int vdpasim_device_remove_cb(struct device *dev, void *data)
> +{
> +	struct vdpa_device *vdpa =3D dev_to_vdpa(dev);
> +
> +	vdpa_unregister_device(vdpa);
> +
> +	return 0;
> +}
> +
> +static void __exit vdpasim_dev_exit(void)
> +{
> +	device_for_each_child(&vdpasim_dev->dev, NULL,
> +			      vdpasim_device_remove_cb);

Why the loop? There is only one device, and it is in the global
varaible vdmasim_dev ?

Jason
