From: ruslanpisarev@gmail.com
Subject: [PATCH 1/7] Xen: fix whitespaces,
	tabs coding style issue in drivers/xen/balloon.c
Date: Tue, 26 Jul 2011 14:15:59 +0300
Message-ID: <1311678959-16470-1-git-send-email-ruslan@rpisarev.org.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jeremy.fitzhardinge@citrix.com
Cc: Ruslan Pisarev <ruslan@rpisarev.org.ua>, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org, konrad.wilk@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

From: Ruslan Pisarev <ruslan@rpisarev.org.ua>

This is a patch to the balloon.c file that fixed up
whitespaces, tabs errors found by the checkpatch.pl tools.

Signed-off-by: Ruslan Pisarev <ruslan@rpisarev.org.ua>
---
 drivers/xen/balloon.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index f54290b..61c0ee7 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -84,8 +84,8 @@ static unsigned long frame_list[PAGE_SIZE / sizeof(unsigned long)];
 #define inc_totalhigh_pages() (totalhigh_pages++)
 #define dec_totalhigh_pages() (totalhigh_pages--)
 #else
-#define inc_totalhigh_pages() do {} while(0)
-#define dec_totalhigh_pages() do {} while(0)
+#define inc_totalhigh_pages() do {} while (0)
+#define dec_totalhigh_pages() do {} while (0)
 #endif
 
 /* List of ballooned pages, threaded through the mem_map array. */
@@ -145,8 +145,7 @@ static struct page *balloon_retrieve(bool prefer_highmem)
 	if (PageHighMem(page)) {
 		balloon_stats.balloon_high--;
 		inc_totalhigh_pages();
-	}
-	else
+	} else
 		balloon_stats.balloon_low--;
 
 	totalram_pages++;
@@ -299,7 +298,7 @@ static enum bp_state decrease_reservation(unsigned long nr_pages, gfp_t gfp)
 				(unsigned long)__va(pfn << PAGE_SHIFT),
 				__pte_ma(0), 0);
 			BUG_ON(ret);
-                }
+		}
 
 	}
 
@@ -376,10 +375,10 @@ EXPORT_SYMBOL_GPL(balloon_set_new_target);
  * @pages: pages returned
  * @return 0 on success, error otherwise
  */
-int alloc_xenballooned_pages(int nr_pages, struct page** pages)
+int alloc_xenballooned_pages(int nr_pages, struct page **pages)
 {
 	int pgno = 0;
-	struct page* page;
+	struct page *page;
 	mutex_lock(&balloon_mutex);
 	while (pgno < nr_pages) {
 		page = balloon_retrieve(true);
@@ -409,7 +408,7 @@ EXPORT_SYMBOL(alloc_xenballooned_pages);
  * @nr_pages: Number of pages
  * @pages: pages to return
  */
-void free_xenballooned_pages(int nr_pages, struct page** pages)
+void free_xenballooned_pages(int nr_pages, struct page **pages)
 {
 	int i;
 
-- 
1.7.4.1
