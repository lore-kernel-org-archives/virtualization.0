From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/6] virtio interace
Date: Fri, 21 Sep 2007 14:05:31 +0200
Message-ID: <200709211405.32116.arnd__21182.253296911$1190376960$gmane$org@arndb.de>
References: <1190289808.7262.223.camel@localhost.localdomain>
	<1190290140.7262.228.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1190290140.7262.228.camel@localhost.localdomain>
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

On Thursday 20 September 2007, Rusty Russell wrote:
> + * virtio_driver - operations for a virtio I/O driver
> + * @name: the name of the driver (KBUILD_MODNAME).
> + * @owner: the module which contains these routines (ie. THIS_MODULE).
> + * @id_table: the ids (we re-use PCI ids) serviced by this driver.
> + * @probe: the function to call when a device is found. =A0Returns a t=
oken for
> + * =A0 =A0remove, or PTR_ERR().
> + * @remove: the function when a device is removed.
> + */
> +struct virtio_driver {
> +=A0=A0=A0=A0=A0=A0=A0const char *name;
> +=A0=A0=A0=A0=A0=A0=A0struct module *owner;
> +=A0=A0=A0=A0=A0=A0=A0struct pci_device_id *id_table;
> +=A0=A0=A0=A0=A0=A0=A0void *(*probe)(struct device *device,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 struct virti=
o_config_space *config,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 struct virtq=
ueue_ops *vqops);
> +=A0=A0=A0=A0=A0=A0=A0void (*remove)(void *dev);
> +};
> +
> +int register_virtio_driver(struct virtio_driver *drv);
> +void unregister_virtio_driver(struct virtio_driver *drv);
> +
> +/* The particular virtio backend supplies these. */
> +struct virtio_backend_ops {
> +       int (*register_driver)(struct virtio_driver *drv);
> +       void (*unregister_driver)(struct virtio_driver *drv);
> +};
> +extern struct virtio_backend_ops virtio_backend_ops;

This still seems a little awkward. From what I understand, you register
a virtio_driver, which leads to a pci_driver (or whatever you are based o=
n)
to be registered behind the covers, so that the pci_device can be used
directly as the virtio device.

I think there should instead be a pci_driver that automatically binds
to all PCI based virtio imlpementations and creates a child device for
the actual virtio_device. Then you can have the virtio_driver itself
be based on a device_driver, and you can get rid of the global
virtio_backend_ops. That will be useful when a virtual machine
has two ways to get at the virtio devices, e.g. a KVM guest that
has both hcall based probing for virtio devices and some other virtio
devices that are exported through PCI.

	Arnd <><
