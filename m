From: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER to
 handle THP spilt issue
Date: Tue, 31 Mar 2020 12:35:24 +0200
Message-ID: <f26dc94a-7296-90c9-56cd-4586b78bc03d@redhat.com>
References: <20200326031817-mutt-send-email-mst@kernel.org>
 <C4C6BAF7-C040-403D-997C-48C7AB5A7D6B@redhat.com>
 <20200326054554-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200326054554-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Hui Zhu <teawater@gmail.com>, jasowang@redhat.com, akpm@linux-foundation.org, pagupta@redhat.com, mojha@codeaurora.org, namit@vmware.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, Hui Zhu <teawaterz@linux.alibaba.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On 26.03.20 10:49, Michael S. Tsirkin wrote:
> On Thu, Mar 26, 2020 at 08:54:04AM +0100, David Hildenbrand wrote:
>>
>>
>>> Am 26.03.2020 um 08:21 schrieb Michael S. Tsirkin <mst@redhat.com>:
>>>
>>> =EF=BB=BFOn Thu, Mar 12, 2020 at 09:51:25AM +0100, David Hildenbrand =
wrote:
>>>>> On 12.03.20 09:47, Michael S. Tsirkin wrote:
>>>>> On Thu, Mar 12, 2020 at 09:37:32AM +0100, David Hildenbrand wrote:
>>>>>> 2. You are essentially stealing THPs in the guest. So the fastest
>>>>>> mapping (THP in guest and host) is gone. The guest won't be able t=
o make
>>>>>> use of THP where it previously was able to. I can imagine this imp=
lies a
>>>>>> performance degradation for some workloads. This needs a proper
>>>>>> performance evaluation.
>>>>>
>>>>> I think the problem is more with the alloc_pages API.
>>>>> That gives you exactly the given order, and if there's
>>>>> a larger chunk available, it will split it up.
>>>>>
>>>>> But for balloon - I suspect lots of other users,
>>>>> we do not want to stress the system but if a large
>>>>> chunk is available anyway, then we could handle
>>>>> that more optimally by getting it all in one go.
>>>>>
>>>>>
>>>>> So if we want to address this, IMHO this calls for a new API.
>>>>> Along the lines of
>>>>>
>>>>>    struct page *alloc_page_range(gfp_t gfp, unsigned int min_order,
>>>>>                    unsigned int max_order, unsigned int *order)
>>>>>
>>>>> the idea would then be to return at a number of pages in the given
>>>>> range.
>>>>>
>>>>> What do you think? Want to try implementing that?
>>>>
>>>> You can just start with the highest order and decrement the order un=
til
>>>> your allocation succeeds using alloc_pages(), which would be enough =
for
>>>> a first version. At least I don't see the immediate need for a new
>>>> kernel API.
>>>
>>> OK I remember now.  The problem is with reclaim. Unless reclaim is
>>> completely disabled, any of these calls can sleep. After it wakes up,
>>> we would like to get the larger order that has become available
>>> meanwhile.
>>>
>>
>> Yes, but that=E2=80=98s a pure optimization IMHO.
>> So I think we should do a trivial implementation first and then see wh=
at we gain from a new allocator API. Then we might also be able to justif=
y it using real numbers.
>>
>=20
> Well how do you propose implement the necessary semantics?
> I think we are both agreed that alloc_page_range is more or
> less what's necessary anyway - so how would you approximate it
> on top of existing APIs?

Looking at drivers/misc/vmw_balloon.c:vmballoon_inflate(), it first
tries to allocate huge pages using

	alloc_pages(__GFP_HIGHMEM|__GFP_NOWARN| __GFP_NOMEMALLOC,=20
                    VMW_BALLOON_2M_ORDER)

And then falls back to 4k allocations (balloon_page_alloc()) in case
allocation fails.

I'm roughly thinking of something like the following, but with an
optimized reporting interface/bigger pfn array so we can report >
1MB at a time. Also, it might make sense to remember the order that
succeeded across some fill_balloon() calls.

Don't even expect it to compile ...



From 4305f989672ccca4be9293e6d4167e929f3e299b Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Tue, 31 Mar 2020 12:28:07 +0200
Subject: [PATCH RFC] tmp

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_balloon.c    | 38 ++++++++++++++++++--------
 include/linux/balloon_compaction.h |  7 ++++-
 mm/balloon_compaction.c            | 43 +++++++++++++++++++++++-------
 3 files changed, 67 insertions(+), 21 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ball=
