From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 1/1] Shared memory uio_pci driver
Date: Thu, 25 Mar 2010 11:15:52 +0200
Message-ID: <20100325091552.GB11153__37914.4301558428$1269508976$gmane$org@redhat.com>
References: <1269497376-21903-1-git-send-email-cam@cs.ualberta.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1269497376-21903-1-git-send-email-cam@cs.ualberta.ca>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cam Macdonell <cam@cs.ualberta.ca>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 25, 2010 at 12:09:36AM -0600, Cam Macdonell wrote:
> This patch adds a driver for my shared memory PCI device using the uio_pci
> interface.  The driver has three memory regions.  The first memory region is for
> device registers for sending interrupts. The second BAR is for receiving MSI-X
> interrupts and the third memory region maps the shared memory.  The device only
> exports the first and third memory regions to userspace.
> 
> This driver supports MSI-X and regular pin interrupts.  Currently, the number of
> MSI vectors is set to 4 which could be increased, but the driver will work with
> fewer vectors.  If MSI is not available, then regular interrupts will be used.

Some high level questions, sorry if they have been raised in the past:
- Can this device use virtio framework?
  This gives us some standards to work off, with feature negotiation,
  ability to detect config changes, support for non-PCI
  platforms, decent documentation that is easy to extend,
  legal id range to use.
  You would thus have your driver in uio/uio_virtio_shmem.c

- Why are you using 32 bit long memory accesses for interrupts?
  16 bit IO eould be enough and it's faster. This what virtio-pci does.

- How was the driver tested?

