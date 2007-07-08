From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 1/4] New virtio bus driver
Date: Sun, 8 Jul 2007 22:29:00 +0200
Message-ID: <200707082229.00810.arnd@arndb.de>
References: <20070706124200.988637662@arndb.de>
	<200707081729.58461.arnd@arndb.de> <4691076B.5050106@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4691076B.5050106@qumranet.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sunday 08 July 2007, Avi Kivity wrote:

> > Alternatively, we could have a mechanism separate from the
> > virtqueue concept, like a synchronous get_config_data/set_config_data
> > callback into the host driver.
> >   
> 
> You also need to allow the host to notify the guest about configuration 
> changes.

That is much harder to do, it would require a separate interrupt if you
want to have a device independent mechanism. Most real buses (like PCI)
don't have this, so I'm not sure it's good to do this at the virtio
layer. You already listed the media change notification, which can
be handled without this by either removing and adding the complete
virtio device, or by using a channel for out-of-band data like scsi.
 
> > So in your example, you get
> >
> > virtnet.ko (, virtblock.ko, hwrng-virtio.ko, ...): host-independent
> >   device driver
> > virtbus-lguest.ko, virtbus-kvm.ko, virtbus-pci.ko, virtbus-xen.ko:
> >   device independent host drivers
> >
> > In cases where some of the code can be shared, e.g. virtbus-lguest
> > and virtbus-kvm, you can have multiple host drivers sharing part
> > of their code by using symbols from a library module, but my basic
> > idea is that each host driver has a single module that handles
> > the transport and the device probing.
> >   
> 
> Is that module linked to both the pci libraries and the virtbus 
> libraries?  Or does virtbus abstract pci in some way?

The virtbus-pci module would be linked against both the virtio_bus
and against the pci layer, like this (not compile tested):

========
#define MAX_PCI_VIRTQUEUES 8

struct virtio_pci_config {
	char pci_config[64]; /* standard config space */
	char device_type[16]; /* for matching the driver */
	__le16 virtqueue_id[MAX_PCI_VIRTQUEUES]; /* global IDs */
	__le16 device_hd /* global device id */
	u8 num_virtqueues;
	char pad[31]; /* host config space is 128 bytes */
};

struct virtio_pci_device {
	struct virtio_device vdev;
	struct virtio_pci_config *config;
	/* more data related to the transport, as needed */
};

static struct virtio_device_ops virtbus_pci_hcall_ops = {
	...
};

/* irq: one of the queues for this device wants a callback */
static int virtbus_pci_irq(int irq, void *data)
{
	struct virtio_pci_device *pdev = data;
	unsigned int irq_mask;
	int i;
	
	/* note: this hcall could easily be an mmio read from one
	   of the PCI BARs, if we went to a model without hcalls. */
	irq_mask = hcall_get_pending_queues(pdev->config->device_id);

	for (i=0; i < pdev->config->num_virqueues; i++) {
		if (irq_mask & 1) {
			struct virtqueue *vq = &pdev->vdev.virtqueue[i];
			vq->cb(vq);
		}
	}
}

/* probe: we have found a PCI device for us, now create the virtio device as
   a child device below it */
static int virtbus_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
{
	struct virtio_pci_device *pdev;
	int i;
	char *config;
	int ret;

	pdev = kzalloc(sizeof (*pdev), GFP_KERNEL);
	if (!pdev)
		return -ENOMEM;

	/* copy PCI config space data into virtio_device */
	config = (void *)&pdev->vdev.config;
	for (i = 0; i < 256; i++) {
		ret = pci_read_config_byte(dev, i, config + i);
		if (ret)
			goto out;
	}

	/* set up device so we can register it */
	pdev->config = (void *)&pdev->vdev.config;
	pdev->vdev.dev.parent = &dev->dev;
	pdev->vdev.ops = &virtbus_pci_hcall_ops;
	pdev->vdev.device_type = pdev->device_type;
	dev->dev.driver_data = pdev;
	snprintf(pdev->vdev.dev.bus_id, BUS_ID_SIZE, "pciv:%s",
		 &dev->dev.bus_id);

	ret = request_irq(dev->irq, virtbus_pci_irq, IRQF_SHARED,
			pdev->vdev.dev.bus_id, pdev);
	if (ret)
		goto out;

	ret = virtio_device_register(&pdev->vdev,
				pdev->config.num_virtqueues);
	if (ret)
		goto out_irq;

	return 0;

out_irq:
	free_irq(dev->irq);
out:
	dev->driver_data = NULL;
	kfree(pdev);
	return ret;
}

static void virtbus_pci_remove(struct pci_dev *dev)
{
	struct virtio_pci_device *pdev = dev->dev.driver_data;
	virtio_device_unregister(pdev);
	free_irq(dev->irq, pdev);
	dev->driver_data = NULL;
	kfree(pdev);
}

static struct pci_device_id virtbus_pci_ids = {
	{ PCI_DEVICE(PCI_VENDOR_LINUX, PCI_DEVICE_VIRTIO_RAW), },
	{},
};
MODULE_DEVICE_TABLE(pci, virtbus_pci_ids);

static struct pci_driver virtbus_pci = {
	.name = "virtbus_pci_hcall",
	.probe = virtbus_pci_probe,
	.id_table = &virtbus_pci_ids,
};

static int __init virtbus_pci_init(void)
{
	return pci_register_driver(&virtbus_pci);
}
module_init(virtbus_pci_init);
