From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: [PATCH] tools/virtio: add sg_unmark_end to scatterlist.h
Date: Wed, 27 Feb 2013 18:02:13 +0800
Message-ID: <1361959333-8164-1-git-send-email-gaowanlong@cn.fujitsu.com>
References: <1361226573-12481-1-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1361226573-12481-1-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Add sg_unmark_end to scatterlist.h to fix compile.

Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 tools/virtio/linux/scatterlist.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/virtio/linux/scatterlist.h b/tools/virtio/linux/scatterlist.h
index b2cf7d0..68c9e2a 100644
--- a/tools/virtio/linux/scatterlist.h
+++ b/tools/virtio/linux/scatterlist.h
@@ -125,6 +125,22 @@ static inline void sg_mark_end(struct scatterlist *sg)
 	sg->page_link &= ~0x01;
 }
 
+/**
+ * sg_unmark_end - Undo setting the end of the scatterlist
+ * @sg:		 SG entryScatterlist
+ *
+ * Description:
+ *   Removes the termination marker from the given entry of the scatterlist.
+ *
+ **/
+static inline void sg_unmark_end(struct scatterlist *sg)
+{
+#ifdef CONFIG_DEBUG_SG
+	BUG_ON(sg->sg_magic != SG_MAGIC);
+#endif
+	sg->page_link &= ~0x02;
+}
+
 static inline struct scatterlist *sg_next(struct scatterlist *sg)
 {
 #ifdef CONFIG_DEBUG_SG
-- 
1.8.1
