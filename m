From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH V2 3/5] vDPA: introduce vDPA bus
Date: Tue, 11 Feb 2020 09:47:46 -0400
Message-ID: <20200211134746.GI4271@mellanox.com>
References: <20200210035608.10002-1-jasowang@redhat.com>
 <20200210035608.10002-4-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200210035608.10002-4-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, tiwei.bie@intel.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Feb 10, 2020 at 11:56:06AM +0800, Jason Wang wrote:
> +/**
> + * vdpa_register_device - register a vDPA device
> + * Callers must have a succeed call of vdpa_init_device() before.
> + * @vdev: the vdpa device to be registered to vDPA bus
> + *
> + * Returns an error when fail to add to vDPA bus
> + */
> +int vdpa_register_device(struct vdpa_device *vdev)
> +{
> +	int err = device_add(&vdev->dev);
> +
> +	if (err) {
> +		put_device(&vdev->dev);
> +		ida_simple_remove(&vdpa_index_ida, vdev->index);
> +	}

This is a very dangerous construction, I've seen it lead to driver
bugs. Better to require the driver to always do the put_device on
error unwind

The ida_simple_remove should probably be part of the class release
function to make everything work right

> +/**
> + * vdpa_unregister_driver - unregister a vDPA device driver
> + * @drv: the vdpa device driver to be unregistered
> + */
> +void vdpa_unregister_driver(struct vdpa_driver *drv)
> +{
> +	driver_unregister(&drv->driver);
> +}
> +EXPORT_SYMBOL_GPL(vdpa_unregister_driver);
> +
> +static int vdpa_init(void)
> +{
> +	if (bus_register(&vdpa_bus) != 0)
> +		panic("virtio bus registration failed");
> +	return 0;
> +}

Linus will tell you not to kill the kernel - return the error code and
propagate it up to the module init function.

> +/**
> + * vDPA device - representation of a vDPA device
> + * @dev: underlying device
> + * @dma_dev: the actual device that is performing DMA
> + * @config: the configuration ops for this device.
> + * @index: device index
> + */
> +struct vdpa_device {
> +	struct device dev;
> +	struct device *dma_dev;
> +	const struct vdpa_config_ops *config;
> +	int index;

unsigned values shuld be unsigned int

Jason
