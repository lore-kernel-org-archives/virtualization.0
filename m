From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v7 1/5] swiotlb: Introduce swiotlb_max_mapping_size()
Date: Thu,  7 Feb 2019 12:59:13 +0100
Message-ID: <20190207115917.20535-2-joro__36323.870385398$1549553184$gmane$org@8bytes.org>
References: <20190207115917.20535-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190207115917.20535-1-joro@8bytes.org>
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

The function returns the maximum size that can be remapped
by the SWIOTLB implementation. This function will be later
exposed to users through the DMA-API.

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 include/linux/swiotlb.h | 5 +++++
 kernel/dma/swiotlb.c    | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 7c007ed7505f..d3980aeed4a0 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -76,6 +76,7 @@ bool swiotlb_map(struct device *dev, phys_addr_t *phys, dma_addr_t *dma_addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs);
 void __init swiotlb_exit(void);
 unsigned int swiotlb_max_segment(void);
+size_t swiotlb_max_mapping_size(struct device *dev);
 #else
 #define swiotlb_force SWIOTLB_NO_FORCE
 static inline bool is_swiotlb_buffer(phys_addr_t paddr)
@@ -95,6 +96,10 @@ static inline unsigned int swiotlb_max_segment(void)
 {
 	return 0;
 }
+static inline size_t swiotlb_max_mapping_size(struct device *dev)
+{
+	return SIZE_MAX;
+}
 #endif /* CONFIG_SWIOTLB */
 
 extern void swiotlb_print_info(void);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 1fb6fd68b9c7..9cb21259cb0b 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -662,3 +662,8 @@ swiotlb_dma_supported(struct device *hwdev, u64 mask)
 {
 	return __phys_to_dma(hwdev, io_tlb_end - 1) <= mask;
 }
+
+size_t swiotlb_max_mapping_size(struct device *dev)
+{
+	return ((size_t)1 << IO_TLB_SHIFT) * IO_TLB_SEGSIZE;
+}
-- 
2.17.1
