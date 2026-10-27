Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793069818;
	b=RWw7tTyJqPa4Sq+zMCelTZQyReTKJtE/d8LngYpk5MwrIp2hmzJfhR2uRKUMOg7XV8MZ
	 VXXz9ZSoBN6c/TY3fxlHY/kWVpc93UhMDtaTY9gqE/EDx/xMjiHRfRguqoPOO1kANvjgC
	 B1AS6772Nx6/V1KVCRZGVFcZ2RPK0WoozyUAa/ZJuVYL1wcXs7bIfUdDfFKPWnlz+VhDP
	 bJ8Kxvy7mHrFO26YahSIeUXuIJ96jLKWleD01UZMs30CNVcTAgxlcPWOMnUA7Qy832Cqr
	 ESZnhHoV0vDWFOLu1+kFIsLj3YvovTjFXqnn5EEJ1UanpF1hJiJQ6AE2r76dcBbI/uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793069818;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=8uOyeoIi9QhKAYiQPs1BFfiuxWbIrsz7kuwNrIhzcWE=;
	b=LzmpUYhMFE/apbvtx9Yd1vJH+W1tgI3o5DcrZnNCozd0NvzJ0oRyQ4VVYUD2hhfgQ+Ei
	 lPT4NoYhQIbk4rXgD9uJpJDVOluTheMg/GWiJ2h2EthIYfmcUzd7ejEjAPQ2qSalITIxS
	 NlA+Q7JhNo+FN3leSOQ/SDPKzF9VGxpPd/V5J1LfsGBEc5don9OVS3hLLEizBf+4fHOtO
	 r8IsfsBrvbgvS339o1WhfAlXy1qnkpLvN5zdjHx6a3XMypfYGKfJrrIrOss0RtH7qbU3p
	 AnhIlzmIyZgScYx3osem9bt042Ashyj9/zxJQ1l2vA6fPXHLeXKRuOfNAnRoqXwTHcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Gl+wnZky;
	arc=none smtp.remote-ip=209.85.210.72
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFD260A262B
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 02:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BFD260A262B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Gl+wnZky
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-84fe2593525so5193704a34.3
        for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 19:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793069817; x=1793674617; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8uOyeoIi9QhKAYiQPs1BFfiuxWbIrsz7kuwNrIhzcWE=;
        b=Gl+wnZkyk6iDObmS99renPX7TDHFeHaDZjpF63H3Qq18z+qMIGNsGgWetPOgW7OT6c
         a00Sm8UpbcxJxqTLGxypc7imXNl1UpIJs0kqojVdY0yTcML1D4sYpATo1L2q5OKTjgRv
         FTVTgeoe6YgaOpNyk/kpQVEv3o2473nZWuBrP3UxjVzOO4JbHG/YUztB/803TPmqgfPe
         QpkFGWWy2BmzDoGu60Bh/riE/AhGrNGzzOrwHBvRTuNgjOt23ky9IhUEGssgCMlFXxZi
         OX6oyyU0PUegCSuukNkj4uKp9446cNu5R8VAfO8+73USDyEutanDP/MU/L7yTM9kQWsc
         UMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793069817; x=1793674617;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8uOyeoIi9QhKAYiQPs1BFfiuxWbIrsz7kuwNrIhzcWE=;
        b=guaF2lwfDx85hcH6mOQO9s0DZ6ErzPmzuJGXSaNESlZbh+mYI9ckH4Yi6biLQavxlr
         YLBdQm0nTBWv02NBoCuAuCORmCTUWDHMLoYf0s9rOj7B8ucq8fuqyUdwT3Q0OzR3wXGK
         /M7sxtF7ZMb8JYpMaKZZns4zW42LDuJo6fJJrrt1MeWcB8GF9rII2AWixZgUntisn69b
         +ZpxyxuCRn0HrcNCCywTJlZJXl8xVS83TdB6lVDDu8L+JTUNq6EnZO0eELm8jrcLiec4
         iFVrf2Bhuj20B0FFvaOQpPgwLUaGnlFo0nnmlVPiZ4Gy5nh1XBOze6uIPxc+dn3V7shi
         yHMA==
