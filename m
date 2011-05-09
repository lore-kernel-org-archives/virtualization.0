From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 042/206] Staging: hv: Get rid of the forwrd declaration of
	destroy_bounce_buffer
Date: Mon,  9 May 2011 14:55:24 -0700
Message-ID: <1304978288-22999-42-git-send-email-kys@microsoft.com>
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
 drivers/staging/hv/storvsc_drv.c |   32 +++++++++++++++-----------------
 1 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 4196d6a..bf5b138 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -148,6 +148,21 @@ static int storvsc_device_configure(struct scsi_device *sdevice)
 	return 0;
 }
 
+static void destroy_bounce_buffer(struct scatterlist *sgl,
+				  unsigned int sg_count)
+{
+	int i;
+	struct page *page_buf;
+
+	for (i = 0; i < sg_count; i++) {
+		page_buf = sg_page((&sgl[i]));
+		if (page_buf != NULL)
+			__free_page(page_buf);
+	}
+
+	kfree(sgl);
+}
+
 /* Static decl */
 static int storvsc_probe(struct hv_device *dev);
 static int storvsc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmnd);
@@ -157,8 +172,6 @@ static int storvsc_remove(struct hv_device *dev);
 static struct scatterlist *create_bounce_buffer(struct scatterlist *sgl,
 						unsigned int sg_count,
 						unsigned int len);
-static void destroy_bounce_buffer(struct scatterlist *sgl,
-				  unsigned int sg_count);
 static int do_bounce_buffer(struct scatterlist *sgl, unsigned int sg_count);
 static unsigned int copy_from_bounce_buffer(struct scatterlist *orig_sgl,
 					    struct scatterlist *bounce_sgl,
@@ -542,21 +555,6 @@ cleanup:
 	return NULL;
 }
 
-static void destroy_bounce_buffer(struct scatterlist *sgl,
-				  unsigned int sg_count)
-{
-	int i;
-	struct page *page_buf;
-
-	for (i = 0; i < sg_count; i++) {
-		page_buf = sg_page((&sgl[i]));
-		if (page_buf != NULL)
-			__free_page(page_buf);
-	}
-
-	kfree(sgl);
-}
-
 /* Assume the bounce_sgl has enough room ie using the create_bounce_buffer() */
 static unsigned int copy_to_bounce_buffer(struct scatterlist *orig_sgl,
 					  struct scatterlist *bounce_sgl,
-- 
1.7.4.1
