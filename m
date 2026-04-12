Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690503264F7
	for <virtualization@lists.linux.dev>; Sun, 12 Apr 2026 22:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776034251; cv=none; b=N9WIyrvIZIAJMKwrk5pwn7CUem6H7giXuR8UlU4QYb9NGssCsoKAmhD+/fiB2LZzFhHW+u9JCm7egpqO2sriCSElSLD4fYhFjJvJqv8d9yw2kdeWkXfi5W0rdJUpkpyEI6uyXE54sXj2msMmXCZMlETS7hJP2lPv2BWykhq0O6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776034251; c=relaxed/simple;
	bh=Yc6J0CiR6gIkKdBB1+3J2Bp7hvOLmDRVaaqOrMBw7Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KsZn137Qsf5CboJ+/OvvJEZ7ZtNE1+v8r858FmRuZjpxFi0i91mCwNECWng59i975UlejajRtxi8ZIGsZix8uvkcaIgSRnw1PSYfT9n/zdluenOvhVTIhjD4WVO+yZFXf0NGdKPPrSgqmKPzuZmG/Be1nJdGeo7HxLwE0VOhV8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RFXw6+gW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RFXw6+gW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776034249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p7fwwS8rthQO9vLHBO8UifZIVV+lw2sOdmaFyBVbO1I=;
	b=RFXw6+gW2/UEZ79RTTX/u/TocYcFq6hgY34FyBFmmIq3IOjSVabClvoG57n1ZzDaoj4mzb
	d1963k815qyrVdcdU1Lur7ROAn17QetxVDZ1PAHY2707KN/uNGxJfL6Xfc0ctxDHRSKTcu
	q3pDpt0FVijYt1mNeYQrZzmi9580M54=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-U4pcx66gOeyWb4dU2NI9Jw-1; Sun, 12 Apr 2026 18:50:48 -0400
X-MC-Unique: U4pcx66gOeyWb4dU2NI9Jw-1
X-Mimecast-MFC-AGG-ID: U4pcx66gOeyWb4dU2NI9Jw_1776034247
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d03065782so2219015f8f.0
        for <virtualization@lists.linux.dev>; Sun, 12 Apr 2026 15:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776034247; x=1776639047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7fwwS8rthQO9vLHBO8UifZIVV+lw2sOdmaFyBVbO1I=;
        b=Xo6WIty1YpZyObc5lzX7NryNj1pE6TcHU7zTlZ2qyYIas7D59NLDSkE9JdkKoazDz5
         zQ2Jvok2C1QNknzKcjZiFwrLJatvXkKKzd0vAVrR2n/xUs0bJ8j21o6IQbRJE6t0/Qsb
         0CGsFbLcGVusjyPuyX5EtNmYlNRoSTGk7f0vjROKz9KqUcu3L2RoKdEHTFfn2r/dbsyo
         hjyPzNnTWTJsIiZgYQNFjVOiyvau/R3qcWPJl1JnFTag+BWxCizcFYVs8fva8w8++kKj
         30/I0RYIsLDjfLvpD8iAjO+rDk2FQ9RrFf8b61OifV68/19OiyrrMj3aSLHaPmKTtk6h
         zBZw==
X-Forwarded-Encrypted: i=1; AFNElJ+qphMUUYPiW5rPd1FbJX7r7ecV/1v+PcvVzjgPrDHBzvtaABW/WSAYBXNSSqH9GPr4mGy8qhBS0uoiTGYlrw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwCq2NxhMxj+XOHJFHWIOgdR/lFmpkkOnYvU98Hag/Vaqn6kIZe
	IZbU1hp1QNNl2PyfEZjRjeowltpNitRRvYNDHUkQ2q3Q9T07ZlDfF/St2gXCmOJVhiHp0gAHreN
	mQaS6Lz6cLNXE5TwnXYwMj+PTCzKOdChw0U5ApeBIXuxqzWUc6uoLvdnJYiqh4OABJ/fE
