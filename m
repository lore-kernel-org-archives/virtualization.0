From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 3/5] vDPA: introduce vDPA bus
Date: Wed, 12 Feb 2020 15:55:31 +0800
Message-ID: <cf7abcc9-f8ef-1fe2-248e-9b9028788ade@redhat.com>
References: <20200210035608.10002-1-jasowang@redhat.com>
 <20200210035608.10002-4-jasowang@redhat.com>
 <20200211134746.GI4271@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200211134746.GI4271@mellanox.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, tiwei.bie@intel.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/2/11 =E4=B8=8B=E5=8D=889:47, Jason Gunthorpe wrote:
> On Mon, Feb 10, 2020 at 11:56:06AM +0800, Jason Wang wrote:
>> +/**
>> + * vdpa_register_device - register a vDPA device
>> + * Callers must have a succeed call of vdpa_init_device() before.
>> + * @vdev: the vdpa device to be registered to vDPA bus
>> + *
>> + * Returns an error when fail to add to vDPA bus
>> + */
>> +int vdpa_register_device(struct vdpa_device *vdev)
>> +{
>> +	int err =3D device_add(&vdev->dev);
>> +
>> +	if (err) {
>> +		put_device(&vdev->dev);
>> +		ida_simple_remove(&vdpa_index_ida, vdev->index);
>> +	}
> This is a very dangerous construction, I've seen it lead to driver
> bugs. Better to require the driver to always do the put_device on
> error unwind


Ok.


>
> The ida_simple_remove should probably be part of the class release
> function to make everything work right


It looks to me bus instead of class is the correct abstraction here=20
since the devices share a set of programming interface but not the=20
semantics.

Or do you actually mean type here?


>
>> +/**
>> + * vdpa_unregister_driver - unregister a vDPA device driver
>> + * @drv: the vdpa device driver to be unregistered
>> + */
>> +void vdpa_unregister_driver(struct vdpa_driver *drv)
>> +{
>> +	driver_unregister(&drv->driver);
>> +}
>> +EXPORT_SYMBOL_GPL(vdpa_unregister_driver);
>> +
>> +static int vdpa_init(void)
>> +{
>> +	if (bus_register(&vdpa_bus) !=3D 0)
>> +		panic("virtio bus registration failed");
>> +	return 0;
>> +}
> Linus will tell you not to kill the kernel - return the error code and
> propagate it up to the module init function.


Yes, will fix.


>
>> +/**
>> + * vDPA device - representation of a vDPA device
>> + * @dev: underlying device
>> + * @dma_dev: the actual device that is performing DMA
>> + * @config: the configuration ops for this device.
>> + * @index: device index
>> + */
>> +struct vdpa_device {
>> +	struct device dev;
>> +	struct device *dma_dev;
>> +	const struct vdpa_config_ops *config;
>> +	int index;
> unsigned values shuld be unsigned int
>
> Jason


Will fix.

Thanks

>
