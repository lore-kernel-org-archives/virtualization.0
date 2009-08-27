From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv4 2/2] virtio: refactor find_vqs
Date: Thu, 27 Aug 2009 19:00:34 +0930
Message-ID: <200908271900.34757.rusty__29136.0914278359$1251365604$gmane$org@rustcorp.com.au>
References: <cover.1248623150.git.mst@redhat.com>
	<200908100907.53059.rusty@rustcorp.com.au>
	<20090825120434.GA13896@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090825120434.GA13896@redhat.com>
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

On Tue, 25 Aug 2009 09:34:34 pm Michael S. Tsirkin wrote:
> > That's because we didn't do the request_irq's for the per_vector case, because
> > we don't have the names.  This is what prevented me from doing a nice
> > encapsulation.
> 
> Yes. But let's split free_vectors out into free_msix_vectors and
> free_intx as well?

Perhaps.  Patch welcome :)

> Yes, I agree, this is good cleanup, structure field names should be
> desriptive.  Are you sure we want to make all local variables named
> vector renamed to msix_vector though? CodingStyle says local var names
> should be short ...  A couple of ideas below.

msix_vec would work.  But vector for something which isn't always the vector
is misleading, IMHO.

> > -	if (vector != VIRTIO_MSI_NO_VECTOR) {
> > -		iowrite16(vector, vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
> > -		vector = ioread16(vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
> > -		if (vector == VIRTIO_MSI_NO_VECTOR) {
> > +	if (msix_vector != VIRTIO_MSI_NO_VECTOR) {
> > +		iowrite16(msix_vector, vp_dev->ioaddr+VIRTIO_MSI_QUEUE_VECTOR);
> > +		msix_vector = ioread16(vp_dev->ioaddr+VIRTIO_MSI_QUEUE_VECTOR);
> 
> checkpatch will complain that space is lacking around "+".
> We won't have a problem if we keep it named vector.

Yeah, but OTOH ignoring checkpatch warnings is good for the soul.

> >  	if (!use_msix) {
> >  		/* Old style: one normal interrupt for change and all vqs. */
> >  		vp_dev->msix_vectors = 0;
> > -		vp_dev->per_vq_vectors = false;
> 
> I know it's enough to look at msix_vectors, but isn't
> it cleaner to have per_vq_vectors consistent as well?
> E.g. del_vqs seems to only look at per_vq_vectors.

This should in fact be:

 	if (!use_msix) {
 		/* Old style: one normal interrupt for change and all vqs. */
-		vp_dev->msix_vectors = 0;
-		vp_dev->per_vq_vectors = false;
 		err = request_irq(vp_dev->pci_dev->irq, vp_interrupt,
 				  IRQF_SHARED, dev_name(&vdev->dev), vp_dev);
-		if (!err)
-			vp_dev->intx_enabled = 1;
-		return err;
+		if (err)
+			return err;
+		vp_dev->intx_enabled = 1;


The msix fields should all be ignored if msix_enabled is false.  Think about
running valgrind (or equiv) over the code: if you initialize something which
shouldn't be accessed, valgrind won't spot it.

For similar reasons, I dislike memseting structs to 0, or kzallocing them.

> >  		err = request_irq(vp_dev->pci_dev->irq, vp_interrupt,
> >  				  IRQF_SHARED, dev_name(&vdev->dev), vp_dev);
> > -		if (!err)
> > -			vp_dev->intx_enabled = 1;
> > -		return err;
> > +		if (err)
> > +			return err;
> 
> Maybe move this part out into a separate function?  This way
> vp_try_to_find_vqs does high-level processing.

Nice.  Moved this to vp_request_intx().

> > +	} else {
> > +		if (per_vq_vectors) {
> > +			/* Best option: one for change interrupt, one per vq. */
> > +			nvectors = 1;
> > +			for (i = 0; i < nvqs; ++i)
> > +				if (callbacks[i])
> > +					++nvectors;
> > +		} else {
> > +			/* Second best: one for change, shared for all vqs. */
> > +			nvectors = 2;
> 
> Out of curiosity: why do you put {} here? They aren't
> strictly necessary ...

Comment made it multiline, looked a bit neater?

Here's the diff result:

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -346,10 +346,22 @@ error:
 	return err;
 }
 
+static int vp_request_intx(struct virtio_device *vdev)
+{
+	int err;
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+
+	err = request_irq(vp_dev->pci_dev->irq, vp_interrupt,
+			  IRQF_SHARED, dev_name(&vdev->dev), vp_dev);
+	if (!err)
+		vp_dev->intx_enabled = 1;
+	return err;
+}
+
 static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
 				  void (*callback)(struct virtqueue *vq),
 				  const char *name,
-				  u16 msix_vector)
+				  u16 msix_vec)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtio_pci_vq_info *info;
@@ -374,7 +386,7 @@ static struct virtqueue *setup_vq(struct
 
 	info->queue_index = index;
 	info->num = num;
-	info->msix_vector = msix_vector;
+	info->msix_vector = msix_vec;
 
 	size = PAGE_ALIGN(vring_size(num, VIRTIO_PCI_VRING_ALIGN));
 	info->queue = alloc_pages_exact(size, GFP_KERNEL|__GFP_ZERO);
@@ -398,10 +410,10 @@ static struct virtqueue *setup_vq(struct
 	vq->priv = info;
 	info->vq = vq;
 
-	if (msix_vector != VIRTIO_MSI_NO_VECTOR) {
-		iowrite16(msix_vector, vp_dev->ioaddr+VIRTIO_MSI_QUEUE_VECTOR);
-		msix_vector = ioread16(vp_dev->ioaddr+VIRTIO_MSI_QUEUE_VECTOR);
-		if (msix_vector == VIRTIO_MSI_NO_VECTOR) {
+	if (msix_vec != VIRTIO_MSI_NO_VECTOR) {
+		iowrite16(msix_vec, vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
+		msix_vec = ioread16(vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
+		if (msix_vec == VIRTIO_MSI_NO_VECTOR) {
 			err = -EBUSY;
 			goto out_assign;
 		}
@@ -479,16 +491,14 @@ static int vp_try_to_find_vqs(struct vir
 			      bool per_vq_vectors)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	u16 msix_vector;
+	u16 msix_vec;
 	int i, err, nvectors, allocated_vectors;
 
 	if (!use_msix) {
 		/* Old style: one normal interrupt for change and all vqs. */
-		err = request_irq(vp_dev->pci_dev->irq, vp_interrupt,
-				  IRQF_SHARED, dev_name(&vdev->dev), vp_dev);
+		err = vp_request_intx(vdev);
 		if (err)
-			return err;
-		vp_dev->intx_enabled = 1;
+			goto error_request;
 	} else {
 		if (per_vq_vectors) {
 			/* Best option: one for change interrupt, one per vq. */
@@ -510,24 +520,24 @@ static int vp_try_to_find_vqs(struct vir
 	allocated_vectors = vp_dev->msix_used_vectors;
 	for (i = 0; i < nvqs; ++i) {
 		if (!callbacks[i] || !vp_dev->msix_enabled)
-			msix_vector = VIRTIO_MSI_NO_VECTOR;
+			msix_vec = VIRTIO_MSI_NO_VECTOR;
 		else if (vp_dev->per_vq_vectors)
-			msix_vector = allocated_vectors++;
+			msix_vec = allocated_vectors++;
 		else
-			msix_vector = VP_MSIX_VQ_VECTOR;
-		vqs[i] = setup_vq(vdev, i, callbacks[i], names[i], msix_vector);
+			msix_vec = VP_MSIX_VQ_VECTOR;
+		vqs[i] = setup_vq(vdev, i, callbacks[i], names[i], msix_vec);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto error_find;
 		}
 		/* allocate per-vq irq if available and necessary */
 		if (vp_dev->per_vq_vectors) {
-			snprintf(vp_dev->msix_names[msix_vector],
+			snprintf(vp_dev->msix_names[msix_vec],
 				 sizeof *vp_dev->msix_names,
 				 "%s-%s",
 				 dev_name(&vp_dev->vdev.dev), names[i]);
-			err = request_irq(msix_vector, vring_interrupt, 0,
-					  vp_dev->msix_names[msix_vector],
+			err = request_irq(msix_vec, vring_interrupt, 0,
+					  vp_dev->msix_names[msix_vec],
 					  vqs[i]);
 			if (err) {
 				vp_del_vq(vqs[i]);
