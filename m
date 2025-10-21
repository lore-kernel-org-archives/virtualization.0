Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2588336EFB
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 12:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051588; cv=none; b=PLSRJV1hwSe23AKgwq5ipygNSWy0eT04c4dr1xgSmNqsUR4V/npOzsVo6Q+QmknmdcGvn1ucK2T4uh1u8F3EshmvBPYFF87aOMeHDrYGVmU84klXN/gotG1YmsP5kpVZ4ukUFZQwiT8YLphJ918b2UafFkaTt3nqH5O4T1tFGic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051588; c=relaxed/simple;
	bh=97cB6P/al8lN3e4yxP/MWCa5SAPX4AFlrOtpe6WV0P0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=YhqH4k6+Fi/dkkV9OEGOkW7cHf3ggMpBvAxTg1e6JxHEjOoI6KmuobTAmXHzLvBtLZwQ9rwN4ZnecuAI0R24+81+WPKqHUbOXGwiNnotPEEoYO0pVPLqfGMsuBPGR4TwiJEkQ1f7BWrKiiF0tjroDCaG5RdZVkgtGd6wFzrtpA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QG+RyGqZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QG+RyGqZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761051586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sUyqikpnRIZJJ7+CBYLr21ot5Ik6tImIDaS0WggNCzg=;
	b=QG+RyGqZ0Zdwl7CvRSdI+4LbL8zQMhvA4l1QBwERDhiU82Mq6SaU5U46mgWu5CGI3G3d5V
	SW5Ycd1QyA2W+d3ZXSvmNo5T4tQXFb8i5/3N2gJ3QmH9Li69epF/x6h566UEYiD0s6KVnX
	C0fpQw7PAW8BmFdUFB/fEfgAQDQ6flY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-YB-bEkJ3NJ-lBsUfEQVBHA-1; Tue, 21 Oct 2025 08:59:44 -0400
X-MC-Unique: YB-bEkJ3NJ-lBsUfEQVBHA-1
X-Mimecast-MFC-AGG-ID: YB-bEkJ3NJ-lBsUfEQVBHA_1761051584
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ee888281c3so9987039f8f.3
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 05:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051583; x=1761656383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUyqikpnRIZJJ7+CBYLr21ot5Ik6tImIDaS0WggNCzg=;
        b=SfC11agpIMYYeINS3L/LRPBZhh/JqeRrAE41K11MGcM0Bl4WSUZUNI4movQHbwFvwp
         Ha5QwLRyQZZQMJtE/k/YpjDczva9h/QGoPmIqbk6U5ss8oOqz9O0KSFbOEYEMd7F6suu
         hZW6lcA2BIzxp+sfITB0343kFsvXrAsuIKZZ+ZLKMcR0QAcGCnvJLT7oZiEMwCwM0DZz
         VZkf8HOHcUIiF+qhKrHqrosmB6LT+ubcgjgyLe8Bus4SODhEvS2UvlYEbKo+x2QmH2qJ
         hkLFkl/2dPGZjHkTCBnOHs2yP/vpLoW0CPaOMflqlTYsJ9Y797QHEidnETrLGppfZn2G
         tnBg==
X-Forwarded-Encrypted: i=1; AJvYcCXBmNTJ/NYzr3gePasCCyHScvfCj5gFVJz2hQySSKPqzTymvUoPdoSZoCRhmTCvLAXduYh45qyYaLV4bWCCFg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz98IMty1lyAUUD9C5JbZza0+AEZXIM9Vsw+cAzi5d+TQAFPZoQ
	GuovznKu+j7txeI9TqmaHM9LVCZIUEqgOUIxQBsok8ytdFkGBsGHm3gr2Zp3AHKjpGNcAfbOB+5
	GQGOQtLDjfEyMbz/1P6PbMTc6kzKyAbskwegY1khI37iV8S+uXS4LGf1zPoQNajdXTpsh
