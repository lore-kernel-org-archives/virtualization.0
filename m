From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: A set of "standard" virtual devices?
Date: Tue, 3 Apr 2007 14:15:37 +0200
Message-ID: <200704031415.38381.arnd@arndb.de>
References: <4611652F.700@zytor.com> <200704031141.50045.arnd@arndb.de> <20070403124108.06108665@gondolin.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965583AbXDCMRs@vger.kernel.org>
In-Reply-To: <20070403124108.06108665@gondolin.boeblingen.de.ibm.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>, Jeff Garzik <jeff@garzik.org>, virtualization@lists.linux-foundation.org, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mathiasen@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 03 April 2007, Cornelia Huck wrote:
> > 
> > I think that's true outside of s390, but a standardized virtual device
> > interface should be able to work there as well. Interestingly, the
> > s390 channel I/O also uses two 16 bit numbers to identify a device
> > (type and model), just like PCI or USB, so in that light, we might
> > be able to use the same number space for something entirely different
> > depending on the virtual bus.
> 
> Even if we used those ids for cu_type and dev_type, it would still be
> ugly IMO. It would be much cleaner to just define a very simple, easy
> to implement virtual bus without dragging implementation details for
> other types of devices around.

Right, but an interesting point is the question what to do when running
another operating system as a guest under Linux, e.g. with kvm.

Ideally, you'd want to use the same interface to announce the presence
of the device, which can be done far more easily with PCI than using
a new bus type that you'd need to implement for every OS, instead of
just implementing the virtual PCI driver.

Using a 16 bit number to identify a specific interface sounds like
a good idea to me, if only for the reason that it is a widely used
approach. The alternative would be to use an ascii string, like we
have for open-firmware devices on powerpc or sparc.

I think in either way, we need to abstract the driver for the virtual
device from the underlying bus infrastructure, which is hypervisor
and/or platform dependent. The abstraction could work roughly like this:


==========
virt_dev.h
==========
struct virt_driver { /* platform independent */
	struct device_driver drv;
	struct pci_device_id *ids; /* not necessarily PCI */
};
struct virt_bus {
	/* platform dependent */
	long (*transfer)(struct virt_dev *dev, void *buffer,
		unsigned long size, int type);
};
struct virt_dev {
	struct device dev;
	struct virt_driver *driver;
	struct virt_bus *bus;
	struct pci_device_id id;
	int irq;
};
==============
virt_example.c
==============
static ssize_t virt_pipe_read(struct file *filp, char __user *buffer,
                         size_t len, loff_t *off)
{
	struct virt_dev *dev = filp->private_data;
	ssize_t ret = dev->bus->transfer(dev, buffer, len, READ);
	*off += ret;
	return ret;
}
static struct file_operations virt_pipe_fops = {
	.open = nonseekable_open,
	.read = virt_pipe_read,
};
static int virt_pipe_probe(struct device *dev)
{
	struct virt_dev *vdev = to_virt_dev(dev);
	struct miscdev *mdev = kmalloc(sizeof(*dev), GFP_KERNEL);
	mdev->name = "virt_pipe";
	mdev->fops = &virt_pipe_fops;
	mdev->parent = dev;
	return register_miscdev(mdev);
}
static struct pci_device_id virt_pipe_id = {
	.vendor = PCI_VENDOR_LINUX, .device = 0x3456,
};
MODULE_DEVICE_TABLE(pci, virt_pipe_id);
static struct virt_driver virt_pipe_driver = {
	.drv = {
		.name = "virt_pipe",
		.probe = virt_pipe_probe,
	},
	.ids = &virt_pipe_id,
}
static int virt_pipe_init(void)
{
	return virt_driver_register(&virt_pipe_driver);
}
module_init(virt_pipe_init);
==============
virt_devtree.c
==============
static long virt_devtree_transfer(struct virt_dev *dev, void *buffer,
		unsigned long size, int type)
{
	long reg;
	switch type {
	case READ:
		ret = hcall(HV_READ, dev->dev.platform_data, buffer, size);
		break;
	case WRITE:
		ret = hcall(HV_WRITE, dev->dev.platform_data, buffer, size);
		break;
	default:
		BUG();
	}
	return ret;
}
static struct virt_bus virt_devtree_bus = {
	.transfer = virt_devtree_transfer,
};
static int virt_devtree_probe(struct of_device *ofdev,
				struct of_device_id *match)
{
	struct virt_dev *vdev = kzalloc(sizeof(*vdev);
	vdev->bus = &virt_devtree_bus;
	vdev->dev.parent = &ofdev->dev;
	vdev.id.vendor = PCI_VENDOR_LINUX;
	vdev.id.device = *of_get_property(ofdev, "virt_dev_id"),
	vdev.irq = of_irq_parse_and_map(ofdev, 0);
	return device_register(&vdev->dev);
}
struct of_device_id virt_devtree_ids = {
	.compatible = "virt-dev",
};
static struct of_platform_driver virt_devtree_driver = {
	.probe = virt_devtree_probe,
	.match_table = &virt_devtree_ids,
};
==============
virt_pci.c
==============
static long virt_pci_transfer(struct virt_dev *dev, void *buffer,
		unsigned long size, int type)
{
	struct virt_pci_regs __iomem *regs = dev->dev.platform_data;
	switch type {
	case READ:
		mmio_insb(regs->read_port, buffer, size);
		break;
	case WRITE:
		mmio_outsb(regs->write_port, buffer, size);
		break;
	default:
		BUG();
	}
	return size;
}
static struct virt_bus virt_pci_bus = {
	.transfer = virt_pci_transfer,
};
static int virt_pci_probe(struct pci_dev *pdev,
				struct pci_device_id *match)
{
	struct virt_dev *vdev = kzalloc(sizeof(*vdev);
	vdev->bus = &virt_pci_bus;
	vdev->dev.parent = &pdev->dev;
	vdev.id = *match;
	vdev.irq = pdev->irq;
	return device_register(&vdev->dev);
}
struct pci_device_id virt_pci_ids = {
	.compatible = "virt-dev",
};
static struct of_platform_driver virt_pci_driver = {
	.probe = virt_pci_probe,
	.match_table = &virt_pci_ids,
};

	Arnd <><