> ---
>  drivers/uio/Kconfig       |    8 ++
>  drivers/uio/Makefile      |    1 +
>  drivers/uio/uio_ivshmem.c |  235 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 244 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/uio/uio_ivshmem.c
> 
> diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
> index 1da73ec..b92cded 100644
> --- a/drivers/uio/Kconfig
> +++ b/drivers/uio/Kconfig
> @@ -74,6 +74,14 @@ config UIO_SERCOS3
>  
>  	  If you compile this as a module, it will be called uio_sercos3.
>  
> +config UIO_IVSHMEM
> +	tristate "KVM shared memory PCI driver"
> +	default n
> +	help
> +	  Userspace I/O interface for the KVM shared memory device.  This
> +	  driver will make available two memory regions, the first is
> +	  registers and the second is a region for sharing between VMs.
> +
>  config UIO_PCI_GENERIC
>  	tristate "Generic driver for PCI 2.3 and PCI Express cards"
>  	depends on PCI
> diff --git a/drivers/uio/Makefile b/drivers/uio/Makefile
> index 18fd818..25c1ca5 100644
> --- a/drivers/uio/Makefile
> +++ b/drivers/uio/Makefile
> @@ -6,3 +6,4 @@ obj-$(CONFIG_UIO_AEC)	+= uio_aec.o
>  obj-$(CONFIG_UIO_SERCOS3)	+= uio_sercos3.o
>  obj-$(CONFIG_UIO_PCI_GENERIC)	+= uio_pci_generic.o
>  obj-$(CONFIG_UIO_NETX)	+= uio_netx.o
> +obj-$(CONFIG_UIO_IVSHMEM) += uio_ivshmem.o
> diff --git a/drivers/uio/uio_ivshmem.c b/drivers/uio/uio_ivshmem.c
> new file mode 100644
> index 0000000..607435b
> --- /dev/null
> +++ b/drivers/uio/uio_ivshmem.c
> @@ -0,0 +1,235 @@
> +/*
> + * UIO IVShmem Driver
> + *
> + * (C) 2009 Cam Macdonell
> + * based on Hilscher CIF card driver (C) 2007 Hans J. Koch <hjk@linutronix.de>
> + *
> + * Licensed under GPL version 2 only.
> + *
> + */
> +
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/uio_driver.h>
> +
> +#include <asm/io.h>
> +
> +#define IntrStatus 0x04
> +#define IntrMask 0x00
> +
> +struct ivshmem_info {
> +    struct uio_info *uio;
> +    struct pci_dev *dev;
> +    char (*msix_names)[256];
> +    struct msix_entry *msix_entries;
> +    int nvectors;
> +};
> +
> +static irqreturn_t ivshmem_handler(int irq, struct uio_info *dev_info)
> +{
> +
> +    void __iomem *plx_intscr = dev_info->mem[0].internal_addr
> +                    + IntrStatus;
> +    u32 val;
> +
> +    val = readl(plx_intscr);
> +    if (val == 0)
> +        return IRQ_NONE;
> +
> +    printk(KERN_INFO "Regular interrupt (val = %d)\n", val);
> +    return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t ivshmem_msix_handler(int irq, void *opaque)
> +{
> +
> +    struct uio_info * dev_info = (struct uio_info *) opaque;
> +
> +    /* we have to do this explicitly when using MSI-X */
> +    uio_event_notify(dev_info);
> +    printk(KERN_INFO "MSI-X interrupt (%d)\n", irq);
> +    return IRQ_HANDLED;
> +
> +}
> +
> +static int request_msix_vectors(struct ivshmem_info *ivs_info, int nvectors)
> +{
> +    int i, err;
> +    const char *name = "ivshmem";
> +
> +    printk(KERN_INFO "devname is %s\n", name);
> +    ivs_info->nvectors = nvectors;
> +
> +
> +    ivs_info->msix_entries = kmalloc(nvectors * sizeof *ivs_info->msix_entries,
> +            GFP_KERNEL);
> +    ivs_info->msix_names = kmalloc(nvectors * sizeof *ivs_info->msix_names,
> +            GFP_KERNEL);
> +
> +    for (i = 0; i < nvectors; ++i)
> +        ivs_info->msix_entries[i].entry = i;
> +
> +    err = pci_enable_msix(ivs_info->dev, ivs_info->msix_entries,
> +                    ivs_info->nvectors);
> +    if (err > 0) {
> +        ivs_info->nvectors = err; /* msi-x positive error code
> +                                     returns the number available*/
> +        err = pci_enable_msix(ivs_info->dev, ivs_info->msix_entries,
> +                    ivs_info->nvectors);
> +        if (err > 0) {
> +            printk(KERN_INFO "no MSI (%d). Back to INTx.\n", err);
> +            return -ENOSPC;
> +        }
> +    }
> +
> +    printk(KERN_INFO "err is %d\n", err);
> +    if (err) return err;
> +
> +    for (i = 0; i < ivs_info->nvectors; i++) {
> +
> +        snprintf(ivs_info->msix_names[i], sizeof *ivs_info->msix_names,
> +            "%s-config", name);
> +
> +        ivs_info->msix_entries[i].entry = i;
> +        err = request_irq(ivs_info->msix_entries[i].vector,
> +            ivshmem_msix_handler, 0,
> +            ivs_info->msix_names[i], ivs_info->uio);
> +
> +        if (err) {
> +            return -ENOSPC;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static int __devinit ivshmem_pci_probe(struct pci_dev *dev,
> +                    const struct pci_device_id *id)
> +{
> +    struct uio_info *info;
> +    struct ivshmem_info * ivshmem_info;
> +    int nvectors = 4;
> +
> +    info = kzalloc(sizeof(struct uio_info), GFP_KERNEL);
> +    if (!info)
> +        return -ENOMEM;
> +
> +    ivshmem_info = kzalloc(sizeof(struct ivshmem_info), GFP_KERNEL);
> +    if (!ivshmem_info) {
> +        kfree(info);
> +        return -ENOMEM;
> +    }
> +
> +    if (pci_enable_device(dev))
> +        goto out_free;
> +
> +    if (pci_request_regions(dev, "ivshmem"))
> +        goto out_disable;
> +
> +    info->mem[0].addr = pci_resource_start(dev, 0);
> +    if (!info->mem[0].addr)
> +        goto out_release;
> +
> +    info->mem[0].size = pci_resource_len(dev, 0);
> +    info->mem[0].internal_addr = pci_ioremap_bar(dev, 0);
> +    if (!info->mem[0].internal_addr) {
> +        printk(KERN_INFO "got a null");
> +        goto out_release;
> +    }
> +
> +    info->mem[0].memtype = UIO_MEM_PHYS;
> +
> +    info->mem[1].addr = pci_resource_start(dev, 2);
> +    if (!info->mem[1].addr)
> +        goto out_unmap;
> +    info->mem[1].internal_addr = pci_ioremap_bar(dev, 2);
> +    if (!info->mem[1].internal_addr)
> +        goto out_unmap;
> +
> +    info->mem[1].size = pci_resource_len(dev, 2);
> +    info->mem[1].memtype = UIO_MEM_PHYS;
> +
> +    ivshmem_info->uio = info;
> +    ivshmem_info->dev = dev;
> +
> +    if (request_msix_vectors(ivshmem_info, nvectors) != 0) {
> +        printk(KERN_INFO "regular IRQs\n");
> +        info->irq = dev->irq;
> +        info->irq_flags = IRQF_SHARED;
> +        info->handler = ivshmem_handler;
> +        writel(0xffffffff, info->mem[0].internal_addr + IntrMask);
> +    } else {
> +        printk(KERN_INFO "MSI-X enabled\n");
> +        info->irq = -1;
> +    }
> +
> +    info->name = "ivshmem";
> +    info->version = "0.0.1";
> +
> +    if (uio_register_device(&dev->dev, info))
> +        goto out_unmap2;
> +
> +    pci_set_drvdata(dev, info);
> +
> +
> +    return 0;
> +out_unmap2:
> +    iounmap(info->mem[2].internal_addr);
> +out_unmap:
> +    iounmap(info->mem[0].internal_addr);
> +out_release:
> +    pci_release_regions(dev);
> +out_disable:
> +    pci_disable_device(dev);
> +out_free:
> +    kfree (info);
> +    return -ENODEV;
> +}
> +
> +static void ivshmem_pci_remove(struct pci_dev *dev)
> +{
> +    struct uio_info *info = pci_get_drvdata(dev);
> +
> +    uio_unregister_device(info);
> +    pci_release_regions(dev);
> +    pci_disable_device(dev);
> +    pci_set_drvdata(dev, NULL);
> +    iounmap(info->mem[0].internal_addr);
> +
> +    kfree (info);
> +}
> +
> +static struct pci_device_id ivshmem_pci_ids[] __devinitdata = {
> +    {
> +        .vendor =    0x1af4,
> +        .device =    0x1110,
> +        .subvendor =    PCI_ANY_ID,
> +        .subdevice =    PCI_ANY_ID,
> +    },
> +    { 0, }
> +};
> +
> +static struct pci_driver ivshmem_pci_driver = {
> +    .name = "uio_ivshmem",
> +    .id_table = ivshmem_pci_ids,
> +    .probe = ivshmem_pci_probe,
> +    .remove = ivshmem_pci_remove,
> +};
> +
> +static int __init ivshmem_init_module(void)
> +{
> +    return pci_register_driver(&ivshmem_pci_driver);
> +}
> +
> +static void __exit ivshmem_exit_module(void)
> +{
> +    pci_unregister_driver(&ivshmem_pci_driver);
> +}
> +
> +module_init(ivshmem_init_module);
> +module_exit(ivshmem_exit_module);
> +
> +MODULE_DEVICE_TABLE(pci, ivshmem_pci_ids);
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Cam Macdonell");
> -- 
> 1.6.6.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
