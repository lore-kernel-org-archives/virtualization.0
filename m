From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Tue, 28 May 2013 12:15:16 -0500
Message-ID: <87bo7vvxej.fsf__17405.5479736582$1369761958$gmane$org@codemonkey.ws>
References: <20130528160342.GA29915@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130528160342.GA29915@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, Rusty Russell <rusty@rustcorp.com.au>, kvm@vger.kernel.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:

> This adds support for new config, and is designed to work with
> the new layout code in Rusty's new layout branch.
>
> At the moment all fields are in the same memory BAR (bar 2).
> This will be used to test performance and compare
> memory, io and hypercall latency.
>
> Compiles but does not work yet.
> Migration isn't handled yet.
>
> It's not clear what do queue_enable/queue_disable
> fields do, not yet implemented.
>
> Gateway for config access with config cycles
> not yet implemented.
>
> Sending out for early review/flames.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/virtio/virtio-pci.c     | 393 +++++++++++++++++++++++++++++++++++++++++++--
>  hw/virtio/virtio-pci.h     |  55 +++++++
>  hw/virtio/virtio.c         |  20 +++
>  include/hw/virtio/virtio.h |   4 +
>  4 files changed, 458 insertions(+), 14 deletions(-)
>
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 752991a..f4db224 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -259,6 +259,26 @@ static void virtio_pci_stop_ioeventfd(VirtIOPCIProxy *proxy)
>      proxy->ioeventfd_started = false;
>  }
>  
> +static void virtio_pci_set_status(VirtIOPCIProxy *proxy, uint8_t val)
> +{
> +    VirtIODevice *vdev = proxy->vdev;
> +
> +    if (!(val & VIRTIO_CONFIG_S_DRIVER_OK)) {
> +        virtio_pci_stop_ioeventfd(proxy);
> +    }
> +
> +    virtio_set_status(vdev, val & 0xFF);
> +
> +    if (val & VIRTIO_CONFIG_S_DRIVER_OK) {
> +        virtio_pci_start_ioeventfd(proxy);
> +    }
> +
> +    if (vdev->status == 0) {
> +        virtio_reset(proxy->vdev);
> +        msix_unuse_all_vectors(&proxy->pci_dev);
> +    }
> +}
> +
>  static void virtio_ioport_write(void *opaque, uint32_t addr, uint32_t val)
>  {
>      VirtIOPCIProxy *proxy = opaque;
> @@ -293,20 +313,7 @@ static void virtio_ioport_write(void *opaque, uint32_t addr, uint32_t val)
>          }
>          break;
>      case VIRTIO_PCI_STATUS:
> -        if (!(val & VIRTIO_CONFIG_S_DRIVER_OK)) {
> -            virtio_pci_stop_ioeventfd(proxy);
> -        }
> -
> -        virtio_set_status(vdev, val & 0xFF);
> -
> -        if (val & VIRTIO_CONFIG_S_DRIVER_OK) {
> -            virtio_pci_start_ioeventfd(proxy);
> -        }
> -
> -        if (vdev->status == 0) {
> -            virtio_reset(proxy->vdev);
> -            msix_unuse_all_vectors(&proxy->pci_dev);
> -        }
> +        virtio_pci_set_status(proxy, val);
>  
>          /* Linux before 2.6.34 sets the device as OK without enabling
>             the PCI device bus master bit. In this case we need to disable
> @@ -455,6 +462,226 @@ static void virtio_pci_config_write(void *opaque, hwaddr addr,
>      }
>  }
>  
> +static uint64_t virtio_pci_config_common_read(void *opaque, hwaddr addr,
> +                                              unsigned size)
> +{
> +    VirtIOPCIProxy *proxy = opaque;
> +    VirtIODevice *vdev = proxy->vdev;
> +
> +    uint64_t low = 0xffffffffull;
> +
> +    switch (addr) {
> +    case offsetof(struct virtio_pci_common_cfg, device_feature_select):
> +        return proxy->device_feature_select;

Oh dear no...  Please use defines like the rest of QEMU.

From a QEMU pov, take a look at:

https://github.com/aliguori/qemu/commit/587c35c1a3fe90f6af0f97927047ef4d3182a659

And:

https://github.com/aliguori/qemu/commit/01ba80a23cf2eb1e15056f82b44b94ec381565cb

Which lets virtio-pci be subclassable and then remaps the config space to
BAR2.

Haven't looked at the proposed new ring layout yet.

Regards,

Anthony Liguori

> +    case offsetof(struct virtio_pci_common_cfg, device_feature):
> +        /* TODO: 64-bit features */
> +	return proxy->device_feature_select ? 0 : proxy->host_features;
> +    case offsetof(struct virtio_pci_common_cfg, guest_feature_select):
> +        return proxy->guest_feature_select;
> +    case offsetof(struct virtio_pci_common_cfg, guest_feature):
> +        /* TODO: 64-bit features */
> +	return proxy->guest_feature_select ? 0 : vdev->guest_features;
> +    case offsetof(struct virtio_pci_common_cfg, msix_config):
> +	return vdev->config_vector;
> +    case offsetof(struct virtio_pci_common_cfg, num_queues):
> +        /* TODO: more exact limit? */
> +	return VIRTIO_PCI_QUEUE_MAX;
> +    case offsetof(struct virtio_pci_common_cfg, device_status):
> +        return vdev->status;
> +
> +	/* About a specific virtqueue. */
> +    case offsetof(struct virtio_pci_common_cfg, queue_select):
> +        return  vdev->queue_sel;
> +    case offsetof(struct virtio_pci_common_cfg, queue_size):
> +        return virtio_queue_get_num(vdev, vdev->queue_sel);
> +    case offsetof(struct virtio_pci_common_cfg, queue_msix_vector):
> +	return virtio_queue_vector(vdev, vdev->queue_sel);
> +    case offsetof(struct virtio_pci_common_cfg, queue_enable):
> +        /* TODO */
> +	return 0;
> +    case offsetof(struct virtio_pci_common_cfg, queue_notify_off):
> +        return vdev->queue_sel;
> +    case offsetof(struct virtio_pci_common_cfg, queue_desc):
> +        return virtio_queue_get_desc_addr(vdev, vdev->queue_sel) & low;
> +    case offsetof(struct virtio_pci_common_cfg, queue_desc) + 4:
> +        return virtio_queue_get_desc_addr(vdev, vdev->queue_sel) >> 32;
> +    case offsetof(struct virtio_pci_common_cfg, queue_avail):
> +        return virtio_queue_get_avail_addr(vdev, vdev->queue_sel) & low;
> +    case offsetof(struct virtio_pci_common_cfg, queue_avail) + 4:
> +        return virtio_queue_get_avail_addr(vdev, vdev->queue_sel) >> 32;
> +    case offsetof(struct virtio_pci_common_cfg, queue_used):
> +        return virtio_queue_get_used_addr(vdev, vdev->queue_sel) & low;
> +    case offsetof(struct virtio_pci_common_cfg, queue_used) + 4:
> +        return virtio_queue_get_used_addr(vdev, vdev->queue_sel) >> 32;
> +    default:
> +        return 0;
> +    }
> +}
> +
> +static void virtio_pci_config_common_write(void *opaque, hwaddr addr,
> +                                           uint64_t val, unsigned size)
> +{
> +    VirtIOPCIProxy *proxy = opaque;
> +    VirtIODevice *vdev = proxy->vdev;
> +
> +    uint64_t low = 0xffffffffull;
> +    uint64_t high = ~low;
> +
> +    switch (addr) {
> +    case offsetof(struct virtio_pci_common_cfg, device_feature_select):
> +        proxy->device_feature_select = val;
> +        break;
> +    case offsetof(struct virtio_pci_common_cfg, device_feature):
> +        break;
> +    case offsetof(struct virtio_pci_common_cfg, guest_feature_select):
> +        proxy->guest_feature_select = val;
> +        break;
> +    case offsetof(struct virtio_pci_common_cfg, guest_feature):
> +        /* TODO: 64-bit features */
> +	if (!proxy->guest_feature_select) {
> +            virtio_set_features(vdev, val);
> +        }
> +        break;
> +    case offsetof(struct virtio_pci_common_cfg, msix_config):
> +	vdev->config_vector = val;
> +        break;
> +    case offsetof(struct virtio_pci_common_cfg, num_queues):
> +        break;
> +    case offsetof(struct virtio_pci_common_cfg, device_status):
> +        virtio_pci_set_status(proxy, val);
> +        break;
> +	/* About a specific virtqueue. */
> +    case offsetof(struct virtio_pci_common_cfg, queue_select):
> +        assert(val < VIRTIO_PCI_QUEUE_MAX);
> +        vdev->queue_sel = val;
> +        break;
> +    case offsetof(struct virtio_pci_common_cfg, queue_size):
> +        assert(val && val < 0x8ffff && !(val & (val - 1)));
> +        virtio_queue_set_num(vdev, vdev->queue_sel, val);
> +        break;
> +    case offsetof(struct virtio_pci_common_cfg, queue_msix_vector):
> +	virtio_queue_set_vector(vdev, vdev->queue_sel, val);
> +        break;
> +    case offsetof(struct virtio_pci_common_cfg, queue_enable):
> +        /* TODO */
> +	break;
> +    case offsetof(struct virtio_pci_common_cfg, queue_notify_off):
> +        break;
> +    case offsetof(struct virtio_pci_common_cfg, queue_desc):
> +        val &= low;
> +        val |= virtio_queue_get_desc_addr(vdev, vdev->queue_sel) & high;
> +        virtio_queue_set_desc_addr(vdev, vdev->queue_sel, val);
> +        break;
> +    case offsetof(struct virtio_pci_common_cfg, queue_desc) + 4:
> +        val = val << 32;
> +        val |= virtio_queue_get_desc_addr(vdev, vdev->queue_sel) & low;
> +        virtio_queue_set_desc_addr(vdev, vdev->queue_sel, val);
> +        break;
> +    case offsetof(struct virtio_pci_common_cfg, queue_avail):
> +        val &= low;
> +        val |= virtio_queue_get_avail_addr(vdev, vdev->queue_sel) & high;
> +        virtio_queue_set_avail_addr(vdev, vdev->queue_sel, val);
> +        break;
> +    case offsetof(struct virtio_pci_common_cfg, queue_avail) + 4:
> +        val = val << 32;
> +        val |= virtio_queue_get_avail_addr(vdev, vdev->queue_sel) & low;
> +        virtio_queue_set_avail_addr(vdev, vdev->queue_sel, val);
> +        break;
> +    case offsetof(struct virtio_pci_common_cfg, queue_used):
> +        val &= low;
> +        val |= virtio_queue_get_used_addr(vdev, vdev->queue_sel) & high;
> +        virtio_queue_set_used_addr(vdev, vdev->queue_sel, val);
> +        break;
> +    case offsetof(struct virtio_pci_common_cfg, queue_used) + 4:
> +        val = val << 32;
> +        val |= virtio_queue_get_used_addr(vdev, vdev->queue_sel) & low;
> +        virtio_queue_set_used_addr(vdev, vdev->queue_sel, val);
> +        break;
> +    default:
> +        break;
> +    }
> +}
> +
> +static uint64_t virtio_pci_config_isr_read(void *opaque, hwaddr addr,
> +                                           unsigned size)
> +{
> +    VirtIOPCIProxy *proxy = opaque;
> +    VirtIODevice *vdev = proxy->vdev;
> +    uint8_t ret;
> +
> +    /* reading from the ISR also clears it. */
> +    ret = vdev->isr;
> +    vdev->isr = 0;
> +    qemu_set_irq(proxy->pci_dev.irq[0], 0);
> +    return ret;
> +}
> +
> +static void virtio_pci_config_isr_write(void *opaque, hwaddr addr,
> +                                           uint64_t val, unsigned size)
> +{
> +}
> +
> +static uint64_t virtio_pci_config_notify_read(void *opaque, hwaddr addr,
> +                                              unsigned size)
> +{
> +    return 0;
> +}
> +
> +static void virtio_pci_config_notify_write(void *opaque, hwaddr addr,
> +                                           uint64_t val, unsigned size)
> +{
> +    VirtIOPCIProxy *proxy = opaque;
> +    VirtIODevice *vdev = proxy->vdev;
> +    if (val < VIRTIO_PCI_QUEUE_MAX) {
> +        virtio_queue_notify(vdev, val);
> +    }
> +}
> +
> +static uint64_t virtio_pci_config_device_read(void *opaque, hwaddr addr,
> +                                              unsigned size)
> +{
> +    VirtIOPCIProxy *proxy = opaque;
> +    uint64_t val = 0;
> +    switch (size) {
> +    case 1:
> +        val = virtio_config_readb(proxy->vdev, addr);
> +        break;
> +    case 2:
> +        val = virtio_config_readw(proxy->vdev, addr);
> +        break;
> +    case 4:
> +        /* Most devices don't have 64 bit config fields.
> +         * Block is an exception: first 8 bytes include
> +         * a 64 bit capacity field.
> +         */
> +        if (VIRTIO_HOST_IS_BIG_ENDIAN &&
> +            proxy->vdev->device_id == VIRTIO_ID_BLOCK && addr < 8) {
> +            /* Swap first two words */
> +            addr ^= 0x4;
> +        }
> +        val = virtio_config_readl(proxy->vdev, addr);
> +        break;
> +    }
> +    return val;
> +}
> +
> +static void virtio_pci_config_device_write(void *opaque, hwaddr addr,
> +                                           uint64_t val, unsigned size)
> +{
> +    VirtIOPCIProxy *proxy = opaque;
> +    switch (size) {
> +    case 1:
> +        virtio_config_writeb(proxy->vdev, addr, val);
> +        break;
> +    case 2:
> +        virtio_config_writew(proxy->vdev, addr, val);
> +        break;
> +    case 4:
> +        virtio_config_writel(proxy->vdev, addr, val);
> +        break;
> +    }
> +}
> +
>  static const MemoryRegionOps virtio_pci_config_ops = {
>      .read = virtio_pci_config_read,
>      .write = virtio_pci_config_write,
> @@ -465,6 +692,46 @@ static const MemoryRegionOps virtio_pci_config_ops = {
>      .endianness = DEVICE_LITTLE_ENDIAN,
>  };
>  
> +static const MemoryRegionOps virtio_pci_config_common_ops = {
> +    .read = virtio_pci_config_common_read,
> +    .write = virtio_pci_config_common_write,
> +    .impl = {
> +        .min_access_size = 1,
> +        .max_access_size = 4,
> +    },
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
> +static const MemoryRegionOps virtio_pci_config_isr_ops = {
> +    .read = virtio_pci_config_isr_read,
> +    .write = virtio_pci_config_isr_write,
> +    .impl = {
> +        .min_access_size = 1,
> +        .max_access_size = 1,
> +    },
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
> +static const MemoryRegionOps virtio_pci_config_notify_ops = {
> +    .read = virtio_pci_config_notify_read,
> +    .write = virtio_pci_config_notify_write,
> +    .impl = {
> +        .min_access_size = 2,
> +        .max_access_size = 2,
> +    },
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
> +static const MemoryRegionOps virtio_pci_config_device_ops = {
> +    .read = virtio_pci_config_device_read,
> +    .write = virtio_pci_config_device_write,
> +    .impl = {
> +        .min_access_size = 1,
> +        .max_access_size = 4,
> +    },
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
>  static void virtio_write_config(PCIDevice *pci_dev, uint32_t address,
>                                  uint32_t val, int len)
>  {
> @@ -949,11 +1216,49 @@ static const TypeInfo virtio_9p_pci_info = {
>   * virtio-pci: This is the PCIDevice which has a virtio-pci-bus.
>   */
>  
> +#define VIRTIO_PCI_CONFIG_BAR_NUM 2
> +
> +static void *virtio_pci_cap_add(VirtIOPCIProxy *proxy,
> +                                const char *name,
> +                                MemoryRegion *reg,
> +                                const MemoryRegionOps *ops,
> +                                unsigned offset,
> +                                unsigned size,
> +                                unsigned cap_type,
> +                                unsigned cap_length)
> +{
> +    struct virtio_pci_cap *cap;
> +    int c;
> +    memory_region_init_io(reg, ops, proxy, name, size);
> +    memory_region_add_subregion(&proxy->config_bar, offset, reg);
> +
> +    if (!cap_length) {
> +        cap_length = sizeof *cap;
> +    }
> +    c = pci_add_capability(&proxy->pci_dev, PCI_CAP_ID_VNDR, 0, cap_length);
> +    assert(c > 0);
> +    cap = (void *)proxy->pci_dev.config + c;
> +    cap->cap_length = cap_length;
> +    cap->cfg_type = cap_type;
> +    cap->bar = VIRTIO_PCI_CONFIG_BAR_NUM;
> +    cap->offset = offset;
> +    cap->length = size;
> +
> +    return cap;
> +}
> +
> +static void virtio_pci_cap_del(VirtIOPCIProxy *proxy, MemoryRegion *reg)
> +{
> +    memory_region_del_subregion(&proxy->config_bar, reg);
> +    memory_region_destroy(reg);
> +}
> +
>  /* This is called by virtio-bus just after the device is plugged. */
>  static void virtio_pci_device_plugged(DeviceState *d)
>  {
>      VirtIOPCIProxy *proxy = VIRTIO_PCI(d);
>      VirtioBusState *bus = &proxy->bus;
> +    struct virtio_pci_notify_cap *notify_cap;
>      uint8_t *config;
>      uint32_t size;
>  
> @@ -986,6 +1291,59 @@ static void virtio_pci_device_plugged(DeviceState *d)
>      pci_register_bar(&proxy->pci_dev, 0, PCI_BASE_ADDRESS_SPACE_IO,
>                       &proxy->bar);
>  
> +    /* New config layout */
> +    /* Four capabilities: common, notify, isr, device cfg */
> +#define VIRTIO_PCI_CONFIG_BAR_SIZE 0x1000
> +#define VIRTIO_PCI_CONFIG_COMMON 0x0
> +#define VIRTIO_PCI_CONFIG_NOTIFY 0x100
> +#define VIRTIO_PCI_CONFIG_ISR 0x200
> +#define VIRTIO_PCI_CONFIG_DEVICE 0x300
> +
> +    /* Make sure we left enough space for all vqs */
> +    assert(VIRTIO_PCI_CONFIG_ISR - VIRTIO_PCI_CONFIG_NOTIFY >=
> +           VIRTIO_PCI_QUEUE_MAX * 2);
> +    assert(VIRTIO_PCI_CONFIG_BAR_SIZE - VIRTIO_PCI_CONFIG_DEVICE >=
> +           proxy->vdev->config_len);
> +
> +    memory_region_init(&proxy->config_bar, "virtio-pci-config",
> +                       VIRTIO_PCI_CONFIG_BAR_SIZE);
> +
> +    virtio_pci_cap_add(proxy, "virtio-pci-common", 
> +                       &proxy->config_common,
> +                       &virtio_pci_config_common_ops,
> +                       VIRTIO_PCI_CONFIG_COMMON,
> +                       sizeof(struct virtio_pci_common_cfg),
> +                       VIRTIO_PCI_CAP_COMMON_CFG,
> +                       0);
> +    notify_cap = virtio_pci_cap_add(proxy, "virtio-pci-notify", 
> +                                    &proxy->config_notify,
> +                                    &virtio_pci_config_notify_ops,
> +                                    VIRTIO_PCI_CONFIG_NOTIFY,
> +                                    VIRTIO_PCI_QUEUE_MAX * 2,
> +                                    VIRTIO_PCI_CAP_NOTIFY_CFG,
> +                                    sizeof *notify_cap);
> +    notify_cap->notify_off_multiplier = 0x2;
> +    virtio_pci_cap_add(proxy, "virtio-pci-isr", 
> +                       &proxy->config_isr,
> +                       &virtio_pci_config_isr_ops,
> +                       VIRTIO_PCI_CONFIG_ISR,
> +                       0x1,
> +                       VIRTIO_PCI_CAP_ISR_CFG,
> +                       0);
> +    if (proxy->vdev->config_len) {
> +        virtio_pci_cap_add(proxy, "virtio-pci-device", 
> +                           &proxy->config_device,
> +                           &virtio_pci_config_device_ops,
> +                           VIRTIO_PCI_CONFIG_DEVICE,
> +                           proxy->vdev->config_len,
> +                           VIRTIO_PCI_CAP_DEVICE_CFG,
> +                           0);
> +    }
> +
> +    pci_register_bar(&proxy->pci_dev, VIRTIO_PCI_CONFIG_BAR_NUM,
> +                     PCI_BASE_ADDRESS_SPACE_MEMORY,
> +                     &proxy->config_bar);
> +
>      if (!kvm_has_many_ioeventfds()) {
>          proxy->flags &= ~VIRTIO_PCI_FLAG_USE_IOEVENTFD;
>      }
> @@ -1012,6 +1370,13 @@ static void virtio_pci_exit(PCIDevice *pci_dev)
>      VirtIOPCIProxy *proxy = VIRTIO_PCI(pci_dev);
>      virtio_pci_stop_ioeventfd(proxy);
>      memory_region_destroy(&proxy->bar);
> +    virtio_pci_cap_del(proxy, &proxy->config_common);
> +    virtio_pci_cap_del(proxy, &proxy->config_notify);
> +    virtio_pci_cap_del(proxy, &proxy->config_isr);
> +    if (&proxy->vdev->config_len) {
> +        virtio_pci_cap_del(proxy, &proxy->config_device);
> +    }
> +    memory_region_destroy(&proxy->config_bar);
>      msix_uninit_exclusive_bar(pci_dev);
>  }
>  
> diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> index 917bcc5..01005e7 100644
> --- a/hw/virtio/virtio-pci.h
> +++ b/hw/virtio/virtio-pci.h
> @@ -84,6 +84,11 @@ struct VirtIOPCIProxy {
>      PCIDevice pci_dev;
>      VirtIODevice *vdev;
>      MemoryRegion bar;
> +    MemoryRegion config_bar;
> +    MemoryRegion config_common;
> +    MemoryRegion config_isr;
> +    MemoryRegion config_notify;
> +    MemoryRegion config_device;
>      uint32_t flags;
>      uint32_t class_code;
>      uint32_t nvectors;
> @@ -93,6 +98,8 @@ struct VirtIOPCIProxy {
>      VirtIOIRQFD *vector_irqfd;
>      int nvqs_with_notifiers;
>      VirtioBusState bus;
> +    unsigned device_feature_select;
> +    unsigned guest_feature_select;
>  };
>  
>  
> @@ -203,4 +210,52 @@ struct VirtIORngPCI {
>  /* Virtio ABI version, if we increment this, we break the guest driver. */
>  #define VIRTIO_PCI_ABI_VERSION          0
>  
> +/* IDs for different capabilities.  Must all exist. */
> +/* Common configuration */
> +#define VIRTIO_PCI_CAP_COMMON_CFG	1
> +/* Notifications */
> +#define VIRTIO_PCI_CAP_NOTIFY_CFG	2
> +/* ISR access */
> +#define VIRTIO_PCI_CAP_ISR_CFG		3
> +/* Device specific confiuration */
> +#define VIRTIO_PCI_CAP_DEVICE_CFG	4
> +
> +/* This is the PCI capability header: */
> +struct virtio_pci_cap {
> +	uint8_t cap_vndr;	/* Generic PCI field: PCI_CAP_ID_VNDR */
> +	uint8_t cap_next;	/* Generic PCI field: next ptr. */
> +	uint8_t cap_length;	/* Generic PCI field: capability length. */
> +	uint8_t cfg_type;	/* One of the VIRTIO_PCI_CAP_*_CFG. */
> +	uint8_t bar;		/* Where to find it. */
> +	uint32_t offset;	/* Offset within bar. */
> +	uint32_t length;	/* Length. */
> +};
> +
> +struct virtio_pci_notify_cap {
> +	struct virtio_pci_cap cap;
> +	uint32_t notify_off_multiplier;	/* Multiplier for queue_notify_off. */
> +};
> +
> +/* Fields in VIRTIO_PCI_CAP_COMMON_CFG: */
> +struct virtio_pci_common_cfg {
> +	/* About the whole device. */
> +	uint32_t device_feature_select;	/* read-write */
> +	uint32_t device_feature;		/* read-only */
> +	uint32_t guest_feature_select;	/* read-write */
> +	uint32_t guest_feature;		/* read-only */
> +	uint16_t msix_config;		/* read-write */
> +	uint16_t num_queues;		/* read-only */
> +	uint8_t device_status;		/* read-write */
> +	uint8_t unused1;
> +
> +	/* About a specific virtqueue. */
> +	uint16_t queue_select;		/* read-write */
> +	uint16_t queue_size;		/* read-write, power of 2. */
> +	uint16_t queue_msix_vector;	/* read-write */
> +	uint16_t queue_enable;		/* read-write */
> +	uint16_t queue_notify_off;	/* read-only */
> +	uint64_t queue_desc;		/* read-write */
> +	uint64_t queue_avail;		/* read-write */
> +	uint64_t queue_used;		/* read-write */
> +};
>  #endif
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 8176c14..e54d692 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -672,6 +672,11 @@ int virtio_queue_get_num(VirtIODevice *vdev, int n)
>      return vdev->vq[n].vring.num;
>  }
>  
> +void virtio_queue_set_num(VirtIODevice *vdev, int n, int num)
> +{
> +    vdev->vq[n].vring.num = num;
> +}
> +
>  int virtio_queue_get_id(VirtQueue *vq)
>  {
>      VirtIODevice *vdev = vq->vdev;
> @@ -987,6 +992,21 @@ hwaddr virtio_queue_get_used_addr(VirtIODevice *vdev, int n)
>      return vdev->vq[n].vring.used;
>  }
>  
> +void virtio_queue_set_desc_addr(VirtIODevice *vdev, int n, hwaddr addr)
> +{
> +    vdev->vq[n].vring.desc = addr;
> +}
> +
> +void virtio_queue_set_avail_addr(VirtIODevice *vdev, int n, hwaddr addr)
> +{
> +    vdev->vq[n].vring.avail = addr;
> +}
> +
> +void virtio_queue_set_used_addr(VirtIODevice *vdev, int n, hwaddr addr)
> +{
> +    vdev->vq[n].vring.used = addr;
> +}
> +
>  hwaddr virtio_queue_get_ring_addr(VirtIODevice *vdev, int n)
>  {
>      return vdev->vq[n].vring.desc;
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index a6c5c53..d056d58 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -199,6 +199,7 @@ void virtio_config_writel(VirtIODevice *vdev, uint32_t addr, uint32_t data);
>  void virtio_queue_set_addr(VirtIODevice *vdev, int n, hwaddr addr);
>  hwaddr virtio_queue_get_addr(VirtIODevice *vdev, int n);
>  int virtio_queue_get_num(VirtIODevice *vdev, int n);
> +void virtio_queue_set_num(VirtIODevice *vdev, int n, int num);
>  void virtio_queue_notify(VirtIODevice *vdev, int n);
>  uint16_t virtio_queue_vector(VirtIODevice *vdev, int n);
>  void virtio_queue_set_vector(VirtIODevice *vdev, int n, uint16_t vector);
> @@ -226,6 +227,9 @@ typedef struct VirtIORNGConf VirtIORNGConf;
>  hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
>  hwaddr virtio_queue_get_avail_addr(VirtIODevice *vdev, int n);
>  hwaddr virtio_queue_get_used_addr(VirtIODevice *vdev, int n);
> +void virtio_queue_set_desc_addr(VirtIODevice *vdev, int n, hwaddr addr);
> +void virtio_queue_set_avail_addr(VirtIODevice *vdev, int n, hwaddr addr);
> +void virtio_queue_set_used_addr(VirtIODevice *vdev, int n, hwaddr addr);
>  hwaddr virtio_queue_get_ring_addr(VirtIODevice *vdev, int n);
>  hwaddr virtio_queue_get_desc_size(VirtIODevice *vdev, int n);
>  hwaddr virtio_queue_get_avail_size(VirtIODevice *vdev, int n);
> -- 
> MST
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
