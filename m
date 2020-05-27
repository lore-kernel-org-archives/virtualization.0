From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH] vdpa: fix typos in the comments for __vdpa_alloc_device()
Date: Wed, 27 May 2020 14:05:28 +0800
Message-ID: <20200527060528.9100-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Fix two typos in the comments for __vdpa_alloc_device().

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index ff6562f602e0..de211ef3738c 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -63,7 +63,7 @@ static void vdpa_release_dev(struct device *d)
  * @config: the bus operations that is supported by this device
  * @size: size of the parent structure that contains private data
  *
- * Drvier should use vdap_alloc_device() wrapper macro instead of
+ * Driver should use vdpa_alloc_device() wrapper macro instead of
  * using this directly.
  *
  * Returns an error when parent/config/dma_dev is not set or fail to get
-- 
2.20.1
