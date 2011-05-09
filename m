From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 046/206] Staging: hv: Get rid of the forward declaration for
	copy_to_bounce_buffer()
Date: Mon,  9 May 2011 14:55:28 -0700
Message-ID: <1304978288-22999-46-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
	<1304978288-22999-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of the forward declaration by moving the code around.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |  132 +++++++++++++++++++-------------------
 1 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 4e3e9ca..807ba89 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -284,16 +284,78 @@ static unsigned int copy_from_bounce_buffer(struct scatterlist *orig_sgl,
 	return total_copied;
 }
 
+
+/* Assume the bounce_sgl has enough room ie using the create_bounce_buffer() */
+static unsigned int copy_to_bounce_buffer(struct scatterlist *orig_sgl,
+					  struct scatterlist *bounce_sgl,
+					  unsigned int orig_sgl_count)
+{
+	int i;
+	int j = 0;
+	unsigned long src, dest;
+	unsigned int srclen, destlen, copylen;
+	unsigned int total_copied = 0;
+	unsigned long bounce_addr = 0;
+	unsigned long src_addr = 0;
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	for (i = 0; i < orig_sgl_count; i++) {
+		src_addr = (unsigned long)kmap_atomic(sg_page((&orig_sgl[i])),
+				KM_IRQ0) + orig_sgl[i].offset;
+		src = src_addr;
+		srclen = orig_sgl[i].length;
+
+		if (bounce_addr == 0)
+			bounce_addr =
+			(unsigned long)kmap_atomic(sg_page((&bounce_sgl[j])),
+						KM_IRQ0);
+
+		while (srclen) {
+			/* assume bounce offset always == 0 */
+			dest = bounce_addr + bounce_sgl[j].length;
+			destlen = PAGE_SIZE - bounce_sgl[j].length;
+
+			copylen = min(srclen, destlen);
+			memcpy((void *)dest, (void *)src, copylen);
+
+			total_copied += copylen;
+			bounce_sgl[j].length += copylen;
+			srclen -= copylen;
+			src += copylen;
+
+			if (bounce_sgl[j].length == PAGE_SIZE) {
+				/* full..move to next entry */
+				kunmap_atomic((void *)bounce_addr, KM_IRQ0);
+				j++;
+
+				/* if we need to use another bounce buffer */
+				if (srclen || i != orig_sgl_count - 1)
+					bounce_addr =
+					(unsigned long)kmap_atomic(
+					sg_page((&bounce_sgl[j])), KM_IRQ0);
+
+			} else if (srclen == 0 && i == orig_sgl_count - 1) {
+				/* unmap the last bounce that is < PAGE_SIZE */
+				kunmap_atomic((void *)bounce_addr, KM_IRQ0);
+			}
+		}
+
+		kunmap_atomic((void *)(src_addr - orig_sgl[i].offset), KM_IRQ0);
+	}
+
+	local_irq_restore(flags);
+
+	return total_copied;
+}
+
 /* Static decl */
 static int storvsc_probe(struct hv_device *dev);
 static int storvsc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmnd);
 static int storvsc_host_reset_handler(struct scsi_cmnd *scmnd);
 static int storvsc_remove(struct hv_device *dev);
 
-static unsigned int copy_to_bounce_buffer(struct scatterlist *orig_sgl,
-					  struct scatterlist *bounce_sgl,
-					  unsigned int orig_sgl_count);
-
 static int storvsc_get_chs(struct scsi_device *sdev, struct block_device *bdev,
 			   sector_t capacity, int *info);
 
@@ -613,68 +675,6 @@ static void storvsc_commmand_completion(struct hv_storvsc_request *request)
 	kmem_cache_free(host_dev->request_pool, cmd_request);
 }
 
-/* Assume the bounce_sgl has enough room ie using the create_bounce_buffer() */
-static unsigned int copy_to_bounce_buffer(struct scatterlist *orig_sgl,
-					  struct scatterlist *bounce_sgl,
-					  unsigned int orig_sgl_count)
-{
-	int i;
-	int j = 0;
-	unsigned long src, dest;
-	unsigned int srclen, destlen, copylen;
-	unsigned int total_copied = 0;
-	unsigned long bounce_addr = 0;
-	unsigned long src_addr = 0;
-	unsigned long flags;
-
-	local_irq_save(flags);
-
-	for (i = 0; i < orig_sgl_count; i++) {
-		src_addr = (unsigned long)kmap_atomic(sg_page((&orig_sgl[i])),
-				KM_IRQ0) + orig_sgl[i].offset;
-		src = src_addr;
-		srclen = orig_sgl[i].length;
-
-		/* ASSERT(orig_sgl[i].offset + orig_sgl[i].length <= PAGE_SIZE); */
-
-		if (bounce_addr == 0)
-			bounce_addr = (unsigned long)kmap_atomic(sg_page((&bounce_sgl[j])), KM_IRQ0);
-
-		while (srclen) {
-			/* assume bounce offset always == 0 */
-			dest = bounce_addr + bounce_sgl[j].length;
-			destlen = PAGE_SIZE - bounce_sgl[j].length;
-
-			copylen = min(srclen, destlen);
-			memcpy((void *)dest, (void *)src, copylen);
-
-			total_copied += copylen;
-			bounce_sgl[j].length += copylen;
-			srclen -= copylen;
-			src += copylen;
-
-			if (bounce_sgl[j].length == PAGE_SIZE) {
-				/* full..move to next entry */
-				kunmap_atomic((void *)bounce_addr, KM_IRQ0);
-				j++;
-
-				/* if we need to use another bounce buffer */
-				if (srclen || i != orig_sgl_count - 1)
-					bounce_addr = (unsigned long)kmap_atomic(sg_page((&bounce_sgl[j])), KM_IRQ0);
-			} else if (srclen == 0 && i == orig_sgl_count - 1) {
-				/* unmap the last bounce that is < PAGE_SIZE */
-				kunmap_atomic((void *)bounce_addr, KM_IRQ0);
-			}
-		}
-
-		kunmap_atomic((void *)(src_addr - orig_sgl[i].offset), KM_IRQ0);
-	}
-
-	local_irq_restore(flags);
-
-	return total_copied;
-}
-
 /*
  * storvsc_queuecommand - Initiate command processing
  */
-- 
1.7.4.1
