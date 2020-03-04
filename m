From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH V5 3/5] vDPA: introduce vDPA bus
Date: Wed, 4 Mar 2020 15:29:49 -0400
Message-ID: <20200304192949.GR26318@mellanox.com>
References: <20200226060456.27275-1-jasowang@redhat.com>
 <20200226060456.27275-4-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200226060456.27275-4-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, tiwei.bie@intel.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 26, 2020 at 02:04:54PM +0800, Jason Wang wrote:
> +struct vdpa_device *vdpa_alloc_device(struct device *parent,
> +				      struct device *dma_dev,
> +				      const struct vdpa_config_ops *config)
> +{
> +	struct vdpa_device *vdev;
> +	int err = -ENOMEM;
> +
> +	if (!parent || !dma_dev || !config)
> +		goto err;
> +
> +	vdev = kzalloc(sizeof(*vdev), GFP_KERNEL);
> +	if (!vdev)
> +		goto err;
> +
> +	err = ida_simple_get(&vdpa_index_ida, 0, 0, GFP_KERNEL);
> +	if (err < 0)
> +		goto err_ida;
> +
> +	vdev->dev.bus = &vdpa_bus;
> +	vdev->dev.parent = parent;
> +	vdev->dev.release = vdpa_release_dev;
> +
> +	device_initialize(&vdev->dev);
> +
> +	vdev->index = err;
> +	vdev->dma_dev = dma_dev;
> +	vdev->config = config;
> +
> +	dev_set_name(&vdev->dev, "vdpa%u", vdev->index);

Probably shouldn't ignore the error for dev_set_name ?

err = dev_set_name()
if (err) {
   put_device(&vdev->dev);
   return ERR_PTR(err);
}

Jason