X-Gm-Gg: ASbGncvW3H+ZSnz51HzXSkEUVAoyEoQr6fCoYyPXbrFNy5/Q3fr5hORAHd4PtjuPymP
	VglR2Y+JNTA3jjdLltfKnDgk45F8dbiNeuBSed/WY2fOD0DoniN6gbEaFbpi9xqo7iIjqHQUcqz
	0O7xXNif0EstXwu5cEOTpOTWT4tc9cJ9jTWdQ8Igc9HOe9fziUykhK/wJXJ5Azj7e7ji0o9bNNn
	6mHWDZbZ3jOZ3UDojvvQHwCvCOpxnh5PHn74u6XAmHHN9hd1lNRaB4VVq98Vkc2wS1mXk6FYpbg
	WkoWUrZHTFCFh+ZqdTz/rIK5XzY/0WHTWDkOG10XhrnRhPIJywMn5YsfnOOFvXJ+mEBFW6jmA7g
	MakS4ZzQuWfrwbJZbcIgelpcrif0NUlRVQfDTbbe3xgYKqIAFADimvvRQArba
X-Received: by 2002:a05:6000:26d1:b0:3ec:db0a:464c with SMTP id ffacd0b85a97d-42704dc94a0mr12883697f8f.44.1761051583506;
        Tue, 21 Oct 2025 05:59:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQe5sfmvBNGfARqbQvLIETNCNFniX0I3Wgmf7ZO8nqCKClSavcBGyNI7STnbkUGhrMC20EJA==
X-Received: by 2002:a05:6000:26d1:b0:3ec:db0a:464c with SMTP id ffacd0b85a97d-42704dc94a0mr12883652f8f.44.1761051583045;
        Tue, 21 Oct 2025 05:59:43 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427ea5b3acfsm20082945f8f.14.2025.10.21.05.59.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 05:59:42 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v1 05/23] mm/balloon_compaction: centralize adjust_managed_page_count() handling
Date: Tue, 21 Oct 2025 14:59:10 +0200
Message-ID: <20251021125929.377194-6-david@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021125929.377194-1-david@redhat.com>
References: <20251021125929.377194-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _gG1b1QFZLQRFS3dIDB6bSSE1OsWL3tJgrF5mFHjhWA_1761051584
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's centralize it, by allowing for the driver to enable this handling
through a new flag (bool for now) in the balloon device info.

Note that we now adjust the counter when adding/removing a page into the
balloon list: when removing a page to deflate it, it will now happen
before the driver communicated with hypervisor, not afterwards.

This shouldn't make a difference in practice.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/platforms/pseries/cmm.c | 13 +------------
 drivers/virtio/virtio_balloon.c      | 19 ++-----------------
 include/linux/balloon_compaction.h   |  2 ++
 mm/balloon_compaction.c              | 17 +++++++++++++++++
 4 files changed, 22 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 07b21d2bc8a78..9ed71683ae402 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -165,7 +165,6 @@ static long cmm_alloc_pages(long nr)
 
 		balloon_page_enqueue(&b_dev_info, page);
 		atomic_long_inc(&loaned_pages);
-		adjust_managed_page_count(page, -1);
 		nr--;
 	}
 
@@ -190,7 +189,6 @@ static long cmm_free_pages(long nr)
 		if (!page)
 			break;
 		plpar_page_set_active(page);
-		adjust_managed_page_count(page, 1);
 		__free_page(page);
 		atomic_long_dec(&loaned_pages);
 		nr--;
@@ -515,16 +513,6 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
 		return -EBUSY;
 	}
 
-	/*
-	 * When we migrate a page to a different zone, we have to fixup the
-	 * count of both involved zones as we adjusted the managed page count
-	 * when inflating.
-	 */
-	if (page_zone(page) != page_zone(newpage)) {
-		adjust_managed_page_count(page, 1);
-		adjust_managed_page_count(newpage, -1);
-	}
-
 	/*
 	 * activate/"deflate" the old page. We ignore any errors just like the
 	 * other callers.
@@ -551,6 +539,7 @@ static int cmm_init(void)
 		return -EOPNOTSUPP;
 
 	balloon_devinfo_init(&b_dev_info);
+	b_dev_info.adjust_managed_page_count = true;
 	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION))
 		b_dev_info.migratepage = cmm_migratepage;
 
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 8969271581bca..f7d6a4a6e54f5 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -274,9 +274,6 @@ static unsigned int fill_balloon(struct virtio_balloon *vb, size_t num)
 
 		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
 		vb->num_pages += VIRTIO_BALLOON_PAGES_PER_PAGE;
-		if (!virtio_has_feature(vb->vdev,
-					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
-			adjust_managed_page_count(page, -1);
 		vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE;
 	}
 
@@ -295,9 +292,6 @@ static void release_pages_balloon(struct virtio_balloon *vb,
 	struct page *page, *next;
 
 	list_for_each_entry_safe(page, next, pages, lru) {
-		if (!virtio_has_feature(vb->vdev,
-					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
-			adjust_managed_page_count(page, 1);
 		list_del(&page->lru);
 		put_page(page); /* balloon reference */
 	}
