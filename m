From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH 2/3] vhost-scsi: new device supporting the tcm_vhost
	Linux kernel module
Date: Wed, 27 Mar 2013 15:45:42 -0700
Message-ID: <1364424342.17698.31.camel@haakon2.linux-iscsi.org>
References: <1364421586-29857-1-git-send-email-nab@linux-iscsi.org>
	<1364421586-29857-3-git-send-email-nab@linux-iscsi.org>
	<20130327222856.GC12518@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130327222856.GC12518@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm-devel <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, lf-virt <virtualization@lists.linux-foundation.org>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2013-03-28 at 00:28 +0200, Michael S. Tsirkin wrote:
> On Wed, Mar 27, 2013 at 09:59:45PM +0000, Nicholas A. Bellinger wrote:
> > From: Paolo Bonzini <pbonzini@redhat.com>
> > 
> > The WWPN specified in configfs is passed to "-device vhost-scsi-pci".
> > The tgpt field of the SET_ENDPOINT ioctl is obsolete now, so it is not
> > available from the QEMU command-line.  Instead, I hardcode it to zero.
> > 
> > Changes in V4:
> >    - Set event_idx=off by default (nab, thanks asias)
> 
> Why? What's going on here?
> 

Not disabling event_idx by default, or disabling from the command line
ends up resulting in ->handle_kick() not getting called for subsequent
commands..

I spent some time trying to track this down recently with no luck, and
AFAICT it's always been required in order for vhost-scsi to function.

> >    - Disable hotplug feature bit for v3.9 tcm_vhost kernel code, need to
> >      re-enable in v3.10 (nab)
> 
> Userspace needs to support detecting host features
> at runtime, based on dev->features.
> In particular this applies to event_idx, but also hotplug.
> See vhost_net_get_features.

<nod>, will get this fixed up.

> 
> >    - Update to latest qemu.git/master HEAD
> > 
> > Changes in V3:
> >    - Drop ioeventfd vhost_scsi_properties (asias, thanks stefanha)
> >    - Add CONFIG_VHOST_SCSI (asias, thanks stefanha)
> >    - Add hotplug feature bit
> > 
> > Changes in V2:
> >    - Add backend guest masking support (nab)
> >    - Bump ABI_VERSION to 1 (nab)
> >    - Set up set_guest_notifiers (asias)
> >    - Set up vs->dev.vq_index (asias)
> >    - Drop vs->vs.vdev.{set,clear}_vhost_endpoint (asias)
> >    - Drop VIRTIO_CONFIG_S_DRIVER check in vhost_scsi_set_status (asias)
> > 
> > Howto:
> >    Use the latest seabios, at least commit b44a7be17b
> >    git clone git://git.seabios.org/seabios.git
> >    make
> >    cp out/bios.bin /usr/share/qemu/bios.bin
> >    qemu -device vhost-scsi-pci,wwpn=naa.6001405bd4e8476d,event_idx=off
> > ...
> > 
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Asias He <asias@redhat.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
> > ---
> >  configure                  |   15 +++-
> >  hw/Makefile.objs           |    5 +-
> >  hw/s390x/s390-virtio-bus.c |   35 +++++++
> >  hw/vhost-scsi.c            |  241 ++++++++++++++++++++++++++++++++++++++++++++
> >  hw/vhost-scsi.h            |   66 ++++++++++++
> >  hw/virtio-pci.c            |   62 +++++++++++
> >  hw/virtio-scsi.h           |    2 +
> >  7 files changed, 424 insertions(+), 2 deletions(-)
> >  create mode 100644 hw/vhost-scsi.c
> >  create mode 100644 hw/vhost-scsi.h
> > 

<SNIP>

