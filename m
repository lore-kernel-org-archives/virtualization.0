From: Eric Auger <eric.auger@redhat.com>
Subject: [PATCH 1/2] dma-mapping: Protect dma_addressing_limited against NULL
	dma_mask
Date: Mon, 22 Jul 2019 16:55:08 +0200
Message-ID: <20190722145509.1284-2-eric.auger__2599.8208949872$1563807358$gmane$org@redhat.com>
References: <20190722145509.1284-1-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190722145509.1284-1-eric.auger@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

dma_addressing_limited() should not be called on a device with
a NULL dma_mask. If this occurs let's WARN_ON_ONCE and immediately
return. Existing call sites are updated separately.

Fixes: b866455423e0 ("dma-mapping: add a dma_addressing_limited helper")
Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v1 -> v2:
- add a WARN_ON_ONCE()
- reword the commit message
---
 include/linux/dma-mapping.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index e11b115dd0e4..ef0cf9537abc 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -689,8 +689,9 @@ static inline int dma_coerce_mask_and_coherent(struct device *dev, u64 mask)
  */
 static inline bool dma_addressing_limited(struct device *dev)
 {
-	return min_not_zero(*dev->dma_mask, dev->bus_dma_mask) <
-		dma_get_required_mask(dev);
+	return WARN_ON_ONCE(!dev->dma_mask) ? false :
+		min_not_zero(*dev->dma_mask, dev->bus_dma_mask) <
+			dma_get_required_mask(dev);
 }
 
 #ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
-- 
2.20.1
