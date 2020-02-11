From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH V2 5/5] vdpasim: vDPA device simulator
Date: Tue, 11 Feb 2020 09:52:54 -0400
Message-ID: <20200211135254.GJ4271@mellanox.com>
References: <20200210035608.10002-1-jasowang@redhat.com>
 <20200210035608.10002-6-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200210035608.10002-6-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, tiwei.bie@intel.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Feb 10, 2020 at 11:56:08AM +0800, Jason Wang wrote:
> +
> +static struct vdpasim *vdpasim_create(void)
> +{
> +	struct vdpasim *vdpasim;
> +	struct virtio_net_config *config;
> +	struct vdpa_device *vdpa;
> +	struct device *dev;
> +	int ret = -ENOMEM;
> +
> +	vdpasim = kzalloc(sizeof(*vdpasim), GFP_KERNEL);
> +	if (!vdpasim)
> +		goto err_vdpa_alloc;
> +
> +	vdpasim->buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +	if (!vdpasim->buffer)
> +		goto err_buffer_alloc;
> +
> +	vdpasim->iommu = vhost_iotlb_alloc(2048, 0);
> +	if (!vdpasim->iommu)
> +		goto err_iotlb;
> +
> +	config = &vdpasim->config;
> +	config->mtu = 1500;
> +	config->status = VIRTIO_NET_S_LINK_UP;
> +	eth_random_addr(config->mac);
> +
> +	INIT_WORK(&vdpasim->work, vdpasim_work);
> +	spin_lock_init(&vdpasim->lock);
> +
> +	vdpa = &vdpasim->vdpa;
> +	vdpa->dev.release = vdpasim_release_dev;

The driver should not provide the release function.

Again the safest model is 'vdpa_alloc_device' which combines the
kzalloc and the vdpa_init_device() and returns something that is
error unwound with put_device()

The subsystem owns the release and does the kfree and other cleanup
like releasing the IDA.

> +	vringh_set_iotlb(&vdpasim->vqs[0].vring, vdpasim->iommu);
> +	vringh_set_iotlb(&vdpasim->vqs[1].vring, vdpasim->iommu);
> +
> +	dev = &vdpa->dev;
> +	dev->coherent_dma_mask = DMA_BIT_MASK(64);
> +	set_dma_ops(dev, &vdpasim_dma_ops);
> +
> +	ret = vdpa_init_device(vdpa, &vdpasim_dev->dev, dev,
> +			       &vdpasim_net_config_ops);
> +	if (ret)
> +		goto err_init;
> +
> +	ret = vdpa_register_device(vdpa);
> +	if (ret)
> +		goto err_register;

See? This error unwind is now all wrong:

> +
> +	return vdpasim;
> +
> +err_register:
> +	put_device(&vdpa->dev);

Double put_device

> +err_init:
> +	vhost_iotlb_free(vdpasim->iommu);
> +err_iotlb:
> +	kfree(vdpasim->buffer);
> +err_buffer_alloc:
> +	kfree(vdpasim);

kfree after vdpa_init_device() is incorrect, as the put_device now
does kfree via release

> +static int __init vdpasim_dev_init(void)
> +{
> +	struct device *dev;
> +	int ret = 0;
> +
> +	vdpasim_dev = kzalloc(sizeof(*vdpasim_dev), GFP_KERNEL);
> +	if (!vdpasim_dev)
> +		return -ENOMEM;
> +
> +	dev = &vdpasim_dev->dev;
> +	dev->release = vdpasim_device_release;
> +	dev_set_name(dev, "%s", VDPASIM_NAME);
> +
> +	ret = device_register(&vdpasim_dev->dev);
> +	if (ret)
> +		goto err_register;
> +
> +	if (!vdpasim_create())
> +		goto err_register;

Wrong error unwind here too

> +	return 0;
> +
> +err_register:
> +	kfree(vdpasim_dev);
> +	vdpasim_dev = NULL;
> +	return ret;
> +}

Jason