oon.c
index 8511d258dbb4..0660b1b988f0 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -187,7 +187,7 @@ int virtballoon_free_page_report(struct page_reportin=
g_dev_info *pr_dev_info,
 }
=20
 static void set_page_pfns(struct virtio_balloon *vb,
-			  __virtio32 pfns[], struct page *page)
+			  __virtio32 pfns[], struct page *page, int order)
 {
 	unsigned int i;
=20
@@ -197,7 +197,7 @@ static void set_page_pfns(struct virtio_balloon *vb,
 	 * Set balloon pfns pointing at this page.
 	 * Note that the first pfn points at start of the page.
 	 */
-	for (i =3D 0; i < VIRTIO_BALLOON_PAGES_PER_PAGE; i++)
+	for (i =3D 0; i < VIRTIO_BALLOON_PAGES_PER_PAGE * (1 << order); i++)
 		pfns[i] =3D cpu_to_virtio32(vb->vdev,
 					  page_to_balloon_pfn(page) + i);
 }
@@ -205,6 +205,7 @@ static void set_page_pfns(struct virtio_balloon *vb,
 static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
 {
 	unsigned num_allocated_pages;
+	int order =3D MAX_ORDER - 1;
 	unsigned num_pfns;
 	struct page *page;
 	LIST_HEAD(pages);
@@ -212,9 +213,20 @@ static unsigned fill_balloon(struct virtio_balloon *=
vb, size_t num)
 	/* We can only do one array worth at a time. */
 	num =3D min(num, ARRAY_SIZE(vb->pfns));
=20
+	/*
+	 * Note: we will currently never allocate more than 1MB due to the
+	 * pfn array size, so we will not allocate MAX_ORDER - 1 ...
+	 */
+
 	for (num_pfns =3D 0; num_pfns < num;
-	     num_pfns +=3D VIRTIO_BALLOON_PAGES_PER_PAGE) {
-		struct page *page =3D balloon_page_alloc();
+	     num_pfns +=3D VIRTIO_BALLOON_PAGES_PER_PAGE * (1 << order)) {
+		const unsigned long remaining =3D num - num_pfns;
+
+		order =3D MIN(order,
+			    get_order(remaining << VIRTIO_BALLOON_PFN_SHIFT));
+		if ((1 << order) * VIRTIO_BALLOON_PAGES_PER_PAGE > remaining)
+			order--;
+		page =3D balloon_pages_alloc(order);
=20
 		if (!page) {
 			dev_info_ratelimited(&vb->vdev->dev,
@@ -225,6 +237,8 @@ static unsigned fill_balloon(struct virtio_balloon *v=
b, size_t num)
 			break;
 		}
=20
+		/* Continue with the actual order that succeeded. */
+		order =3D page_private(page);
 		balloon_page_push(&pages, page);
 	}
=20
@@ -233,14 +247,16 @@ static unsigned fill_balloon(struct virtio_balloon =
*vb, size_t num)
 	vb->num_pfns =3D 0;
=20
 	while ((page =3D balloon_page_pop(&pages))) {
+		order =3D page_order(page);
+		/* enqueuing will split the page and clear the order */
 		balloon_page_enqueue(&vb->vb_dev_info, page);
=20
-		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
-		vb->num_pages +=3D VIRTIO_BALLOON_PAGES_PER_PAGE;
+		set_page_pfns(vb, vb->pfns + vb->num_pfns, page, order);
+		vb->num_pages +=3D VIRTIO_BALLOON_PAGES_PER_PAGE * (1 << order);
 		if (!virtio_has_feature(vb->vdev,
 					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
-			adjust_managed_page_count(page, -1);
-		vb->num_pfns +=3D VIRTIO_BALLOON_PAGES_PER_PAGE;
+			adjust_managed_page_count(page, -1 * (1 << order));
+		vb->num_pfns +=3D VIRTIO_BALLOON_PAGES_PER_PAGE * (1 << order);
 	}
=20
 	num_allocated_pages =3D vb->num_pfns;
@@ -284,7 +300,7 @@ static unsigned leak_balloon(struct virtio_balloon *v=
b, size_t num)
 		page =3D balloon_page_dequeue(vb_dev_info);
 		if (!page)
 			break;
-		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
+		set_page_pfns(vb, vb->pfns + vb->num_pfns, page, 0);
 		list_add(&page->lru, &pages);
 		vb->num_pages -=3D VIRTIO_BALLOON_PAGES_PER_PAGE;
 	}
@@ -786,7 +802,7 @@ static int virtballoon_migratepage(struct balloon_dev=
_info *vb_dev_info,
 	__count_vm_event(BALLOON_MIGRATE);
 	spin_unlock_irqrestore(&vb_dev_info->pages_lock, flags);
 	vb->num_pfns =3D VIRTIO_BALLOON_PAGES_PER_PAGE;
-	set_page_pfns(vb, vb->pfns, newpage);
+	set_page_pfns(vb, vb->pfns, newpage, 0);
 	tell_host(vb, vb->inflate_vq);
=20
 	/* balloon's page migration 2nd step -- deflate "page" */
@@ -794,7 +810,7 @@ static int virtballoon_migratepage(struct balloon_dev=
_info *vb_dev_info,
 	balloon_page_delete(page);
 	spin_unlock_irqrestore(&vb_dev_info->pages_lock, flags);
 	vb->num_pfns =3D VIRTIO_BALLOON_PAGES_PER_PAGE;
-	set_page_pfns(vb, vb->pfns, page);
+	set_page_pfns(vb, vb->pfns, page, 0);
 	tell_host(vb, vb->deflate_vq);
=20
 	mutex_unlock(&vb->balloon_lock);
diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_c=
ompaction.h
index 338aa27e4773..ed93fe5704d1 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -60,7 +60,7 @@ struct balloon_dev_info {
 	struct inode *inode;
 };
=20
-extern struct page *balloon_page_alloc(void);
+extern struct page *balloon_pages_alloc(int order);
 extern void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
 				 struct page *page);
 extern struct page *balloon_page_dequeue(struct balloon_dev_info *b_dev_=
info);
@@ -78,6 +78,11 @@ static inline void balloon_devinfo_init(struct balloon=
_dev_info *balloon)
 	balloon->inode =3D NULL;
 }
=20
+static inline struct page *balloon_page_alloc(void)
+{
+	return balloon_pages_alloc(0);
+}
+
 #ifdef CONFIG_BALLOON_COMPACTION
 extern const struct address_space_operations balloon_aops;
 extern bool balloon_page_isolate(struct page *page,
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 26de020aae7b..067810b32813 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -112,23 +112,35 @@ size_t balloon_page_list_dequeue(struct balloon_dev=
_info *b_dev_info,
 EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
=20
 /*
- * balloon_page_alloc - allocates a new page for insertion into the ball=
oon
- *			page list.
+ * balloon_pages_alloc - allocates a new page (of at most the given orde=
r)
+ * 			 for insertion into the balloon page list.
  *
  * Driver must call this function to properly allocate a new balloon pag=
e.
  * Driver must call balloon_page_enqueue before definitively removing th=
e page
  * from the guest system.
  *
+ * Will fall back to smaller orders if allocation fails. The order of th=
e
+ * allocated page is stored in page->private.
+ *
  * Return: struct page for the allocated page or NULL on allocation fail=
ure.
  */
-struct page *balloon_page_alloc(void)
+struct page *balloon_pages_alloc(int order)
 {
-	struct page *page =3D alloc_page(balloon_mapping_gfp_mask() |
-				       __GFP_NOMEMALLOC | __GFP_NORETRY |
-				       __GFP_NOWARN);
-	return page;
+	struct page *page;
+
+	while (order >=3D 0) {
+		page =3D alloc_pages(balloon_mapping_gfp_mask() |
+				   __GFP_NOMEMALLOC | __GFP_NORETRY |
+				   __GFP_NOWARN, order);
+		if (page) {
+			set_page_private(page, order);
+			return page;
+		}
+		order--;
+	}
+	return NULL;
 }
-EXPORT_SYMBOL_GPL(balloon_page_alloc);
+EXPORT_SYMBOL_GPL(balloon_pages_alloc);
=20
 /*
  * balloon_page_enqueue - inserts a new page into the balloon page list.
@@ -146,10 +158,23 @@ EXPORT_SYMBOL_GPL(balloon_page_alloc);
 void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
 			  struct page *page)
 {
+	const int order =3D page_private(page);
 	unsigned long flags;
+	int i;
+
+	/*
+	 * We can only migrate single pages - and even if we could migrate
+	 * bigger ones, we would want to split them on demand instead of
+	 * trying to move around big chunks.
+	 */
+	if (order > 0)
+		split_page(page, order);
+	set_page_private(page, order);
=20
 	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
-	balloon_page_enqueue_one(b_dev_info, page);
+	for (i =3D 0; i < (1 << order); i++)
+		balloon_page_enqueue_one(b_dev_info, page + i);
+
 	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
 }
 EXPORT_SYMBOL_GPL(balloon_page_enqueue);
--=20
2.25.1

--=20
Thanks,

David / dhildenb