> > diff --git a/hw/vhost-scsi.h b/hw/vhost-scsi.h
> > new file mode 100644
> > index 0000000..b01f012
> > --- /dev/null
> > +++ b/hw/vhost-scsi.h
> > @@ -0,0 +1,66 @@
> > +/*
> > + * vhost_scsi host device
> > + *
> > + * Copyright IBM, Corp. 2011
> > + *
> > + * Authors:
> > + *  Stefan Hajnoczi   <stefanha@linux.vnet.ibm.com>
> > + *
> > + * This work is licensed under the terms of the GNU LGPL, version 2 or later.
> > + * See the COPYING.LIB file in the top-level directory.
> > + *
> > + */
> > +
> > +#ifndef VHOST_SCSI_H
> > +#define VHOST_SCSI_H
> > +
> > +#include "qemu-common.h"
> > +#include "qdev.h"
> > +#include "virtio-scsi.h"
> > +
> > +/*
> > + * Used by QEMU userspace to ensure a consistent vhost-scsi ABI.
> > + *
> > + * ABI Rev 0: July 2012 version starting point for v3.6-rc merge candidate +
> > + *            RFC-v2 vhost-scsi userspace.  Add GET_ABI_VERSION ioctl usage
> > + * ABI Rev 1: January 2013. Ignore vhost_tpgt filed in struct vhost_scsi_target.
> > + * 	      All the targets under vhost_wwpn can be seen and used by guest.
> > + */
> > +
> > +#define VHOST_SCSI_ABI_VERSION 1
> > +
> > +/* TODO #include <linux/vhost.h> properly */
> > +/* For VHOST_SCSI_SET_ENDPOINT/VHOST_SCSI_CLEAR_ENDPOINT ioctl */
> > +struct vhost_scsi_target {
> > +    int abi_version;
> > +    char vhost_wwpn[224];
> > +    unsigned short vhost_tpgt;
> > +    unsigned short reserved;
> > +};
> > +
> > +enum vhost_scsi_vq_list {
> > +    VHOST_SCSI_VQ_CONTROL = 0,
> > +    VHOST_SCSI_VQ_EVENT = 1,
> > +    VHOST_SCSI_VQ_NUM_FIXED = 2,
> > +};
> > +
> > +#define VHOST_VIRTIO 0xAF
> > +#define VHOST_SCSI_SET_ENDPOINT _IOW(VHOST_VIRTIO, 0x40, struct vhost_scsi_target)
> > +#define VHOST_SCSI_CLEAR_ENDPOINT _IOW(VHOST_VIRTIO, 0x41, struct vhost_scsi_target)
> > +#define VHOST_SCSI_GET_ABI_VERSION _IOW(VHOST_VIRTIO, 0x42, int)
> > +
> > +#define DEFINE_VHOST_SCSI_PROPERTIES(_state, _features_field, _conf_field) \
> > +    DEFINE_PROP_BIT("indirect_desc", _state, _features_field, VIRTIO_RING_F_INDIRECT_DESC, true), \
> > +    DEFINE_PROP_BIT("event_idx", _state, _features_field, VIRTIO_RING_F_EVENT_IDX, false), \
> 
> Maybe this works around some bug?
> Needs a comment with motivation.
> 
> Ideally we won't do this, use DEFINE_VIRTIO_COMMON_FEATURES
> so that adding properties to all devices will be easier
> in the future.

AFAICT vhost-scsi has never worked without event_idx=off, so disabling
it by default here made sense.  ;)

> 
> > +    DEFINE_PROP_STRING("vhostfd", _state, _conf_field.vhostfd), \
> > +    DEFINE_PROP_STRING("wwpn", _state, _conf_field.wwpn), \
> > +    DEFINE_PROP_UINT32("num_queues", _state, _conf_field.num_queues, 1), \
> > +    DEFINE_PROP_UINT32("max_sectors", _state, _conf_field.max_sectors, 0xFFFF), \
> > +    DEFINE_PROP_UINT32("cmd_per_lun", _state, _conf_field.cmd_per_lun, 128), \
> > +    DEFINE_PROP_BIT("hotplug", _state, _features_field, VIRTIO_SCSI_F_HOTPLUG, true)
> 
> Seems unused?

Looks like left-over debug code from Asias..

Dropping this now..

