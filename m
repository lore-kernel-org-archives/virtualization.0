From: kbuild test robot <lkp@intel.com>
Subject: [RFC PATCH] virtio: virtio_pool can be static
Date: Thu, 30 Apr 2020 05:06:42 +0800
Message-ID: <20200429210642.GA804@46221c807a07>
References: <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: konrad.wilk@oracle.com, mst@redhat.com, jasowang@redhat.com, jan.kiszka@siemens.com, will@kernel.org, stefano.stabellini@xilinx.com
Cc: kbuild-all@lists.01.org, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org, pratikp@codeaurora.org, vatsa@codeaurora.org, christoffer.dall@arm.com, alex.bennee@linaro.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


Signed-off-by: kbuild test robot <lkp@intel.com>
---
 virtio_bounce.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_bounce.c b/drivers/virtio/virtio_bounce.c
index 3de8e0eb71e48..5a68d48667c42 100644
--- a/drivers/virtio/virtio_bounce.c
+++ b/drivers/virtio/virtio_bounce.c
@@ -19,7 +19,7 @@
 static phys_addr_t bounce_buf_paddr;
 static void *bounce_buf_vaddr;
 static size_t bounce_buf_size;
-struct swiotlb_pool *virtio_pool;
+static struct swiotlb_pool *virtio_pool;
 
 #define VIRTIO_MAX_BOUNCE_SIZE	(16*4096)
 
@@ -76,7 +76,7 @@ static void virtio_unmap_page(struct device *dev, dma_addr_t dev_addr,
 					size, dir, attrs);
 }
 
-size_t virtio_max_mapping_size(struct device *dev)
+static size_t virtio_max_mapping_size(struct device *dev)
 {
 	return VIRTIO_MAX_BOUNCE_SIZE;
 }
