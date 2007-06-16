From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [kvm-devel] [PATCH] Lguest implemention of virtio draft III
Date: Sat, 16 Jun 2007 15:50:52 +0200
Message-ID: <200706161550.53043.arnd__8915.80897518924$1182001968$gmane$org@arndb.de>
References: <1181217762.14054.192.camel@localhost.localdomain>
	<1181999920.6237.263.camel@localhost.localdomain>
	<1182000514.6237.273.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1182000514.6237.273.camel@localhost.localdomain>
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
To: kvm-devel@lists.sourceforge.net
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, "jmk@plan9.bell-labs.com" <jmk@plan9.bell-labs.com>, Christian Borntraeger <cborntra@de.ibm.com>, virtualization <virtualization@lists.linux-foundation.org>, Latchesar Ionkov <lionkov@lanl.gov>, Suzanne McIntosh <skranjac@us.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Saturday 16 June 2007, Rusty Russell wrote:
> This is a bonus patch for those wondering how a virtio implementation
> can look.

Thanks, I assumed it was something like this, but having the code
in front of me makes it a lot easier to comment on it.

> +static struct lguest_driver lguest_virtnet_drv = {
> +	.name = "lguestvirtnet",
> +	.owner = THIS_MODULE,
> +	.device_type = LGUEST_DEVICE_T_VIRTNET,
> +	.probe = lguest_virtnet_probe,
> +};
> +
> +static __init int lguest_virtnet_init(void)
> +{
> +	return register_lguest_driver(&lguest_virtnet_drv);
> +}
> +device_initcall(lguest_virtnet_init);
> +
> +/* Example block driver code. */
> +#include <linux/virtio_blk.h>
> +#include <linux/genhd.h>
> +#include <linux/blkdev.h>
> +static int lguest_virtblk_probe(struct lguest_device *lgdev)
> +{
> +	struct lguest_virtio_device *lgv;
> +	struct gendisk *disk;
> +	unsigned long sectors;
> +	int err;
> +
> +	lgv = lg_new_virtio(lgdev);
> +	if (!lgv)
> +		return -ENOMEM;
> +
> +	/* Page is initially used to pass capacity. */
> +	sectors = *(unsigned long *)lgv->in.desc;
> +	*(unsigned long *)lgv->in.desc = 0;
> +
> +	lgv->priv = disk = virtblk_probe(&lgv->vdev);
> +	if (IS_ERR(lgv->priv)) {
> +		err = PTR_ERR(lgv->priv);
> +		goto destroy;
> +	}
> +	set_capacity(disk, sectors);
> +	blk_queue_max_hw_segments(disk->queue, NUM_DESCS-1);
> +
> +	err = lg_setup_interrupt(lgv, disk->disk_name);
> +	if (err)
> +		goto unprobe;
> +	add_disk(disk);
> +	return 0;
> +
> +unprobe:
> +	virtblk_remove(disk);
> +destroy:
> +	lg_destroy_virtio(lgv);
> +	return err;
> +}
> +
> +static struct lguest_driver lguest_virtblk_drv = {
> +	.name = "lguestvirtblk",
> +	.owner = THIS_MODULE,
> +	.device_type = LGUEST_DEVICE_T_VIRTBLK,
> +	.probe = lguest_virtblk_probe,
> +};
> +
> +static __init int lguest_virtblk_init(void)
> +{
> +	return register_lguest_driver(&lguest_virtblk_drv);
> +}
> +device_initcall(lguest_virtblk_init);

This is the part that I find puzzling. My idea would be that the drivers
and devices you register are _not_ specific to the type of virtio bus.

The problem I see with your approach is that drivers for specific devices
can't be loaded as separate modules, right now all of them have to be
loaded or statically linked into the kernel in order to load the
lguest_virtio module.

I'm sure you know how this works for other buses, but I'll explain anyway
so that everyone knows what I'm talking about. What I have in mind is
to have a single 'struct bus_type virtio_bus_type', which is used by
all virtio implementations. The 'struct virtio_device' is derived from
'struct device', meaning that a 'struct device' is embedded in it.
Each virtio implementation can either use the virtio_device directly,
or derive its own kvm_virtio_device/lguest_virtio_device/... from it.
When lguest scans its devices, it registers the lguest_virtio_device
with the generic virtio_bus_type, not an lguest specific one.
Similarly, the block/net/... drivers each register themselves as
a virtio_driver with the virtio_bus_type, not with an implementation
specific guest.

Do you see a problem with the approach that I described here, or did
you just not bother implementing it so far?

	Arnd <><
