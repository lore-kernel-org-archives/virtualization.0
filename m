Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE7028B3EC
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 13:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288429; cv=none; b=G+2dRUZIjWlTnbbV1Kiizboeo61am7CB4Af8S5ifwXc8CNV9ETNdWMago4vwMMNA02soSj5DRhqtT5Cuox86AJFz7vY+r5hR1gYBAZxeAvLG6NxWGWLL4P3K+3DYZ+vAxubj0+278PnURPMp+GmAH0OqKYwc1eezX+Ctz6oNfvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288429; c=relaxed/simple;
	bh=HoU6IkwEzSx0bRpH46YFQR6C5ixdQUXKWK5iDFNMOt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=dxnzGMsX0cqUmmzha+s78572vjncSvpBBFovGWTNV9ne/F2Oj1Khfb3jIEtTi7uOU16c7OFM4VUA0mBR8y86AXjqjec6jCFCZt3/Msxz5vcm2QQnUdVkJJFQmOVeaBBYZPoO3p7bAuepOV21VkMPUljGNBHwtT6geuCZdhT0+sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KA23lTrs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KA23lTrs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwmXAEBDYo8DkjDdp6VkbgoCuZIqYMKAJtJSkdjCkPU=;
	b=KA23lTrsg5hxMGRxTsiVIEFrrnamiNQkhofFOnm1l4Lpq2W70Lk5q119hCk2PeRwAYynw1
	M46/VNeKJ0TUrnJnYr+P2wsCPHem8GGhchUXY/IJarLcO4UEax+8riuu18hDHEFwIO6DLh
	IoTIuO0HdMxrwiBE8VaokpSpmd3H0IU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-40PEEmtAOgCB8LHkCxs-tw-1; Mon, 30 Jun 2025 09:00:22 -0400
X-MC-Unique: 40PEEmtAOgCB8LHkCxs-tw-1
X-Mimecast-MFC-AGG-ID: 40PEEmtAOgCB8LHkCxs-tw_1751288421
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f858bc5eso1529281f8f.0
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 06:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288421; x=1751893221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwmXAEBDYo8DkjDdp6VkbgoCuZIqYMKAJtJSkdjCkPU=;
        b=DR8s5/ampPHr26bxeSy4ehaEfxgBffJ1m+VWxUi+FNdbqVsG6GHQrbuhHIvEIfrFAZ
         aAb0f1rgjYhp8toDHZoPq76RVZWXDqrvX1iO8u1nN+78hKMjhlyzFuf7bsEqolCHEIhn
         FVDEp/LY0VUORSvVM4z33xleTADwC17XipQ9jGpUKGjc4DIXw5rXdTrCYmaIeuBxs6gU
         uGfLfhK1FwQURCjEz+4Oj5kUvMWcRVvJmJiAM5Q1tRBl6Nd2dL5TJH29moTRLbIuPXOL
         MvgCJZ5wFNWMkOcllPPcsuipzHS2snIItQj0Rd/IXBfC9M/a6aMmR0Gpxu/gyc7g8Cmb
         MXwg==
X-Forwarded-Encrypted: i=1; AJvYcCW7CHvnRORbROKvloJTg9I1vTIxUoXJNnXWksAViqExOai0MIDU2NWKJRnEcAX0Kr3zvwwyXqTsBA648pM5bA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxe+QoiIkAgwcCEfQiLK6QL4650VcJicO7Jd8AWI9DE4jYtueEQ
	alQqiSWil652VkWCUzuUJkT1tzI4kLAcRyelnVcPH/GmJ9FJU/4qPgW8V/lHh8eOceWvUKeoHZz
	5PYg91fHMeHaGJZK1G6GQ4Xol5l9cjOcuOhJhkmq4czGPzGPKggtjll+X7o0OrFkPVGkJ
X-Gm-Gg: ASbGnctD8iHhMrSqDLch0YZJ1KENEtYjG7AXLfiKr2i6NywQWWoeuiuF45jDBrpQRt1
	ylq/vJdvuy3bFcRR84A6yDavQTrV0Ne7rxtIFR2UGR/+HQbJcNU+zwK9igP50ACafg0KZutaNGN
	LV/f+uIB/yGTvnzlNS2YoafC4lEVctiryCgFAJtEn7RGcak4ul+Hu/mHXmExl/DQu5YFIQLcwsb
	BOFvQwfzY6MjGP3G8WnZr3VI7QajopOgjylzTOA6gsjCDYBW75iN9aqICvJ1sio3GT1MR+253aC
	gt3Qo9CAbmp62TODpjFsDEld3cwIuQn5MdFsbU+wvTo+PUGRAd+YmMTcqW12RgdpTdRrDfAPAeh
	mZDzUpYw=
X-Received: by 2002:a05:6000:4186:b0:3a4:db49:94aa with SMTP id ffacd0b85a97d-3a8f482c7a3mr12061848f8f.21.1751288420580;
        Mon, 30 Jun 2025 06:00:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0gb3C+C+LV4oU6wKBD78SFqxqmgRCphVWjbRDEuvh0xGGV6ZK62AjmpQKGwfy92kungebyQ==
X-Received: by 2002:a05:6000:4186:b0:3a4:db49:94aa with SMTP id ffacd0b85a97d-3a8f482c7a3mr12061792f8f.21.1751288419988;
        Mon, 30 Jun 2025 06:00:19 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a88c7facf9sm10288204f8f.22.2025.06.30.06.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:00:19 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: [PATCH v1 02/29] mm/balloon_compaction: convert balloon_page_delete() to balloon_page_finalize()
