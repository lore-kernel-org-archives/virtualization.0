From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 044/206] Staging: hv: Get rid of the forward declaration for
	create_bounce_buffer()
Date: Mon,  9 May 2011 14:55:26 -0700
Message-ID: <1304978288-22999-44-git-send-email-kys@microsoft.com>
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
 drivers/staging/hv/storvsc_drv.c |   61 ++++++++++++++++++--------------------
 1 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 9380866..551c48c 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -190,15 +190,41 @@ static int do_bounce_buffer(struct scatterlist *sgl, unsigned int sg_count)
 	return -1;
 }
 
+static struct scatterlist *create_bounce_buffer(struct scatterlist *sgl,
+						unsigned int sg_count,
+						unsigned int len)
+{
+	int i;
+	int num_pages;
+	struct scatterlist *bounce_sgl;
+	struct page *page_buf;
+
+	num_pages = ALIGN(len, PAGE_SIZE) >> PAGE_SHIFT;
+
+	bounce_sgl = kcalloc(num_pages, sizeof(struct scatterlist), GFP_ATOMIC);
+	if (!bounce_sgl)
+		return NULL;
+
+	for (i = 0; i < num_pages; i++) {
+		page_buf = alloc_page(GFP_ATOMIC);
+		if (!page_buf)
+			goto cleanup;
+		sg_set_page(&bounce_sgl[i], page_buf, 0, 0);
+	}
+
+	return bounce_sgl;
+
+cleanup:
+	destroy_bounce_buffer(bounce_sgl, num_pages);
+	return NULL;
+}
+
 /* Static decl */
 static int storvsc_probe(struct hv_device *dev);
 static int storvsc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmnd);
 static int storvsc_host_reset_handler(struct scsi_cmnd *scmnd);
 static int storvsc_remove(struct hv_device *dev);
 
-static struct scatterlist *create_bounce_buffer(struct scatterlist *sgl,
-						unsigned int sg_count,
-						unsigned int len);
 static unsigned int copy_from_bounce_buffer(struct scatterlist *orig_sgl,
 					    struct scatterlist *bounce_sgl,
 					    unsigned int orig_sgl_count);
@@ -525,35 +551,6 @@ static void storvsc_commmand_completion(struct hv_storvsc_request *request)
 	kmem_cache_free(host_dev->request_pool, cmd_request);
 }
 
-static struct scatterlist *create_bounce_buffer(struct scatterlist *sgl,
-						unsigned int sg_count,
-						unsigned int len)
-{
-	int i;
-	int num_pages;
-	struct scatterlist *bounce_sgl;
-	struct page *page_buf;
-
-	num_pages = ALIGN(len, PAGE_SIZE) >> PAGE_SHIFT;
-
-	bounce_sgl = kcalloc(num_pages, sizeof(struct scatterlist), GFP_ATOMIC);
-	if (!bounce_sgl)
-		return NULL;
-
-	for (i = 0; i < num_pages; i++) {
-		page_buf = alloc_page(GFP_ATOMIC);
-		if (!page_buf)
-			goto cleanup;
-		sg_set_page(&bounce_sgl[i], page_buf, 0, 0);
-	}
-
-	return bounce_sgl;
-
-cleanup:
-	destroy_bounce_buffer(bounce_sgl, num_pages);
-	return NULL;
-}
-
 /* Assume the bounce_sgl has enough room ie using the create_bounce_buffer() */
 static unsigned int copy_to_bounce_buffer(struct scatterlist *orig_sgl,
 					  struct scatterlist *bounce_sgl,
-- 
1.7.4.1
