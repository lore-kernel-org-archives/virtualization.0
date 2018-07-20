From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: [RFC 2/4] virtio: Override device's DMA OPS with
	virtio_direct_dma_ops selectively
Date: Fri, 20 Jul 2018 09:29:39 +0530
Message-ID: <20180720035941.6844-3-khandual__1675.0254821547$1532059153$gmane$org@linux.vnet.ibm.com>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, mst@redhat.com, benh@kernel.crashing.org, linuxram@us.ibm.com, hch@infradead.org, paulus@samba.org, mpe@ellerman.id.au, joe@perches.com, khandual@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, haren@linux.vnet.ibm.com, david@gibson.dropbear.id.au
List-Id: virtualization@lists.linuxfoundation.org

Now that virtio core always needs all virtio devices to have DMA OPS, we
need to make sure that the structure it points is the right one. In the
absence of VIRTIO_F_IOMMU_PLATFORM flag QEMU expects GPA from guest kernel.
In such case, virtio device must use default virtio_direct_dma_ops DMA OPS
structure which transforms scatter gather buffer addresses as GPA. This
DMA OPS override must happen as early as possible during virtio device
initializatin sequence before virtio core starts using given device's DMA
OPS callbacks for I/O transactions. This change detects device's IOMMU flag
and does the override in case the flag is cleared.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 drivers/virtio/virtio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 7907ad3..6b13987 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -166,6 +166,8 @@ void virtio_add_status(struct virtio_device *dev, unsigned int status)
 }
 EXPORT_SYMBOL_GPL(virtio_add_status);
 
+const struct dma_map_ops virtio_direct_dma_ops;
+
 int virtio_finalize_features(struct virtio_device *dev)
 {
 	int ret = dev->config->finalize_features(dev);
@@ -174,6 +176,9 @@ int virtio_finalize_features(struct virtio_device *dev)
 	if (ret)
 		return ret;
 
+	if (virtio_has_iommu_quirk(dev))
+		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);
+
 	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1))
 		return 0;
 
-- 
2.9.3
