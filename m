From: Cam Macdonell <cam@cs.ualberta.ca>
Subject: Re: [PATCH v3 1/1] Shared memory uio_pci driver
Date: Thu, 25 Mar 2010 10:18:12 -0600
Message-ID: <8286e4ee1003250918x659e87ai9e5ca7c68c23a7c3__48929.8246604905$1269533997$gmane$org@mail.gmail.com>
References: <1269497376-21903-1-git-send-email-cam@cs.ualberta.ca>
	<20100325091552.GB11153@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100325091552.GB11153@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 25, 2010 at 3:15 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Thu, Mar 25, 2010 at 12:09:36AM -0600, Cam Macdonell wrote:
>> This patch adds a driver for my shared memory PCI device using the uio_p=
ci
>> interface. =A0The driver has three memory regions. =A0The first memory r=
egion is for
>> device registers for sending interrupts. The second BAR is for receiving=
 MSI-X
>> interrupts and the third memory region maps the shared memory. =A0The de=
vice only
>> exports the first and third memory regions to userspace.
>>
>> This driver supports MSI-X and regular pin interrupts. =A0Currently, the=
 number of
>> MSI vectors is set to 4 which could be increased, but the driver will wo=
rk with
>> fewer vectors. =A0If MSI is not available, then regular interrupts will =
be used.
>
> Some high level questions, sorry if they have been raised in the past:
> - Can this device use virtio framework?
> =A0This gives us some standards to work off, with feature negotiation,
> =A0ability to detect config changes, support for non-PCI
> =A0platforms, decent documentation that is easy to extend,
> =A0legal id range to use.
> =A0You would thus have your driver in uio/uio_virtio_shmem.c

There has been previous discussion of virtio, however while virtio is
good for exporting guest memory, it's not ideal for importing memory
into a guest.

>
> - Why are you using 32 bit long memory accesses for interrupts?
> =A016 bit IO eould be enough and it's faster. This what virtio-pci does.
>
> - How was the driver tested?

I have some test programs in the git repo I linked to.  I've been
using some simple producer/consumer tests to test the interrupt
framework.

