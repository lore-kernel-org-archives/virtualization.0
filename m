From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/5] swiotlb: Add is_swiotlb_active() function
Date: Thu, 31 Jan 2019 17:34:00 +0100
Message-ID: <20190131163403.11363-3-joro__37628.9462483086$1548966785$gmane$org@8bytes.org>
References: <20190131163403.11363-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190131163403.11363-1-joro@8bytes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Thomas.Lendacky@amd.com, jroedel@suse.de, brijesh.singh@amd.com, joro@8bytes.org, jon.grimm@amd.com, jfehlig@suse.com, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Joerg Roedel <jroedel@suse.de>

This function will be used from dma_direct code to determine
the maximum segment size of a dma mapping.

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 include/linux/swiotlb.h | 6 ++++++
 kernel/dma/swiotlb.c    | 9 +++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 1c22d96e1742..e9e786b4b598 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -63,6 +63,7 @@ extern void swiotlb_tbl_sync_single(struct device *hwdev,
 extern int
 swiotlb_dma_supported(struct device *hwdev, u64 mask);
 size_t swiotlb_max_mapping_size(struct device *dev);
+bool is_swiotlb_active(void);
 
 #ifdef CONFIG_SWIOTLB
 extern enum swiotlb_force swiotlb_force;
@@ -100,6 +101,11 @@ static inline size_t swiotlb_max_mapping_size(struct device *dev)
 {
 	return SIZE_MAX;
 }
+
+static inline bool is_swiotlb_active(void)
+{
+	return false;
+}
 #endif /* CONFIG_SWIOTLB */
 
 extern void swiotlb_print_info(void);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 9cb21259cb0b..c873f9cc2146 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -667,3 +667,12 @@ size_t swiotlb_max_mapping_size(struct device *dev)
 {
 	return ((size_t)1 << IO_TLB_SHIFT) * IO_TLB_SEGSIZE;
 }
+
+bool is_swiotlb_active(void)
+{
+	/*
+	 * When SWIOTLB is initialized, even if io_tlb_start points to physical
+	 * address zero, io_tlb_end surely doesn't.
+	 */
+	return io_tlb_end != 0;
+}
-- 
2.17.1
