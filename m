From: Rob Miller via Virtualization <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH 3/5] vDPA: introduce vDPA bus
Date: Fri, 17 Jan 2020 09:12:51 -0500
Message-ID: <CAJPjb1+fG9L3=iKbV4Vn13VwaeDZZdcfBPvarogF_Nzhk+FnKg@mail.gmail.com>
References: <20200116124231.20253-1-jasowang@redhat.com>
 <20200116124231.20253-4-jasowang@redhat.com>
 <20200117070324-mutt-send-email-mst@kernel.org>
 <239b042c-2d9e-0eec-a1ef-b03b7e2c5419@redhat.com>
Reply-To: Rob Miller <rob.miller@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5303532953766732909=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <239b042c-2d9e-0eec-a1ef-b03b7e2c5419@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Jason Wang <jasowang@redhat.com>
Cc: jakub.kicinski@netronome.com, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, mhabets@solarflare.com, haotian.wang@sifive.com, virtualization@lists.linux-foundation.org, lulu@redhat.com, hanand@xilinx.com, hch@infradead.org, eperezma@redhat.com, Jason Gunthorpe <jgg@mellanox.com>, shahafs@mellanox.com, Parav Pandit <parav@mellanox.com>, Jiri Pirko <jiri@mellanox.com>, "Wang,
 Xiao W" <xiao.w.wang@intel.com>, stefanha@redhat.com, "Wang,
 Zhihong" <zhihong.wang@intel.com>, rdunlap@infradead.org, linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com, Netdev <netdev@vger.kernel.org>, "Zhu, Lingshan" <lingshan.zhu@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

--===============5303532953766732909==
Content-Type: multipart/alternative; boundary="00000000000012b746059c568bad"

--00000000000012b746059c568bad
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2020 at 8:52 AM Jason Wang <jasowang@redhat.com> wrote:

