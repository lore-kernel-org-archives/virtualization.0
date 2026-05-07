Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F06239B495
	for <virtualization@lists.linux.dev>; Thu,  7 May 2026 22:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778192597; cv=none; b=AF4Kf2pdq0vwbxafQg6w5rDC76qaNEwL24/B4DWrOHaogjFwgT9DvPAx9KYbH7RnQDuxsIXlW9irXDIa9yZqBpsUCfWJUkzbld17rK2Bg3wWUfJFjdws4x3rZgYfbAq+pkoEkNEqguklb4WMjMRXsTvckS65OLYCI6+1VlwvVIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778192597; c=relaxed/simple;
	bh=IqcJvUNNbK1XhZiTXLCyFfQD4uhQUIj8/4+m+H9660U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mE9UR4pJcH2zmgL0OgEBxDgjJihFfLztFwgaNSLQW6D12jcrAg1W3aXikvIUvF496MK8xQ7I1vqxBy0E/eDH7uryGspExB2e7IS4NvyKmS7m5iE9yXaz6jwGXDTAZ87urBI+uT0jYQ8GUQ8LsAbEgN/WPdKMdF/Mu6O/KNxUTmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TWeDV7Pe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWeDV7Pe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778192594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bXud0h6YxK7twmSfS1n2EW2FIV5pqeOXrOEyMytphT4=;
	b=TWeDV7Pe8eAITOLCuBKfNHhGUvnz9lGMVhhkm38PNsu8XQ4TCWYCvl131NJG9YBnEuNKYF
	QxhzXeRPSOvH1NJtKI0KdVqkSqZ8OTXKlHarQuztIcxrwLCivFs+y34vlJWeYapppJBlv+
	TZxxS5jRc6FZmR966Wvg+sZKxGUka94=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338--rbGfCvLMLSCvHFQ_XTPuA-1; Thu, 07 May 2026 18:23:11 -0400
X-MC-Unique: -rbGfCvLMLSCvHFQ_XTPuA-1
X-Mimecast-MFC-AGG-ID: -rbGfCvLMLSCvHFQ_XTPuA_1778192590
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488d2cd2674so10427575e9.0
        for <virtualization@lists.linux.dev>; Thu, 07 May 2026 15:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778192590; x=1778797390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXud0h6YxK7twmSfS1n2EW2FIV5pqeOXrOEyMytphT4=;
        b=jNjBKlghRenp89WGSSUgkHyNAlXCyXkMKwDs2B9mCzgaOB9HorphFGU6WzrO7bN/Qj
         1b9gSR9iKvrcytpzBilOXwD8AylScp3Qkcr3ySDEi1EiLfbDht20JsCX/vjVBWDqvyoB
         ngyTAyVC7MMqzKTORt9bE0WjQV1C1aFfL9XMbDBfD4x4iC0p78T8mOXxaC+njeYKmqUY
         fup5xsvCDK98G81d62r0hzFDfda/7+lUyObUVrqRheN1N0SryDgF6FL9PoefI1IOsenp
         zu2Id+4v34nUy4O18k5CutKrHmgOSIjlpVXr3HD1/hc8+CgqfT6GhKPIS/I3o6IdXQCj
         +ujg==
X-Forwarded-Encrypted: i=1; AFNElJ+WcqrrdwWYR9FSB8gSzO84Q7jhsK1YLZVESKdbk2WGZHvNgU9boo4QK0QsNo5yDzY8JNzlRjHNnySDMkpF8w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwdUIN4MWrd9iW4nlUxPGPqSIF+amtszLJlZqaaG+ki5odSAjEZ
	X0iy1+x/Cp+Qn9lkJp9iVyNKVP4rwNranktel2rabOc8TtAOiEQoUy5ovtTIUrt9CT+dHrh3ini
	HgisVSN+6rxxR/X7/XRnB395s9mchBuA/oE56NGui+xOzZuS14AvSmUGVjWhHdsMAfjAm
X-Gm-Gg: AeBDievxla7JY+JscddnogWEIDn1kPxvLasfiEjXR1RFM4UOzN8QuO3kMODoyJ9Qr9Y
	RchA9AR9QtUe6w5ipzHG3+sqEZVgja6CkwQPxzxTsL0XGWIAk48vFPDOQ168nVT1jQeEgljgE5b
	wcSCgo5aTcHeM5JQd2K2FEdg3uiWGrBApUPDgEbr5d0xdMf0yqYIl13xwfeGuduTRLsqetK0yzd
	DBfCgkpwB7jHeYLlgn+mkqDKpAuOdaMwj3P2qkuVTFo+5zL3fLnefhukW+GfWcia3A/QIFerm87
	5RZM9mkDp8KhuIeOC+MiwQ5Ws0iSmvenLP7mHKQ/KwX2XhUPQhXXL6Iai5/QfjRext4pEQ/qdqY
	KDNdrt0qDY1vvER6JcmRuD28f+ssFDY1NI/nJB4lm
X-Received: by 2002:a05:600c:4c25:b0:48a:65a5:750f with SMTP id 5b1f17b1804b1-48e51f46ddamr94972165e9.21.1778192589741;
        Thu, 07 May 2026 15:23:09 -0700 (PDT)
X-Received: by 2002:a05:600c:4c25:b0:48a:65a5:750f with SMTP id 5b1f17b1804b1-48e51f46ddamr94971895e9.21.1778192589203;
        Thu, 07 May 2026 15:23:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e53895effsm150472825e9.3.2026.05.07.15.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 15:23:08 -0700 (PDT)
Date: Thu, 7 May 2026 18:23:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@kernel.org>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	virtualization@lists.linux.dev, linux-mm@kvack.org
Subject: [PATCH v5 14/28] mm: page_reporting: allow driver to set batch
 capacity
Message-ID: <e90045272621711a7dc1ba9ce0f949dde5f7c2f4.1778192416.git.mst@redhat.com>
References: <cover.1778192416.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778192416.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dNq7zX4kImG9QD8quG2vNuK29YZ6OXZyYSGJHFyChdU_1778192590
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
index d1fbc8fe8470..7ed024315539 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -1017,10 +1017,6 @@ static int virtballoon_probe(struct virtio_device *vdev)
 		unsigned int capacity;
 
 		capacity = virtqueue_get_vring_size(vb->reporting_vq);
-		if (capacity < PAGE_REPORTING_CAPACITY) {
-			err = -ENOSPC;
-			goto out_unregister_oom;
-		}
 
 		/*
 		 * The default page reporting order is @pageblock_order, which
@@ -1039,6 +1035,7 @@ static int virtballoon_probe(struct virtio_device *vdev)
 		vb->pr_dev_info.order = 5;
 #endif
 
+		vb->pr_dev_info.capacity = capacity;
 		err = page_reporting_register(&vb->pr_dev_info);
 		if (err)
 			goto out_unregister_oom;
diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
index fe648dfa3a7c..306468b6c7d8 100644
--- a/include/linux/page_reporting.h
+++ b/include/linux/page_reporting.h
@@ -21,6 +21,9 @@ struct page_reporting_dev_info {
 
 	/* Minimal order of page reporting */
 	unsigned int order;
+
+	/* Max pages per report batch (default PAGE_REPORTING_CAPACITY) */
+	unsigned int capacity;
 };
 
 /* Tear-down and bring-up for page reporting devices */
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index f0042d5743af..247cda44e9de 100644
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
@@ -376,6 +376,10 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
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

