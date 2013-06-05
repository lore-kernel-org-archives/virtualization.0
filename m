From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Wed, 5 Jun 2013 13:22:32 +0300
Message-ID: <20130605102232.GB31830@redhat.com>
References: <87ppwammp5.fsf@rustcorp.com.au> <87mwreq76y.fsf@codemonkey.ws>
	<87wqqhktjx.fsf@rustcorp.com.au> <87fvx460ba.fsf@codemonkey.ws>
	<20130530140132.GC21440@redhat.com>
	<874ndgujiw.fsf@rustcorp.com.au> <20130603101136.GB8649@redhat.com>
	<87fvwytpa1.fsf@rustcorp.com.au>
	<20130604064216.GD19433@redhat.com>
	<87hahdrpmt.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87hahdrpmt.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, Anthony Liguori <aliguori@us.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 05, 2013 at 04:49:22PM +0930, Rusty Russell wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> >> By my count, net still has 7 feature bits left, so I don't think the
> >> feature bits are likely to be a limitation in the next 6 months?
> >
> > Yes but you wanted a generic transport feature bit
> > for flexible SG layout.
> > Are you happy with VIRTIO_NET_F_ANY_HEADER_SG then?
> 
> If we need it within 6 months, I'd rather do that: this feature would
> then be assumed for 1.0, and reserved.  We may do that for other
> features, too (the committee will have to review).
> 
> >> MMIO is a bigger problem.  Linux guests are happy with it: does it break
> >> the Windows drivers?
> >> 
> >> Thanks,
> >> Rusty.
> >
> > You mean make BAR0 an MMIO BAR?
> > Yes, it would break current windows guests.
> > Further, as long as we use same address to notify all queues,
> > we would also need to decode the instruction on x86 and that's
> > measureably slower than PIO.
> > We could go back to discussing hypercall use for notifications,
> > but that has its own set of issues...
> 
> We might have something ready to deploy in 3 months,
> but realistically,
> I'd rather have it ready and tested outside the main git tree(s) and
> push it once the standard is committed.
> 
> Cheers,
> Rusty.


We have working code already. We don't need 3 months out of tree,
this gets us no progress. To make it ready to deploy
we need it upstream and people testing it.

I think the issue is the layout change, you don't want
the new config layout before we get standartization rolling, right?
Okay how about this small patch to the linux guest
(completely untested, just to give you the idea):


diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index a7ce730..0e34862 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -675,6 +675,33 @@ static void virtio_pci_release_dev(struct device *_d)
 	 */
 }
 
+/* Map a BAR. But carefully: make sure we don't overlap the MSI-X table */
+static void __iomem * virtio_pci_iomap(struct pci_dev *pci_dev, int bar)
+{
+	int msix_cap = pci_find_capability(pci_dev, PCI_CAP_ID_MSIX);
+	if (msix_cap) {
+		u32 offset;
+		u8 bir;
+		pci_read_config_dword(pci_dev, msix_cap + PCI_MSIX_TABLE,
+				      &offset);
+		bir = (u8)(offset & PCI_MSIX_TABLE_BIR);
+		offset &= PCI_MSIX_TABLE_OFFSET;
+		/* Spec says table offset is in a 4K page all by itself */
+		if (bir == bar && offset < 4096)
+			return NULL;
+
+		pci_read_config_dword(pci_dev, msix_cap + PCI_MSIX_PBA,
+				      &offset);
+		bir = (u8)(offset & PCI_MSIX_PBA_BIR);
+		offset &= PCI_MSIX_PBA_OFFSET;
+		/* Spec says table offset is in a 4K page all by itself. */
+		if (bir == bar && offset < 4096)
+			return NULL;
+	}
+	/* 4K is enough for all devices at the moment. */
+	return pci_iomap(pci_dev, 0, 4096);
+}
+
 /* the PCI probing function */
 static int virtio_pci_probe(struct pci_dev *pci_dev,
 			    const struct pci_device_id *id)
@@ -716,7 +743,10 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
 	if (err)
 		goto out_enable_device;
 
-	vp_dev->ioaddr = pci_iomap(pci_dev, 0, 0);
+	vp_dev->ioaddr = virtio_pci_iomap(pci_dev, 0);
+	/* Failed to map BAR0? Try with BAR1. */
+	if (vp_dev->ioaddr == NULL) {
+		vp_dev->ioaddr = virtio_pci_iomap(pci_dev, 1);
 	if (vp_dev->ioaddr == NULL) {
 		err = -ENOMEM;
 		goto out_req_regions;


In other words: put a copy of IO config at start of MMIO BAR1,
making sure we don't overlap the MSIX table that's there.

This does not break windows guests, and makes us compliant to the
PCI express spec.

Is this small enough to start going immediately, without waiting
3+ months?

I really think it's a good idea to put something like this
in the field: we might discover more issues around MMIO
and we'll address them in the new config layout.
This way we don't get two changes: new layout and switch to MMIO
all at once.

If you like this, I can make the appropriate spec and qemu changes in a
couple of days.

-- 
MST
