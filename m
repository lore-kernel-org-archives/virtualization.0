From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 2/2] balloon: fix up comments
Date: Thu, 18 Jul 2019 08:24:24 -0400
Message-ID: <20190718122324.10552-2-mst__10930.0023688533$1563452697$gmane$org@redhat.com>
References: <20190718122324.10552-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190718122324.10552-1-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Lots of comments bitrotted. Fix them up.

Fixes: 418a3ab1e778 (mm/balloon_compaction: List interfaces)
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 mm/balloon_compaction.c | 73 +++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 32 deletions(-)

diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index d25664e1857b..9cb03da5bcea 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -32,10 +32,10 @@ static void balloon_page_enqueue_one(struct balloon_dev_info *b_dev_info,
  * @b_dev_info: balloon device descriptor where we will insert a new page to
  * @pages: pages to enqueue - allocated using balloon_page_alloc.
  *
- * Driver must call it to properly enqueue a balloon pages before definitively
- * removing it from the guest system.
+ * Driver must call this function to properly enqueue balloon pages before
+ * definitively removing them from the guest system.
  *
- * Return: number of pages that were enqueued.
+ * Returns: number of pages that were enqueued.
  */
 size_t balloon_page_list_enqueue(struct balloon_dev_info *b_dev_info,
 				 struct list_head *pages)
@@ -63,14 +63,15 @@ EXPORT_SYMBOL_GPL(balloon_page_list_enqueue);
  * @n_req_pages: number of requested pages.
  *
  * Driver must call this function to properly de-allocate a previous enlisted
- * balloon pages before definetively releasing it back to the guest system.
+ * balloon pages before definitively releasing it back to the guest system.
  * This function tries to remove @n_req_pages from the ballooned pages and
  * return them to the caller in the @pages list.
  *
- * Note that this function may fail to dequeue some pages temporarily empty due
- * to compaction isolated pages.
+ * Note that this function may fail to dequeue some pages even if the balloon
+ * isn't empty - since the page list can be temporarily empty due to compaction
+ * of isolated pages.
  *
- * Return: number of pages that were added to the @pages list.
+ * Returns: number of pages that were added to the @pages list.
  */
 size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
 				 struct list_head *pages, size_t n_req_pages)
@@ -112,12 +113,14 @@ EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
 
 /*
  * balloon_page_alloc - allocates a new page for insertion into the balloon
- *			  page list.
+ *			page list.
  *
- * Driver must call it to properly allocate a new enlisted balloon page.
- * Driver must call balloon_page_enqueue before definitively removing it from
- * the guest system.  This function returns the page address for the recently
- * allocated page or NULL in the case we fail to allocate a new page this turn.
+ * Driver must call this function to properly allocate a new enlisted balloon page.
+ * Driver must call balloon_page_enqueue before definitively removing the page
+ * from the guest system.
+ *
+ * Returns: struct page address for the allocated page or NULL in case it fails
+ * 			to allocate a new page.
  */
 struct page *balloon_page_alloc(void)
 {
@@ -130,19 +133,15 @@ EXPORT_SYMBOL_GPL(balloon_page_alloc);
 /*
  * balloon_page_enqueue - inserts a new page into the balloon page list.
  *
- * @b_dev_info: balloon device descriptor where we will insert a new page to
+ * @b_dev_info: balloon device descriptor where we will insert a new page
  * @page: new page to enqueue - allocated using balloon_page_alloc.
  *
- * Driver must call it to properly enqueue a new allocated balloon page
- * before definitively removing it from the guest system.
+ * Drivers must call this function to properly enqueue a new allocated balloon
+ * page before definitively removing the page from the guest system.
  *
- * Drivers must not call balloon_page_enqueue on pages that have been
- * pushed to a list with balloon_page_push before removing them with
- * balloon_page_pop. To all pages on a list, use balloon_page_list_enqueue
- * instead.
- *
- * This function returns the page address for the recently enqueued page or
- * NULL in the case we fail to allocate a new page this turn.
+ * Drivers must not call balloon_page_enqueue on pages that have been pushed to
+ * a list with balloon_page_push before removing them with balloon_page_pop. To
+ * enqueue all pages on a list, use balloon_page_list_enqueue instead.
  */
 void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
 			  struct page *page)
@@ -157,14 +156,24 @@ EXPORT_SYMBOL_GPL(balloon_page_enqueue);
 
 /*
  * balloon_page_dequeue - removes a page from balloon's page list and returns
- *			  the its address to allow the driver release the page.
+ *			  its address to allow the driver to release the page.
  * @b_dev_info: balloon device decriptor where we will grab a page from.
  *
- * Driver must call it to properly de-allocate a previous enlisted balloon page
- * before definetively releasing it back to the guest system.
- * This function returns the page address for the recently dequeued page or
- * NULL in the case we find balloon's page list temporarily empty due to
- * compaction isolated pages.
+ * Driver must call this to properly dequeue a previously enqueued page
+ * before definitively releasing it back to the guest system.
+ *
+ * Caller must perform its own accounting to ensure that this
+ * function is called only if some pages are actually enqueued.
+ *
+ * Note that this function may fail to dequeue some pages even if there are
+ * some enqueued pages - since the page list can be temporarily empty due to
+ * the compaction of isolated pages.
+ *
+ * TODO: remove the caller accounting requirements, and allow caller to wait
+ * until all pages can be dequeued.
+ *
+ * Returns: struct page address for the dequeued page, or NULL if it fails to
+ * 			dequeue any pages.
  */
 struct page *balloon_page_dequeue(struct balloon_dev_info *b_dev_info)
 {
@@ -177,9 +186,9 @@ struct page *balloon_page_dequeue(struct balloon_dev_info *b_dev_info)
 	if (n_pages != 1) {
 		/*
 		 * If we are unable to dequeue a balloon page because the page
-		 * list is empty and there is no isolated pages, then something
+		 * list is empty and there are no isolated pages, then something
 		 * went out of track and some balloon pages are lost.
-		 * BUG() here, otherwise the balloon driver may get stuck into
+		 * BUG() here, otherwise the balloon driver may get stuck in
 		 * an infinite loop while attempting to release all its pages.
 		 */
 		spin_lock_irqsave(&b_dev_info->pages_lock, flags);
@@ -230,8 +239,8 @@ int balloon_page_migrate(struct address_space *mapping,
 
 	/*
 	 * We can not easily support the no copy case here so ignore it as it
-	 * is unlikely to be use with ballon pages. See include/linux/hmm.h for
-	 * user of the MIGRATE_SYNC_NO_COPY mode.
+	 * is unlikely to be used with ballon pages. See include/linux/hmm.h for
+	 * a user of the MIGRATE_SYNC_NO_COPY mode.
 	 */
 	if (mode == MIGRATE_SYNC_NO_COPY)
 		return -EINVAL;
-- 
MST
