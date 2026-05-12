Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D27E3C1978
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 21:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778619932; cv=none; b=gSssy4ppN69Q/zziGQnp6KJbRtan8R0vMX6Kpik5mqbnAUg0qPGDgz7sQfNNRtr2JgSfTTU+Eobhwsx6smrgph39dZ48S40SmpMapddIrMjpbC71iMKM5oRTQLqEl4eTl2k9f4R8J6b+rwWF7ZT1UFOIhhye8UcOIrxXkR9nFZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778619932; c=relaxed/simple;
	bh=jAEaO4JfYvTZh0h5rRrKJYMGQ45gKsBKH3AVbKj8c00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bKVwMTPSdDgdZaHCC1D6KyR73qb00GcxeEzrQ7eyAirH0aS58xI4gFhagEOdEKIGzE3uQ+/Rx65HsyCZzFNzsIRaewgeS5SOw3xr7N+AJ4HbAFYunsUHODK+LLJIeZFfUp0lCeFE/yRYEV4MDYZ5Zb3FCPZMsUrKkrvGkYNipwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I0uIMa4Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I0uIMa4Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778619930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dLzVjPl4JuXWdYl/OMkyXvKlFkDQF6qpB2cxYBp2hXA=;
	b=I0uIMa4QdgkTsxKeJfk+giwJVa6JKPCyyJYqBQMHzK0DsvI+Rf7extfZT/4kFFQY1sDBLb
	3Hyfdf+VfHQrm93ft5DWlAHlPXzppG0M8HqgSU6RWGmwI1rYqRUEBDG59ml/b4TUBXSG7o
	sQZpTfCXNpH0/mA6yOlqXyCJrM+2/AE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-yg3YI-uFOt2C7_ZzUmlLlA-1; Tue, 12 May 2026 17:05:28 -0400
X-MC-Unique: yg3YI-uFOt2C7_ZzUmlLlA-1
X-Mimecast-MFC-AGG-ID: yg3YI-uFOt2C7_ZzUmlLlA_1778619927
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44f65835b77so4111751f8f.2
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 14:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778619927; x=1779224727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLzVjPl4JuXWdYl/OMkyXvKlFkDQF6qpB2cxYBp2hXA=;
        b=Q7HMBArXnktwYNBxRq13t6MEi7D1rqGCOVvl+S0A6YndfUCjNUt7FweNxsjuE3qJjB
         0kDBIAhYhrn4oLAiAJF73UrgJnntTr/Jg/GdahM5hMXGAuTGdkFNNMuS/vHfDJDsG93H
         5uX52h3ExyiUyxgDBjRuS6D5Pvk7p8O2kdWBnkjVm81zJxJ7WrKeY6ZaBrhqcIm+YSVx
         TxkOOgysKMAfBdocMLgmCFAdg4XPNaR+ZHkhC6J+m77gQHy2JREHcJus3Ru6ToN84dfZ
         1DgASLzCYjd3ej+U29tcc3mE5oxbI3yXdeXuCUz2y74uZ1AHYlPnnBfJa91U8mEytGK5
         vG2A==
X-Forwarded-Encrypted: i=1; AFNElJ8Et5dlOAA4kXpDKXISiC/fpSm5LJ3Tj+IqWuzI4IaRCLHNsFQbV+jZWWIC8P5BghE9R7iN5ZMGYtLuuVVl6A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgbX5HqR1oIpwW4GejI8zuedIV6LwfSYm3PKyxs3cJkDwI2AKA
	i0ulrITaOVtpsasiTWMwZZcePPJ2dv5TTQAXquDXglgyEarZRr9kraceM7Dqe7LKndk99VqzWva
	zV5p7x9wR3p3IGuvI7xshpH8vHXKx1DgM7bOH5oqqqaX+PKr1ntJSs+O1hbXFhscC2FZ5
X-Gm-Gg: Acq92OECa0T2m/WWgtLLMfpaU9Wak6yrSu4FeuL4hwXnv76Cfjd2vI3m7xF05Cax6JR
	aXUorlcK3yvcSy0DbvgwbB8RO7nl7Xg3v3Xv8PW09jPasTYXlER2fR1kwHmy84mxaBzEmjhPhFT
	YA0Ag0zrYW886zl0qm4vBXvVmjO83LZOZokfMnzcIDYl7hOZVKa+bDKsmxGC2EQplJcluIzG80/
	70fdSfUKy6vkku68Pk+Uf1Pk1xOomqUiBoZfYDp4nX8SBpEmkAi7dk/gPTxj1FwT7mu4A9RPjSH
	WfckvWT1UN5J2cKbKImiFVucYiNx8fDj0+J8d+45grEOHGPtFOBNQy7R+waVqAn+e/2oV6LsNsX
	wMWVQuyI1lS8f1+52/Ia4dNClyzhIVhWgUpPenjMg
X-Received: by 2002:a05:6000:268a:b0:43f:e934:50ac with SMTP id ffacd0b85a97d-45c5859efc6mr574250f8f.7.1778619926606;
        Tue, 12 May 2026 14:05:26 -0700 (PDT)
X-Received: by 2002:a05:6000:268a:b0:43f:e934:50ac with SMTP id ffacd0b85a97d-45c5859efc6mr574198f8f.7.1778619926094;
        Tue, 12 May 2026 14:05:26 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491f8d4c3sm34961168f8f.34.2026.05.12.14.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:05:25 -0700 (PDT)
Date: Tue, 12 May 2026 17:05:21 -0400
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
Subject: [PATCH v7 03/31] mm: page_reporting: allow driver to set batch
 capacity
Message-ID: <46519548042fe8029d74459704468e0587e674ec.1778616612.git.mst@redhat.com>
References: <cover.1778616612.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778616612.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vNGSgOwi7BNiS_KV28XXxG_Tl_cpmxYl21nLB2O90IA_1778619927
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
 mm/page_reporting.c             | 26 +++++++++++++++-----------
 3 files changed, 19 insertions(+), 15 deletions(-)

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
index 7418f2e500bb..006f7cdddc18 100644
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
@@ -377,6 +377,10 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
 			page_reporting_order = pageblock_order;
 	}
 
+	if (!prdev->capacity || prdev->capacity > PAGE_REPORTING_CAPACITY)
+		prdev->capacity = PAGE_REPORTING_CAPACITY;
+	prdev->capacity = rounddown_pow_of_two(prdev->capacity);
+
 	/* initialize state and work structures */
 	atomic_set(&prdev->state, PAGE_REPORTING_IDLE);
 	INIT_DELAYED_WORK(&prdev->work, &page_reporting_process);
-- 
MST

