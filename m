From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: remove virtio-pci root device
Date: Mon, 10 Jan 2011 19:19:04 +0200
Message-ID: <20110110171904.GA30058__24223.7542676323$1294680028$gmane$org@redhat.com>
References: <20110105191711.GA27489@redhat.com>
	<virtio-pci-whynotsimplify@mdm.bga.com>
	<virtio-pci-noroot@mdm.bga.com> <20110110171046.GB27292@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110110171046.GB27292@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gleb Natapov <gleb@redhat.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, Jamie Lokier <jamie@shareable.org>, Thomas Weber <swirl@gmx.li>, linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jan 10, 2011 at 07:10:46PM +0200, Gleb Natapov wrote:
> On Fri, Jan 07, 2011 at 02:55:06AM -0600, Milton Miller wrote:
> > We sometimes need to map between the virtio device and
> > the given pci device. One such use is OS installer that
> > gets the boot pci device from BIOS and needs to
> > find the relevant block device. Since it can't,
> > installation fails.
> > 
> > Instead of creating a top-level devices/virtio-pci
> > directory, create each device under the corresponding
> > pci device node.  Symlinks to all virtio-pci
> > devices can be found under the pci driver link in
> > bus/pci/drivers/virtio-pci/devices, and all virtio
> > devices under drivers/bus/virtio/devices.
> > 
> > Signed-off-by: Milton Miller <miltonm@bga.com>
> Acked-by: Gleb Natapov <gleb@redhat.com>

Rusty, any comments?
We are going to tell the installer guys that this
is the interface, would be nice to know that the
patch is queued before we do.


> > ---
> > 
> > This is an alternative to the patch by Michael S. Tsirkin
> > titled "virtio-pci: add softlinks between virtio and pci"
> > https://patchwork.kernel.org/patch/454581/
> > 
> > It creates simpler code, uses less memory, and should
> > be even easier use by the installer as it won't have to
> > know a virtio symlink to follow (just follow none).
> > 
> > Compile tested only as I don't have kvm setup.
> > 
> > 
> > diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
> > index ef8d9d5..4fb5b2b 100644
> > --- a/drivers/virtio/virtio_pci.c
> > +++ b/drivers/virtio/virtio_pci.c
> > @@ -96,11 +96,6 @@ static struct pci_device_id virtio_pci_id_table[] = {
> >  
> >  MODULE_DEVICE_TABLE(pci, virtio_pci_id_table);
> >  
> > -/* A PCI device has it's own struct device and so does a virtio device so
> > - * we create a place for the virtio devices to show up in sysfs.  I think it
> > - * would make more sense for virtio to not insist on having it's own device. */
> > -static struct device *virtio_pci_root;
> > -
> >  /* Convert a generic virtio device to our structure */
> >  static struct virtio_pci_device *to_vp_device(struct virtio_device *vdev)
> >  {
> > @@ -629,7 +624,7 @@ static int __devinit virtio_pci_probe(struct pci_dev *pci_dev,
> >  	if (vp_dev == NULL)
> >  		return -ENOMEM;
> >  
> > -	vp_dev->vdev.dev.parent = virtio_pci_root;
> > +	vp_dev->vdev.dev.parent = &pci_dev->dev;
> >  	vp_dev->vdev.dev.release = virtio_pci_release_dev;
> >  	vp_dev->vdev.config = &virtio_pci_config_ops;
> >  	vp_dev->pci_dev = pci_dev;
> > @@ -717,17 +712,7 @@ static struct pci_driver virtio_pci_driver = {
> >  
> >  static int __init virtio_pci_init(void)
> >  {
> > -	int err;
> > -
> > -	virtio_pci_root = root_device_register("virtio-pci");
> > -	if (IS_ERR(virtio_pci_root))
> > -		return PTR_ERR(virtio_pci_root);
> > -
> > -	err = pci_register_driver(&virtio_pci_driver);
> > -	if (err)
> > -		root_device_unregister(virtio_pci_root);
> > -
> > -	return err;
> > +	return pci_register_driver(&virtio_pci_driver);
> >  }
> >  
> >  module_init(virtio_pci_init);
> > @@ -735,7 +720,6 @@ module_init(virtio_pci_init);
> >  static void __exit virtio_pci_exit(void)
> >  {
> >  	pci_unregister_driver(&virtio_pci_driver);
> > -	root_device_unregister(virtio_pci_root);
> >  }
> >  
> >  module_exit(virtio_pci_exit);
> 
> --
> 			Gleb.
