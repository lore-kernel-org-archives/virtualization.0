Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C923B0AF3
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907719; cv=none; b=Tvh0FCsDK/KKj38DRkAyh7G8MYBLtQBgbbmr3xL8Y1e5xU+gVWbliPyo03cr65yFE43v5oor+SIDbgc6aKXdgy8YTTbA/5ssiGYrioyx9Jst+F3nEeJ9JWDYdwhhhVGb9pfmusvgPkUnxXP4BMkEV5/u6QH5qygNB5EHFiZBP5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907719; c=relaxed/simple;
	bh=VM/bNOZTb0RCzRWmIDoLOJCCyLB90lnxDaW3yIFW1Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Lvgwc03ZtZUFUllLtRC5GLoYMydQxkcUmhPUWK+vQYyVCzFYk3F8oz0Av3o5OKvgxX1BlAGp24009lMlP1dCV8YEDT+e2E1uJISlXsKzATDCdWhdQSaGnlV6pq7Yt6I7pBa//HxP39rARlniKBiiErwRYo01x/QT1Fkv/xJCguQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W1VsTXPE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W1VsTXPE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780907707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/LdI09yfbzRCb1twey6OkL3QcRw2oFWT9IrdWUT5qiU=;
	b=W1VsTXPEEKT0U75GU1KVt+Rl7lILna+vX11Bw621V38E1BcGyy0uEm1RGwiiU10UqGj7B/
	CMEesvIyO9MmdpEHhuyePcZeZYT/WPwxZwYh7H4ihQsWK51CHVCiFjIZvI5IQ+XyB1SJuX
	/VCqxUcewkGNZ0dnJQc7FPw06ZG4ZlI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-NY8F7ZsxOZ2yoPUnmLIa7w-1; Mon, 08 Jun 2026 04:34:59 -0400
X-MC-Unique: NY8F7ZsxOZ2yoPUnmLIa7w-1
X-Mimecast-MFC-AGG-ID: NY8F7ZsxOZ2yoPUnmLIa7w_1780907698
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45efa2f7009so2516549f8f.3
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 01:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780907698; x=1781512498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LdI09yfbzRCb1twey6OkL3QcRw2oFWT9IrdWUT5qiU=;
        b=ZXHAZ0CUBUFN+vFqindWTxOsolWYUduDXYUuxQOek5LeQBsYpZ+nv/KSaP3AR2QJw3
         7waLzjYyrD1gIuSwT1trBk0mgsQ1/KhQYI8Kn8A6QueUHAG6F+vBd8//CLSaABWWmdnA
         QEfbSiqGyeFSJHtVsmsJs9BeVus6Dh3rbNhiPMKB5o1E6tKtbKuQ0EinYwkmSkWpE0pp
         ytCg9F17aOk+zR5beNJoepSZJG18rzArETsLZHQmRDVrlqkbq4JRVhQi4/hzQ2w+ccuV
         XDTJ35E1PGLS7we4596CzVpks3zxPJAW6kVidYj1aBt1yW/wUfatwwotw6Tv/B5NUK0j
         uErA==
X-Forwarded-Encrypted: i=1; AFNElJ/DT9He8r/6PEC0X6uBBrHTLhVdGYWUPE4ssnRDouiZh3ChFrO+Eg/AkJTNYGMdoDtG+7bWuf8yb5FBrnN1ZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwnHnHUcl2WvojhZJLxioHNmLLO5nFXDKwBuV/yAUiUy1yB0iFD
	k+402n3jARubN5KHpFNh7YQ7r+BhNfcjS64WE/4QaMG2SkHThWAx1o7x3qCYVACf+i0aTX6JQGn
	zVfTDotNNcrWGmg3kv1v3phb4Nw3SQ0sPtOLFv0Y2FytL1tYFTBd0b6ZYg791hKr9kxwr
