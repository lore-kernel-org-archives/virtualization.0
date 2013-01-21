From: Asias He <asias@redhat.com>
Subject: [PATCH 2/3] tcm_vhost: Optimize gup in vhost_scsi_map_to_sgl
Date: Mon, 21 Jan 2013 16:05:27 +0800
Message-ID: <1358755528-31421-3-git-send-email-asias__36042.0927209363$1358755462$gmane$org@redhat.com>
References: <1358755528-31421-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1358755528-31421-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nicholas Bellinger <nab@linux-iscsi.org>
Cc: target-devel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

We can get all the pages in one time instead of calling
gup N times.

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/tcm_vhost.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
index ca35c16..59be442 100644
--- a/drivers/vhost/tcm_vhost.c
+++ b/drivers/vhost/tcm_vhost.c
@@ -430,37 +430,45 @@ static struct tcm_vhost_cmd *vhost_scsi_allocate_cmd(
  * Returns the number of scatterlist entries used or -errno on error.
  */
 static int vhost_scsi_map_to_sgl(struct scatterlist *sgl,
-	unsigned int sgl_count, void __user *ptr, size_t len, int write)
+	unsigned int sgl_count, struct iovec *iov, int write)
 {
 	struct scatterlist *sg = sgl;
 	unsigned int npages = 0;
+	void __user *ptr = iov->iov_base;
+	size_t len = iov->iov_len;
 	int ret;
+	unsigned int pages_nr, offset, nbytes;
+	struct page **pages;
+
+	pages_nr = iov_num_pages(iov);
+	pages = kmalloc(pages_nr * sizeof(struct page *), GFP_ATOMIC);
+	if (!pages)
+		return -ENOMEM;
+
+	ret = get_user_pages_fast((unsigned long)ptr, pages_nr, write, pages);
+	if (ret != pages_nr)
+		goto err;
 
 	while (len > 0) {
-		struct page *page;
-		unsigned int offset = (uintptr_t)ptr & ~PAGE_MASK;
-		unsigned int nbytes = min_t(unsigned int,
-				PAGE_SIZE - offset, len);
+		offset = (uintptr_t)ptr & ~PAGE_MASK;
+		nbytes = min_t(unsigned int, PAGE_SIZE - offset, len);
 
 		if (npages == sgl_count) {
 			ret = -ENOBUFS;
 			goto err;
 		}
 
-		ret = get_user_pages_fast((unsigned long)ptr, 1, write, &page);
-		BUG_ON(ret == 0); /* we should either get our page or fail */
-		if (ret < 0)
-			goto err;
-
-		sg_set_page(sg, page, nbytes, offset);
+		sg_set_page(sg, pages[npages], nbytes, offset);
 		ptr += nbytes;
 		len -= nbytes;
 		sg++;
 		npages++;
 	}
+	kfree(pages);
 	return npages;
 
 err:
+	kfree(pages);
 	/* Put pages that we hold */
 	for (sg = sgl; sg != &sgl[npages]; sg++)
 		put_page(sg_page(sg));
@@ -498,8 +506,7 @@ static int vhost_scsi_map_iov_to_sgl(struct tcm_vhost_cmd *tv_cmd,
 
 	pr_debug("Mapping %u iovecs for %u pages\n", niov, sgl_count);
 	for (i = 0; i < niov; i++) {
-		ret = vhost_scsi_map_to_sgl(sg, sgl_count, iov[i].iov_base,
-					iov[i].iov_len, write);
+		ret = vhost_scsi_map_to_sgl(sg, sgl_count, &iov[i], write);
 		if (ret < 0) {
 			for (i = 0; i < tv_cmd->tvc_sgl_count; i++)
 				put_page(sg_page(&tv_cmd->tvc_sgl[i]));
-- 
1.8.1