Date: Mon, 30 Jun 2025 14:59:43 +0200
Message-ID: <20250630130011.330477-3-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630130011.330477-1-david@redhat.com>
References: <20250630130011.330477-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WzR08GWY3JnikJOvTCAz4OD2rzbs-Vu3hcsA9eQK8H4_1751288421
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's move the removal of the page from the balloon list into the single
caller, to remove the dependency on the PG_isolated flag and clarify
locking requirements.

We'll shuffle the operations a bit such that they logically make more sense
(e.g., remove from the list before clearing flags).

In balloon migration functions we can now move the balloon_page_finalize()
out of the balloon lock and perform the finalization just before dropping
the balloon reference.

Document that the page lock is currently required when modifying the
movability aspects of a page; hopefully we can soon decouple this from the
page lock.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/platforms/pseries/cmm.c |  2 +-
 drivers/misc/vmw_balloon.c           |  3 +-
 drivers/virtio/virtio_balloon.c      |  4 +--
 include/linux/balloon_compaction.h   | 43 +++++++++++-----------------
 mm/balloon_compaction.c              |  3 +-
 5 files changed, 21 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 5f4037c1d7fe8..5e0a718d1be7b 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -532,7 +532,6 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
 
 	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
 	balloon_page_insert(b_dev_info, newpage);
-	balloon_page_delete(page);
 	b_dev_info->isolated_pages--;
 	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
 
@@ -542,6 +541,7 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
 	 */
 	plpar_page_set_active(page);
 
+	balloon_page_finalize(page);
 	/* balloon page list reference */
 	put_page(page);
 
diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index c817d8c216413..6653fc53c951c 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -1778,8 +1778,7 @@ static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
 	 * @pages_lock . We keep holding @comm_lock since we will need it in a
 	 * second.
 	 */
-	balloon_page_delete(page);
-
+	balloon_page_finalize(page);
 	put_page(page);
 
 	/* Inflate */
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 89da052f4f687..e299e18346a30 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -866,15 +866,13 @@ static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
 	tell_host(vb, vb->inflate_vq);
 
 	/* balloon's page migration 2nd step -- deflate "page" */
-	spin_lock_irqsave(&vb_dev_info->pages_lock, flags);
-	balloon_page_delete(page);
-	spin_unlock_irqrestore(&vb_dev_info->pages_lock, flags);
 	vb->num_pfns = VIRTIO_BALLOON_PAGES_PER_PAGE;
 	set_page_pfns(vb, vb->pfns, page);
 	tell_host(vb, vb->deflate_vq);
 
 	mutex_unlock(&vb->balloon_lock);
 
+	balloon_page_finalize(page);
 	put_page(page); /* balloon reference */
 
 	return MIGRATEPAGE_SUCCESS;
diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index 5ca2d56996201..b9f19da37b089 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -97,27 +97,6 @@ static inline void balloon_page_insert(struct balloon_dev_info *balloon,
 	list_add(&page->lru, &balloon->pages);
 }
 
-/*
- * balloon_page_delete - delete a page from balloon's page list and clear
- *			 the page->private assignement accordingly.
- * @page    : page to be released from balloon's page list
- *
- * Caller must ensure the page is locked and the spin_lock protecting balloon
- * pages list is held before deleting a page from the balloon device.
- */
-static inline void balloon_page_delete(struct page *page)
-{
-	__ClearPageOffline(page);
-	__ClearPageMovable(page);
-	set_page_private(page, 0);
-	/*
-	 * No touch page.lru field once @page has been isolated
-	 * because VM is using the field.
-	 */
-	if (!PageIsolated(page))
-		list_del(&page->lru);
-}
-
 /*
  * balloon_page_device - get the b_dev_info descriptor for the balloon device
  *			 that enqueues the given page.
@@ -141,12 +120,6 @@ static inline void balloon_page_insert(struct balloon_dev_info *balloon,
 	list_add(&page->lru, &balloon->pages);
 }
 
-static inline void balloon_page_delete(struct page *page)
-{
-	__ClearPageOffline(page);
-	list_del(&page->lru);
-}
-
 static inline gfp_t balloon_mapping_gfp_mask(void)
 {
 	return GFP_HIGHUSER;
@@ -154,6 +127,22 @@ static inline gfp_t balloon_mapping_gfp_mask(void)
 
 #endif /* CONFIG_BALLOON_COMPACTION */
 
+/*
+ * balloon_page_finalize - prepare a balloon page that was removed from the
+ *			   balloon list for release to the page allocator
+ * @page: page to be released to the page allocator
+ *
+ * Caller must ensure that the page is locked.
+ */
+static inline void balloon_page_finalize(struct page *page)
+{
+	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION)) {
+		__ClearPageMovable(page);
+		set_page_private(page, 0);
+	}
+	__ClearPageOffline(page);
+}
+
 /*
  * balloon_page_push - insert a page into a page list.
  * @head : pointer to list
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index fcb60233aa35d..ec176bdb8a78b 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -94,7 +94,8 @@ size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
 		if (!trylock_page(page))
 			continue;
 
-		balloon_page_delete(page);
+		list_del(&page->lru);
+		balloon_page_finalize(page);
 		__count_vm_event(BALLOON_DEFLATE);
 		list_add(&page->lru, pages);
 		unlock_page(page);
-- 
2.49.0

