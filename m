From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv4 2/2] virtio: refactor find_vqs
Date: Mon, 10 Aug 2009 09:07:52 +0930
Message-ID: <200908100907.53059.rusty__20642.1946328648$1249861155$gmane$org@rustcorp.com.au>
References: <cover.1248623150.git.mst@redhat.com>
	<200907281244.32124.rusty@rustcorp.com.au>
	<20090728083308.GA662@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090728083308.GA662@redhat.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, avi@redhat.com, Anthony Liguori <anthony@codemonkey.ws>, amit.shah@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 28 Jul 2009 06:03:08 pm Michael S. Tsirkin wrote:
> On Tue, Jul 28, 2009 at 12:44:31PM +0930, Rusty Russell wrote:
> > On Mon, 27 Jul 2009 01:17:09 am Michael S. Tsirkin wrote:
> > > This refactors find_vqs, making it more readable and robust, and fixing
> > > two regressions from 2.6.30:
> > > - double free_irq causing BUG_ON on device removal
> > > - probe failure when vq can't be assigned to msi-x vector
> > >   (reported on old host kernels)
> > > 
> > > An older version of this patch was tested by Amit Shah.
> > 
> > OK, I've applied both of these; I'd like to see a new test by Amit to
> > make sure tho.
> > 
> > I really like this cleanup!  I looked harder at this code, and my best
> > attempts to untangle it further came to very little.  This is what I
> > ended up with, but it's all cosmetic and can wait until next merge window.
> > See what you think.
> > 
> > Thanks!
> > Rusty.
> > 
> > virtio_pci: minor MSI-X cleanups
> > 
> > 1) Rename vp_request_vectors to vp_request_msix_vectors, and take
> >    non-MSI-X case out to caller.
> 
> I'm not sure this change was for the best: we still have a separate code
> path under if !use_msix, only in another place now.  See below.
> And this seems to break the symmetry between request_ and free_vectors.