>
>> ---
>> =A0drivers/uio/Kconfig =A0 =A0 =A0 | =A0 =A08 ++
>> =A0drivers/uio/Makefile =A0 =A0 =A0| =A0 =A01 +
>> =A0drivers/uio/uio_ivshmem.c | =A0235 ++++++++++++++++++++++++++++++++++=
+++++++++++
>> =A03 files changed, 244 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/uio/uio_ivshmem.c
>>
>> diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
>> index 1da73ec..b92cded 100644
>> --- a/drivers/uio/Kconfig
>> +++ b/drivers/uio/Kconfig
>> @@ -74,6 +74,14 @@ config UIO_SERCOS3
>>
>> =A0 =A0 =A0 =A0 If you compile this as a module, it will be called uio_s=
ercos3.
>>
>> +config UIO_IVSHMEM
>> + =A0 =A0 tristate "KVM shared memory PCI driver"
>> + =A0 =A0 default n
>> + =A0 =A0 help
>> + =A0 =A0 =A0 Userspace I/O interface for the KVM shared memory device. =
=A0This
>> + =A0 =A0 =A0 driver will make available two memory regions, the first is
>> + =A0 =A0 =A0 registers and the second is a region for sharing between V=
Ms.
>> +
>> =A0config UIO_PCI_GENERIC
>> =A0 =A0 =A0 tristate "Generic driver for PCI 2.3 and PCI Express cards"
>> =A0 =A0 =A0 depends on PCI
>> diff --git a/drivers/uio/Makefile b/drivers/uio/Makefile
>> index 18fd818..25c1ca5 100644
>> --- a/drivers/uio/Makefile
>> +++ b/drivers/uio/Makefile
>> @@ -6,3 +6,4 @@ obj-$(CONFIG_UIO_AEC) +=3D uio_aec.o
>> =A0obj-$(CONFIG_UIO_SERCOS3) =A0 =A0+=3D uio_sercos3.o
>> =A0obj-$(CONFIG_UIO_PCI_GENERIC) =A0 =A0 =A0 =A0+=3D uio_pci_generic.o
>> =A0obj-$(CONFIG_UIO_NETX) =A0 =A0 =A0 +=3D uio_netx.o
>> +obj-$(CONFIG_UIO_IVSHMEM) +=3D uio_ivshmem.o
>> diff --git a/drivers/uio/uio_ivshmem.c b/drivers/uio/uio_ivshmem.c
>> new file mode 100644
>> index 0000000..607435b
>> --- /dev/null
>> +++ b/drivers/uio/uio_ivshmem.c
>> @@ -0,0 +1,235 @@
>> +/*
>> + * UIO IVShmem Driver
>> + *
>> + * (C) 2009 Cam Macdonell
>> + * based on Hilscher CIF card driver (C) 2007 Hans J. Koch <hjk@linutro=
nix.de>
>> + *
>> + * Licensed under GPL version 2 only.
>> + *
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/module.h>
>> +#include <linux/pci.h>
>> +#include <linux/uio_driver.h>
>> +
>> +#include <asm/io.h>
>> +
>> +#define IntrStatus 0x04
>> +#define IntrMask 0x00
>> +
>> +struct ivshmem_info {
>> + =A0 =A0struct uio_info *uio;
>> + =A0 =A0struct pci_dev *dev;
>> + =A0 =A0char (*msix_names)[256];
>> + =A0 =A0struct msix_entry *msix_entries;
>> + =A0 =A0int nvectors;
>> +};
>> +
>> +static irqreturn_t ivshmem_handler(int irq, struct uio_info *dev_info)
>> +{
>> +
>> + =A0 =A0void __iomem *plx_intscr =3D dev_info->mem[0].internal_addr
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+ IntrStatus;
>> + =A0 =A0u32 val;
>> +
>> + =A0 =A0val =3D readl(plx_intscr);
>> + =A0 =A0if (val =3D=3D 0)
>> + =A0 =A0 =A0 =A0return IRQ_NONE;
>> +
>> + =A0 =A0printk(KERN_INFO "Regular interrupt (val =3D %d)\n", val);
>> + =A0 =A0return IRQ_HANDLED;
>> +}
>> +
>> +static irqreturn_t ivshmem_msix_handler(int irq, void *opaque)
>> +{
>> +
>> + =A0 =A0struct uio_info * dev_info =3D (struct uio_info *) opaque;
>> +
>> + =A0 =A0/* we have to do this explicitly when using MSI-X */
>> + =A0 =A0uio_event_notify(dev_info);
>> + =A0 =A0printk(KERN_INFO "MSI-X interrupt (%d)\n", irq);
>> + =A0 =A0return IRQ_HANDLED;
>> +
>> +}
>> +
>> +static int request_msix_vectors(struct ivshmem_info *ivs_info, int nvec=
tors)
>> +{
>> + =A0 =A0int i, err;
>> + =A0 =A0const char *name =3D "ivshmem";
>> +
>> + =A0 =A0printk(KERN_INFO "devname is %s\n", name);
>> + =A0 =A0ivs_info->nvectors =3D nvectors;
>> +
>> +
>> + =A0 =A0ivs_info->msix_entries =3D kmalloc(nvectors * sizeof *ivs_info-=
>msix_entries,
>> + =A0 =A0 =A0 =A0 =A0 =A0GFP_KERNEL);
>> + =A0 =A0ivs_info->msix_names =3D kmalloc(nvectors * sizeof *ivs_info->m=
six_names,
>> + =A0 =A0 =A0 =A0 =A0 =A0GFP_KERNEL);
>> +
>> + =A0 =A0for (i =3D 0; i < nvectors; ++i)
>> + =A0 =A0 =A0 =A0ivs_info->msix_entries[i].entry =3D i;
>> +
>> + =A0 =A0err =3D pci_enable_msix(ivs_info->dev, ivs_info->msix_entries,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ivs_info->nvectors);
>> + =A0 =A0if (err > 0) {
>> + =A0 =A0 =A0 =A0ivs_info->nvectors =3D err; /* msi-x positive error code
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 returns the number available*/
>> + =A0 =A0 =A0 =A0err =3D pci_enable_msix(ivs_info->dev, ivs_info->msix_e=
ntries,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ivs_info->nvectors);
>> + =A0 =A0 =A0 =A0if (err > 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_INFO "no MSI (%d). Back to INTx.\n"=
, err);
>> + =A0 =A0 =A0 =A0 =A0 =A0return -ENOSPC;
>> + =A0 =A0 =A0 =A0}
>> + =A0 =A0}
>> +
>> + =A0 =A0printk(KERN_INFO "err is %d\n", err);
>> + =A0 =A0if (err) return err;
>> +
>> + =A0 =A0for (i =3D 0; i < ivs_info->nvectors; i++) {
>> +
>> + =A0 =A0 =A0 =A0snprintf(ivs_info->msix_names[i], sizeof *ivs_info->msi=
x_names,
>> + =A0 =A0 =A0 =A0 =A0 =A0"%s-config", name);
>> +
>> + =A0 =A0 =A0 =A0ivs_info->msix_entries[i].entry =3D i;
>> + =A0 =A0 =A0 =A0err =3D request_irq(ivs_info->msix_entries[i].vector,
>> + =A0 =A0 =A0 =A0 =A0 =A0ivshmem_msix_handler, 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0ivs_info->msix_names[i], ivs_info->uio);
>> +
>> + =A0 =A0 =A0 =A0if (err) {
>> + =A0 =A0 =A0 =A0 =A0 =A0return -ENOSPC;
>> + =A0 =A0 =A0 =A0}
>> + =A0 =A0}
>> +
>> + =A0 =A0return 0;
>> +}
>> +
>> +static int __devinit ivshmem_pci_probe(struct pci_dev *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const struct pci_device_id *id)
>> +{
>> + =A0 =A0struct uio_info *info;
>> + =A0 =A0struct ivshmem_info * ivshmem_info;
>> + =A0 =A0int nvectors =3D 4;
>> +
>> + =A0 =A0info =3D kzalloc(sizeof(struct uio_info), GFP_KERNEL);
>> + =A0 =A0if (!info)
>> + =A0 =A0 =A0 =A0return -ENOMEM;
>> +
>> + =A0 =A0ivshmem_info =3D kzalloc(sizeof(struct ivshmem_info), GFP_KERNE=
L);
>> + =A0 =A0if (!ivshmem_info) {
>> + =A0 =A0 =A0 =A0kfree(info);
>> + =A0 =A0 =A0 =A0return -ENOMEM;
>> + =A0 =A0}
>> +
>> + =A0 =A0if (pci_enable_device(dev))
>> + =A0 =A0 =A0 =A0goto out_free;
>> +
>> + =A0 =A0if (pci_request_regions(dev, "ivshmem"))
>> + =A0 =A0 =A0 =A0goto out_disable;
>> +
>> + =A0 =A0info->mem[0].addr =3D pci_resource_start(dev, 0);
>> + =A0 =A0if (!info->mem[0].addr)
>> + =A0 =A0 =A0 =A0goto out_release;
>> +
>> + =A0 =A0info->mem[0].size =3D pci_resource_len(dev, 0);
>> + =A0 =A0info->mem[0].internal_addr =3D pci_ioremap_bar(dev, 0);
>> + =A0 =A0if (!info->mem[0].internal_addr) {
>> + =A0 =A0 =A0 =A0printk(KERN_INFO "got a null");
>> + =A0 =A0 =A0 =A0goto out_release;
>> + =A0 =A0}
>> +
>> + =A0 =A0info->mem[0].memtype =3D UIO_MEM_PHYS;
>> +
>> + =A0 =A0info->mem[1].addr =3D pci_resource_start(dev, 2);
>> + =A0 =A0if (!info->mem[1].addr)
>> + =A0 =A0 =A0 =A0goto out_unmap;
>> + =A0 =A0info->mem[1].internal_addr =3D pci_ioremap_bar(dev, 2);
>> + =A0 =A0if (!info->mem[1].internal_addr)
>> + =A0 =A0 =A0 =A0goto out_unmap;
>> +
>> + =A0 =A0info->mem[1].size =3D pci_resource_len(dev, 2);
>> + =A0 =A0info->mem[1].memtype =3D UIO_MEM_PHYS;
>> +
>> + =A0 =A0ivshmem_info->uio =3D info;
>> + =A0 =A0ivshmem_info->dev =3D dev;
>> +
>> + =A0 =A0if (request_msix_vectors(ivshmem_info, nvectors) !=3D 0) {
>> + =A0 =A0 =A0 =A0printk(KERN_INFO "regular IRQs\n");
>> + =A0 =A0 =A0 =A0info->irq =3D dev->irq;
>> + =A0 =A0 =A0 =A0info->irq_flags =3D IRQF_SHARED;
>> + =A0 =A0 =A0 =A0info->handler =3D ivshmem_handler;
>> + =A0 =A0 =A0 =A0writel(0xffffffff, info->mem[0].internal_addr + IntrMas=
k);
>> + =A0 =A0} else {
>> + =A0 =A0 =A0 =A0printk(KERN_INFO "MSI-X enabled\n");
>> + =A0 =A0 =A0 =A0info->irq =3D -1;
>> + =A0 =A0}
>> +
>> + =A0 =A0info->name =3D "ivshmem";
>> + =A0 =A0info->version =3D "0.0.1";
>> +
>> + =A0 =A0if (uio_register_device(&dev->dev, info))
>> + =A0 =A0 =A0 =A0goto out_unmap2;
>> +
>> + =A0 =A0pci_set_drvdata(dev, info);
>> +
>> +
>> + =A0 =A0return 0;
>> +out_unmap2:
>> + =A0 =A0iounmap(info->mem[2].internal_addr);
>> +out_unmap:
>> + =A0 =A0iounmap(info->mem[0].internal_addr);
>> +out_release:
>> + =A0 =A0pci_release_regions(dev);
>> +out_disable:
>> + =A0 =A0pci_disable_device(dev);
>> +out_free:
>> + =A0 =A0kfree (info);
>> + =A0 =A0return -ENODEV;
>> +}
>> +
>> +static void ivshmem_pci_remove(struct pci_dev *dev)
>> +{
>> + =A0 =A0struct uio_info *info =3D pci_get_drvdata(dev);
>> +
>> + =A0 =A0uio_unregister_device(info);
>> + =A0 =A0pci_release_regions(dev);
>> + =A0 =A0pci_disable_device(dev);
>> + =A0 =A0pci_set_drvdata(dev, NULL);
>> + =A0 =A0iounmap(info->mem[0].internal_addr);
>> +
>> + =A0 =A0kfree (info);
>> +}
>> +
>> +static struct pci_device_id ivshmem_pci_ids[] __devinitdata =3D {
>> + =A0 =A0{
>> + =A0 =A0 =A0 =A0.vendor =3D =A0 =A00x1af4,
>> + =A0 =A0 =A0 =A0.device =3D =A0 =A00x1110,
>> + =A0 =A0 =A0 =A0.subvendor =3D =A0 =A0PCI_ANY_ID,
>> + =A0 =A0 =A0 =A0.subdevice =3D =A0 =A0PCI_ANY_ID,
>> + =A0 =A0},
>> + =A0 =A0{ 0, }
>> +};
>> +
>> +static struct pci_driver ivshmem_pci_driver =3D {
>> + =A0 =A0.name =3D "uio_ivshmem",
>> + =A0 =A0.id_table =3D ivshmem_pci_ids,
>> + =A0 =A0.probe =3D ivshmem_pci_probe,
>> + =A0 =A0.remove =3D ivshmem_pci_remove,
>> +};
>> +
>> +static int __init ivshmem_init_module(void)
>> +{
>> + =A0 =A0return pci_register_driver(&ivshmem_pci_driver);
>> +}
>> +
>> +static void __exit ivshmem_exit_module(void)
>> +{
>> + =A0 =A0pci_unregister_driver(&ivshmem_pci_driver);
>> +}
>> +
>> +module_init(ivshmem_init_module);
>> +module_exit(ivshmem_exit_module);
>> +
>> +MODULE_DEVICE_TABLE(pci, ivshmem_pci_ids);
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_AUTHOR("Cam Macdonell");
>> --
>> 1.6.6.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe kvm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
