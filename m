From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 3/5] vDPA: introduce vDPA bus
Date: Fri, 17 Jan 2020 21:52:28 +0800
Message-ID: <239b042c-2d9e-0eec-a1ef-b03b7e2c5419@redhat.com>
References: <20200116124231.20253-1-jasowang@redhat.com>
 <20200116124231.20253-4-jasowang@redhat.com>
 <20200117070324-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200117070324-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, tiwei.bie@intel.com, jgg@mellanox.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jakub.kicinski@netronome.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/1/17 =E4=B8=8B=E5=8D=888:13, Michael S. Tsirkin wrote:
> On Thu, Jan 16, 2020 at 08:42:29PM +0800, Jason Wang wrote:
>> vDPA device is a device that uses a datapath which complies with the
>> virtio specifications with vendor specific control path. vDPA devices
>> can be both physically located on the hardware or emulated by
>> software. vDPA hardware devices are usually implemented through PCIE
>> with the following types:
>>
>> - PF (Physical Function) - A single Physical Function
>> - VF (Virtual Function) - Device that supports single root I/O
>>    virtualization (SR-IOV). Its Virtual Function (VF) represents a
>>    virtualized instance of the device that can be assigned to differen=
t
>>    partitions
>> - VDEV (Virtual Device) - With technologies such as Intel Scalable
>>    IOV, a virtual device composed by host OS utilizing one or more
>>    ADIs.
>> - SF (Sub function) - Vendor specific interface to slice the Physical
>>    Function to multiple sub functions that can be assigned to differen=
t
>>    partitions as virtual devices.
>>
>> >From a driver's perspective, depends on how and where the DMA
>> translation is done, vDPA devices are split into two types:
>>
>> - Platform specific DMA translation - From the driver's perspective,
>>    the device can be used on a platform where device access to data in
>>    memory is limited and/or translated. An example is a PCIE vDPA whos=
e
>>    DMA request was tagged via a bus (e.g PCIE) specific way. DMA
>>    translation and protection are done at PCIE bus IOMMU level.
>> - Device specific DMA translation - The device implements DMA
>>    isolation and protection through its own logic. An example is a vDP=
A
>>    device which uses on-chip IOMMU.
>>
>> To hide the differences and complexity of the above types for a vDPA
>> device/IOMMU options and in order to present a generic virtio device
>> to the upper layer, a device agnostic framework is required.
>>
>> This patch introduces a software vDPA bus which abstracts the
>> common attributes of vDPA device, vDPA bus driver and the
>> communication method (vdpa_config_ops) between the vDPA device
>> abstraction and the vDPA bus driver:
>>
>> With the abstraction of vDPA bus and vDPA bus operations, the
>> difference and complexity of the under layer hardware is hidden from
>> upper layer. The vDPA bus drivers on top can use a unified
>> vdpa_config_ops to control different types of vDPA device.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   MAINTAINERS                  |   1 +
>>   drivers/virtio/Kconfig       |   2 +
>>   drivers/virtio/Makefile      |   1 +
>>   drivers/virtio/vdpa/Kconfig  |   9 ++
>>   drivers/virtio/vdpa/Makefile |   2 +
>>   drivers/virtio/vdpa/vdpa.c   | 141 ++++++++++++++++++++++++++
>>   include/linux/vdpa.h         | 191 +++++++++++++++++++++++++++++++++=
++
>>   7 files changed, 347 insertions(+)
>>   create mode 100644 drivers/virtio/vdpa/Kconfig
>>   create mode 100644 drivers/virtio/vdpa/Makefile
>>   create mode 100644 drivers/virtio/vdpa/vdpa.c
>>   create mode 100644 include/linux/vdpa.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index d4bda9c900fa..578d2a581e3b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -17540,6 +17540,7 @@ F:	tools/virtio/
>>   F:	drivers/net/virtio_net.c
>>   F:	drivers/block/virtio_blk.c
>>   F:	include/linux/virtio*.h
>> +F:	include/linux/vdpa.h
>>   F:	include/uapi/linux/virtio_*.h
>>   F:	drivers/crypto/virtio/
>>   F:	mm/balloon_compaction.c
>> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
>> index 078615cf2afc..9c4fdb64d9ac 100644
>> --- a/drivers/virtio/Kconfig
>> +++ b/drivers/virtio/Kconfig
>> @@ -96,3 +96,5 @@ config VIRTIO_MMIO_CMDLINE_DEVICES
>>   	 If unsure, say 'N'.
>>  =20
>>   endif # VIRTIO_MENU
>> +
>> +source "drivers/virtio/vdpa/Kconfig"
>> diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
>> index 3a2b5c5dcf46..fdf5eacd0d0a 100644
>> --- a/drivers/virtio/Makefile
>> +++ b/drivers/virtio/Makefile
>> @@ -6,3 +6,4 @@ virtio_pci-y :=3D virtio_pci_modern.o virtio_pci_commo=
n.o
>>   virtio_pci-$(CONFIG_VIRTIO_PCI_LEGACY) +=3D virtio_pci_legacy.o
>>   obj-$(CONFIG_VIRTIO_BALLOON) +=3D virtio_balloon.o
>>   obj-$(CONFIG_VIRTIO_INPUT) +=3D virtio_input.o
>> +obj-$(CONFIG_VDPA) +=3D vdpa/
>> diff --git a/drivers/virtio/vdpa/Kconfig b/drivers/virtio/vdpa/Kconfig
>> new file mode 100644
>> index 000000000000..3032727b4d98
>> --- /dev/null
>> +++ b/drivers/virtio/vdpa/Kconfig
>> @@ -0,0 +1,9 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +config VDPA
>> +	tristate
>> +        default n
>> +        help
>> +          Enable this module to support vDPA device that uses a
>> +          datapath which complies with virtio specifications with
>> +          vendor specific control path.
>> +
>> diff --git a/drivers/virtio/vdpa/Makefile b/drivers/virtio/vdpa/Makefi=
le
>> new file mode 100644
>> index 000000000000..ee6a35e8a4fb
>> --- /dev/null
>> +++ b/drivers/virtio/vdpa/Makefile
>> @@ -0,0 +1,2 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +obj-$(CONFIG_VDPA) +=3D vdpa.o
>> diff --git a/drivers/virtio/vdpa/vdpa.c b/drivers/virtio/vdpa/vdpa.c
>> new file mode 100644
>> index 000000000000..2b0e4a9f105d
>> --- /dev/null
>> +++ b/drivers/virtio/vdpa/vdpa.c
>> @@ -0,0 +1,141 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * vDPA bus.
>> + *
>> + * Copyright (c) 2019, Red Hat. All rights reserved.
>> + *     Author: Jason Wang <jasowang@redhat.com>
>> + *
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/idr.h>
>> +#include <linux/vdpa.h>
>> +
>> +#define MOD_VERSION  "0.1"
>> +#define MOD_DESC     "vDPA bus"
>> +#define MOD_AUTHOR   "Jason Wang <jasowang@redhat.com>"
>> +#define MOD_LICENSE  "GPL v2"
>> +
>> +static DEFINE_IDA(vdpa_index_ida);
>> +
>> +struct device *vdpa_get_parent(struct vdpa_device *vdpa)
>> +{
>> +	return vdpa->dev.parent;
>> +}
>> +EXPORT_SYMBOL(vdpa_get_parent);
>> +
>> +void vdpa_set_parent(struct vdpa_device *vdpa, struct device *parent)
>> +{
>> +	vdpa->dev.parent =3D parent;
>> +}
>> +EXPORT_SYMBOL(vdpa_set_parent);
>> +
>> +struct vdpa_device *dev_to_vdpa(struct device *_dev)
>> +{
>> +	return container_of(_dev, struct vdpa_device, dev);
>> +}
>> +EXPORT_SYMBOL_GPL(dev_to_vdpa);
>> +
>> +struct device *vdpa_to_dev(struct vdpa_device *vdpa)
>> +{
>> +	return &vdpa->dev;
>> +}
>> +EXPORT_SYMBOL_GPL(vdpa_to_dev);
>> +
>> +static int vdpa_dev_probe(struct device *d)
>> +{
>> +	struct vdpa_device *dev =3D dev_to_vdpa(d);
>> +	struct vdpa_driver *drv =3D drv_to_vdpa(dev->dev.driver);
>> +	int ret =3D 0;
>> +
>> +	if (drv && drv->probe)
>> +		ret =3D drv->probe(d);
>> +
>> +	return ret;
>> +}
>> +
>> +static int vdpa_dev_remove(struct device *d)
>> +{
>> +	struct vdpa_device *dev =3D dev_to_vdpa(d);
>> +	struct vdpa_driver *drv =3D drv_to_vdpa(dev->dev.driver);
>> +
>> +	if (drv && drv->remove)
>> +		drv->remove(d);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct bus_type vdpa_bus =3D {
>> +	.name  =3D "vdpa",
>> +	.probe =3D vdpa_dev_probe,
>> +	.remove =3D vdpa_dev_remove,
>> +};
>> +
>> +int register_vdpa_device(struct vdpa_device *vdpa)
>> +{
>> +	int err;
>> +
>> +	if (!vdpa_get_parent(vdpa))
>> +		return -EINVAL;
>> +
>> +	if (!vdpa->config)
>> +		return -EINVAL;
>> +
>> +	err =3D ida_simple_get(&vdpa_index_ida, 0, 0, GFP_KERNEL);
>> +	if (err < 0)
>> +		return -EFAULT;
>> +
>> +	vdpa->dev.bus =3D &vdpa_bus;
>> +	device_initialize(&vdpa->dev);
>> +
>> +	vdpa->index =3D err;
>> +	dev_set_name(&vdpa->dev, "vdpa%u", vdpa->index);
>> +
>> +	err =3D device_add(&vdpa->dev);
>> +	if (err)
>> +		ida_simple_remove(&vdpa_index_ida, vdpa->index);
>> +
>> +	return err;
>> +}
>> +EXPORT_SYMBOL_GPL(register_vdpa_device);
>> +
>> +void unregister_vdpa_device(struct vdpa_device *vdpa)
>> +{
>> +	int index =3D vdpa->index;
>> +
>> +	device_unregister(&vdpa->dev);
>> +	ida_simple_remove(&vdpa_index_ida, index);
>> +}
>> +EXPORT_SYMBOL_GPL(unregister_vdpa_device);
>> +
>> +int register_vdpa_driver(struct vdpa_driver *driver)
>> +{
>> +	driver->drv.bus =3D &vdpa_bus;
>> +	return driver_register(&driver->drv);
>> +}
>> +EXPORT_SYMBOL_GPL(register_vdpa_driver);
>> +
>> +void unregister_vdpa_driver(struct vdpa_driver *driver)
>> +{
>> +	driver_unregister(&driver->drv);
>> +}
>> +EXPORT_SYMBOL_GPL(unregister_vdpa_driver);
>> +
>> +static int vdpa_init(void)
>> +{
>> +	if (bus_register(&vdpa_bus) !=3D 0)
>> +		panic("virtio bus registration failed");
>> +	return 0;
>> +}
>> +
>> +static void __exit vdpa_exit(void)
>> +{
>> +	bus_unregister(&vdpa_bus);
>> +	ida_destroy(&vdpa_index_ida);
>> +}
>> +core_initcall(vdpa_init);
>> +module_exit(vdpa_exit);
>> +
>> +MODULE_VERSION(MOD_VERSION);
>> +MODULE_AUTHOR(MOD_AUTHOR);
>> +MODULE_LICENSE(MOD_LICENSE);
>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>> new file mode 100644
>> index 000000000000..47760137ef66
>> --- /dev/null
>> +++ b/include/linux/vdpa.h
>> @@ -0,0 +1,191 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_VDPA_H
>> +#define _LINUX_VDPA_H
>> +
>> +#include <linux/device.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/vhost_iotlb.h>
>> +
>> +/**
>> + * vDPA callback definition.
>> + * @callback: interrupt callback function
>> + * @private: the data passed to the callback function
>> + */
>> +struct vdpa_callback {
>> +	irqreturn_t (*callback)(void *data);
>> +	void *private;
>> +};
>> +
>> +/**
>> + * vDPA device - representation of a vDPA device
>> + * @dev: underlying device
>> + * @config: the configuration ops for this device.
>> + * @index: device index
>> + */
>> +struct vdpa_device {
>> +	struct device dev;
>> +	const struct vdpa_config_ops *config;
>> +	int index;
>> +};
>> +
>> +/**
>> + * vDPA_config_ops - operations for configuring a vDPA device.
>> + * Note: vDPA device drivers are required to implement all of the
>> + * operations unless it is optional mentioned in the following list.
>> + * @set_vq_address:		Set the address of virtqueue
>> + *				@vdev: vdpa device
>> + *				@idx: virtqueue index
>> + *				@desc_area: address of desc area
>> + *				@driver_area: address of driver area
>> + *				@device_area: address of device area
>> + *				Returns integer: success (0) or error (< 0)
>> + * @set_vq_num:			Set the size of virtqueue
>> + *				@vdev: vdpa device
>> + *				@idx: virtqueue index
>> + *				@num: the size of virtqueue
>> + * @kick_vq:			Kick the virtqueue
>> + *				@vdev: vdpa device
>> + *				@idx: virtqueue index
>
> This seems wrong: kicks are data path so drivers should not
> do it in a vendor specific way.


I'm not sure I get this since the doorbell is pretty vendor specific.

The idea here is to start form simple and common cases that can work for=20
both kernel virtio drivers and vhost:

- For kernel, kick_vq() is called from vq->notify() directly
- For vhost, vhost is in charge of hook eventfd to kick_vq()


>   How about an API
> returning the device/resource that can then be
> mapped as appropriate?
>

Yes, this could be a further optimization on top but not a must (only=20
work for e.g the doorbell does not share MMIO space with other=20
functions). For vhost we need something like this and need to hook it to=20
mmap() of vhost file descriptor.


>> + * @set_vq_cb:			Set the interrupt callback function for
>> + *				a virtqueue
>> + *				@vdev: vdpa device
>> + *				@idx: virtqueue index
>> + *				@cb: virtio-vdev interrupt callback structure
>
> Calls are data path too, I think we need some way to map MSI?


Similarly, this could be a optimization on top, and we can start from=20
simple and common cases:

- For kernel, the vq callback could be mapped to MSI interrupt handler=20
directly
- For vhost, eventfd wakeup could be hook in the cb here


>
>> + * @set_vq_ready:		Set ready status for a virtqueue
>> + *				@vdev: vdpa device
>> + *				@idx: virtqueue index
>> + *				@ready: ready (true) not ready(false)
>> + * @get_vq_ready:		Get ready status for a virtqueue
>> + *				@vdev: vdpa device
>> + *				@idx: virtqueue index
>> + *				Returns boolean: ready (true) or not (false)
>> + * @set_vq_state:		Set the state for a virtqueue
>> + *				@vdev: vdpa device
>> + *				@idx: virtqueue index
>> + *				@state: virtqueue state (last_avail_idx)
>> + *				Returns integer: success (0) or error (< 0)
>> + * @get_vq_state:		Get the state for a virtqueue
>> + *				@vdev: vdpa device
>> + *				@idx: virtqueue index
>> + *				Returns virtqueue state (last_avail_idx)
>> + * @get_vq_align:		Get the virtqueue align requirement
>> + *				for the device
>> + *				@vdev: vdpa device
>> + *				Returns virtqueue algin requirement
>
> Where does this come from? Spec dictates that for a data path,
> vendor specific values for this will break userspace ...


It comes from the align parameter of vring_create_virtqueue(). We can=20
expose the alignment to userspace if necessary. If it's not necessary, I=20
can drop this method here.


>
>> + * @get_features:		Get virtio features supported by the device
>> + *				@vdev: vdpa device
>> + *				Returns the virtio features support by the
>> + *				device
>> + * @set_features:		Set virtio features supported by the driver
>> + *				@vdev: vdpa device
>> + *				@features: feature support by the driver
>> + *				Returns integer: success (0) or error (< 0)
>> + * @set_config_cb:		Set the config interrupt callback
>> + *				@vdev: vdpa device
>> + *				@cb: virtio-vdev interrupt callback structure
>> + * @get_vq_num_max:		Get the max size of virtqueue
>> + *				@vdev: vdpa device
>> + *				Returns u16: max size of virtqueue
>
> I'm not sure this has to be uniform across VQs.


Let me add an index parameter to this.


>
>> + * @get_device_id:		Get virtio device id
>> + *				@vdev: vdpa device
>> + *				Returns u32: virtio device id
>
> is this the virtio ID? PCI ID?


Virtio ID


>
>> + * @get_vendor_id:		Get id for the vendor that provides this device
>> + *				@vdev: vdpa device
>> + *				Returns u32: virtio vendor id
> what's the idea behind this? userspace normally doesn't interact with
> this ... debugging?


This allows some vendor specific driver on top of vDPA bus. If this is=20
not interested, I can drop this.


>
>> + * @get_status:			Get the device status
>> + *				@vdev: vdpa device
>> + *				Returns u8: virtio device status
>> + * @set_status:			Set the device status
>> + *				@vdev: vdpa device
>> + *				@status: virtio device status
>> + * @get_config:			Read from device specific configuration space
>> + *				@vdev: vdpa device
>> + *				@offset: offset from the beginning of
>> + *				configuration space
>> + *				@buf: buffer used to read to
>> + *				@len: the length to read from
>> + *				configuration space
>> + * @set_config:			Write to device specific configuration space
>> + *				@vdev: vdpa device
>> + *				@offset: offset from the beginning of
>> + *				configuration space
>> + *				@buf: buffer used to write from
>> + *				@len: the length to write to
>> + *				configuration space
>> + * @get_generation:		Get device config generation (optional)
>> + *				@vdev: vdpa device
>> + *				Returns u32: device generation
>> + * @set_map:			Set device memory mapping, optional
>> + *				and only needed for device that using
>> + *				device specific DMA translation
>> + *				(on-chip IOMMU)
>> + *				@vdev: vdpa device
>> + *				@iotlb: vhost memory mapping to be
>> + *				used by the vDPA
>> + *				Returns integer: success (0) or error (< 0)
> OK so any change just swaps in a completely new mapping?
> Wouldn't this make minor changes such as memory hotplug
> quite expensive?


My understanding is that the incremental updating of the on chip IOMMU=20
may degrade the=C2=A0 performance. So vendor vDPA drivers may want to kno=
w=20
all the mappings at once. Technically, we can keep the incremental API=20
here and let the vendor vDPA drivers to record the full mapping=20
internally which may slightly increase the complexity of vendor driver.=20
We need more inputs from vendors here.

Thanks


>
>> + */
>> +struct vdpa_config_ops {
>> +	/* Virtqueue ops */
>> +	int (*set_vq_address)(struct vdpa_device *vdev,
>> +			      u16 idx, u64 desc_area, u64 driver_area,
>> +			      u64 device_area);
>> +	void (*set_vq_num)(struct vdpa_device *vdev, u16 idx, u32 num);
>> +	void (*kick_vq)(struct vdpa_device *vdev, u16 idx);
>> +	void (*set_vq_cb)(struct vdpa_device *vdev, u16 idx,
>> +			  struct vdpa_callback *cb);
>> +	void (*set_vq_ready)(struct vdpa_device *vdev, u16 idx, bool ready);
>> +	bool (*get_vq_ready)(struct vdpa_device *vdev, u16 idx);
>> +	int (*set_vq_state)(struct vdpa_device *vdev, u16 idx, u64 state);
>> +	u64 (*get_vq_state)(struct vdpa_device *vdev, u16 idx);
>> +
>> +	/* Device ops */
>> +	u16 (*get_vq_align)(struct vdpa_device *vdev);
>> +	u64 (*get_features)(struct vdpa_device *vdev);
>> +	int (*set_features)(struct vdpa_device *vdev, u64 features);
>> +	void (*set_config_cb)(struct vdpa_device *vdev,
>> +			      struct vdpa_callback *cb);
>> +	u16 (*get_vq_num_max)(struct vdpa_device *vdev);
>> +	u32 (*get_device_id)(struct vdpa_device *vdev);
>> +	u32 (*get_vendor_id)(struct vdpa_device *vdev);
>> +	u8 (*get_status)(struct vdpa_device *vdev);
>> +	void (*set_status)(struct vdpa_device *vdev, u8 status);
>> +	void (*get_config)(struct vdpa_device *vdev, unsigned int offset,
>> +			   void *buf, unsigned int len);
>> +	void (*set_config)(struct vdpa_device *vdev, unsigned int offset,
>> +			   const void *buf, unsigned int len);
>> +	u32 (*get_generation)(struct vdpa_device *vdev);
>> +
>> +	/* Mem table */
>> +	int (*set_map)(struct vdpa_device *vdev, struct vhost_iotlb *iotlb);
>> +};
>> +
>> +int register_vdpa_device(struct vdpa_device *vdpa);
>> +void unregister_vdpa_device(struct vdpa_device *vdpa);
>> +
>> +struct device *vdpa_get_parent(struct vdpa_device *vdpa);
>> +void vdpa_set_parent(struct vdpa_device *vdpa, struct device *parent)=
;
>> +
>> +struct vdpa_device *dev_to_vdpa(struct device *_dev);
>> +struct device *vdpa_to_dev(struct vdpa_device *vdpa);
>> +
>> +/**
>> + * vdpa_driver - operations for a vDPA driver
>> + * @driver: underlying device driver
>> + * @probe: the function to call when a device is found.  Returns 0 or=
 -errno.
>> + * @remove: the function to call when a device is removed.
>> + */
>> +struct vdpa_driver {
>> +	struct device_driver drv;
>> +	int (*probe)(struct device *dev);
>> +	void (*remove)(struct device *dev);
>> +};
>> +
>> +int register_vdpa_driver(struct vdpa_driver *drv);
>> +void unregister_vdpa_driver(struct vdpa_driver *drv);
>> +
>> +static inline struct vdpa_driver *drv_to_vdpa(struct device_driver *d=
rv)
>> +{
>> +	return container_of(drv, struct vdpa_driver, drv);
>> +}
>> +
>> +#endif /* _LINUX_VDPA_H */
>> --=20
>> 2.19.1
