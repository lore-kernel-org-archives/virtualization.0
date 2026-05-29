Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A549F3BCD3A
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068152; cv=none; b=eqKS80+O3BWvfXx/+Spb/1Ne1KuevF8XJJAA69gcKNpqP60CtHYRyf/5khKVgjbyGRJVkjdVxMbRr0HC+EML8adVD3y6jBaaL7R9arX9DBqnC8U/oUS/23ou1xtJuAu7Ht1aJUioZQe/QjXTvamNB60S0BJsd3CcztURffkI8gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068152; c=relaxed/simple;
	bh=sa7tjyyH5w82gQsWdnwXLh3+WpyPoKY2RLFi26AWDX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KxHmJ7D3CuwRgxyAEVQflm1s1Lk3wmTQs7iDhh3PwBzNe8WQsP2rB69VlUUxKlwFowZj/+Q389yT4JXAPfIa0bYU3YP/yUUvGHtMSEUdm6LAWx87PslYSN+cgUnkBLBaCE0kbw/kq3/CRpQ89pLIaM/JN153/zsNmEZqwAx9Pa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JrbCeweW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JrbCeweW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780068149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CGpf7NEGXo6YXa4YKC+LNXdeGyms+G/W0uzlFnpQv6k=;
	b=JrbCeweWk5sp1syjirB0rb6zL7vlzHhm1xqrmT+Wtuh1grsRlYtAYiLOWeSc5gbWZ22DF8
	0IKukvclsZeKD0EyV5YoxG6i3WgWEqAxLK2nqOWjmq5eGBjVdAHHFT+8jJ2CpU4zYNUvpJ
	bd4g0LyZ53ZFQEs99TYgw1qIcjB+ULo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-BvGR8ulcPxK3lzSJBEqPmQ-1; Fri, 29 May 2026 11:22:28 -0400
X-MC-Unique: BvGR8ulcPxK3lzSJBEqPmQ-1
X-Mimecast-MFC-AGG-ID: BvGR8ulcPxK3lzSJBEqPmQ_1780068147
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49081106196so27064605e9.1
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068147; x=1780672947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGpf7NEGXo6YXa4YKC+LNXdeGyms+G/W0uzlFnpQv6k=;
        b=ltP1m4+/JD7hGIn5tEgX/7/eyje41f6va2xo3kiX/irAhoFSBSQHskVIRWH56h0SiZ
         1ARnPkDeyp/rf4FNFmd3gp6HypcCZoNFdEpbckBsZTJxAz8c1VliRHQhUSpJPwIScP95
         v3KpWtL34LRKIl/rBueiOH/2fqWSU1LcruBl7eqxhQhvd6mmyiwq+8F8pgCTvCx1BYQM
         /qzPX0NruOeJdSED+y4eSuRAVbfKgoEmTBBa3yGOaJejmGLXZkKX4Bug0m6Ovj4hVZ3a
         s7NDc+UZq2tQxREdc32hk6Q3P0coxFu/F80D569r1QDjdhnjbhgyNDPUaVDTVrgG+d05
         cg+A==
X-Forwarded-Encrypted: i=1; AFNElJ8V7qlv7U9bNL+Ltf2ZYWdAGWwfRXrS1XvB3zs1+IDjHoPPfXAJzbm39zRwtVI0OjgIrdtfnqqvX+umCE8psw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxIrfc5ggplqbP6WCvqmXQNHE/40xps2Ejse4ZNO01e243CltUD
	EkHT+h7MlSgQDEQ51+paNL0eIMOgW5d5nF0z/Uzkq9joO6qcs2Xi8UUh2VOUUUOrXn0atOySfyS
	J8aLTCBOVpg4T2I/L7h5AlgHV7xk7Ly7zZ/2IfbjNrNMwP0cXSeg5eILSoOCQNtQWUPYT
X-Gm-Gg: Acq92OHzOhfyQGhG5Nq5X/TknqzysyvyjLL4rWdEhOFqcjoAbhnCCyoZUJ/z4UBSOY0
	b6t1c7CjdQwBCk2SKw/VroNbT+A8kRuaIZfnekWOI0YdUiQJFVBzsF/Ywn891hFCRRQR0U3eF8n
	foUcovZHl8gY9djicDQQN2igqmB0FomHp5pG5NNeTEWwMm5DJbYhj8PZpImFrEAqIyAodF/+AuS
	W1NgtmT6oh+XxxnF8/hEncjzp5v9CNq2x7JMqlcuW6kdmZkNd7eWsldzx6FFMM1Gr20MDgYgDP5
	MnKD2bjAcog/wNZt72gIwihZA11fOvSRvgrTPX+hW7fKwG0DMPitWslw4r79t3ze6kKxEfxwLCm
	IPDqEV7uy5CiGLlCflNstxCSRuvP+sllB69gEf6OmntZTb+3sD+OULw==
X-Received: by 2002:a05:600c:34cf:b0:490:5e2a:f924 with SMTP id 5b1f17b1804b1-490a2900e81mr2220935e9.7.1780068146690;
        Fri, 29 May 2026 08:22:26 -0700 (PDT)
X-Received: by 2002:a05:600c:34cf:b0:490:5e2a:f924 with SMTP id 5b1f17b1804b1-490a2900e81mr2220045e9.7.1780068146235;
        Fri, 29 May 2026 08:22:26 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909caa7e17sm56125215e9.9.2026.05.29.08.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:22:25 -0700 (PDT)
Date: Fri, 29 May 2026 11:22:21 -0400
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
Subject: [PATCH v9 04/37] mm: page_reporting: allow driver to set batch
 capacity
Message-ID: <da332cc87d07af8b4359284cab40f69175915730.1780067977.git.mst@redhat.com>
References: <cover.1780067977.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1780067977.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SN05lcQsgE8gWCb11L5WJ-7SbBLtd-ZdY5OiCSySUvw_1780068147
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add a capacity field to page_reporting_dev_info so drivers can
control the maximum number of pages per report batch. This is
useful when the driver needs to reserve virtqueue descriptors for
metadata (e.g., a bitmap buffer) alongside the page buffers.

The value is capped at PAGE_REPORTING_CAPACITY and rounded down
to a power of 2. If unset (0), defaults to PAGE_REPORTING_CAPACITY.

The virtio_balloon driver sets capacity to the reporting virtqueue
size, letting page_reporting adapt to whatever the device provides.

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
index 7418f2e500bb..a6ddf6fafc20 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -174,10 +174,10 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 	 * list processed. This should result in us reporting all pages on
 	 * an idle system in about 30 seconds.
 	 *
-	 * The division here should be cheap since PAGE_REPORTING_CAPACITY
-	 * should always be a power of 2.
+	 * The division here should be cheap since capacity should
+	 * always be a power of 2.
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

