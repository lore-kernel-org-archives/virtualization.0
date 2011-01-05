From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-pci: add softlinks between virtio and pci
Date: Wed, 5 Jan 2011 23:15:48 +0200
Message-ID: <20110105211547.GB3607__744.930949486111$1294262214$gmane$org@redhat.com>
References: <20110105191711.GA27489@redhat.com>
	<4D24C662.9070804@codemonkey.ws> <20110105200501.GA3224@redhat.com>
	<4D24CFC1.9020305@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4D24CFC1.9020305@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Jamie Lokier <jamie@shareable.org>, Thomas Weber <swirl@gmx.li>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 05, 2011 at 02:08:33PM -0600, Anthony Liguori wrote:
> On 01/05/2011 02:05 PM, Michael S. Tsirkin wrote:
> >On Wed, Jan 05, 2011 at 01:28:34PM -0600, Anthony Liguori wrote:
> >>On 01/05/2011 01:17 PM, Michael S. Tsirkin wrote:
> >>>We sometimes need to map between the virtio device and
> >>>the given pci device. One such use is OS installer that
> >>>gets the boot pci device from BIOS and needs to
> >>>find the relevant block device. Since it can't,
> >>>installation fails.
> >>I have no objection to this patch but I'm a tad confused by the description.
> >>
> >>I assume you mean the installer is querying the boot device via
> >>int13 get driver parameters such that it returns the pci address of
> >>the device?
> >>
> >>Or is it querying geometry information and then trying to find the
> >>best match block device?
> >>
> >>If it's the former, I don't really understand the need for a
> >>backlink since the PCI address gives you a link to the block device.
> >>OTOH, if it's the later, it would make sense but then your
> >>description doesn't really make much sense.
> >>
> >>At any rate, a better commit message would be helpful in explaining
> >>the need for this.
> >>
> >>Regards,
> >>
> >>Anthony Liguori
> >OK just to clarify: we get pci address from BIOS
> >and need the virtio device to get at the linux device
> >(e.g. block) in the end.  Thus the link from pci to virtio.
> >I also added a backlink since I thought it's handy.
> >
> >Does this answer the questions?
> >
> >Rusty rewrites my commit logs anyway, he has better style :)
> 
> It helps.  The real reason this is needed is because in a normal
> device, there is only one struct device whereas with virtio-pci, the
> virtio-pci device has a struct device and then the actual virtio
> device has another one.

I like how it works with e.g. net devices:

$ ls -l /sys/class/net/eth1
lrwxrwxrwx 1 root root 0 Jan  5 23:10 /sys/class/net/eth1 -> ../../devices/pci0000:00/0000:00:19.0/net/eth1

We maybe could have had

lrwxrwxrwx 1 root root 0 Jan  5 23:10 /sys/bus/virtio/virtio0 -> ../../devices/pci0000:00/0000:00:19.0/virtio/virtio0

This is pretty and would preserve the compatibility, but I am not sure how to implement this:
bus seems to want to have real kobjs behind it, not softlinks.
Ideas?

> There's probably a better way to handle
> this in sysfs making virtio-pci a proper bus with only a single
> device as a child or something like that.

I admit I'm just confused by all these buses.

> 
> But the links are probably an easier solution.
> 
> Regards,
> 
> Anthony Liguori
> 
> >>>Supply softlinks between these to make it possible.
> >>>
> >>>Signed-off-by: Michael S. Tsirkin<mst@redhat.com>
> >>>---
> >>>
> >>>Gleb, could you please ack that this patch below
> >>>will be enough to fix the installer issue that
> >>>you see?
> >>>
> >>>  drivers/virtio/virtio_pci.c |   18 +++++++++++++++++-
> >>>  1 files changed, 17 insertions(+), 1 deletions(-)
> >>>
> >>>diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
> >>>index ef8d9d5..06eb2f8 100644
> >>>--- a/drivers/virtio/virtio_pci.c
> >>>+++ b/drivers/virtio/virtio_pci.c
> >>>@@ -25,6 +25,7 @@
> >>>  #include<linux/virtio_pci.h>
> >>>  #include<linux/highmem.h>
> >>>  #include<linux/spinlock.h>
> >>>+#include<linux/sysfs.h>
> >>>
> >>>  MODULE_AUTHOR("Anthony Liguori<aliguori@us.ibm.com>");
> >>>  MODULE_DESCRIPTION("virtio-pci");
> >>>@@ -667,8 +668,21 @@ static int __devinit virtio_pci_probe(struct pci_dev *pci_dev,
> >>>  	if (err)
> >>>  		goto out_set_drvdata;
> >>>
> >>>-	return 0;
> >>>+	err = sysfs_create_link(&pci_dev->dev.kobj,&vp_dev->vdev.dev.kobj,
> >>>+				"virtio_device");
> >>>+	if (err)
> >>>+		goto out_register_device;
> >>>+
> >>>+	err = sysfs_create_link(&vp_dev->vdev.dev.kobj,&pci_dev->dev.kobj,
> >>>+				"bus_device");
> >>>+	if (err)
> >>>+		goto out_create_link;
> >>>
> >>>+	return 0;
> >>>+out_create_link:
> >>>+	sysfs_remove_link(&pci_dev->dev.kobj, "virtio_device");
> >>>+out_register_device:
> >>>+	unregister_virtio_device(&vp_dev->vdev);
> >>>  out_set_drvdata:
> >>>  	pci_set_drvdata(pci_dev, NULL);
> >>>  	pci_iounmap(pci_dev, vp_dev->ioaddr);
> >>>@@ -685,6 +699,8 @@ static void __devexit virtio_pci_remove(struct pci_dev *pci_dev)
> >>>  {
> >>>  	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
> >>>
> >>>+	sysfs_remove_link(&vp_dev->vdev.dev.kobj, "bus_device");
> >>>+	sysfs_remove_link(&pci_dev->dev.kobj, "virtio_device");
> >>>  	unregister_virtio_device(&vp_dev->vdev);
> >>>  }
> >>>