X-Gm-Message-State: AFq9FYLwOfBaeMUOkVyoBb3joGzBYfvrjbjBrNRLL8EQtr/B45D9ysut
	PtuPn6T62ZaJ9SzB+SDIkNoZK2hcIzgGdn3JiVFBOrJUaNVUxohbzEoJt4je16oBYpu6Y/3wsg4
	vAUVRXESPn2Nrack5Bsl/C0Q3KL6P/qdIlw==
X-Received: from iowl9.prod.google.com ([2002:a05:6602:2dc9:b0:9c7:5a74:531d])
 (user=kevinloughlin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:7094:20b0:6d7:aca3:bba9 with SMTP id 006d021491bc7-70ba0e5ee88mr3818249eaf.38.1793069816905;
 Mon, 26 Oct 2026 19:56:56 -0700 (PDT)
Date: Tue, 27 Oct 2026 02:56:13 +0000
In-Reply-To: <20261027025616.1632690-1-kevinloughlin@google.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261027025616.1632690-1-kevinloughlin@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027025616.1632690-11-kevinloughlin@google.com>
Subject: [PATCH 10/13] virtio_balloon: add higher-order page inflation
From: Kevin Loughlin <kevinloughlin@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@kernel.org>, Jason Wang <jasowangio@gmail.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Kiryl Shutsemau <kas@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Alexander Duyck <alexanderduyck@fb.com>
Cc: virtualization@lists.linux.dev, linux-coco@lists.linux.dev, 
	linux-efi@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Sidharth Telang <sidtelang@google.com>, Punit Salian <psalian@google.com>, 
	Peter Gonda <pgonda@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	Jacky Li <jackyli@google.com>, Steve Rutherford <srutherford@google.com>, 
	David Skidmore <davidskidmore@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

In confidential computing guests requiring page state transitions,
unaccepted memory tracking operates at the EFI unaccepted memory unit
granularity (typically 2MB / order 9 on x86). Inflating the balloon
with 4KB pages would prevent unaccepting the backing 2MB unit.

Inflate balloon pages at unaccepted_memory_order() when
virtballoon_cc_needs_state_transition() is true, while retaining
order-0 allocations for non-CoCo guests and CoCo guests that do not
use unaccepted memory transitions. When a higher-order balloon page
spans more 4KB balloon PFNs than VIRTIO_BALLOON_ARRAY_PFNS_MAX (256),
transmit its PFNs to the host in VIRTIO_BALLOON_ARRAY_PFNS_MAX chunks.

Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
---
 drivers/virtio/virtio_balloon.c | 87 ++++++++++++++++++++++++++-------
 include/linux/balloon.h         |  1 +
 mm/balloon.c                    | 67 +++++++++++++++++++------
 3 files changed, 121 insertions(+), 34 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 11f74848fdc4..d162c162b496 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -182,6 +182,13 @@ static void balloon_ack(struct virtqueue *vq)
 	wake_up(&vb->acked);
 }
 
+static inline bool virtballoon_cc_needs_state_transition(void)
+{
+	return IS_ENABLED(CONFIG_UNACCEPTED_MEMORY) &&
+	       cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
+	       has_unaccepted_memory();
+}
+
 static void tell_host(struct virtio_balloon *vb, struct virtqueue *vq)
 {
 	struct scatterlist sg;
@@ -243,24 +250,49 @@ static void set_page_pfns(struct virtio_balloon *vb,
 					  page_to_balloon_pfn(page) + i);
 }
 
