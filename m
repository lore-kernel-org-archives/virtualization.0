From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/3] swiotlb: Export maximum allocation size
Date: Thu, 10 Jan 2019 14:44:31 +0100
Message-ID: <20190110134433.15672-2-joro__22872.2873297103$1547127767$gmane$org@8bytes.org>
References: <20190110134433.15672-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190110134433.15672-1-joro@8bytes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, Joerg Roedel <jroedel@suse.de>, brijesh.singh@amd.com, jon.grimm@amd.com, jfehlig@suse.com, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, hch@lst.de
List-Id: virtualization@lists.linuxfoundation.org

From: Joerg Roedel <jroedel@suse.de>

The SWIOTLB implementation has a maximum size it can
allocate dma-handles for. This needs to be exported so that
device drivers don't try to allocate larger chunks.

This is especially important for block device drivers like
virtio-blk, that might do DMA through SWIOTLB.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 include/linux/swiotlb.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 7c007ed7505f..0bcc80a97036 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -72,6 +72,11 @@ static inline bool is_swiotlb_buffer(phys_addr_t paddr)
 	return paddr >= io_tlb_start && paddr < io_tlb_end;
 }
 
+static inline size_t swiotlb_max_alloc_size(void)
+{
+	return ((1UL << IO_TLB_SHIFT) * IO_TLB_SEGSIZE);
+}
+
 bool swiotlb_map(struct device *dev, phys_addr_t *phys, dma_addr_t *dma_addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs);
 void __init swiotlb_exit(void);
@@ -95,6 +100,13 @@ static inline unsigned int swiotlb_max_segment(void)
 {
 	return 0;
 }
+
+static inline size_t swiotlb_max_alloc_size(void)
+{
+	/* There is no limit when SWIOTLB isn't used */
+	return ~0UL;
+}
+
 #endif /* CONFIG_SWIOTLB */
 
 extern void swiotlb_print_info(void);
-- 
2.17.1
