From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/6] virtio interace
Date: Fri, 21 Sep 2007 16:22:21 +0200
Message-ID: <200709211622.22005.arnd__5303.41995549879$1190385115$gmane$org@arndb.de>
References: <1190289808.7262.223.camel@localhost.localdomain>
	<200709211405.32116.arnd@arndb.de>
	<1190378736.27805.54.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1190378736.27805.54.camel@localhost.localdomain>
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, Dor Laor <dor.laor@qumranet.com>
List-Id: virtualization@lists.linuxfoundation.org

On Friday 21 September 2007, Rusty Russell wrote:
> Hmm, I guess we could have a PCI driver which claims all VIRTIO vendor
> devices. =A0

yes, that was the idea.

> Then it can call virtio_find_driver() (?) at the top of its=20
> probe function to find if there's a matching virtio driver. =A0
> This PCI  driver would have to be initialized after all the virtio
> drivers are registered, but that's easy.

No, just use the driver model, instead of working against it:

struct pci_virtio_device {
	struct pci_dev *pdev;
	char __iomem *mmio_space;
	struct virtio_device vdev;
};

static int __devinit pci_virtio_probe(struct pci_dev *pdev,
				const struct pci_device_id *ent)
{
	struct pci_virtio_device *dev =3D kzalloc(sizeof (*dev), GFP_KERNEL);
	dev->pdev =3D pdev;
	dev->mmio_space =3D pcim_iomap(pdev, 0, PCI_VIRTIO_BUFSIZE);
	dev->vdev->ops =3D &pci_virtqueue_ops;
	dev->vdev->config =3D &pci_virtio_config_ops;
	dev->vdev->type =3D ent->device;
	dev->vdev->class =3D ent->class;
	dev->vdev.dev.parent =3D &pdev->dev;

	return virtio_device_register(&dev->vdev;
}

> The virtio layer would simply maintain a linked list of drivers and
> implement the virtio_find_driver() matching function.

nonono, just a virtio_bus that all virtio drivers register to:

static int virtio_net_probe(struct device *dev)
{
	struct virtio_device *vdev =3D to_virtio_dev(dev);
	struct virtqueue_ops *vq_ops =3D vdev->ops;

	/* same as current code */
	...

	return 0;
}

static struct virtio_device_id virtio_net_ids[] =3D {
	{ .type =3D VIRTIO_ID_NET, .class =3D PCI_CLASS_NETWORK_OTHER },
	{ },
};

static struct virtio_driver virtio_net =3D {
	.id_table =3D &virtio_net_ids,
	.driver =3D {
		.name =3D "virtionet",
		.probe =3D virtio_net_probe,
		.remove =3D virtionet_remove,
		.bus =3D &virtio_bus,        /* <- look here */
	},
};

static int __init virtio_net_init(void)
{
	return driver_register(&virtio_net.driver);
}
module_init(virtio_net_init);

> And since we've suppressed normal PCI driver request_module (since it
> always finds "the driver") then we can implement that in
> virtio_find_driver(), and not use a PCI MODULE_DEVICE_TABLE. =A0Then we
> don't need (full) PCI ids at all.

right, as shown in my example above.

	Arnd <><