+static void queue_page_pfns(struct virtio_balloon *vb, struct virtqueue *vq,
+			    struct page *page, unsigned int order)
+{
+	unsigned int nr_pages = 1 << order;
+	unsigned int i;
+
+	for (i = 0; i < nr_pages; i++) {
+		set_page_pfns(vb, vb->pfns + vb->num_pfns, page + i);
+		vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE;
+		if (vb->num_pfns == ARRAY_SIZE(vb->pfns)) {
+			tell_host(vb, vq);
+			vb->num_pfns = 0;
+		}
+	}
+}
+
+static inline unsigned int virtballoon_preferred_order(void)
+{
+	if (virtballoon_cc_needs_state_transition())
+		return unaccepted_memory_order();
+	return 0;
+}
+
 static unsigned int fill_balloon(struct virtio_balloon *vb, size_t num)
 {
-	unsigned int num_allocated_pages;
+	unsigned int order = virtballoon_preferred_order();
+	unsigned int page_pfns = (1 << order) * VIRTIO_BALLOON_PAGES_PER_PAGE;
+	unsigned int num_allocated_pages = 0;
 	struct page *page, *next;
 	unsigned int num_pfns;
 	LIST_HEAD(pages);
 
-	/* We can only do one array worth at a time. */
-	num = min(num, ARRAY_SIZE(vb->pfns));
+	/* We can only do one array or preferred-order page worth at a time. */
+	num = min(num, max_t(size_t, ARRAY_SIZE(vb->pfns), page_pfns));
 
 	for (num_pfns = 0; num_pfns < num;
-	     num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE) {
-		page = balloon_page_alloc();
+	     num_pfns += page_pfns) {
+		page = balloon_pages_alloc(order);
 
 		if (!page) {
 			dev_info_ratelimited(&vb->vdev->dev,
 					     "Out of puff! Can't get %u pages\n",
-					     VIRTIO_BALLOON_PAGES_PER_PAGE);
+					     page_pfns);
 			/* Sleep for at least 1/5 of a second before retry. */
 			msleep(200);
 			break;
@@ -274,15 +306,17 @@ static unsigned int fill_balloon(struct virtio_balloon *vb, size_t num)
 	vb->num_pfns = 0;
 
 	list_for_each_entry_safe(page, next, &pages, lru) {
+		unsigned int page_order = compound_order(page);
+		unsigned int pfns = (1 << page_order) * VIRTIO_BALLOON_PAGES_PER_PAGE;
+
 		list_del(&page->lru);
 		balloon_page_enqueue(&vb->vb_dev_info, page);
 
-		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
-		vb->num_pages += VIRTIO_BALLOON_PAGES_PER_PAGE;
-		vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE;
+		vb->num_pages += pfns;
+		num_allocated_pages += pfns;
+		queue_page_pfns(vb, vb->inflate_vq, page, page_order);
 	}
 
-	num_allocated_pages = vb->num_pfns;
 	/* Did we get any? */
 	if (vb->num_pfns != 0)
 		tell_host(vb, vb->inflate_vq);
@@ -304,28 +338,42 @@ static void release_pages_balloon(struct virtio_balloon *vb,
 
 static unsigned int leak_balloon(struct virtio_balloon *vb, size_t num)
 {
-	unsigned int num_freed_pages;
+	unsigned int order = virtballoon_preferred_order();
+	unsigned int page_pfns = (1 << order) * VIRTIO_BALLOON_PAGES_PER_PAGE;
+	unsigned int num_freed_pages = 0;
 	struct page *page;
 	struct balloon_dev_info *vb_dev_info = &vb->vb_dev_info;
 	LIST_HEAD(pages);
 
-	/* We can only do one array worth at a time. */
-	num = min(num, ARRAY_SIZE(vb->pfns));
+	/* We can only do one array or preferred-order page worth at a time. */
+	num = min(num, max_t(size_t, ARRAY_SIZE(vb->pfns), page_pfns));
 
 	mutex_lock(&vb->balloon_lock);
 	/* We can't release more pages than taken */
 	num = min(num, (size_t)vb->num_pages);
-	for (vb->num_pfns = 0; vb->num_pfns < num;
-	     vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE) {
+	vb->num_pfns = 0;
+	while (num_freed_pages < num) {
+		unsigned int dequeued_order;
+		unsigned int dequeued_pfns;
+
 		page = balloon_page_dequeue(vb_dev_info);
 		if (!page)
 			break;
-		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
+		dequeued_order = compound_order(page);
+		dequeued_pfns = (1 << dequeued_order) * VIRTIO_BALLOON_PAGES_PER_PAGE;
+
+		if (num_freed_pages + dequeued_pfns > num &&
+		    num_freed_pages > 0) {
+			balloon_page_enqueue(vb_dev_info, page);
+			break;
+		}
+
+		queue_page_pfns(vb, vb->deflate_vq, page, dequeued_order);
 		list_add(&page->lru, &pages);
-		vb->num_pages -= VIRTIO_BALLOON_PAGES_PER_PAGE;
+		vb->num_pages -= dequeued_pfns;
+		num_freed_pages += dequeued_pfns;
 	}
 
-	num_freed_pages = vb->num_pfns;
 	/*
 	 * Note that if
 	 * virtio_has_feature(vdev, VIRTIO_BALLOON_F_MUST_TELL_HOST);
@@ -474,7 +522,8 @@ static inline s64 towards_target(struct virtio_balloon *vb)
 	 * Aligned up to guest page size to avoid inflating and deflating
 	 * balloon endlessly.
 	 */
-	target = ALIGN(num_pages, VIRTIO_BALLOON_PAGES_PER_PAGE);
+	target = ALIGN((s64)num_pages,
+		       VIRTIO_BALLOON_PAGES_PER_PAGE << virtballoon_preferred_order());
 	return target - vb->num_pages;
 }
 
diff --git a/include/linux/balloon.h b/include/linux/balloon.h
index ca5b15150f42..bc46e36b997f 100644
--- a/include/linux/balloon.h
+++ b/include/linux/balloon.h
@@ -58,6 +58,7 @@ struct balloon_dev_info {
 	bool adjust_managed_page_count;
 };
 
+struct page *balloon_pages_alloc(unsigned int order);
 struct page *balloon_page_alloc(void);
 void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
 		struct page *page);
diff --git a/mm/balloon.c b/mm/balloon.c
index 96a8f1e20bc6..e9941d08d8e9 100644
--- a/mm/balloon.c
+++ b/mm/balloon.c
@@ -27,9 +27,12 @@ static DEFINE_SPINLOCK(balloon_pages_lock);
 static void balloon_page_insert(struct balloon_dev_info *balloon,
 				       struct page *page)
 {
+	unsigned int i, nr_pages = 1U << compound_order(page);
+
 	lockdep_assert_held(&balloon_pages_lock);
-	__SetPageOffline(page);
-	if (IS_ENABLED(CONFIG_BALLOON_MIGRATION)) {
+	for (i = 0; i < nr_pages; i++)
+		__SetPageOffline(page + i);
+	if (IS_ENABLED(CONFIG_BALLOON_MIGRATION) && !PageCompound(page)) {
 		SetPageMovableOps(page);
 		set_page_private(page, (unsigned long)balloon);
 	}
@@ -45,20 +48,31 @@ static void balloon_page_insert(struct balloon_dev_info *balloon,
  */
 static void balloon_page_finalize(struct page *page)
 {
+	unsigned int i, nr_pages = 1U << compound_order(page);
+
 	lockdep_assert_held(&balloon_pages_lock);
-	if (IS_ENABLED(CONFIG_BALLOON_MIGRATION))
+	if (IS_ENABLED(CONFIG_BALLOON_MIGRATION) && !PageCompound(page))
 		set_page_private(page, 0);
-	/* PageOffline is sticky until the page is freed to the buddy. */
+	/*
+	 * PageOffline is sticky on the head page until freed to the buddy,
+	 * which resets the head page's page_type in __free_pages_prepare().
+	 * Clear PageOffline on tail pages here as __free_pages_prepare()
+	 * expects tail pages to have a default page_type.
+	 */
+	for (i = 1; i < nr_pages; i++)
+		__ClearPageOffline(page + i);
 }
 
 static void balloon_page_enqueue_one(struct balloon_dev_info *b_dev_info,
 				     struct page *page)
 {
+	unsigned int order = compound_order(page);
+
 	balloon_page_insert(b_dev_info, page);
 	if (b_dev_info->adjust_managed_page_count)
-		adjust_managed_page_count(page, -1);
-	__count_vm_event(BALLOON_INFLATE);
-	inc_node_page_state(page, NR_BALLOON_PAGES);
+		adjust_managed_page_count(page, -(1L << order));
+	__count_vm_events(BALLOON_INFLATE, 1UL << order);
+	mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES, 1L << order);
 }
 
 /**
@@ -117,15 +131,18 @@ size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
 
 	spin_lock_irqsave(&balloon_pages_lock, flags);
 	list_for_each_entry_safe(page, tmp, &b_dev_info->pages, lru) {
+		unsigned int order = compound_order(page);
+
 		if (n_pages == n_req_pages)
 			break;
 		list_del(&page->lru);
 		if (b_dev_info->adjust_managed_page_count)
-			adjust_managed_page_count(page, 1);
+			adjust_managed_page_count(page, 1L << order);
 		balloon_page_finalize(page);
-		__count_vm_event(BALLOON_DEFLATE);
+		__count_vm_events(BALLOON_DEFLATE, 1UL << order);
 		list_add(&page->lru, pages);
-		dec_node_page_state(page, NR_BALLOON_PAGES);
+		mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES,
+				    -(1L << order));
 		n_pages++;
 	}
 	spin_unlock_irqrestore(&balloon_pages_lock, flags);
@@ -135,8 +152,9 @@ size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
 EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
 
 /**
- * balloon_page_alloc - allocates a new page for insertion into the balloon
- *			page list.
+ * balloon_pages_alloc - allocates a new page of given order for insertion
+ *			 into the balloon page list.
+ * @order: allocation order
  *
  * Driver must call this function to properly allocate a new balloon page.
  * Driver must call balloon_page_enqueue before definitively removing the page
@@ -144,16 +162,35 @@ EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
  *
  * Return: struct page for the allocated page or NULL on allocation failure.
  */
-struct page *balloon_page_alloc(void)
+struct page *balloon_pages_alloc(unsigned int order)
 {
 	gfp_t gfp_flags = __GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
 
-	if (IS_ENABLED(CONFIG_BALLOON_MIGRATION))
+	if (IS_ENABLED(CONFIG_BALLOON_MIGRATION) && !order)
 		gfp_flags |= GFP_HIGHUSER_MOVABLE;
 	else
 		gfp_flags |= GFP_HIGHUSER;
 
-	return alloc_page(gfp_flags);
+	if (order > 0)
+		gfp_flags |= __GFP_COMP;
+
+	return alloc_pages(gfp_flags, order);
+}
+EXPORT_SYMBOL_GPL(balloon_pages_alloc);
+
+/**
+ * balloon_page_alloc - allocates a new page for insertion into the balloon
+ *			page list.
+ *
+ * Driver must call this function to properly allocate a new balloon page.
+ * Driver must call balloon_page_enqueue before definitively removing the page
+ * from the guest system.
+ *
+ * Return: struct page for the allocated page or NULL on allocation failure.
+ */
+struct page *balloon_page_alloc(void)
+{
+	return balloon_pages_alloc(0);
 }
 EXPORT_SYMBOL_GPL(balloon_page_alloc);
 
-- 
2.56.0.307.g5fe7bd680c-goog

