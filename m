From: Ram Pai <linuxram@us.ibm.com>
Subject: RE: [PATCH 2/2] virtio_ring: Use DMA API if memory is encrypted
Date: Wed, 16 Oct 2019 00:55:21 -0700
Message-ID: <20191016075521.GA5201__40895.7629044139$1571212554$gmane$org@oc0525413822.ibm.com>
References: <1570843519-8696-1-git-send-email-linuxram@us.ibm.com>
	<1570843519-8696-2-git-send-email-linuxram@us.ibm.com>
	<1570843519-8696-3-git-send-email-linuxram@us.ibm.com>
	<20191015073501.GA32345@lst.de>
Reply-To: Ram Pai <linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191015073501.GA32345@lst.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@lst.de>
Cc: andmike@us.ibm.com, sukadev@linux.vnet.ibm.com, b.zolnierkie@samsung.com, benh@kernel.crashing.org, aik@linux.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, paulus@ozlabs.org, iommu@lists.linux-foundation.org, paul.burton@mips.com, mpe@ellerman.id.au, robin.murphy@arm.com, m.szyprowski@samsung.com, linuxppc-dev@lists.ozlabs.org, david@gibson.dropbear.id.au
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Oct 15, 2019 at 09:35:01AM +0200, Christoph Hellwig wrote:
> On Fri, Oct 11, 2019 at 06:25:19PM -0700, Ram Pai wrote:
> > From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> > 
> > Normally, virtio enables DMA API with VIRTIO_F_IOMMU_PLATFORM, which must
> > be set by both device and guest driver. However, as a hack, when DMA API
> > returns physical addresses, guest driver can use the DMA API; even though
> > device does not set VIRTIO_F_IOMMU_PLATFORM and just uses physical
> > addresses.
> 
> Sorry, but this is a complete bullshit hack.  Driver must always use
> the DMA API if they do DMA, and if virtio devices use physical addresses
> that needs to be returned through the platform firmware interfaces for
> the dma setup.  If you don't do that yet (which based on previous
> informations you don't), you need to fix it, and we can then quirk
> old implementations that already are out in the field.
> 
> In other words: we finally need to fix that virtio mess and not pile
> hacks on top of hacks.

So force all virtio devices to use DMA API, except when
VIRTIO_F_IOMMU_PLATFORM is not enabled?

Any help detailing the idea, will enable us fix this issue once for all.

Will something like below work? It removes the prior hacks, and
always uses DMA API; except when VIRTIO_F_IOMMU_PLATFORM is not enabled.

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index c8be1c4..b593d3d 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -240,22 +240,10 @@ static inline bool virtqueue_use_indirect(struct virtqueue *_vq,
 
 static bool vring_use_dma_api(struct virtio_device *vdev)
 {
-	if (!virtio_has_iommu_quirk(vdev))
-		return true;
-
-	/* Otherwise, we are left to guess. */
-	/*
-	 * In theory, it's possible to have a buggy QEMU-supposed
-	 * emulated Q35 IOMMU and Xen enabled at the same time.  On
-	 * such a configuration, virtio has never worked and will
-	 * not work without an even larger kludge.  Instead, enable
-	 * the DMA API if we're a Xen guest, which at least allows
-	 * all of the sensible Xen configurations to work correctly.
-	 */
-	if (xen_domain())
-		return true;
+	if (virtio_has_iommu_quirk(vdev))
+		return false;
 
-	return false;
+	return true;
 }
 
 size_t virtio_max_dma_size(struct virtio_device *vdev)


-- 
Ram Pai
