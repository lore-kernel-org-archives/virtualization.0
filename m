From: Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v17 3/6] mm/balloon_compaction.c: split balloon page
	allocation and enqueue
Date: Fri,  3 Nov 2017 16:13:03 +0800
Message-ID: <1509696786-1597-4-git-send-email-wei.w.wang__10361.0722501346$1509697734$gmane$org@intel.com>
References: <1509696786-1597-1-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1509696786-1597-1-git-send-email-wei.w.wang@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com
Cc: aarcange@redhat.com, yang.zhang.wz@gmail.com, penguin-kernel@I-love.SAKURA.ne.jp, liliang.opensource@gmail.com, willy@infradead.org, amit.shah@redhat.com, quan.xu@aliyun.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst.redhat.com>

fill_balloon doing memory allocations under balloon_lock
can cause a deadlock when leak_balloon is called from
virtballoon_oom_notify and tries to take same lock.

To fix, split page allocation and enqueue and do allocations outside
the lock.

Here's a detailed analysis of the deadlock by Tetsuo Handa:

In leak_balloon(), mutex_lock(&vb->balloon_lock) is called in order to
serialize against fill_balloon(). But in fill_balloon(),
alloc_page(GFP_HIGHUSER[_MOVABLE] | __GFP_NOMEMALLOC | __GFP_NORETRY) is
called with vb->balloon_lock mutex held. Since GFP_HIGHUSER[_MOVABLE]
implies __GFP_DIRECT_RECLAIM | __GFP_IO | __GFP_FS, despite __GFP_NORETRY
is specified, this allocation attempt might indirectly depend on somebody
else's __GFP_DIRECT_RECLAIM memory allocation. And such indirect
__GFP_DIRECT_RECLAIM memory allocation might call leak_balloon() via
virtballoon_oom_notify() via blocking_notifier_call_chain() callback via
out_of_memory() when it reached __alloc_pages_may_oom() and held oom_lock
mutex. Since vb->balloon_lock mutex is already held by fill_balloon(), it
will cause OOM lockup. Thus, do not wait for vb->balloon_lock mutex if
leak_balloon() is called from out_of_memory().

Thread1                                Thread2
fill_balloon()
 takes a balloon_lock
  balloon_page_enqueue()
   alloc_page(GFP_HIGHUSER_MOVABLE)
    direct reclaim (__GFP_FS context)  takes a fs lock
     waits for that fs lock             alloc_page(GFP_NOFS)
                                         __alloc_pages_may_oom()
                                          takes the oom_lock
                                           out_of_memory()
                                            blocking_notifier_call_chain()
                                             leak_balloon()
                                               tries to take that
					       balloon_lock and deadlocks

Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Wei Wang <wei.w.wang@intel.com>
Reviewed-by: Wei Wang <wei.w.wang@intel.com>

