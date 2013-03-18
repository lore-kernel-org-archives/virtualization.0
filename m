From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 01/22] scatterlist: introduce sg_unmark_end
Date: Mon, 18 Mar 2013 20:04:32 +1030
Message-ID: <1363599293-23065-2-git-send-email-rusty@rustcorp.com.au>
References: <1363599293-23065-1-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1363599293-23065-1-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Paolo Bonzini <pbonzini@redhat.com>

This is useful in places that recycle the same scatterlist multiple
times, and do not want to incur the cost of sg_init_table every
time in hot paths.

Acked-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 block/blk-integrity.c       |    2 +-
 block/blk-merge.c           |    2 +-
 include/linux/scatterlist.h |   16 ++++++++++++++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index dabd221..03cf717 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -110,7 +110,7 @@ new_segment:
 			if (!sg)
 				sg = sglist;
 			else {
-				sg->page_link &= ~0x02;
+				sg_unmark_end(sg);
 				sg = sg_next(sg);
 			}
 
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 936a110..5f24482 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -143,7 +143,7 @@ new_segment:
 			 * termination bit to avoid doing a full
 			 * sg_init_table() in drivers for each command.
 			 */
-			(*sg)->page_link &= ~0x02;
+			sg_unmark_end(*sg);
 			*sg = sg_next(*sg);
 		}
 
diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 2d8bdae..bfc47e0 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -172,6 +172,22 @@ static inline void sg_mark_end(struct scatterlist *sg)
 }
 
 /**
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
+/**
  * sg_phys - Return physical address of an sg entry
  * @sg:	     SG entry
  *
-- 
1.7.10.4
