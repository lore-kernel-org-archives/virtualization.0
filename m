Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33A03DDDD7
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 13:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781097440; cv=none; b=ozSS1TQUS/GUEZuXFDqYG33jDsMe7EkMQPJudODnx83i/FWvEhlP3PCexaSa+kU3uJEHxrPd8x+21aTDgRf6nKD44WwnNGCX4NTQcNsk55F4q4lxkPMeuJzm0C40+d/CKr+Ncl6/MBR3PUVIJBR+DQTlVXmpjV5jFmgZaj9X+E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781097440; c=relaxed/simple;
	bh=1D9+hklB7r3x0u0ch2J4IhAFeDFpVae4jEVnWDHzGsA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N8hmK+CLZm9RK2mKEx09KZVD1wB3xbGQqU/HZVxvCAnEYgi6UPLOC/pb/CYqjry50+T8DjyMa9xjmUQXXkQox/TdhFlzMJVQf8bhlgINaAoKiniNnMoQsRhtxuDmr2wJys373R7RiTw9uAIRbiEzDF6lTR+YMUpnV2CVREJinss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ipUOx04h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ipUOx04h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781097437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=JIynXs9jKTkZFqI4maeQsdqviVHDwx4+PYnRpWMJtSw=;
	b=ipUOx04hIZPPGb7N6wPk8WJ17+noyrP69fyPWOcbt/2eiYod6b88tLSHgIYisYL4e4Vxlo
	/1HsAmKiKbhAaJPELNOnTSg3ksD0BTBf5eA8c47jbvqCUt7OzjyFq6ZVX7GHbal4hguRzW
	09psHfoo+R+YYTwhvgm3l6cAGPqG/BU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-9vt6H_ozOaeL6gWlfZxCUA-1; Wed, 10 Jun 2026 09:17:16 -0400
X-MC-Unique: 9vt6H_ozOaeL6gWlfZxCUA-1
X-Mimecast-MFC-AGG-ID: 9vt6H_ozOaeL6gWlfZxCUA_1781097435
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490c4f61a34so34212105e9.2
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 06:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781097435; x=1781702235;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JIynXs9jKTkZFqI4maeQsdqviVHDwx4+PYnRpWMJtSw=;
        b=kYLd6X7Vz0sg+u0iwWW5FcfNB8+qxoXeu6NWoD6eRXGmEw/DM9mlxPlBnrlVaofPnb
         WNbkGJ/hVOzgRtbdrV+BnzjHXmHKjsM5Xz8FVsGrEcIQTh6P4dvzVX+r/iF09vLFgJPV
         xrUa6fUuGN4CtuchJi9GswuxwZgpbJc2D6Y0w9Rrpsp9jiCYDuaRfjCrj/r1EQcnpRdB
         86/okK17hgzbLzAzdHLnaYVut4a8mlI3s/DaSFygwr0uvAXkkNFTn/y7rWMmdqtsqQVc
         lfc1M+i8E+9yU5qs4+C4Tn3dQxgXL/1BJCTRLUHCLZWwF7WeyVnmrQ+J2dfoWwzIloeB
         PkQA==
X-Forwarded-Encrypted: i=1; AFNElJ+59avF1NKoKlgVoMQD0FzE3ga0GvfHXmRQlf2jdh0mI2NU+rITX7e3LF4qakXS1A4l+wMoEK82e7rExT7ZPA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2DzXqnrYiF9mM47sn/yrEWfDCj7T/9lIOHz0Q/GiOX6lqIdc5
	wPEDuYr3vbka78yQEVCO7w4hB5R5lHsetHXgrxwb6RbmO3hX7U00OfXGcSl/rvgquisfX7Q6SDH
	oOWfO1Jb+JWAORQZ4+8GKuxvGrIsWHhPc0vaC8rklip4qmXKkWrc4JmMMTr0D04I3XkCD
X-Gm-Gg: Acq92OE1GpiMhLputiagNTWOg7cVSc0/GOOFHBCLQKriizL7f31Dh7jhgyHtxgbT+Mc
	AX89OU14cUCERu9X8/bUKeZr8vzgxhfKNQjA1DkMeRDh0Lb6a7fpX82eRJiLGXrfudhMA9ytLEW
	FawHm/bm2jeKMzEPpgXPjNfPxX2TpXK9JQ+YEAkrJ66qNqvso7LZ9nJvcKcwW9H0RUe5ruqY7jD
	hYAxfbcx2dlQ4PsHVc8+9Xm/8ckKS/bQ1MRcMWRKZG+K3liagQLrzngEvxJV0aS+SSJEq8TPgqy
	vMVaSExtUYLEhBkr8oi2mtcaLS1XGk8GeuE1+1f9ToaZQLjlnkXDaJ5OfzE8EZkpIyA4cmlDtrN
	5JixmvRGIWL9VslZc7J6e1ZjntVWdedSqKVpYVkdmwqFbhKBPP5ZjcQ==
X-Received: by 2002:a05:600c:c491:b0:490:bb44:3f8b with SMTP id 5b1f17b1804b1-490c2605385mr407783245e9.17.1781097434724;
        Wed, 10 Jun 2026 06:17:14 -0700 (PDT)