X-Gm-Gg: Acq92OEtUKn9t4HAjWN/WNVWM/D7OVEJ/SDjbDM0EWZvUa9ANC0SxQFx74T0r2iUbfN
	RgBUMHzXEwjBrP++OlZc0iMaZAU/g/EhOx/i7mJEk1weNOObuUvB7rRccdCdt+8KrDiu6Re1mRc
	ofpwOtQBop9nFxkDBymVSHTM5JY/cwipVizQoYgKFXN1hSZ0zHb7ynob0yKIVjXhBCkfJXi+ZMP
	m1g6fRk7pJ0qB8l+jD63eAOyNHq1kNMqA4qh+C5DYOyxrmWxg6FFXVmkK2uEcANkXOQ6vAIx7dZ
	d0ZJr7NcJl70KS9YqxEzXzvW45TYyM+ZIXP49HpcslsEOyFBx5e728KOKAWggLiwqnhhc1e/beb
	lPFaVzBKrgcHVqr17Yeno2R0=
X-Received: by 2002:a5d:660c:0:b0:460:1695:89be with SMTP id ffacd0b85a97d-460302f1a80mr16882944f8f.17.1780907698162;
        Mon, 08 Jun 2026 01:34:58 -0700 (PDT)
X-Received: by 2002:a5d:660c:0:b0:460:1695:89be with SMTP id ffacd0b85a97d-460302f1a80mr16882899f8f.17.1780907697659;
        Mon, 08 Jun 2026 01:34:57 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcae2sm53186372f8f.6.2026.06.08.01.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:34:57 -0700 (PDT)
Date: Mon, 8 Jun 2026 04:34:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	virtualization@lists.linux.dev, linux-mm@kvack.org,
	Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v10 04/37] mm: page_reporting: allow driver to set batch
 capacity
Message-ID: <776d350bffd86c5776485ffc4f24e668df36367e.1780906288.git.mst@redhat.com>
References: <cover.1780906288.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1780906288.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2cUhOSLRePdQBJQWVT5CC1pFsrCyYYvaaBnONSz5fZo_1780907698
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add a capacity field to page_reporting_dev_info so drivers can
control the maximum number of pages per report batch. This is
useful when the driver needs to reserve virtqueue descriptors for
metadata (e.g., a bitmap buffer) alongside the page buffers.

The value is capped at PAGE_REPORTING_CAPACITY.
If unset (0), defaults to PAGE_REPORTING_CAPACITY.

The virtio_balloon driver sets capacity to the reporting virtqueue
size, letting page_reporting adapt to whatever the device provides.

Note: capacity need not be a power of 2. The DIV_ROUND_UP
in page_reporting_cycle() uses integer division, which the
compiler handles efficiently. Rounding would halve the batch
size for non-power-of-2 virtqueue sizes, wasting capacity.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 drivers/virtio/virtio_balloon.c |  5 +----
 include/linux/page_reporting.h  |  3 +++
 mm/page_reporting.c             | 25 ++++++++++++++-----------
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index f6c2dff33f8a..6a1a610c2cb1 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -1017,10 +1017,6 @@ static int virtballoon_probe(struct virtio_device *vdev)
 		unsigned int capacity;
 
 		capacity = virtqueue_get_vring_size(vb->reporting_vq);
-		if (capacity < PAGE_REPORTING_CAPACITY) {
-			err = -ENOSPC;
-			goto out_unregister_oom;
-		}
 
 		vb->pr_dev_info.order = PAGE_REPORTING_ORDER_UNSPECIFIED;
 
@@ -1041,6 +1037,7 @@ static int virtballoon_probe(struct virtio_device *vdev)
 		vb->pr_dev_info.order = 5;
 #endif
 
+		vb->pr_dev_info.capacity = capacity;
 		err = page_reporting_register(&vb->pr_dev_info);
 		if (err)
 			goto out_unregister_oom;
diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
index 9d4ca5c218a0..5ab5be02fa15 100644
--- a/include/linux/page_reporting.h
+++ b/include/linux/page_reporting.h
@@ -22,6 +22,9 @@ struct page_reporting_dev_info {
 
 	/* Minimal order of page reporting */
 	unsigned int order;
+
+	/* Max pages per report batch (default PAGE_REPORTING_CAPACITY) */
+	unsigned int capacity;
 };
 
 /* Tear-down and bring-up for page reporting devices */
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 7418f2e500bb..5b6b17f67131 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -174,10 +174,10 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 	 * list processed. This should result in us reporting all pages on
 	 * an idle system in about 30 seconds.
 	 *
