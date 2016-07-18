From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 2/3] qemu: Implement virtio-pstore device
Date: Mon, 18 Jul 2016 09:28:42 +0200
Message-ID: <578C852A.1030502@de.ibm.com>
References: <1468816661-6345-1-git-send-email-namhyung@kernel.org>
	<1468816661-6345-3-git-send-email-namhyung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1468816661-6345-3-git-send-email-namhyung@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Namhyung Kim <namhyung@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Namhyung Kim <namhyung@gmail.com>, Anton Vorontsov <anton@enomsg.org>, qemu-devel@nongnu.org, Steven Rostedt <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, Minchan Kim <minchan@kernel.org>, Anthony Liguori <aliguori@amazon.com>, Colin Cross <ccross@android.com>, Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 07/18/2016 06:37 AM, Namhyung Kim wrote:

Can you do the virtio-mmio and virtio-ccw plumbing as well, or
do you need help with that?

[...]
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 2b34b43..8281b80 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -2416,6 +2416,55 @@ static const TypeInfo virtio_host_pci_info = {
>  };
>  #endif
> 
> +/* virtio-pstore-pci */
> +
> +static void virtio_pstore_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> +{
> +    VirtIOPstorePCI *vps = VIRTIO_PSTORE_PCI(vpci_dev);
> +    DeviceState *vdev = DEVICE(&vps->vdev);
> +    Error *err = NULL;
> +
> +    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
> +    object_property_set_bool(OBJECT(vdev), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +}
> +
> +static void virtio_pstore_pci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
> +    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
> +
> +    k->realize = virtio_pstore_pci_realize;
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +
> +    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
> +    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_PSTORE;
> +    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
> +    pcidev_k->class_id = PCI_CLASS_OTHERS;
> +}
> +
> +static void virtio_pstore_pci_instance_init(Object *obj)
> +{
> +    VirtIOPstorePCI *dev = VIRTIO_PSTORE_PCI(obj);
> +
> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VIRTIO_PSTORE);
> +    object_property_add_alias(obj, "directory", OBJECT(&dev->vdev),
> +                              "directory", &error_abort);
> +}
> +
> +static const TypeInfo virtio_pstore_pci_info = {
> +    .name          = TYPE_VIRTIO_PSTORE_PCI,
> +    .parent        = TYPE_VIRTIO_PCI,
> +    .instance_size = sizeof(VirtIOPstorePCI),
> +    .instance_init = virtio_pstore_pci_instance_init,
> +    .class_init    = virtio_pstore_pci_class_init,
> +};
> +
>  /* virtio-pci-bus */
> 
>  static void virtio_pci_bus_new(VirtioBusState *bus, size_t bus_size,
> @@ -2485,6 +2534,7 @@ static void virtio_pci_register_types(void)
>  #ifdef CONFIG_VHOST_SCSI
>      type_register_static(&vhost_scsi_pci_info);
>  #endif
> +    type_register_static(&virtio_pstore_pci_info);
>  }
> 
>  type_init(virtio_pci_register_types)
> diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> index e4548c2..b4c039f 100644
> --- a/hw/virtio/virtio-pci.h
> +++ b/hw/virtio/virtio-pci.h
> @@ -31,6 +31,7 @@
>  #ifdef CONFIG_VHOST_SCSI
>  #include "hw/virtio/vhost-scsi.h"
>  #endif
> +#include "hw/virtio/virtio-pstore.h"
> 
>  typedef struct VirtIOPCIProxy VirtIOPCIProxy;
>  typedef struct VirtIOBlkPCI VirtIOBlkPCI;
> @@ -44,6 +45,7 @@ typedef struct VirtIOInputPCI VirtIOInputPCI;
>  typedef struct VirtIOInputHIDPCI VirtIOInputHIDPCI;
>  typedef struct VirtIOInputHostPCI VirtIOInputHostPCI;
>  typedef struct VirtIOGPUPCI VirtIOGPUPCI;
> +typedef struct VirtIOPstorePCI VirtIOPstorePCI;
> 
>  /* virtio-pci-bus */
> 
> @@ -311,6 +313,18 @@ struct VirtIOGPUPCI {
>      VirtIOGPU vdev;
>  };
> 
> +/*
> + * virtio-pstore-pci: This extends VirtioPCIProxy.
> + */
> +#define TYPE_VIRTIO_PSTORE_PCI "virtio-pstore-pci"
> +#define VIRTIO_PSTORE_PCI(obj) \
> +        OBJECT_CHECK(VirtIOPstorePCI, (obj), TYPE_VIRTIO_PSTORE_PCI)
> +
> +struct VirtIOPstorePCI {
> +    VirtIOPCIProxy parent_obj;
> +    VirtIOPstore vdev;
> +};
> +
>  /* Virtio ABI version, if we increment this, we break the guest driver. */
>  #define VIRTIO_PCI_ABI_VERSION          0
> 

[...]