>
> On 2020/1/17 =E4=B8=8B=E5=8D=888:13, Michael S. Tsirkin wrote:
> > On Thu, Jan 16, 2020 at 08:42:29PM +0800, Jason Wang wrote:
> >> vDPA device is a device that uses a datapath which complies with the
> >> virtio specifications with vendor specific control path. vDPA devices
> >> can be both physically located on the hardware or emulated by
> >> software. vDPA hardware devices are usually implemented through PCIE
> >> with the following types:
> >>
> >> - PF (Physical Function) - A single Physical Function
> >> - VF (Virtual Function) - Device that supports single root I/O
> >>    virtualization (SR-IOV). Its Virtual Function (VF) represents a
> >>    virtualized instance of the device that can be assigned to differen=
t
> >>    partitions
> >> - VDEV (Virtual Device) - With technologies such as Intel Scalable
> >>    IOV, a virtual device composed by host OS utilizing one or more
> >>    ADIs.
> >> - SF (Sub function) - Vendor specific interface to slice the Physical
> >>    Function to multiple sub functions that can be assigned to differen=
t
> >>    partitions as virtual devices.
> >>
> >> >From a driver's perspective, depends on how and where the DMA
> >> translation is done, vDPA devices are split into two types:
> >>
> >> - Platform specific DMA translation - From the driver's perspective,
> >>    the device can be used on a platform where device access to data in
> >>    memory is limited and/or translated. An example is a PCIE vDPA whos=
e
> >>    DMA request was tagged via a bus (e.g PCIE) specific way. DMA
> >>    translation and protection are done at PCIE bus IOMMU level.
> >> - Device specific DMA translation - The device implements DMA
> >>    isolation and protection through its own logic. An example is a vDP=
A
> >>    device which uses on-chip IOMMU.
> >>
> >> To hide the differences and complexity of the above types for a vDPA
> >> device/IOMMU options and in order to present a generic virtio device
> >> to the upper layer, a device agnostic framework is required.
> >>
> >> This patch introduces a software vDPA bus which abstracts the
> >> common attributes of vDPA device, vDPA bus driver and the
> >> communication method (vdpa_config_ops) between the vDPA device
> >> abstraction and the vDPA bus driver:
> >>
> >> With the abstraction of vDPA bus and vDPA bus operations, the
> >> difference and complexity of the under layer hardware is hidden from
> >> upper layer. The vDPA bus drivers on top can use a unified
> >> vdpa_config_ops to control different types of vDPA device.
> >>
> >> Signed-off-by: Jason Wang <jasowang@redhat.com>
> >> ---
> >>   MAINTAINERS                  |   1 +
> >>   drivers/virtio/Kconfig       |   2 +
> >>   drivers/virtio/Makefile      |   1 +
> >>   drivers/virtio/vdpa/Kconfig  |   9 ++
> >>   drivers/virtio/vdpa/Makefile |   2 +
> >>   drivers/virtio/vdpa/vdpa.c   | 141 ++++++++++++++++++++++++++
> >>   include/linux/vdpa.h         | 191 +++++++++++++++++++++++++++++++++=
++
> >>   7 files changed, 347 insertions(+)
> >>   create mode 100644 drivers/virtio/vdpa/Kconfig
> >>   create mode 100644 drivers/virtio/vdpa/Makefile
> >>   create mode 100644 drivers/virtio/vdpa/vdpa.c
> >>   create mode 100644 include/linux/vdpa.h
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index d4bda9c900fa..578d2a581e3b 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -17540,6 +17540,7 @@ F:   tools/virtio/
> >>   F: drivers/net/virtio_net.c
> >>   F: drivers/block/virtio_blk.c
> >>   F: include/linux/virtio*.h
> >> +F:  include/linux/vdpa.h
> >>   F: include/uapi/linux/virtio_*.h
> >>   F: drivers/crypto/virtio/
> >>   F: mm/balloon_compaction.c
> >> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> >> index 078615cf2afc..9c4fdb64d9ac 100644
> >> --- a/drivers/virtio/Kconfig
> >> +++ b/drivers/virtio/Kconfig
> >> @@ -96,3 +96,5 @@ config VIRTIO_MMIO_CMDLINE_DEVICES
> >>       If unsure, say 'N'.
> >>
> >>   endif # VIRTIO_MENU
> >> +
> >> +source "drivers/virtio/vdpa/Kconfig"
> >> diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
> >> index 3a2b5c5dcf46..fdf5eacd0d0a 100644
> >> --- a/drivers/virtio/Makefile
> >> +++ b/drivers/virtio/Makefile
> >> @@ -6,3 +6,4 @@ virtio_pci-y :=3D virtio_pci_modern.o virtio_pci_commo=
n.o
> >>   virtio_pci-$(CONFIG_VIRTIO_PCI_LEGACY) +=3D virtio_pci_legacy.o
> >>   obj-$(CONFIG_VIRTIO_BALLOON) +=3D virtio_balloon.o
> >>   obj-$(CONFIG_VIRTIO_INPUT) +=3D virtio_input.o
> >> +obj-$(CONFIG_VDPA) +=3D vdpa/
> >> diff --git a/drivers/virtio/vdpa/Kconfig b/drivers/virtio/vdpa/Kconfig
> >> new file mode 100644
> >> index 000000000000..3032727b4d98
> >> --- /dev/null
> >> +++ b/drivers/virtio/vdpa/Kconfig
> >> @@ -0,0 +1,9 @@
> >> +# SPDX-License-Identifier: GPL-2.0-only
> >> +config VDPA
> >> +    tristate
> >> +        default n
> >> +        help
> >> +          Enable this module to support vDPA device that uses a
> >> +          datapath which complies with virtio specifications with
> >> +          vendor specific control path.
> >> +
> >> diff --git a/drivers/virtio/vdpa/Makefile b/drivers/virtio/vdpa/Makefi=
le
> >> new file mode 100644
> >> index 000000000000..ee6a35e8a4fb
> >> --- /dev/null
> >> +++ b/drivers/virtio/vdpa/Makefile
> >> @@ -0,0 +1,2 @@
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +obj-$(CONFIG_VDPA) +=3D vdpa.o
> >> diff --git a/drivers/virtio/vdpa/vdpa.c b/drivers/virtio/vdpa/vdpa.c
> >> new file mode 100644
> >> index 000000000000..2b0e4a9f105d
> >> --- /dev/null
> >> +++ b/drivers/virtio/vdpa/vdpa.c
> >> @@ -0,0 +1,141 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * vDPA bus.
> >> + *
> >> + * Copyright (c) 2019, Red Hat. All rights reserved.
> >> + *     Author: Jason Wang <jasowang@redhat.com>
> >> + *
> >> + */
> >> +
> >> +#include <linux/module.h>
> >> +#include <linux/idr.h>
> >> +#include <linux/vdpa.h>
> >> +
> >> +#define MOD_VERSION  "0.1"
> >> +#define MOD_DESC     "vDPA bus"
> >> +#define MOD_AUTHOR   "Jason Wang <jasowang@redhat.com>"
> >> +#define MOD_LICENSE  "GPL v2"
> >> +
> >> +static DEFINE_IDA(vdpa_index_ida);
> >> +
> >> +struct device *vdpa_get_parent(struct vdpa_device *vdpa)
> >> +{
> >> +    return vdpa->dev.parent;
> >> +}
> >> +EXPORT_SYMBOL(vdpa_get_parent);
> >> +
> >> +void vdpa_set_parent(struct vdpa_device *vdpa, struct device *parent)
> >> +{
> >> +    vdpa->dev.parent =3D parent;
> >> +}
> >> +EXPORT_SYMBOL(vdpa_set_parent);
> >> +
> >> +struct vdpa_device *dev_to_vdpa(struct device *_dev)
> >> +{
> >> +    return container_of(_dev, struct vdpa_device, dev);
> >> +}
> >> +EXPORT_SYMBOL_GPL(dev_to_vdpa);
> >> +
> >> +struct device *vdpa_to_dev(struct vdpa_device *vdpa)
> >> +{
> >> +    return &vdpa->dev;
> >> +}
> >> +EXPORT_SYMBOL_GPL(vdpa_to_dev);
> >> +
> >> +static int vdpa_dev_probe(struct device *d)
> >> +{
> >> +    struct vdpa_device *dev =3D dev_to_vdpa(d);
> >> +    struct vdpa_driver *drv =3D drv_to_vdpa(dev->dev.driver);
> >> +    int ret =3D 0;
> >> +
> >> +    if (drv && drv->probe)
> >> +            ret =3D drv->probe(d);
> >> +
> >> +    return ret;
> >> +}
> >> +
> >> +static int vdpa_dev_remove(struct device *d)
> >> +{
> >> +    struct vdpa_device *dev =3D dev_to_vdpa(d);
> >> +    struct vdpa_driver *drv =3D drv_to_vdpa(dev->dev.driver);
> >> +
> >> +    if (drv && drv->remove)
> >> +            drv->remove(d);
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +static struct bus_type vdpa_bus =3D {
> >> +    .name  =3D "vdpa",
> >> +    .probe =3D vdpa_dev_probe,
> >> +    .remove =3D vdpa_dev_remove,
> >> +};
> >> +
> >> +int register_vdpa_device(struct vdpa_device *vdpa)
> >> +{
> >> +    int err;
> >> +
> >> +    if (!vdpa_get_parent(vdpa))
> >> +            return -EINVAL;
> >> +
> >> +    if (!vdpa->config)
> >> +            return -EINVAL;
> >> +
> >> +    err =3D ida_simple_get(&vdpa_index_ida, 0, 0, GFP_KERNEL);
> >> +    if (err < 0)
> >> +            return -EFAULT;
> >> +
> >> +    vdpa->dev.bus =3D &vdpa_bus;
> >> +    device_initialize(&vdpa->dev);
> >> +
> >> +    vdpa->index =3D err;
> >> +    dev_set_name(&vdpa->dev, "vdpa%u", vdpa->index);
> >> +
> >> +    err =3D device_add(&vdpa->dev);
> >> +    if (err)
> >> +            ida_simple_remove(&vdpa_index_ida, vdpa->index);
> >> +
> >> +    return err;
> >> +}
> >> +EXPORT_SYMBOL_GPL(register_vdpa_device);
> >> +
> >> +void unregister_vdpa_device(struct vdpa_device *vdpa)
> >> +{
> >> +    int index =3D vdpa->index;
> >> +
> >> +    device_unregister(&vdpa->dev);
> >> +    ida_simple_remove(&vdpa_index_ida, index);
> >> +}
> >> +EXPORT_SYMBOL_GPL(unregister_vdpa_device);
> >> +
> >> +int register_vdpa_driver(struct vdpa_driver *driver)
> >> +{
> >> +    driver->drv.bus =3D &vdpa_bus;
> >> +    return driver_register(&driver->drv);
> >> +}
> >> +EXPORT_SYMBOL_GPL(register_vdpa_driver);
> >> +
> >> +void unregister_vdpa_driver(struct vdpa_driver *driver)
> >> +{
> >> +    driver_unregister(&driver->drv);
> >> +}
> >> +EXPORT_SYMBOL_GPL(unregister_vdpa_driver);
> >> +
> >> +static int vdpa_init(void)
> >> +{
> >> +    if (bus_register(&vdpa_bus) !=3D 0)
> >> +            panic("virtio bus registration failed");
> >> +    return 0;
> >> +}
> >> +
> >> +static void __exit vdpa_exit(void)
> >> +{
> >> +    bus_unregister(&vdpa_bus);
> >> +    ida_destroy(&vdpa_index_ida);
> >> +}
> >> +core_initcall(vdpa_init);
> >> +module_exit(vdpa_exit);
> >> +
> >> +MODULE_VERSION(MOD_VERSION);
> >> +MODULE_AUTHOR(MOD_AUTHOR);
> >> +MODULE_LICENSE(MOD_LICENSE);
> >> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> >> new file mode 100644
> >> index 000000000000..47760137ef66
> >> --- /dev/null
> >> +++ b/include/linux/vdpa.h
> >> @@ -0,0 +1,191 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +#ifndef _LINUX_VDPA_H
> >> +#define _LINUX_VDPA_H
> >> +
> >> +#include <linux/device.h>
> >> +#include <linux/interrupt.h>
> >> +#include <linux/vhost_iotlb.h>
> >> +
> >> +/**
> >> + * vDPA callback definition.
> >> + * @callback: interrupt callback function
> >> + * @private: the data passed to the callback function
> >> + */
> >> +struct vdpa_callback {
> >> +    irqreturn_t (*callback)(void *data);
> >> +    void *private;
> >> +};
> >> +
> >> +/**
> >> + * vDPA device - representation of a vDPA device
> >> + * @dev: underlying device
> >> + * @config: the configuration ops for this device.
> >> + * @index: device index
> >> + */
> >> +struct vdpa_device {
> >> +    struct device dev;
> >> +    const struct vdpa_config_ops *config;
> >> +    int index;
> >> +};
> >> +
> >> +/**
> >> + * vDPA_config_ops - operations for configuring a vDPA device.
> >> + * Note: vDPA device drivers are required to implement all of the
> >> + * operations unless it is optional mentioned in the following list.
> >> + * @set_vq_address:         Set the address of virtqueue
> >> + *                          @vdev: vdpa device
> >> + *                          @idx: virtqueue index
> >> + *                          @desc_area: address of desc area
> >> + *                          @driver_area: address of driver area
> >> + *                          @device_area: address of device area
> >> + *                          Returns integer: success (0) or error (< =
0)
> >> + * @set_vq_num:                     Set the size of virtqueue
> >> + *                          @vdev: vdpa device
> >> + *                          @idx: virtqueue index
> >> + *                          @num: the size of virtqueue
> >> + * @kick_vq:                        Kick the virtqueue
> >> + *                          @vdev: vdpa device
> >> + *                          @idx: virtqueue index
> >
> > This seems wrong: kicks are data path so drivers should not
> > do it in a vendor specific way.
>
>
> I'm not sure I get this since the doorbell is pretty vendor specific.
>
> The idea here is to start form simple and common cases that can work for
> both kernel virtio drivers and vhost:
>
> - For kernel, kick_vq() is called from vq->notify() directly
> - For vhost, vhost is in charge of hook eventfd to kick_vq()
>
>
> >   How about an API
> > returning the device/resource that can then be
> > mapped as appropriate?
> >
>
> Yes, this could be a further optimization on top but not a must (only
> work for e.g the doorbell does not share MMIO space with other
> functions). For vhost we need something like this and need to hook it to
> mmap() of vhost file descriptor.
>
>
> >> + * @set_vq_cb:                      Set the interrupt callback
> function for
> >> + *                          a virtqueue
> >> + *                          @vdev: vdpa device
> >> + *                          @idx: virtqueue index
> >> + *                          @cb: virtio-vdev interrupt callback
> structure
> >
> > Calls are data path too, I think we need some way to map MSI?
>
>
> Similarly, this could be a optimization on top, and we can start from
> simple and common cases:
>
> - For kernel, the vq callback could be mapped to MSI interrupt handler
> directly
> - For vhost, eventfd wakeup could be hook in the cb here
>
>
> >
> >> + * @set_vq_ready:           Set ready status for a virtqueue
> >> + *                          @vdev: vdpa device
> >> + *                          @idx: virtqueue index
> >> + *                          @ready: ready (true) not ready(false)
> >> + * @get_vq_ready:           Get ready status for a virtqueue
> >> + *                          @vdev: vdpa device
> >> + *                          @idx: virtqueue index
> >> + *                          Returns boolean: ready (true) or not
> (false)
> >> + * @set_vq_state:           Set the state for a virtqueue
> >> + *                          @vdev: vdpa device
> >> + *                          @idx: virtqueue index
> >> + *                          @state: virtqueue state (last_avail_idx)
> >> + *                          Returns integer: success (0) or error (< =
0)
> >> + * @get_vq_state:           Get the state for a virtqueue
> >> + *                          @vdev: vdpa device
> >> + *                          @idx: virtqueue index
> >> + *                          Returns virtqueue state (last_avail_idx)
> >> + * @get_vq_align:           Get the virtqueue align requirement
> >> + *                          for the device
> >> + *                          @vdev: vdpa device
> >> + *                          Returns virtqueue algin requirement
> >
> > Where does this come from? Spec dictates that for a data path,
> > vendor specific values for this will break userspace ...
>
>
> It comes from the align parameter of vring_create_virtqueue(). We can
> expose the alignment to userspace if necessary. If it's not necessary, I
> can drop this method here.
>
>
> >
> >> + * @get_features:           Get virtio features supported by the devi=
ce
> >> + *                          @vdev: vdpa device
> >> + *                          Returns the virtio features support by th=
e
> >> + *                          device
> >> + * @set_features:           Set virtio features supported by the driv=
er
> >> + *                          @vdev: vdpa device
> >> + *                          @features: feature support by the driver
> >> + *                          Returns integer: success (0) or error (< =
0)
> >> + * @set_config_cb:          Set the config interrupt callback
> >> + *                          @vdev: vdpa device
> >> + *                          @cb: virtio-vdev interrupt callback
> structure
> >> + * @get_vq_num_max:         Get the max size of virtqueue
> >> + *                          @vdev: vdpa device
> >> + *                          Returns u16: max size of virtqueue
> >
> > I'm not sure this has to be uniform across VQs.
>
>
> Let me add an index parameter to this.
>
>
> >
> >> + * @get_device_id:          Get virtio device id
> >> + *                          @vdev: vdpa device
> >> + *                          Returns u32: virtio device id
> >
> > is this the virtio ID? PCI ID?
>
>
> Virtio ID
>
>
> >
> >> + * @get_vendor_id:          Get id for the vendor that provides this
> device
> >> + *                          @vdev: vdpa device
> >> + *                          Returns u32: virtio vendor id
> > what's the idea behind this? userspace normally doesn't interact with
> > this ... debugging?
>
>
> This allows some vendor specific driver on top of vDPA bus. If this is
> not interested, I can drop this.
>
RJM>] wouldn't  usage of  get_device_id &  get_vendor_id, beyond reporting,
tend to possibly leading to vendor specific code in the framework instead
of leaving the framework agnostic and leave the vendor specific stuff to
the vendor's vDPA device driver?

>
>
> >
> >> + * @get_status:                     Get the device status
> >> + *                          @vdev: vdpa device
> >> + *                          Returns u8: virtio device status
> >> + * @set_status:                     Set the device status
> >> + *                          @vdev: vdpa device
> >> + *                          @status: virtio device status
> >> + * @get_config:                     Read from device specific
> configuration space
> >> + *                          @vdev: vdpa device
> >> + *                          @offset: offset from the beginning of
> >> + *                          configuration space
> >> + *                          @buf: buffer used to read to
> >> + *                          @len: the length to read from
> >> + *                          configuration space
> >> + * @set_config:                     Write to device specific
> configuration space
> >> + *                          @vdev: vdpa device
> >> + *                          @offset: offset from the beginning of
> >> + *                          configuration space
> >> + *                          @buf: buffer used to write from
> >> + *                          @len: the length to write to
> >> + *                          configuration space
> >> + * @get_generation:         Get device config generation (optional)
> >> + *                          @vdev: vdpa device
> >> + *                          Returns u32: device generation
> >> + * @set_map:                        Set device memory mapping, option=
al
> >> + *                          and only needed for device that using
> >> + *                          device specific DMA translation
> >> + *                          (on-chip IOMMU)
> >> + *                          @vdev: vdpa device
> >> + *                          @iotlb: vhost memory mapping to be
> >> + *                          used by the vDPA
> >> + *                          Returns integer: success (0) or error (< =
0)
> > OK so any change just swaps in a completely new mapping?
> > Wouldn't this make minor changes such as memory hotplug
> > quite expensive?
>
>
> My understanding is that the incremental updating of the on chip IOMMU
> may degrade the  performance. So vendor vDPA drivers may want to know
> all the mappings at once. Technically, we can keep the incremental API
> here and let the vendor vDPA drivers to record the full mapping
> internally which may slightly increase the complexity of vendor driver.
> We need more inputs from vendors here.
>
> Thanks
>
>
> >
> >> + */
> >> +struct vdpa_config_ops {
> >> +    /* Virtqueue ops */
> >> +    int (*set_vq_address)(struct vdpa_device *vdev,
> >> +                          u16 idx, u64 desc_area, u64 driver_area,
> >> +                          u64 device_area);
> >> +    void (*set_vq_num)(struct vdpa_device *vdev, u16 idx, u32 num);
> >> +    void (*kick_vq)(struct vdpa_device *vdev, u16 idx);
> >> +    void (*set_vq_cb)(struct vdpa_device *vdev, u16 idx,
> >> +                      struct vdpa_callback *cb);
> >> +    void (*set_vq_ready)(struct vdpa_device *vdev, u16 idx, bool
> ready);
> >> +    bool (*get_vq_ready)(struct vdpa_device *vdev, u16 idx);
> >> +    int (*set_vq_state)(struct vdpa_device *vdev, u16 idx, u64 state)=
;
> >> +    u64 (*get_vq_state)(struct vdpa_device *vdev, u16 idx);
> >> +
> >> +    /* Device ops */
> >> +    u16 (*get_vq_align)(struct vdpa_device *vdev);
> >> +    u64 (*get_features)(struct vdpa_device *vdev);
> >> +    int (*set_features)(struct vdpa_device *vdev, u64 features);
> >> +    void (*set_config_cb)(struct vdpa_device *vdev,
> >> +                          struct vdpa_callback *cb);
> >> +    u16 (*get_vq_num_max)(struct vdpa_device *vdev);
> >> +    u32 (*get_device_id)(struct vdpa_device *vdev);
> >> +    u32 (*get_vendor_id)(struct vdpa_device *vdev);
> >> +    u8 (*get_status)(struct vdpa_device *vdev);
> >> +    void (*set_status)(struct vdpa_device *vdev, u8 status);
> >> +    void (*get_config)(struct vdpa_device *vdev, unsigned int offset,
> >> +                       void *buf, unsigned int len);
> >> +    void (*set_config)(struct vdpa_device *vdev, unsigned int offset,
> >> +                       const void *buf, unsigned int len);
> >> +    u32 (*get_generation)(struct vdpa_device *vdev);
> >> +
> >> +    /* Mem table */
> >> +    int (*set_map)(struct vdpa_device *vdev, struct vhost_iotlb
> *iotlb);
> >> +};
> >> +
> >> +int register_vdpa_device(struct vdpa_device *vdpa);
> >> +void unregister_vdpa_device(struct vdpa_device *vdpa);
> >> +
> >> +struct device *vdpa_get_parent(struct vdpa_device *vdpa);
> >> +void vdpa_set_parent(struct vdpa_device *vdpa, struct device *parent)=
;
> >> +
> >> +struct vdpa_device *dev_to_vdpa(struct device *_dev);
> >> +struct device *vdpa_to_dev(struct vdpa_device *vdpa);
> >> +
> >> +/**
> >> + * vdpa_driver - operations for a vDPA driver
> >> + * @driver: underlying device driver
> >> + * @probe: the function to call when a device is found.  Returns 0 or
> -errno.
> >> + * @remove: the function to call when a device is removed.
> >> + */
> >> +struct vdpa_driver {
> >> +    struct device_driver drv;
> >> +    int (*probe)(struct device *dev);
> >> +    void (*remove)(struct device *dev);
> >> +};
> >> +
> >> +int register_vdpa_driver(struct vdpa_driver *drv);
> >> +void unregister_vdpa_driver(struct vdpa_driver *drv);
> >> +
> >> +static inline struct vdpa_driver *drv_to_vdpa(struct device_driver
> *drv)
> >> +{
> >> +    return container_of(drv, struct vdpa_driver, drv);
> >> +}
> >> +
> >> +#endif /* _LINUX_VDPA_H */
> >> --
> >> 2.19.1
>
>

--00000000000012b746059c568bad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 17, 2020 at 8:52 AM Jason=
 Wang &lt;<a href=3D"mailto:jasowang@redhat.com">jasowang@redhat.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
On 2020/1/17 =E4=B8=8B=E5=8D=888:13, Michael S. Tsirkin wrote:<br>
&gt; On Thu, Jan 16, 2020 at 08:42:29PM +0800, Jason Wang wrote:<br>
&gt;&gt; vDPA device is a device that uses a datapath which complies with t=
he<br>
&gt;&gt; virtio specifications with vendor specific control path. vDPA devi=
ces<br>
&gt;&gt; can be both physically located on the hardware or emulated by<br>
&gt;&gt; software. vDPA hardware devices are usually implemented through PC=
IE<br>
&gt;&gt; with the following types:<br>
&gt;&gt;<br>
&gt;&gt; - PF (Physical Function) - A single Physical Function<br>
&gt;&gt; - VF (Virtual Function) - Device that supports single root I/O<br>
&gt;&gt;=C2=A0 =C2=A0 virtualization (SR-IOV). Its Virtual Function (VF) re=
presents a<br>
&gt;&gt;=C2=A0 =C2=A0 virtualized instance of the device that can be assign=
ed to different<br>
&gt;&gt;=C2=A0 =C2=A0 partitions<br>
&gt;&gt; - VDEV (Virtual Device) - With technologies such as Intel Scalable=
<br>
&gt;&gt;=C2=A0 =C2=A0 IOV, a virtual device composed by host OS utilizing o=
ne or more<br>
&gt;&gt;=C2=A0 =C2=A0 ADIs.<br>
&gt;&gt; - SF (Sub function) - Vendor specific interface to slice the Physi=
cal<br>
&gt;&gt;=C2=A0 =C2=A0 Function to multiple sub functions that can be assign=
ed to different<br>
&gt;&gt;=C2=A0 =C2=A0 partitions as virtual devices.<br>
&gt;&gt;<br>
&gt;&gt; &gt;From a driver&#39;s perspective, depends on how and where the =
DMA<br>
&gt;&gt; translation is done, vDPA devices are split into two types:<br>
&gt;&gt;<br>
&gt;&gt; - Platform specific DMA translation - From the driver&#39;s perspe=
ctive,<br>
&gt;&gt;=C2=A0 =C2=A0 the device can be used on a platform where device acc=
ess to data in<br>
&gt;&gt;=C2=A0 =C2=A0 memory is limited and/or translated. An example is a =
PCIE vDPA whose<br>
&gt;&gt;=C2=A0 =C2=A0 DMA request was tagged via a bus (e.g PCIE) specific =
way. DMA<br>
&gt;&gt;=C2=A0 =C2=A0 translation and protection are done at PCIE bus IOMMU=
 level.<br>
&gt;&gt; - Device specific DMA translation - The device implements DMA<br>
&gt;&gt;=C2=A0 =C2=A0 isolation and protection through its own logic. An ex=
ample is a vDPA<br>
&gt;&gt;=C2=A0 =C2=A0 device which uses on-chip IOMMU.<br>
&gt;&gt;<br>
&gt;&gt; To hide the differences and complexity of the above types for a vD=
PA<br>
&gt;&gt; device/IOMMU options and in order to present a generic virtio devi=
ce<br>
&gt;&gt; to the upper layer, a device agnostic framework is required.<br>
&gt;&gt;<br>
&gt;&gt; This patch introduces a software vDPA bus which abstracts the<br>
&gt;&gt; common attributes of vDPA device, vDPA bus driver and the<br>
&gt;&gt; communication method (vdpa_config_ops) between the vDPA device<br>
&gt;&gt; abstraction and the vDPA bus driver:<br>
&gt;&gt;<br>
&gt;&gt; With the abstraction of vDPA bus and vDPA bus operations, the<br>
&gt;&gt; difference and complexity of the under layer hardware is hidden fr=
om<br>
&gt;&gt; upper layer. The vDPA bus drivers on top can use a unified<br>
&gt;&gt; vdpa_config_ops to control different types of vDPA device.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.co=
m" target=3D"_blank">jasowang@redhat.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;&gt;=C2=A0 =C2=A0drivers/virtio/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A02 +<br>
&gt;&gt;=C2=A0 =C2=A0drivers/virtio/Makefile=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A01 +<br>
&gt;&gt;=C2=A0 =C2=A0drivers/virtio/vdpa/Kconfig=C2=A0 |=C2=A0 =C2=A09 ++<b=
r>
&gt;&gt;=C2=A0 =C2=A0drivers/virtio/vdpa/Makefile |=C2=A0 =C2=A02 +<br>
&gt;&gt;=C2=A0 =C2=A0drivers/virtio/vdpa/vdpa.c=C2=A0 =C2=A0| 141 +++++++++=
+++++++++++++++++<br>
&gt;&gt;=C2=A0 =C2=A0include/linux/vdpa.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| 191 +++++++++++++++++++++++++++++++++++<br>
&gt;&gt;=C2=A0 =C2=A07 files changed, 347 insertions(+)<br>
&gt;&gt;=C2=A0 =C2=A0create mode 100644 drivers/virtio/vdpa/Kconfig<br>
&gt;&gt;=C2=A0 =C2=A0create mode 100644 drivers/virtio/vdpa/Makefile<br>
&gt;&gt;=C2=A0 =C2=A0create mode 100644 drivers/virtio/vdpa/vdpa.c<br>
&gt;&gt;=C2=A0 =C2=A0create mode 100644 include/linux/vdpa.h<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt;&gt; index d4bda9c900fa..578d2a581e3b 100644<br>
&gt;&gt; --- a/MAINTAINERS<br>
&gt;&gt; +++ b/MAINTAINERS<br>
&gt;&gt; @@ -17540,6 +17540,7 @@ F:=C2=A0 =C2=A0tools/virtio/<br>
&gt;&gt;=C2=A0 =C2=A0F: drivers/net/virtio_net.c<br>
&gt;&gt;=C2=A0 =C2=A0F: drivers/block/virtio_blk.c<br>
&gt;&gt;=C2=A0 =C2=A0F: include/linux/virtio*.h<br>
&gt;&gt; +F:=C2=A0 include/linux/vdpa.h<br>
&gt;&gt;=C2=A0 =C2=A0F: include/uapi/linux/virtio_*.h<br>
&gt;&gt;=C2=A0 =C2=A0F: drivers/crypto/virtio/<br>
&gt;&gt;=C2=A0 =C2=A0F: mm/balloon_compaction.c<br>
&gt;&gt; diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig<br>
&gt;&gt; index 078615cf2afc..9c4fdb64d9ac 100644<br>
&gt;&gt; --- a/drivers/virtio/Kconfig<br>
&gt;&gt; +++ b/drivers/virtio/Kconfig<br>
&gt;&gt; @@ -96,3 +96,5 @@ config VIRTIO_MMIO_CMDLINE_DEVICES<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0If unsure, say &#39;N&#39;.<br>
&gt;&gt;=C2=A0 =C2=A0<br>
&gt;&gt;=C2=A0 =C2=A0endif # VIRTIO_MENU<br>
&gt;&gt; +<br>
&gt;&gt; +source &quot;drivers/virtio/vdpa/Kconfig&quot;<br>
&gt;&gt; diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile<br>
&gt;&gt; index 3a2b5c5dcf46..fdf5eacd0d0a 100644<br>
&gt;&gt; --- a/drivers/virtio/Makefile<br>
&gt;&gt; +++ b/drivers/virtio/Makefile<br>
&gt;&gt; @@ -6,3 +6,4 @@ virtio_pci-y :=3D virtio_pci_modern.o virtio_pci_c=
ommon.o<br>
&gt;&gt;=C2=A0 =C2=A0virtio_pci-$(CONFIG_VIRTIO_PCI_LEGACY) +=3D virtio_pci=
_legacy.o<br>
&gt;&gt;=C2=A0 =C2=A0obj-$(CONFIG_VIRTIO_BALLOON) +=3D virtio_balloon.o<br>
&gt;&gt;=C2=A0 =C2=A0obj-$(CONFIG_VIRTIO_INPUT) +=3D virtio_input.o<br>
&gt;&gt; +obj-$(CONFIG_VDPA) +=3D vdpa/<br>
&gt;&gt; diff --git a/drivers/virtio/vdpa/Kconfig b/drivers/virtio/vdpa/Kco=
nfig<br>
&gt;&gt; new file mode 100644<br>
&gt;&gt; index 000000000000..3032727b4d98<br>
&gt;&gt; --- /dev/null<br>
&gt;&gt; +++ b/drivers/virtio/vdpa/Kconfig<br>
&gt;&gt; @@ -0,0 +1,9 @@<br>
&gt;&gt; +# SPDX-License-Identifier: GPL-2.0-only<br>
&gt;&gt; +config VDPA<br>
&gt;&gt; +=C2=A0 =C2=A0 tristate<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 default n<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 help<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Enable this module to support =
vDPA device that uses a<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 datapath which complies with v=
irtio specifications with<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vendor specific control path.<=
br>
&gt;&gt; +<br>
&gt;&gt; diff --git a/drivers/virtio/vdpa/Makefile b/drivers/virtio/vdpa/Ma=
kefile<br>
&gt;&gt; new file mode 100644<br>
&gt;&gt; index 000000000000..ee6a35e8a4fb<br>
&gt;&gt; --- /dev/null<br>
&gt;&gt; +++ b/drivers/virtio/vdpa/Makefile<br>
&gt;&gt; @@ -0,0 +1,2 @@<br>
&gt;&gt; +# SPDX-License-Identifier: GPL-2.0<br>
&gt;&gt; +obj-$(CONFIG_VDPA) +=3D vdpa.o<br>
&gt;&gt; diff --git a/drivers/virtio/vdpa/vdpa.c b/drivers/virtio/vdpa/vdpa=
.c<br>
&gt;&gt; new file mode 100644<br>
&gt;&gt; index 000000000000..2b0e4a9f105d<br>
&gt;&gt; --- /dev/null<br>
&gt;&gt; +++ b/drivers/virtio/vdpa/vdpa.c<br>
&gt;&gt; @@ -0,0 +1,141 @@<br>
&gt;&gt; +// SPDX-License-Identifier: GPL-2.0-only<br>
&gt;&gt; +/*<br>
&gt;&gt; + * vDPA bus.<br>
&gt;&gt; + *<br>
&gt;&gt; + * Copyright (c) 2019, Red Hat. All rights reserved.<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0Author: Jason Wang &lt;<a href=3D"mailto:ja=
sowang@redhat.com" target=3D"_blank">jasowang@redhat.com</a>&gt;<br>
&gt;&gt; + *<br>
&gt;&gt; + */<br>
&gt;&gt; +<br>
&gt;&gt; +#include &lt;linux/module.h&gt;<br>
&gt;&gt; +#include &lt;linux/idr.h&gt;<br>
&gt;&gt; +#include &lt;linux/vdpa.h&gt;<br>
&gt;&gt; +<br>
&gt;&gt; +#define MOD_VERSION=C2=A0 &quot;0.1&quot;<br>
&gt;&gt; +#define MOD_DESC=C2=A0 =C2=A0 =C2=A0&quot;vDPA bus&quot;<br>
&gt;&gt; +#define MOD_AUTHOR=C2=A0 =C2=A0&quot;Jason Wang &lt;<a href=3D"ma=
ilto:jasowang@redhat.com" target=3D"_blank">jasowang@redhat.com</a>&gt;&quo=
t;<br>
&gt;&gt; +#define MOD_LICENSE=C2=A0 &quot;GPL v2&quot;<br>
&gt;&gt; +<br>
&gt;&gt; +static DEFINE_IDA(vdpa_index_ida);<br>
&gt;&gt; +<br>
&gt;&gt; +struct device *vdpa_get_parent(struct vdpa_device *vdpa)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0 =C2=A0 return vdpa-&gt;dev.parent;<br>
&gt;&gt; +}<br>
&gt;&gt; +EXPORT_SYMBOL(vdpa_get_parent);<br>
&gt;&gt; +<br>
&gt;&gt; +void vdpa_set_parent(struct vdpa_device *vdpa, struct device *par=
ent)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0 =C2=A0 vdpa-&gt;dev.parent =3D parent;<br>
&gt;&gt; +}<br>
&gt;&gt; +EXPORT_SYMBOL(vdpa_set_parent);<br>
&gt;&gt; +<br>
&gt;&gt; +struct vdpa_device *dev_to_vdpa(struct device *_dev)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0 =C2=A0 return container_of(_dev, struct vdpa_device, dev);=
<br>
&gt;&gt; +}<br>
&gt;&gt; +EXPORT_SYMBOL_GPL(dev_to_vdpa);<br>
&gt;&gt; +<br>
&gt;&gt; +struct device *vdpa_to_dev(struct vdpa_device *vdpa)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0 =C2=A0 return &amp;vdpa-&gt;dev;<br>
&gt;&gt; +}<br>
&gt;&gt; +EXPORT_SYMBOL_GPL(vdpa_to_dev);<br>
&gt;&gt; +<br>
&gt;&gt; +static int vdpa_dev_probe(struct device *d)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0 =C2=A0 struct vdpa_device *dev =3D dev_to_vdpa(d);<br>
&gt;&gt; +=C2=A0 =C2=A0 struct vdpa_driver *drv =3D drv_to_vdpa(dev-&gt;dev=
.driver);<br>
&gt;&gt; +=C2=A0 =C2=A0 int ret =3D 0;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 if (drv &amp;&amp; drv-&gt;probe)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D drv-&gt;probe(d=
);<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static int vdpa_dev_remove(struct device *d)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0 =C2=A0 struct vdpa_device *dev =3D dev_to_vdpa(d);<br>
&gt;&gt; +=C2=A0 =C2=A0 struct vdpa_driver *drv =3D drv_to_vdpa(dev-&gt;dev=
.driver);<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 if (drv &amp;&amp; drv-&gt;remove)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 drv-&gt;remove(d);<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static struct bus_type vdpa_bus =3D {<br>
&gt;&gt; +=C2=A0 =C2=A0 .name=C2=A0 =3D &quot;vdpa&quot;,<br>
&gt;&gt; +=C2=A0 =C2=A0 .probe =3D vdpa_dev_probe,<br>
&gt;&gt; +=C2=A0 =C2=A0 .remove =3D vdpa_dev_remove,<br>
&gt;&gt; +};<br>
&gt;&gt; +<br>
&gt;&gt; +int register_vdpa_device(struct vdpa_device *vdpa)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0 =C2=A0 int err;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 if (!vdpa_get_parent(vdpa))<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 if (!vdpa-&gt;config)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 err =3D ida_simple_get(&amp;vdpa_index_ida, 0, 0, G=
FP_KERNEL);<br>
&gt;&gt; +=C2=A0 =C2=A0 if (err &lt; 0)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 vdpa-&gt;dev.bus =3D &amp;vdpa_bus;<br>
&gt;&gt; +=C2=A0 =C2=A0 device_initialize(&amp;vdpa-&gt;dev);<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 vdpa-&gt;index =3D err;<br>
&gt;&gt; +=C2=A0 =C2=A0 dev_set_name(&amp;vdpa-&gt;dev, &quot;vdpa%u&quot;,=
 vdpa-&gt;index);<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 err =3D device_add(&amp;vdpa-&gt;dev);<br>
