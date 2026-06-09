Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05520380FE0
	for <virtualization@lists.linux.dev>; Tue,  9 Jun 2026 15:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020411; cv=none; b=DKATlUP06IcJn82G3RYan1seIXAbfvQW/GrOhyrq5AENUsflAPFod1YKA0PVZpdTk1YEixG2wyiOhyNkn5sAjMaiEj0b7ZwVDhAozgl3eEgPllPq6I/WPzuve1KUtJVSrH1+hLc0G0dCFr7yfphp2O0BtEoiLJnn0EN6RnatbdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020411; c=relaxed/simple;
	bh=g1EKEYRYLribbyiGUWZVYck5VAG9jAxTKOR/GeNwZko=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jpv7MfRcJnXa8o+09naeZFZERKpnkZ6CJAYN9jvs3fumQu7dVBOQR5K4BBhx2t8u8FKRID2wvtmDKZWEhhhyOjwOGmRhquVFsQOvuAmwAP55nkojTiHbXA4hVEaObOYgiKvn1tTn8sF0WvLMgSisN+pVlJ2m9rO/JNiQFQDsv5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hfg+wJUV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hfg+wJUV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781020409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=znUgJLwcI/t7tvESv/1fH8INfEp80ot2BgxIAU0A+Is=;
	b=Hfg+wJUV2vMnababyz6gDFfh+KUjPvPNqYzVTAtf+a+Fy3cIJQYk/n9QqmJWcY2l15MoJR
	OP7AThjxbWt2/sXI7fB9lyvjKXVI/AJKm5wZluYrAyV4OGFBBp8I+jSPA/sGzcw2P/FrZc
	pxCw2lpRzWj5u8ivvwBL5HumiFCwcDc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-1P_ilK_HMSe2fqNyECH_SQ-1; Tue, 09 Jun 2026 11:53:27 -0400
X-MC-Unique: 1P_ilK_HMSe2fqNyECH_SQ-1
X-Mimecast-MFC-AGG-ID: 1P_ilK_HMSe2fqNyECH_SQ_1781020406
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490d3f03883so12331765e9.1
        for <virtualization@lists.linux.dev>; Tue, 09 Jun 2026 08:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781020406; x=1781625206;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=znUgJLwcI/t7tvESv/1fH8INfEp80ot2BgxIAU0A+Is=;
        b=FBSNnv4FSNCTKUWLtQ+yxT8GjBr5AmauzEIUh0m8HXcoWRZKaH6zUGbD3fVOzRcRG1
         f/27SgUNPZlTIOwd+TlacIZ0b9IH1wOL+GgjfQLTgXRQKAIeV7UknIfcqkp3z8LuABUW
         wFTnwrEEkiFczmCozZCgZE7QA1z+f2IeyNjF9N/uTW5aOi5MY9VoJh5esOlsg1hboNiW
         /tceHTZvRzLXEOhwzNOAkkWe2OHBvJSF57PLHd/whgvXb6A8YWvdg4xuW+XdgdD035Ga
         C1vbz7FBJ+Aj4pIki5ssRY1jDzBf+2qtFOJDji7V8OFalu6DAgT4CA98LYfL4snidmSQ
         pZRQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Jpzl7KpgS2Wq0i5FpamsyqsyyuLIvDKl0zX7+HT+qXUevTDPk3waiQs3g9UDC8eRQTTO4KuY2Tzja+8WorA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxeGMfnXQlf2PDL4h7vmffhWjgOufGV/2GbAyVnUncx1iuDAUpq
	UfDUzkVqfMbj+E45jrYr6CwyFNsYtRNhCKDEuRZhmp4KZIELvsh+gRPrXEuSlcsB83AZc/cIMVD
	zOJ1oQ40MudBsSfoLQBJj548epnvlMkc0TJOOuOS1ISkNJUZljX958wH4t6TIUu2X6adu
X-Gm-Gg: Acq92OHlqAw3LJI/KWICQ9kcfVB2BL50qKYID5p06N+k04XxmpV5XO5Xln4VXFhEw2P
	o+q1hhtNFuJTVuXxc6EoSvhvTtS2sWTnmeN3fAOBtVyMLsyPrk4SbEeEaFS6mwhp25hCQqRFAZi
	jQ9EguANVfuhKLvIFw2xMF516lH63kmVKR5un6D3CWrRVaBtCbEXmZul4PmLFplkBlILWs4jwpQ
	lB5mw46KMrLswXibbeHeTjSKUwBJnb+fz/p0tSzCbKRdGL8wDtzAfzmA8avIRT/F48pZSaFZbvd
	pt2XEu5DyyV/nDk83kd9DlONtZX+n65+xhpVnRmNc32gLq5B4ivGniFZ9Nv1PBBvVsRAXCcmHEE
	Y0+UdeFo8TtAMeXXeZHW68v4VFV5w9n2gu9WsETUTCNWITkU3rnOu9A==
X-Received: by 2002:a05:600c:524a:b0:490:b11f:2560 with SMTP id 5b1f17b1804b1-490c256f131mr368572675e9.9.1781020406196;
        Tue, 09 Jun 2026 08:53:26 -0700 (PDT)
X-Received: by 2002:a05:600c:524a:b0:490:b11f:2560 with SMTP id 5b1f17b1804b1-490c256f131mr368571885e9.9.1781020405506;
        Tue, 09 Jun 2026 08:53:25 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2f67c6sm60824138f8f.16.2026.06.09.08.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 08:53:24 -0700 (PDT)
Date: Tue, 9 Jun 2026 11:53:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Miaohe Lin <linmiaohe@huawei.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
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
	Andrea Arcangeli <aarcange@redhat.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: [PATCH splitout] mm: page_reporting: allow driver to set batch
 capacity
Message-ID: <b25ea6c63503f24c8b5b64910a44dc03b5aa610d.1781020302.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NPB_nK43DP2v2zYDqgpiDsi2dgMMpS0kA3vcFRhzMNo_1781020406
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

Fixes: b0c504f15471 ("virtio-balloon: add support for providing free page reports to host")
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