X-Gm-Gg: AeBDiesuGqVdYorhPsZJk2aopucY+wubwbh2AnrlCdfjG61GI+rTPX5aC04cCEgWFhJ
	WWCmufy8eQzBtckoXCaDYuACVjocE8xVvHJn992UEV6fi0MTh5Tp2beUzEnXFHFE79c5PgdO/Sg
	HFCSWZBBCJaNUCFICRcQIDh+PJJFaTE1dUg/3mBYW8BFap9vvxupzDLsS9pq1kRo0k90sXg9fjj
	YA7svyShG4+fX0g295tlBQTejn5XTVJOfWTflFCyycVR9nTDLIEFPWTQB8Q05PJ9pK/1afzVbdO
	kgaT6jUhbJ4ADgkFZpbF0QZjypINtKBqxMTK7+71okrv1axoy9072ozuO1waN5g0VeRQEa60h6P
	Gtr05jtpt816v6gcUyiAFdkbxeAG7sX+sNyTrcxS/NLM=
X-Received: by 2002:a05:6000:2f88:b0:43d:71f4:7ed5 with SMTP id ffacd0b85a97d-43d71f480a8mr5521363f8f.17.1776034246828;
        Sun, 12 Apr 2026 15:50:46 -0700 (PDT)
X-Received: by 2002:a05:6000:2f88:b0:43d:71f4:7ed5 with SMTP id ffacd0b85a97d-43d71f480a8mr5521336f8f.17.1776034246368;
        Sun, 12 Apr 2026 15:50:46 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e50200sm27750304f8f.29.2026.04.12.15.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 15:50:45 -0700 (PDT)
Date: Sun, 12 Apr 2026 18:50:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC 2/9] mm: page_reporting: skip redundant zeroing of
 host-zeroed reported pages
Message-ID: <ea67e39bc3aea1b0b491908f851ffce25154cd26.1776033771.git.mst@redhat.com>
References: <cover.1776033471.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1776033471.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ftpISpgS6sbxqmADkIRn9rAS9cBiWjYcwbEZYlzx9Y0_1776034247
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When a guest reports free pages to the hypervisor via the page reporting
framework (used by virtio-balloon and hv_balloon), the host typically
zeros those pages when reclaiming their backing memory.  However, when
those pages are later allocated in the guest, post_alloc_hook()
unconditionally zeros them again if __GFP_ZERO is set.  This
double-zeroing is wasteful, especially for large pages.

Avoid redundant zeroing by propagating the "host already zeroed this"
information through the allocation path:

1. Add a host_zeroes_pages flag to page_reporting_dev_info, allowing
   drivers to declare that their host zeros reported pages on reclaim.
   A static key (page_reporting_host_zeroes) gates the fast path.

2. In page_del_and_expand(), when the page was reported and the
   static key is enabled, stash a sentinel value (MAGIC_PAGE_ZEROED)
   in page->private.

3. In post_alloc_hook(), check page->private for the sentinel.  If
   present and zeroing was requested (but not tag zeroing), skip
   kernel_init_pages().

In particular, __GFP_ZERO is used by the x86 arch override of
vma_alloc_zeroed_movable_folio.

No driver sets host_zeroes_pages yet; a follow-up patch to
virtio_balloon is needed to opt in.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 include/linux/mm.h             |  6 ++++++
 include/linux/page_reporting.h |  3 +++
 mm/page_alloc.c                | 21 +++++++++++++++++++++
 mm/page_reporting.c            |  9 +++++++++
 mm/page_reporting.h            |  2 ++
 5 files changed, 41 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5be3d8a8f806..59fc77c4c90e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4814,6 +4814,12 @@ static inline bool user_alloc_needs_zeroing(void)
 				   &init_on_alloc);
 }
 
+/*
+ * Sentinel stored in page->private to indicate the page was pre-zeroed
+ * by the hypervisor (via free page reporting).
+ */
+#define MAGIC_PAGE_ZEROED	0x5A45524FU	/* ZERO */
+
 int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *status);
 int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status);
 int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