&gt;&gt; +=C2=A0 =C2=A0 if (err)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ida_simple_remove(&amp;=
vdpa_index_ida, vdpa-&gt;index);<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 return err;<br>
&gt;&gt; +}<br>
&gt;&gt; +EXPORT_SYMBOL_GPL(register_vdpa_device);<br>
&gt;&gt; +<br>
&gt;&gt; +void unregister_vdpa_device(struct vdpa_device *vdpa)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0 =C2=A0 int index =3D vdpa-&gt;index;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 device_unregister(&amp;vdpa-&gt;dev);<br>
&gt;&gt; +=C2=A0 =C2=A0 ida_simple_remove(&amp;vdpa_index_ida, index);<br>
&gt;&gt; +}<br>
&gt;&gt; +EXPORT_SYMBOL_GPL(unregister_vdpa_device);<br>
&gt;&gt; +<br>
&gt;&gt; +int register_vdpa_driver(struct vdpa_driver *driver)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0 =C2=A0 driver-&gt;drv.bus =3D &amp;vdpa_bus;<br>
&gt;&gt; +=C2=A0 =C2=A0 return driver_register(&amp;driver-&gt;drv);<br>
&gt;&gt; +}<br>
&gt;&gt; +EXPORT_SYMBOL_GPL(register_vdpa_driver);<br>
&gt;&gt; +<br>
&gt;&gt; +void unregister_vdpa_driver(struct vdpa_driver *driver)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0 =C2=A0 driver_unregister(&amp;driver-&gt;drv);<br>
&gt;&gt; +}<br>
&gt;&gt; +EXPORT_SYMBOL_GPL(unregister_vdpa_driver);<br>
&gt;&gt; +<br>
&gt;&gt; +static int vdpa_init(void)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0 =C2=A0 if (bus_register(&amp;vdpa_bus) !=3D 0)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 panic(&quot;virtio bus =
registration failed&quot;);<br>
&gt;&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static void __exit vdpa_exit(void)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0 =C2=A0 bus_unregister(&amp;vdpa_bus);<br>
&gt;&gt; +=C2=A0 =C2=A0 ida_destroy(&amp;vdpa_index_ida);<br>
&gt;&gt; +}<br>
&gt;&gt; +core_initcall(vdpa_init);<br>
&gt;&gt; +module_exit(vdpa_exit);<br>
&gt;&gt; +<br>
&gt;&gt; +MODULE_VERSION(MOD_VERSION);<br>
&gt;&gt; +MODULE_AUTHOR(MOD_AUTHOR);<br>
&gt;&gt; +MODULE_LICENSE(MOD_LICENSE);<br>
&gt;&gt; diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h<br>
&gt;&gt; new file mode 100644<br>
&gt;&gt; index 000000000000..47760137ef66<br>
&gt;&gt; --- /dev/null<br>
&gt;&gt; +++ b/include/linux/vdpa.h<br>
&gt;&gt; @@ -0,0 +1,191 @@<br>
&gt;&gt; +/* SPDX-License-Identifier: GPL-2.0 */<br>
&gt;&gt; +#ifndef _LINUX_VDPA_H<br>
&gt;&gt; +#define _LINUX_VDPA_H<br>
&gt;&gt; +<br>
&gt;&gt; +#include &lt;linux/device.h&gt;<br>
&gt;&gt; +#include &lt;linux/interrupt.h&gt;<br>
&gt;&gt; +#include &lt;linux/vhost_iotlb.h&gt;<br>
&gt;&gt; +<br>
&gt;&gt; +/**<br>
&gt;&gt; + * vDPA callback definition.<br>
&gt;&gt; + * @callback: interrupt callback function<br>
&gt;&gt; + * @private: the data passed to the callback function<br>
&gt;&gt; + */<br>
&gt;&gt; +struct vdpa_callback {<br>
&gt;&gt; +=C2=A0 =C2=A0 irqreturn_t (*callback)(void *data);<br>
&gt;&gt; +=C2=A0 =C2=A0 void *private;<br>
&gt;&gt; +};<br>
&gt;&gt; +<br>
&gt;&gt; +/**<br>
&gt;&gt; + * vDPA device - representation of a vDPA device<br>
&gt;&gt; + * @dev: underlying device<br>
&gt;&gt; + * @config: the configuration ops for this device.<br>
&gt;&gt; + * @index: device index<br>
&gt;&gt; + */<br>
&gt;&gt; +struct vdpa_device {<br>
&gt;&gt; +=C2=A0 =C2=A0 struct device dev;<br>
&gt;&gt; +=C2=A0 =C2=A0 const struct vdpa_config_ops *config;<br>
&gt;&gt; +=C2=A0 =C2=A0 int index;<br>
&gt;&gt; +};<br>
&gt;&gt; +<br>
&gt;&gt; +/**<br>
&gt;&gt; + * vDPA_config_ops - operations for configuring a vDPA device.<br=
>
&gt;&gt; + * Note: vDPA device drivers are required to implement all of the=
<br>
&gt;&gt; + * operations unless it is optional mentioned in the following li=
st.<br>
&gt;&gt; + * @set_vq_address:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Set the addr=
ess of virtqueue<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @vdev: vdpa device<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @idx: virtqueue index<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @desc_area: address of desc area<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @driver_area: address of driver area<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @device_area: address of device area<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns integer: success (0) or error (&lt; 0)<=
br>
&gt;&gt; + * @set_vq_num:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0Set the size of virtqueue<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @vdev: vdpa device<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @idx: virtqueue index<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @num: the size of virtqueue<br>
&gt;&gt; + * @kick_vq:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Kick the virtqueue<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @vdev: vdpa device<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @idx: virtqueue index<br>
&gt;<br>
&gt; This seems wrong: kicks are data path so drivers should not<br>
&gt; do it in a vendor specific way.<br>
<br>
<br>
I&#39;m not sure I get this since the doorbell is pretty vendor specific.<b=
r>
<br>
The idea here is to start form simple and common cases that can work for <b=
r>
both kernel virtio drivers and vhost:<br>
<br>
- For kernel, kick_vq() is called from vq-&gt;notify() directly<br>
- For vhost, vhost is in charge of hook eventfd to kick_vq()<br>
<br>
<br>
&gt;=C2=A0 =C2=A0How about an API<br>
&gt; returning the device/resource that can then be<br>
&gt; mapped as appropriate?<br>
&gt;<br>
<br>
Yes, this could be a further optimization on top but not a must (only <br>
work for e.g the doorbell does not share MMIO space with other <br>
functions). For vhost we need something like this and need to hook it to <b=
r>
mmap() of vhost file descriptor.<br>
<br>
<br>
&gt;&gt; + * @set_vq_cb:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Set the interrupt callback function for<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 a virtqueue<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @vdev: vdpa device<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @idx: virtqueue index<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @cb: virtio-vdev interrupt callback structure<b=
r>
&gt;<br>
&gt; Calls are data path too, I think we need some way to map MSI?<br>
<br>
<br>
Similarly, this could be a optimization on top, and we can start from <br>
simple and common cases:<br>
<br>
- For kernel, the vq callback could be mapped to MSI interrupt handler <br>
directly<br>
- For vhost, eventfd wakeup could be hook in the cb here<br>
<br>
<br>
&gt;<br>
&gt;&gt; + * @set_vq_ready:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Set rea=
dy status for a virtqueue<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @vdev: vdpa device<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @idx: virtqueue index<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @ready: ready (true) not ready(false)<br>
&gt;&gt; + * @get_vq_ready:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Get rea=
dy status for a virtqueue<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @vdev: vdpa device<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @idx: virtqueue index<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns boolean: ready (true) or not (false)<br=
>
&gt;&gt; + * @set_vq_state:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Set the=
 state for a virtqueue<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @vdev: vdpa device<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @idx: virtqueue index<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @state: virtqueue state (last_avail_idx)<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns integer: success (0) or error (&lt; 0)<=
br>
&gt;&gt; + * @get_vq_state:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Get the=
 state for a virtqueue<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @vdev: vdpa device<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @idx: virtqueue index<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns virtqueue state (last_avail_idx)<br>
&gt;&gt; + * @get_vq_align:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Get the=
 virtqueue align requirement<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for the device<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @vdev: vdpa device<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns virtqueue algin requirement<br>
&gt;<br>
&gt; Where does this come from? Spec dictates that for a data path,<br>
&gt; vendor specific values for this will break userspace ...<br>
<br>
<br>
It comes from the align parameter of vring_create_virtqueue(). We can <br>
expose the alignment to userspace if necessary. If it&#39;s not necessary, =
I <br>
can drop this method here.<br>
<br>
<br>
&gt;<br>
&gt;&gt; + * @get_features:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Get vir=
tio features supported by the device<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @vdev: vdpa device<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns the virtio features support by the<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 device<br>
&gt;&gt; + * @set_features:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Set vir=
tio features supported by the driver<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @vdev: vdpa device<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @features: feature support by the driver<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns integer: success (0) or error (&lt; 0)<=
br>
&gt;&gt; + * @set_config_cb:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Set the conf=
ig interrupt callback<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @vdev: vdpa device<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @cb: virtio-vdev interrupt callback structure<b=
r>
&gt;&gt; + * @get_vq_num_max:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Get the max =
size of virtqueue<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @vdev: vdpa device<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns u16: max size of virtqueue<br>
&gt;<br>
&gt; I&#39;m not sure this has to be uniform across VQs.<br>
<br>
<br>
Let me add an index parameter to this.<br>
<br>
<br>
&gt;<br>
&gt;&gt; + * @get_device_id:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Get virtio d=
evice id<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @vdev: vdpa device<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns u32: virtio device id<br>
&gt;<br>
&gt; is this the virtio ID? PCI ID?<br>
<br>
<br>
Virtio ID<br>
<br>
<br>
&gt;<br>
&gt;&gt; + * @get_vendor_id:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Get id for t=
he vendor that provides this device<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @vdev: vdpa device<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns u32: virtio vendor id<br>
&gt; what&#39;s the idea behind this? userspace normally doesn&#39;t intera=
ct with<br>
&gt; this ... debugging?<br>
<br>
<br>
This allows some vendor specific driver on top of vDPA bus. If this is <br>
not interested, I can drop this.<br></blockquote><div>RJM&gt;] wouldn&#39;t=
=C2=A0 usage of=C2=A0

get_device_id &amp;=C2=A0

get_vendor_id, beyond reporting, tend to possibly leading to vendor specifi=
c code in the framework instead of leaving the framework=C2=A0agnostic and =
leave the vendor specific stuff to the vendor&#39;s vDPA device driver?</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
&gt;<br>
&gt;&gt; + * @get_status:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0Get the device status<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @vdev: vdpa device<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns u8: virtio device status<br>
&gt;&gt; + * @set_status:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0Set the device status<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @vdev: vdpa device<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @status: virtio device status<br>
&gt;&gt; + * @get_config:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0Read from device specific configuration space<br=
>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @vdev: vdpa device<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @offset: offset from the beginning of<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 configuration space<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @buf: buffer used to read to<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @len: the length to read from<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 configuration space<br>
&gt;&gt; + * @set_config:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0Write to device specific configuration space<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @vdev: vdpa device<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @offset: offset from the beginning of<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 configuration space<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @buf: buffer used to write from<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @len: the length to write to<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 configuration space<br>
&gt;&gt; + * @get_generation:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Get device c=
onfig generation (optional)<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @vdev: vdpa device<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns u32: device generation<br>
&gt;&gt; + * @set_map:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Set device memory mapping, optional<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 and only needed for device that using<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 device specific DMA translation<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (on-chip IOMMU)<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @vdev: vdpa device<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @iotlb: vhost memory mapping to be<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 used by the vDPA<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns integer: success (0) or error (&lt; 0)<=
br>
&gt; OK so any change just swaps in a completely new mapping?<br>
&gt; Wouldn&#39;t this make minor changes such as memory hotplug<br>
&gt; quite expensive?<br>
<br>
<br>
My understanding is that the incremental updating of the on chip IOMMU <br>
may degrade the=C2=A0 performance. So vendor vDPA drivers may want to know =
<br>
all the mappings at once. Technically, we can keep the incremental API <br>
here and let the vendor vDPA drivers to record the full mapping <br>
internally which may slightly increase the complexity of vendor driver. <br=
>
We need more inputs from vendors here.<br>
<br>
Thanks<br>
<br>
<br>
&gt;<br>
&gt;&gt; + */<br>
&gt;&gt; +struct vdpa_config_ops {<br>
&gt;&gt; +=C2=A0 =C2=A0 /* Virtqueue ops */<br>
&gt;&gt; +=C2=A0 =C2=A0 int (*set_vq_address)(struct vdpa_device *vdev,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 idx, u64 desc_area, u64 driver_area,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u64 device_area);<br>
&gt;&gt; +=C2=A0 =C2=A0 void (*set_vq_num)(struct vdpa_device *vdev, u16 id=
x, u32 num);<br>
&gt;&gt; +=C2=A0 =C2=A0 void (*kick_vq)(struct vdpa_device *vdev, u16 idx);=
<br>
&gt;&gt; +=C2=A0 =C2=A0 void (*set_vq_cb)(struct vdpa_device *vdev, u16 idx=
,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 struct vdpa_callback *cb);<br>
&gt;&gt; +=C2=A0 =C2=A0 void (*set_vq_ready)(struct vdpa_device *vdev, u16 =
idx, bool ready);<br>
&gt;&gt; +=C2=A0 =C2=A0 bool (*get_vq_ready)(struct vdpa_device *vdev, u16 =
idx);<br>
&gt;&gt; +=C2=A0 =C2=A0 int (*set_vq_state)(struct vdpa_device *vdev, u16 i=
dx, u64 state);<br>
&gt;&gt; +=C2=A0 =C2=A0 u64 (*get_vq_state)(struct vdpa_device *vdev, u16 i=
dx);<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 /* Device ops */<br>
&gt;&gt; +=C2=A0 =C2=A0 u16 (*get_vq_align)(struct vdpa_device *vdev);<br>
&gt;&gt; +=C2=A0 =C2=A0 u64 (*get_features)(struct vdpa_device *vdev);<br>
&gt;&gt; +=C2=A0 =C2=A0 int (*set_features)(struct vdpa_device *vdev, u64 f=
eatures);<br>
&gt;&gt; +=C2=A0 =C2=A0 void (*set_config_cb)(struct vdpa_device *vdev,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct vdpa_callback *cb);<br>
&gt;&gt; +=C2=A0 =C2=A0 u16 (*get_vq_num_max)(struct vdpa_device *vdev);<br=
>
&gt;&gt; +=C2=A0 =C2=A0 u32 (*get_device_id)(struct vdpa_device *vdev);<br>
&gt;&gt; +=C2=A0 =C2=A0 u32 (*get_vendor_id)(struct vdpa_device *vdev);<br>
&gt;&gt; +=C2=A0 =C2=A0 u8 (*get_status)(struct vdpa_device *vdev);<br>
&gt;&gt; +=C2=A0 =C2=A0 void (*set_status)(struct vdpa_device *vdev, u8 sta=
tus);<br>
&gt;&gt; +=C2=A0 =C2=A0 void (*get_config)(struct vdpa_device *vdev, unsign=
ed int offset,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0void *buf, unsigned int len);<br>
&gt;&gt; +=C2=A0 =C2=A0 void (*set_config)(struct vdpa_device *vdev, unsign=
ed int offset,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0const void *buf, unsigned int len);<br>
&gt;&gt; +=C2=A0 =C2=A0 u32 (*get_generation)(struct vdpa_device *vdev);<br=
>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 /* Mem table */<br>
&gt;&gt; +=C2=A0 =C2=A0 int (*set_map)(struct vdpa_device *vdev, struct vho=
st_iotlb *iotlb);<br>
&gt;&gt; +};<br>
&gt;&gt; +<br>
&gt;&gt; +int register_vdpa_device(struct vdpa_device *vdpa);<br>
&gt;&gt; +void unregister_vdpa_device(struct vdpa_device *vdpa);<br>
&gt;&gt; +<br>
&gt;&gt; +struct device *vdpa_get_parent(struct vdpa_device *vdpa);<br>
&gt;&gt; +void vdpa_set_parent(struct vdpa_device *vdpa, struct device *par=
ent);<br>
&gt;&gt; +<br>
&gt;&gt; +struct vdpa_device *dev_to_vdpa(struct device *_dev);<br>
&gt;&gt; +struct device *vdpa_to_dev(struct vdpa_device *vdpa);<br>
&gt;&gt; +<br>
&gt;&gt; +/**<br>
&gt;&gt; + * vdpa_driver - operations for a vDPA driver<br>
&gt;&gt; + * @driver: underlying device driver<br>
&gt;&gt; + * @probe: the function to call when a device is found.=C2=A0 Ret=
urns 0 or -errno.<br>
&gt;&gt; + * @remove: the function to call when a device is removed.<br>
&gt;&gt; + */<br>
&gt;&gt; +struct vdpa_driver {<br>
&gt;&gt; +=C2=A0 =C2=A0 struct device_driver drv;<br>
&gt;&gt; +=C2=A0 =C2=A0 int (*probe)(struct device *dev);<br>
&gt;&gt; +=C2=A0 =C2=A0 void (*remove)(struct device *dev);<br>
&gt;&gt; +};<br>
&gt;&gt; +<br>
&gt;&gt; +int register_vdpa_driver(struct vdpa_driver *drv);<br>
&gt;&gt; +void unregister_vdpa_driver(struct vdpa_driver *drv);<br>
&gt;&gt; +<br>
&gt;&gt; +static inline struct vdpa_driver *drv_to_vdpa(struct device_drive=
r *drv)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0 =C2=A0 return container_of(drv, struct vdpa_driver, drv);<=
br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +#endif /* _LINUX_VDPA_H */<br>
&gt;&gt; -- <br>
&gt;&gt; 2.19.1<br>
<br>
</blockquote></div></div>

--00000000000012b746059c568bad--

--===============5303532953766732909==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5303532953766732909==--