> 
> > +
> > +VirtIODevice *vhost_scsi_init(DeviceState *dev, VirtIOSCSIConf *proxyconf);
> > +void vhost_scsi_exit(VirtIODevice *vdev);
> > +
> > +
> > +#endif
> > diff --git a/hw/virtio-pci.c b/hw/virtio-pci.c
> > index f3ece78..0d67b84 100644
> > --- a/hw/virtio-pci.c
> > +++ b/hw/virtio-pci.c
> > @@ -22,6 +22,7 @@
> >  #include "hw/virtio-net.h"
> >  #include "hw/virtio-serial.h"
> >  #include "hw/virtio-scsi.h"
> > +#include "hw/vhost-scsi.h"
> >  #include "hw/pci/pci.h"
> >  #include "qemu/error-report.h"
> >  #include "hw/pci/msi.h"
> > @@ -1247,6 +1248,64 @@ static const TypeInfo virtio_scsi_info = {
> >      .class_init    = virtio_scsi_class_init,
> >  };
> >  
> > +#ifdef CONFIG_VHOST_SCSI
> > +static int vhost_scsi_init_pci(PCIDevice *pci_dev)
> > +{
> > +    VirtIOPCIProxy *proxy = DO_UPCAST(VirtIOPCIProxy, pci_dev, pci_dev);
> > +    VirtIODevice *vdev;
> > +
> > +    vdev = vhost_scsi_init(&pci_dev->qdev, &proxy->scsi);
> > +    if (!vdev) {
> > +        return -EINVAL;
> > +    }
> > +
> > +    vdev->nvectors = proxy->nvectors == DEV_NVECTORS_UNSPECIFIED
> > +                                        ? proxy->scsi.num_queues + 3
> > +                                        : proxy->nvectors;
> > +    virtio_init_pci(proxy, vdev);
> > +
> > +    /* make the actual value visible */
> > +    proxy->nvectors = vdev->nvectors;
> > +    return 0;
> > +}
> > +
> > +static void vhost_scsi_exit_pci(PCIDevice *pci_dev)
> > +{
> > +    VirtIOPCIProxy *proxy = DO_UPCAST(VirtIOPCIProxy, pci_dev, pci_dev);
> > +
> > +    vhost_scsi_exit(proxy->vdev);
> > +    virtio_exit_pci(pci_dev);
> > +}
> > +
> > +static Property vhost_scsi_properties[] = {
> > +    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, DEV_NVECTORS_UNSPECIFIED),
> > +    DEFINE_VHOST_SCSI_PROPERTIES(VirtIOPCIProxy, host_features, scsi),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void vhost_scsi_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc = DEVICE_CLASS(klass);
> > +    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> > +
> > +    k->init = vhost_scsi_init_pci;
> > +    k->exit = vhost_scsi_exit_pci;
> > +    k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
> > +    k->device_id = PCI_DEVICE_ID_VIRTIO_SCSI;
> > +    k->revision = 0x00;
> > +    k->class_id = PCI_CLASS_STORAGE_SCSI;
> > +    dc->reset = virtio_pci_reset;
> > +    dc->props = vhost_scsi_properties;
> > +}
> > +
> > +static const TypeInfo vhost_scsi_info = {
> > +    .name          = "vhost-scsi-pci",
> > +    .parent        = TYPE_PCI_DEVICE,
> > +    .instance_size = sizeof(VirtIOPCIProxy),
> > +    .class_init    = vhost_scsi_class_init,
> > +};
> > +#endif
> > +
> >  #ifdef CONFIG_VIRTFS
> >  static int virtio_9p_init_pci(PCIDevice *pci_dev)
> >  {
> > @@ -1495,6 +1554,9 @@ static void virtio_pci_register_types(void)
> >      type_register_static(&virtio_serial_info);
> >      type_register_static(&virtio_balloon_info);
> >      type_register_static(&virtio_scsi_info);
> > +#ifdef CONFIG_VHOST_SCSI
> > +    type_register_static(&vhost_scsi_info);
> > +#endif
> >      type_register_static(&virtio_rng_info);
> >      type_register_static(&virtio_pci_bus_info);
> >      type_register_static(&virtio_pci_info);
> > diff --git a/hw/virtio-scsi.h b/hw/virtio-scsi.h
> > index 2bcf606..356bf38 100644
> > --- a/hw/virtio-scsi.h
> > +++ b/hw/virtio-scsi.h
> > @@ -142,6 +142,8 @@ struct VirtIOSCSIConf {
> >      uint32_t num_queues;
> >      uint32_t max_sectors;
> >      uint32_t cmd_per_lun;
> > +    char *vhostfd;
> > +    char *wwpn;
> >  };
> >  
> >  typedef struct VirtIOSCSICommon {
> > -- 
> > 1.7.2.5
> --
> To unsubscribe from this list: send the line "unsubscribe target-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