@@ -839,17 +833,6 @@ static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
 	if (!mutex_trylock(&vb->balloon_lock))
 		return -EAGAIN;
 
-	/*
-	  * When we migrate a page to a different zone and adjusted the
-	  * managed page count when inflating, we have to fixup the count of
-	  * both involved zones.
-	  */
-	if (!virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM) &&
-	    page_zone(page) != page_zone(newpage)) {
-		adjust_managed_page_count(page, 1);
-		adjust_managed_page_count(newpage, -1);
-	}
-
 	/* balloon's page migration 1st step  -- inflate "newpage" */
 	vb->num_pfns = VIRTIO_BALLOON_PAGES_PER_PAGE;
 	set_page_pfns(vb, vb->pfns, newpage);
@@ -958,6 +941,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 	if (err)
 		goto out_free_vb;
 
+	if (!virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
+		vb->vb_dev_info.adjust_managed_page_count = true;
 #ifdef CONFIG_BALLOON_COMPACTION
 	vb->vb_dev_info.migratepage = virtballoon_migratepage;
 #endif
diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index 7cfe48769239e..3109d3c43d306 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -56,6 +56,7 @@ struct balloon_dev_info {
 	struct list_head pages;		/* Pages enqueued & handled to Host */
 	int (*migratepage)(struct balloon_dev_info *, struct page *newpage,
 			struct page *page, enum migrate_mode mode);
+	bool adjust_managed_page_count;
 };
 
 extern struct page *balloon_page_alloc(void);
@@ -73,6 +74,7 @@ static inline void balloon_devinfo_init(struct balloon_dev_info *balloon)
 	spin_lock_init(&balloon->pages_lock);
 	INIT_LIST_HEAD(&balloon->pages);
 	balloon->migratepage = NULL;
+	balloon->adjust_managed_page_count = false;
 }
 
 #ifdef CONFIG_BALLOON_COMPACTION
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 5444c61bb9e76..fd9ec47cf4670 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -23,6 +23,8 @@ static void balloon_page_enqueue_one(struct balloon_dev_info *b_dev_info,
 	BUG_ON(!trylock_page(page));
 	balloon_page_insert(b_dev_info, page);
 	unlock_page(page);
+	if (b_dev_info->adjust_managed_page_count)
+		adjust_managed_page_count(page, -1);
 	__count_vm_event(BALLOON_INFLATE);
 	inc_node_page_state(page, NR_BALLOON_PAGES);
 }
@@ -95,6 +97,8 @@ size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
 			continue;
 
 		list_del(&page->lru);
+		if (b_dev_info->adjust_managed_page_count)
+			adjust_managed_page_count(page, 1);
 		balloon_page_finalize(page);
 		__count_vm_event(BALLOON_DEFLATE);
 		list_add(&page->lru, pages);
@@ -256,12 +260,25 @@ static int balloon_page_migrate(struct page *newpage, struct page *page,
 
 		balloon_page_insert(b_dev_info, newpage);
 		__count_vm_event(BALLOON_MIGRATE);
+
+		if (b_dev_info->adjust_managed_page_count &&
+		    page_zone(page) != page_zone(newpage)) {
+			/*
+			 * When we migrate a page to a different zone we
+			 * have to fixup the count of both involved zones.
+			 */
+			adjust_managed_page_count(page, 1);
+			adjust_managed_page_count(newpage, -1);
+		}
 		break;
 	case -ENOENT:
 		spin_lock_irqsave(&b_dev_info->pages_lock, flags);
 
 		/* Old page was deflated but new page not inflated. */
 		__count_vm_event(BALLOON_DEFLATE);
+
+		if (b_dev_info->adjust_managed_page_count)
+			adjust_managed_page_count(page, 1);
 		break;
 	default:
 		return rc;
-- 
2.51.0