X-Received: by 2002:a05:600c:c491:b0:490:bb44:3f8b with SMTP id 5b1f17b1804b1-490c2605385mr407782215e9.17.1781097434064;
        Wed, 10 Jun 2026 06:17:14 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3b5b82sm595285305e9.1.2026.06.10.06.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 06:17:13 -0700 (PDT)
Date: Wed, 10 Jun 2026 09:17:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Miaohe Lin <linmiaohe@huawei.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio Perez <eperezma@redhat.com>,
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
	Andrea Arcangeli <aarcange@redhat.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: [PATCH v2] mm: page_reporting: allow driver to set batch capacity
Message-ID: <cb43adc61d2ed3069b2fe428f3e051dbdc4cc28d.1781097156.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OfiphhVfzLPC-U5sib7RsOTdb5Nzg4aIeLrBZLHZZpc_1781097435
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

At the moment, if a virtio balloon device has a page reporting vq but
its size is < PAGE_REPORTING_CAPACITY (32), the balloon driver fails
probe.

But, there's no way for host to know this value, so it can easily
create a smaller vq and suddenly adding the reporting capability
to the device makes all of the driver fail. Not pretty.

Add a capacity field to page_reporting_dev_info so drivers can
control the maximum number of pages per report batch.

In virtio-balloon, set the capacity to the reporting virtqueue size,
letting page_reporting adapt to whatever the device provides.

Capacity need not be a power of two.  Code previously called out
division by PAGE_REPORTING_CAPACITY as cheap since it was a power
of 2, but no performance difference was observed with non-power-of-2
values.

If capacity is 0 or exceeds PAGE_REPORTING_CAPACITY, it defaults
to PAGE_REPORTING_CAPACITY.  The 0 check and the clamping is done in
page_reporting_register(), before the reporting work is scheduled,
so we never get division by 0.

Fixes: b0c504f15471 ("virtio-balloon: add support for providing free page reports to host")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
Changes v1->v2:
- Document capacity=0 as default in commit log
- Document that capacity need not be a power of two
- Drop unnecessary comment about integer division cost
- Update comment on capacity field: "0 (default) means PAGE_REPORTING_CAPACITY"

 drivers/virtio/virtio_balloon.c |  5 +----
 include/linux/page_reporting.h  |  3 +++
 mm/page_reporting.c             | 24 ++++++++++++------------
 3 files changed, 16 insertions(+), 16 deletions(-)

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
index 9d4ca5c218a0..048578118a4b 100644
--- a/include/linux/page_reporting.h
+++ b/include/linux/page_reporting.h
@@ -22,6 +22,9 @@ struct page_reporting_dev_info {
 
 	/* Minimal order of page reporting */
 	unsigned int order;
+
+	/* Max pages per report batch; 0 (default) means PAGE_REPORTING_CAPACITY */
+	unsigned int capacity;
 };
 
 /* Tear-down and bring-up for page reporting devices */
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 7418f2e500bb..942e84b6908a 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -173,11 +173,8 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 	 * any pages that may have already been present from the previous
 	 * list processed. This should result in us reporting all pages on
 	 * an idle system in about 30 seconds.
-	 *
-	 * The division here should be cheap since PAGE_REPORTING_CAPACITY
-	 * should always be a power of 2.
 	 */
-	budget = DIV_ROUND_UP(area->nr_free, PAGE_REPORTING_CAPACITY * 16);
+	budget = DIV_ROUND_UP(area->nr_free, prdev->capacity * 16);
 
 	/* loop through free list adding unreported pages to sg list */
 	list_for_each_entry_safe(page, next, list, lru) {
@@ -222,10 +219,10 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 		spin_unlock_irq(&zone->lock);
 
 		/* begin processing pages in local list */
-		err = prdev->report(prdev, sgl, PAGE_REPORTING_CAPACITY);
+		err = prdev->report(prdev, sgl, prdev->capacity);
 
 		/* reset offset since the full list was reported */
-		*offset = PAGE_REPORTING_CAPACITY;
+		*offset = prdev->capacity;
 
 		/* update budget to reflect call to report function */
 		budget--;
@@ -234,7 +231,7 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 		spin_lock_irq(&zone->lock);
 
 		/* flush reported pages from the sg list */
-		page_reporting_drain(prdev, sgl, PAGE_REPORTING_CAPACITY, !err);
+		page_reporting_drain(prdev, sgl, prdev->capacity, !err);
 
 		/*
 		 * Reset next to first entry, the old next isn't valid
@@ -260,13 +257,13 @@ static int
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
@@ -290,7 +287,7 @@ page_reporting_process_zone(struct page_reporting_dev_info *prdev,
 	}
 
 	/* report the leftover pages before going idle */
-	leftover = PAGE_REPORTING_CAPACITY - offset;
+	leftover = prdev->capacity - offset;
 	if (leftover) {
 		sgl = &sgl[offset];
 		err = prdev->report(prdev, sgl, leftover);
@@ -322,11 +319,11 @@ static void page_reporting_process(struct work_struct *work)
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
@@ -377,6 +374,9 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
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