---
 drivers/virtio/virtio_balloon.c    | 23 ++++++++++++++++++-----
 include/linux/balloon_compaction.h | 34 +++++++++++++++++++++++++++++++++-
 mm/balloon_compaction.c            | 28 +++++++++++++++++++++-------
 3 files changed, 72 insertions(+), 13 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index f0b3a0b..45fe6a8 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -143,16 +143,17 @@ static void set_page_pfns(struct virtio_balloon *vb,
 
 static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
 {
-	struct balloon_dev_info *vb_dev_info = &vb->vb_dev_info;
 	unsigned num_allocated_pages;
+	unsigned int num_pfns;
+	struct page *page;
+	LIST_HEAD(pages);
 
 	/* We can only do one array worth at a time. */
 	num = min(num, ARRAY_SIZE(vb->pfns));
 
-	mutex_lock(&vb->balloon_lock);
-	for (vb->num_pfns = 0; vb->num_pfns < num;
-	     vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE) {
-		struct page *page = balloon_page_enqueue(vb_dev_info);
+	for (num_pfns = 0; num_pfns < num;
+	     num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE) {
+		struct page *page = balloon_page_alloc();
 
 		if (!page) {
 			dev_info_ratelimited(&vb->vdev->dev,
@@ -162,6 +163,18 @@ static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
 			msleep(200);
 			break;
 		}
+
+		balloon_page_push(&pages, page);
+	}
+
+	mutex_lock(&vb->balloon_lock);
+
+	vb->num_pfns = 0;
+	while ((page = balloon_page_pop(&pages))) {
+		balloon_page_enqueue(&vb->vb_dev_info, page);
+
+		vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE;
+
 		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
 		vb->num_pages += VIRTIO_BALLOON_PAGES_PER_PAGE;
 		if (!virtio_has_feature(vb->vdev,
diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index 79542b2..bdc055a 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -49,6 +49,7 @@
 #include <linux/gfp.h>
 #include <linux/err.h>
 #include <linux/fs.h>
+#include <linux/list.h>
 
 /*
  * Balloon device information descriptor.
@@ -66,7 +67,9 @@ struct balloon_dev_info {
 	struct inode *inode;
 };
 
-extern struct page *balloon_page_enqueue(struct balloon_dev_info *b_dev_info);
+extern struct page *balloon_page_alloc(void);
+extern void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
+				 struct page *page);
 extern struct page *balloon_page_dequeue(struct balloon_dev_info *b_dev_info);
 
 static inline void balloon_devinfo_init(struct balloon_dev_info *balloon)
@@ -86,6 +89,35 @@ extern void balloon_page_putback(struct page *page);
 extern int balloon_page_migrate(struct address_space *mapping,
 				struct page *newpage,
 				struct page *page, enum migrate_mode mode);
+/*
+ * balloon_page_push - insert a page into a page list.
+ * @head : pointer to list
+ * @page : page to be added
+ *
+ * Caller must ensure the page is private and protect the list.
+ */
+static inline void balloon_page_push(struct list_head *pages, struct page *page)
+{
+	list_add(&page->lru, pages);
+}
+
+/*
+ * balloon_page_pop - remove a page from a page list.
+ * @head : pointer to list
+ * @page : page to be added
+ *
+ * Caller must ensure the page is private and protect the list.
+ */
+static inline struct page *balloon_page_pop(struct list_head *pages)
+{
+	struct page *page = list_first_entry_or_null(pages, struct page, lru);
+
+	if (!page)
+		return NULL;
+
+	list_del(&page->lru);
+	return page;
+}
 
 /*
  * balloon_page_insert - insert a page into the balloon's page list and make
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 68d2892..16212c7 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -11,22 +11,36 @@
 #include <linux/balloon_compaction.h>
 
 /*
- * balloon_page_enqueue - allocates a new page and inserts it into the balloon
+ * balloon_page_alloc - allocates a new page for insertion into the balloon
  *			  page list.
+ *
+ * Driver must call it to properly allocate a new enlisted balloon page.
+ * Driver must call balloon_page_enqueue before definitively removing it from
+ * the guest system.  This function returns the page address for the recently
+ * allocated page or NULL in the case we fail to allocate a new page this turn.
+ */
+struct page *balloon_page_alloc(void)
+{
+	struct page *page = alloc_page(balloon_mapping_gfp_mask() |
+				       __GFP_NOMEMALLOC | __GFP_NORETRY);
+	return page;
+}
+EXPORT_SYMBOL_GPL(balloon_page_alloc);
+
+/*
+ * balloon_page_enqueue - inserts a new page into the balloon page list.
  * @b_dev_info: balloon device descriptor where we will insert a new page to
+ * @page: new page to enqueue - allocated using balloon_page_alloc.
  *
- * Driver must call it to properly allocate a new enlisted balloon page
+ * Driver must call it to properly enqueue a new enlisted balloon page
  * before definitively removing it from the guest system.
  * This function returns the page address for the recently enqueued page or
  * NULL in the case we fail to allocate a new page this turn.
  */
-struct page *balloon_page_enqueue(struct balloon_dev_info *b_dev_info)
+void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
+			  struct page *page)
 {
 	unsigned long flags;
-	struct page *page = alloc_page(balloon_mapping_gfp_mask() |
-				       __GFP_NOMEMALLOC | __GFP_NORETRY);
-	if (!page)
-		return NULL;
 
 	/*
 	 * Block others from accessing the 'page' when we get around to
-- 
2.7.4