index fe648dfa3a7c..10faadfeb4fb 100644
--- a/include/linux/page_reporting.h
+++ b/include/linux/page_reporting.h
@@ -13,6 +13,9 @@ struct page_reporting_dev_info {
 	int (*report)(struct page_reporting_dev_info *prdev,
 		      struct scatterlist *sg, unsigned int nents);
 
+	/* If true, host zeros reported pages on reclaim */
+	bool host_zeroes_pages;
+
 	/* work struct for processing reports */
 	struct delayed_work work;
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index edbb1edf463d..efb65eee826b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1774,8 +1774,20 @@ static __always_inline void page_del_and_expand(struct zone *zone,
 	bool was_reported = page_reported(page);
 
 	__del_page_from_free_list(page, zone, high, migratetype);
+
+	was_reported = was_reported &&
+		       static_branch_unlikely(&page_reporting_host_zeroes);
+
 	nr_pages -= expand(zone, page, low, high, migratetype, was_reported);
 	account_freepages(zone, -nr_pages, migratetype);
+
+	/*
+	 * If the page was reported and the host is known to zero reported
+	 * pages, mark it zeroed via page->private so that
+	 * post_alloc_hook() can skip redundant zeroing.
+	 */
+	if (was_reported)
+		set_page_private(page, MAGIC_PAGE_ZEROED);
 }
 
 static void check_new_page_bad(struct page *page)
@@ -1851,11 +1863,20 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 {
 	bool init = !want_init_on_free() && want_init_on_alloc(gfp_flags) &&
 			!should_skip_init(gfp_flags);
+	bool prezeroed = page_private(page) == MAGIC_PAGE_ZEROED;
 	bool zero_tags = init && (gfp_flags & __GFP_ZEROTAGS);
 	int i;
 
 	set_page_private(page, 0);
 
+	/*
+	 * If the page is pre-zeroed, skip memory initialization.
+	 * We still need to handle tag zeroing separately since the host
+	 * does not know about memory tags.
+	 */
+	if (prezeroed && init && !zero_tags)
+		init = false;
+
 	arch_alloc_page(page, order);
 	debug_pagealloc_map_pages(page, 1 << order);
 
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index f0042d5743af..cb24832bdf4e 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -50,6 +50,8 @@ EXPORT_SYMBOL_GPL(page_reporting_order);
 #define PAGE_REPORTING_DELAY	(2 * HZ)
 static struct page_reporting_dev_info __rcu *pr_dev_info __read_mostly;
 
+DEFINE_STATIC_KEY_FALSE(page_reporting_host_zeroes);
+
 enum {
 	PAGE_REPORTING_IDLE = 0,
 	PAGE_REPORTING_REQUESTED,
@@ -386,6 +388,10 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
 	/* Assign device to allow notifications */
 	rcu_assign_pointer(pr_dev_info, prdev);
 
+	/* enable zeroed page optimization if host zeroes reported pages */
+	if (prdev->host_zeroes_pages)
+		static_branch_enable(&page_reporting_host_zeroes);
+
 	/* enable page reporting notification */
 	if (!static_key_enabled(&page_reporting_enabled)) {
 		static_branch_enable(&page_reporting_enabled);
@@ -410,6 +416,9 @@ void page_reporting_unregister(struct page_reporting_dev_info *prdev)
 
 		/* Flush any existing work, and lock it out */
 		cancel_delayed_work_sync(&prdev->work);
+
+		if (prdev->host_zeroes_pages)
+			static_branch_disable(&page_reporting_host_zeroes);
 	}
 
 	mutex_unlock(&page_reporting_mutex);
diff --git a/mm/page_reporting.h b/mm/page_reporting.h
index c51dbc228b94..2bbf99f456f5 100644
--- a/mm/page_reporting.h
+++ b/mm/page_reporting.h
@@ -15,6 +15,8 @@ DECLARE_STATIC_KEY_FALSE(page_reporting_enabled);
 extern unsigned int page_reporting_order;
 void __page_reporting_notify(void);
 
+DECLARE_STATIC_KEY_FALSE(page_reporting_host_zeroes);
+
 static inline bool page_reported(struct page *page)
 {
 	return static_branch_unlikely(&page_reporting_enabled) &&
-- 
MST

