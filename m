From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [RFC PATCH 3/8] virtio-pci: save/restore config space across S4
Date: Fri, 29 Jul 2011 09:50:51 +0530
Message-ID: <20110729042051.GA24868@amit-x200.redhat.com>
References: <cover.1311863438.git.amit.shah@redhat.com>
	<124c8fbc2974d0353cac204d5d9ff35a6a6a0e13.1311863438.git.amit.shah@redhat.com>
	<20110729040758.GC31888@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110729040758.GC31888@redhat.com>
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
Cc: Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On (Fri) 29 Jul 2011 [07:07:58], Michael S. Tsirkin wrote:
> On Thu, Jul 28, 2011 at 08:05:08PM +0530, Amit Shah wrote:
> > The virtio config space doesn't get saved across hibernation; we save it
> > locally and update it after restore.
> > 
> > Signed-off-by: Amit Shah <amit.shah@redhat.com>
> > ---
> >  drivers/virtio/virtio_pci.c |    6 ++++++
> >  1 files changed, 6 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
> > index 579681f..9c37561 100644
> > --- a/drivers/virtio/virtio_pci.c
> > +++ b/drivers/virtio/virtio_pci.c
> > @@ -56,6 +56,10 @@ struct virtio_pci_device
> >  	unsigned msix_vectors;
> >  	/* Vectors allocated, excluding per-vq vectors if any */
> >  	unsigned msix_used_vectors;
> > +
> > +	/* Status saved during hibernate/restore */
> > +	u8 saved_status;
> > +
> >  	/* Whether we have vector per vq */
> >  	bool per_vq_vectors;
> >  };
> > @@ -713,6 +717,7 @@ static int virtio_pci_freeze(struct device *dev)
> >  	drv = container_of(vp_dev->vdev.dev.driver,
> >  			   struct virtio_driver, driver);
> >  
> > +	vp_dev->saved_status = vp_get_status(&vp_dev->vdev);
> >  	if (drv && drv->freeze)
> >  		return drv->freeze(&vp_dev->vdev);
> >  
> > @@ -728,6 +733,7 @@ static int virtio_pci_restore(struct device *dev)
> >  	drv = container_of(vp_dev->vdev.dev.driver,
> >  			   struct virtio_driver, driver);
> >  
> > +	vp_set_status(&vp_dev->vdev, vp_dev->saved_status);
> >  	if (drv && drv->restore)
> >  		return drv->restore(&vp_dev->vdev);
> 
> Yes, this looks wrong. Status would typically be DRIVER_OK,
> and it needs to be set after vq setup.

Because I expect this to be carried forward from the hibernated
image.. the feature negotiation, etc., all happened the first time
around, and the driver should just be ready when the image is
restored.  I still don't know why the status is reset, and why we'd
need to replay the sequence in probe.

Of course, this patch exists in the current form only because I don't
know the answers yet (as mentioned in 0/8).  Once I know the answer,
either we'll have a better patch or a better description for this
patch.

> It also needs to match current state I think:
> e.g. if restore failed we want to set it to FAILED.

If restore fails, we return to a normal bootup sequence.  The probe
routine should handle that case normally.  However, this is something
that has to be tested to ensure it works fine.

		Amit