Yes, but unfortunately request_vectors was never really symmetrical :(

That's because we didn't do the request_irq's for the per_vector case, because
we don't have the names.  This is what prevented me from doing a nice
encapsulation.

> > -	err = vp_request_vectors(vdev, nvectors, per_vq_vectors);
> > +	if (!use_msix) {
> > +		/* Old style: one normal interrupt for change and all vqs. */
> > +		vp_dev->msix_vectors = 0;
> > +		vp_dev->per_vq_vectors = false;
> > +		err = request_irq(vp_dev->pci_dev->irq, vp_interrupt,
> > +				  IRQF_SHARED, dev_name(&vdev->dev), vp_dev);
> > +		if (!err)
> > +			vp_dev->intx_enabled = 1;
> 
> shorter as vp_dev->intx_enabled = !err
> 
> > +		return err;
> 
> Is that all? Don't we need to create the vqs?

Oh, yeah :)

This patch applies on top.  Basically reverts that part, and
renames vector to msix_vector, which I think makes the code more
readable.

virtio: more PCI minor cleanups

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/virtio_pci.c |   73 +++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 37 deletions(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -84,7 +84,7 @@ struct virtio_pci_vq_info
 	struct list_head node;
 
 	/* MSI-X vector (or none) */
-	unsigned vector;
+	unsigned msix_vector;
 };
 
 /* Qumranet donated their vendor ID for devices 0x1000 thru 0x10FF. */
@@ -349,7 +349,7 @@ error:
 static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
 				  void (*callback)(struct virtqueue *vq),
 				  const char *name,
-				  u16 vector)
+				  u16 msix_vector)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtio_pci_vq_info *info;
@@ -374,7 +374,7 @@ static struct virtqueue *setup_vq(struct
 
 	info->queue_index = index;
 	info->num = num;
-	info->vector = vector;
+	info->msix_vector = msix_vector;
 
 	size = PAGE_ALIGN(vring_size(num, VIRTIO_PCI_VRING_ALIGN));
 	info->queue = alloc_pages_exact(size, GFP_KERNEL|__GFP_ZERO);
@@ -398,10 +398,10 @@ static struct virtqueue *setup_vq(struct
 	vq->priv = info;
 	info->vq = vq;
 
-	if (vector != VIRTIO_MSI_NO_VECTOR) {
-		iowrite16(vector, vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
-		vector = ioread16(vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
-		if (vector == VIRTIO_MSI_NO_VECTOR) {
+	if (msix_vector != VIRTIO_MSI_NO_VECTOR) {
+		iowrite16(msix_vector, vp_dev->ioaddr+VIRTIO_MSI_QUEUE_VECTOR);
+		msix_vector = ioread16(vp_dev->ioaddr+VIRTIO_MSI_QUEUE_VECTOR);
+		if (msix_vector == VIRTIO_MSI_NO_VECTOR) {
 			err = -EBUSY;
 			goto out_assign;
 		}
@@ -462,7 +462,8 @@ static void vp_del_vqs(struct virtio_dev
 	list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
 		info = vq->priv;
 		if (vp_dev->per_vq_vectors)
-			free_irq(vp_dev->msix_entries[info->vector].vector, vq);
+			free_irq(vp_dev->msix_entries[info->msix_vector].vector,
+				 vq);
 		vp_del_vq(vq);
 	}
 	vp_dev->per_vq_vectors = false;
@@ -478,58 +479,56 @@ static int vp_try_to_find_vqs(struct vir
 			      bool per_vq_vectors)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	u16 vector;
+	u16 msix_vector;
 	int i, err, nvectors, allocated_vectors;
 
 	if (!use_msix) {
 		/* Old style: one normal interrupt for change and all vqs. */
 		vp_dev->msix_vectors = 0;
-		vp_dev->per_vq_vectors = false;
 		err = request_irq(vp_dev->pci_dev->irq, vp_interrupt,
 				  IRQF_SHARED, dev_name(&vdev->dev), vp_dev);
-		if (!err)
-			vp_dev->intx_enabled = 1;
-		return err;
+		if (err)
+			return err;
+	} else {
+		if (per_vq_vectors) {
+			/* Best option: one for change interrupt, one per vq. */
+			nvectors = 1;
+			for (i = 0; i < nvqs; ++i)
+				if (callbacks[i])
+					++nvectors;
+		} else {
+			/* Second best: one for change, shared for all vqs. */
+			nvectors = 2;
+		}
+
+		err = vp_request_msix_vectors(vdev, nvectors, per_vq_vectors);
+		if (err)
+			goto error_request;
 	}
 
-	if (per_vq_vectors) {
-		/* Best option: one for change interrupt, one per vq. */
-		nvectors = 1;
-		for (i = 0; i < nvqs; ++i)
-			if (callbacks[i])
-				++nvectors;
-	} else {
-		/* Second best: one for change, shared one for all vqs. */
-		nvectors = 2;
-	}
-
-	err = vp_request_msix_vectors(vdev, nvectors, per_vq_vectors);
-	if (err)
-		goto error_request;
-
 	vp_dev->per_vq_vectors = per_vq_vectors;
 	allocated_vectors = vp_dev->msix_used_vectors;
 	for (i = 0; i < nvqs; ++i) {
 		if (!callbacks[i] || !vp_dev->msix_enabled)
-			vector = VIRTIO_MSI_NO_VECTOR;
+			msix_vector = VIRTIO_MSI_NO_VECTOR;
 		else if (vp_dev->per_vq_vectors)
-			vector = allocated_vectors++;
+			msix_vector = allocated_vectors++;
 		else
-			vector = VP_MSIX_VQ_VECTOR;
-		vqs[i] = setup_vq(vdev, i, callbacks[i], names[i], vector);
+			msix_vector = VP_MSIX_VQ_VECTOR;
+		vqs[i] = setup_vq(vdev, i, callbacks[i], names[i], msix_vector);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto error_find;
 		}
 		/* allocate per-vq irq if available and necessary */
-		if (vp_dev->per_vq_vectors && vector != VIRTIO_MSI_NO_VECTOR) {
-			snprintf(vp_dev->msix_names[vector],
+		if (vp_dev->per_vq_vectors) {
+			snprintf(vp_dev->msix_names[msix_vector],
 				 sizeof *vp_dev->msix_names,
 				 "%s-%s",
 				 dev_name(&vp_dev->vdev.dev), names[i]);
-			err = request_irq(vp_dev->msix_entries[vector].vector,
-					  vring_interrupt, 0,
-					  vp_dev->msix_names[vector], vqs[i]);
+			err = request_irq(msix_vector, vring_interrupt, 0,
+					  vp_dev->msix_names[msix_vector],
+					  vqs[i]);
 			if (err) {
 				vp_del_vq(vqs[i]);
 				goto error_find;
