Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D385282F1D
	for <virtualization@lists.linux.dev>; Sun,  5 Jul 2026 06:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783232723; cv=none; b=hVw2TmE2PQh1abatFTCw7AG+0isYEKKTLtZ/ZjvJvvT75MDinTnAcInvzw183uakttKgVJhdhNzppqF+OMzFsRYr9BSl4CMVPJ1VsO/GQ2xgeBId0tqK6JDfNf6FM/IXY4+XLzq7md6L2AhFStc+E0IQl99k3+dNxtFMC3DR7vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783232723; c=relaxed/simple;
	bh=vrOoCblHrybAbpcv04VUI/XiWhyHlkiIiC5Z5Exw6ik=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jrJYH2kru6hyUIY60s5KdSqkEbCkN/N0KstBgludPd1gqrUJjgg8QsYpyeBZgcb5GGMuwWiw5opSvfOIWw3uE0rBkx1/jcJk1YMdPUwI2LZHhHzy2pz8twiHaM9xSLl1C2GLdC26/defPCfVfEFdSUlt4Z+bIJQJeMATHXDFB9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b90uOWoz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b90uOWoz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783232719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=GAQqvqsCquPh23M+Tm8SQSpQZO6IalsSXrunX7fJKhU=;
	b=b90uOWozqQ7vAjy/2+/koVYmZRN5y2GyyM8ClG8IohgCf3iNswdbVr5F8Fz1c+IKkAcuV/
	EI9t2vsDW+xql/FUZz1SiFtXma4WxJ0hOGpyaAegC1ckCv36k+38KdXn8co2sHlLGojjDr
	VIK0w8HX6F8QuyFGlywfgx/ukRJf7R8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-hRCAtFqGPfe0BpoDZD08YA-1; Sun, 05 Jul 2026 02:25:18 -0400
X-MC-Unique: hRCAtFqGPfe0BpoDZD08YA-1
X-Mimecast-MFC-AGG-ID: hRCAtFqGPfe0BpoDZD08YA_1783232717
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-473941177b0so1503996f8f.1
        for <virtualization@lists.linux.dev>; Sat, 04 Jul 2026 23:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783232717; x=1783837517;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GAQqvqsCquPh23M+Tm8SQSpQZO6IalsSXrunX7fJKhU=;
        b=UI248RSfxLiRl+TZvVpVby/qQzTw60lmDfUaUN6eJXrG7FB3xwy06b9T/RttdQauPe
         2qmpqoOthwEgKGhhG2sic2McJ7JLm4WQYDfBd8lIb771F1RpOiiLuvcU4bC9O0DB5K/y
         sho4wp+6oxb9QuSOo92qcNkosb6d0ePak/yumpFYkFo7OiRNQgWTP+tl9ZsJMewJvjzs
         kpSI11Yv7sWfUiVo4LgJDyZoLxGpFr3sA9gSwcIlteQlv7OUulFWBLThToU9KIS1vZBG
         5V9To0w2AfqmYcoH/hooI8M8ycfZr9YlIHo2PypEA+eWnrvRuiavZLFXvVVskEOCmRwR
         JGRA==
X-Forwarded-Encrypted: i=1; AFNElJ9jWlvLL30jJ0R5Ib67/G/QVUgesxU4ejhkqSE5V4A+g0BYn2GWydSG/6SAURzD3Sw5eMfuQe8OE9y1rF/1Bg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzTec0P4tpGXCMUf+8DMfYX43pyfw3TbUJGGaXgxL5NcJQe1xp9
	NT0baHZAhIWqR2fpDiFE6JuhcSYwsj4zzkRePYxP/XEi3HwVfyHFnVNNyacEDwWw5ZEsm3zDd4C
	17rmhKUIvZXrZbwAQmOVjbnsA/jB2YrAK1Uebk8PSRtLvQyleoU8R0P+e8UhzHca+ip2A
X-Gm-Gg: AfdE7clIVIdJwmD57wz0dHiZVob9FHEoqynqeP9D/kjYian/1jDXuqxy8WqI8eUMjm7
	wfzF9e84Xk3v5jEVDyp3QIzkLERCEH491j3rH6OKXBKD6AIiJYYLgYxt+wzJEAPzqVgOppfdVzl
	KTt/Ipd03BLtRi5V6X2PgECEEkfGy50RIW0/xTdfhEIxpvFStZ9ZaOsDwWocbew6LGAfaOZtNqC
	DjW8x+HomQGmpfv6wkYNuldbZ67QRKZeOJ1BehPPWyXnc933JSXdG5g0ky2QRHh9+FDnwaz8a7Y
	LuFfcuNvdQuDS5k2qde9vBq5+PyioELFBH0qI5tAsPpR9IbFp0glqgT+rsCB3jAOZI9gOPn2Xhi
	IeIW5LCnVBZeZQIT/6KvMGafF9X8OreEs
X-Received: by 2002:a05:600c:a011:b0:493:b84f:9c28 with SMTP id 5b1f17b1804b1-493d526dff6mr31636895e9.4.1783232716720;
        Sat, 04 Jul 2026 23:25:16 -0700 (PDT)
X-Received: by 2002:a05:600c:a011:b0:493:b84f:9c28 with SMTP id 5b1f17b1804b1-493d526dff6mr31636635e9.4.1783232716215;
        Sat, 04 Jul 2026 23:25:16 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a558easm13544055f8f.27.2026.07.04.23.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 23:25:15 -0700 (PDT)
Date: Sun, 5 Jul 2026 02:25:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	virtualization@lists.linux.dev, linux-mm@kvack.org
Subject: [PATCH v3] mm: page_reporting: allow driver to set batch capacity
Message-ID: <444c24cf39f3f3620fc90ef4695bd6b0979f4c4b.1783232420.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: a1kerNhF1us-v1p_isjtmmYZ42S26YM2eMXKs8O92RQ_1783232717
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
Assisted-by: Claude:claude-opus-4-6
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Gregory Price <gourry@gourry.net>
Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Who's merging this? Me?

Changes in v3:
 - Dropped stale "This value should always be a power of 2" comment
   above PAGE_REPORTING_CAPACITY (David Hildenbrand, others)

Changes in v2:
 - Added paragraph explaining capacity need not be a power of two
 - Added paragraph documenting capacity=0 default and no div-by-zero
   (Gregory Price)
 - Improved struct field comment: "0 (default) means PAGE_REPORTING_CAPACITY"

 drivers/virtio/virtio_balloon.c |  5 +----
 include/linux/page_reporting.h  |  4 +++-
 mm/page_reporting.c             | 24 ++++++++++++------------
 3 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 088b3a0e6ce6..581ac799d974 100644
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
index 9d4ca5c218a0..272b1274efdc 100644
--- a/include/linux/page_reporting.h
+++ b/include/linux/page_reporting.h
@@ -5,7 +5,6 @@
 #include <linux/mmzone.h>
 #include <linux/scatterlist.h>
 
-/* This value should always be a power of 2, see page_reporting_cycle() */
 #define PAGE_REPORTING_CAPACITY		32
 #define PAGE_REPORTING_ORDER_UNSPECIFIED	-1
 
@@ -22,6 +21,9 @@ struct page_reporting_dev_info {
 
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