-	 * The division here should be cheap since PAGE_REPORTING_CAPACITY
-	 * should always be a power of 2.
+	 * The division here uses integer division; capacity need
+	 * not be a power of 2.
 	 */
-	budget = DIV_ROUND_UP(area->nr_free, PAGE_REPORTING_CAPACITY * 16);
+	budget = DIV_ROUND_UP(area->nr_free, prdev->capacity * 16);
 
 	/* loop through free list adding unreported pages to sg list */
 	list_for_each_entry_safe(page, next, list, lru) {
@@ -222,10 +222,10 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 		spin_unlock_irq(&zone->lock);
 
 		/* begin processing pages in local list */
-		err = prdev->report(prdev, sgl, PAGE_REPORTING_CAPACITY);
+		err = prdev->report(prdev, sgl, prdev->capacity);
 
 		/* reset offset since the full list was reported */
-		*offset = PAGE_REPORTING_CAPACITY;
+		*offset = prdev->capacity;
 
 		/* update budget to reflect call to report function */
 		budget--;
@@ -234,7 +234,7 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 		spin_lock_irq(&zone->lock);
 
 		/* flush reported pages from the sg list */
-		page_reporting_drain(prdev, sgl, PAGE_REPORTING_CAPACITY, !err);
+		page_reporting_drain(prdev, sgl, prdev->capacity, !err);
 
 		/*
 		 * Reset next to first entry, the old next isn't valid
@@ -260,13 +260,13 @@ static int
 page_reporting_process_zone(struct page_reporting_dev_info *prdev,
 			    struct scatterlist *sgl, struct zone *zone)
 {
-	unsigned int order, mt, leftover, offset = PAGE_REPORTING_CAPACITY;
+	unsigned int order, mt, leftover, offset = prdev->capacity;
 	unsigned long watermark;
 	int err = 0;
 
 	/* Generate minimum watermark to be able to guarantee progress */
 	watermark = low_wmark_pages(zone) +
-		    (PAGE_REPORTING_CAPACITY << page_reporting_order);
+		    (prdev->capacity << page_reporting_order);
 
 	/*
 	 * Cancel request if insufficient free memory or if we failed
@@ -290,7 +290,7 @@ page_reporting_process_zone(struct page_reporting_dev_info *prdev,
 	}
 
 	/* report the leftover pages before going idle */
-	leftover = PAGE_REPORTING_CAPACITY - offset;
+	leftover = prdev->capacity - offset;
 	if (leftover) {
 		sgl = &sgl[offset];
 		err = prdev->report(prdev, sgl, leftover);
@@ -322,11 +322,11 @@ static void page_reporting_process(struct work_struct *work)
 	atomic_set(&prdev->state, state);
 
 	/* allocate scatterlist to store pages being reported on */
-	sgl = kmalloc_objs(*sgl, PAGE_REPORTING_CAPACITY);
+	sgl = kmalloc_objs(*sgl, prdev->capacity);
 	if (!sgl)
 		goto err_out;
 
-	sg_init_table(sgl, PAGE_REPORTING_CAPACITY);
+	sg_init_table(sgl, prdev->capacity);
 
 	for_each_zone(zone) {
 		err = page_reporting_process_zone(prdev, sgl, zone);
@@ -377,6 +377,9 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
 			page_reporting_order = pageblock_order;
 	}
 
+	if (!prdev->capacity || prdev->capacity > PAGE_REPORTING_CAPACITY)
+		prdev->capacity = PAGE_REPORTING_CAPACITY;
+
 	/* initialize state and work structures */
 	atomic_set(&prdev->state, PAGE_REPORTING_IDLE);
 	INIT_DELAYED_WORK(&prdev->work, &page_reporting_process);
-- 
MST

