Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026202EF9DA
	for <virtualization@lists.linux.dev>; Fri,  4 Jul 2025 10:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624738; cv=none; b=rIspgUzmK2VoRtq59XZJ9kqVLSWTJfrknUo6jR/11y8P42das2WVcRrXMhE+w2I1QJWXkBnanIUq4yW/qI3fZJG8KJ+8Br6uHOcPBXOI2Q7zTNtoIoVWhai5MdQeHBau5u0cyINSYTCKQo7krgErCcJsVVmV0dRK2J9w1FX2PbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624738; c=relaxed/simple;
	bh=I63+tICEwC4FRjr5OpxcwU6Xz35bpjNotIszeWd/mZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Pk2HDlqYYjLKRaDwVctlmyP/E3a2om0lhdxrmHOTp3fF88EE2Ih8A+FVANL8WIn36/nAwmKvlLq2vVdOFQcXki6mIEBy1HnDn8xev53wlWz4vWALYahAFoluRzmiZ+U6RdAz/4WoStgDMPv+FbgVlVH96HP65cZGcn18KID89yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GmmbOC4B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GmmbOC4B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rzG8kZhPdoUa83Bv+EhsniO+15GPe15At7nc5LLJ+tY=;
	b=GmmbOC4Bjt2gxxvnQNEQ+JxvUbaTlPvKuJ54TxEOI39wwaD2h+w0O4cL92fWVQizGtjAVV
	uZupCv0a6zb5e4VSshjX9Ho264cGvymVg+HpNzTQ2TpRxonAck//+Vgzttk9EyfyelS4IU
	uX7Ce8rX6GHNpyZxoJYcvos1L1vXj6Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-7dvXmZhOOKqyWFavdij77A-1; Fri, 04 Jul 2025 06:25:35 -0400
X-MC-Unique: 7dvXmZhOOKqyWFavdij77A-1
X-Mimecast-MFC-AGG-ID: 7dvXmZhOOKqyWFavdij77A_1751624734
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a58939191eso293839f8f.0
        for <virtualization@lists.linux.dev>; Fri, 04 Jul 2025 03:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624734; x=1752229534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rzG8kZhPdoUa83Bv+EhsniO+15GPe15At7nc5LLJ+tY=;
        b=VkajTkmZDlEpEWhL4E8JIoOOt13jbORFeoH/6HrTWqUR7FIluKYdn7LObSDsTvEInr
         PG3KV8cdFP2a4Ls44ZblaP+oXr9zEH7SX+Fy4Sj6g4BWW9NMijD5Tu4fHVKx/9kQMFVR
         ZZeD0G5xBqyI1gU5lwsc5q+zFbBPCaThflbl/Z7QV7JNb0f9FGC7prH8e9m7cc+s9aXW
         EIyK10ppf8x37VhcEg3mJSHuEm//nG8fgazm1i9hevSoxlKJuoPVMGx8WAjTfMXygoPP
         ohShxVKPsVQ0ANofwpP/dh6n0x+5RN1ZnUkMC8ay6lg8IQWSfAlq3Ra73f/H+MFAy8YQ
         uLnw==
X-Forwarded-Encrypted: i=1; AJvYcCUDPufGvT6FUuioNT9fKVt0P6oanP7p4ApMABLi9dsE/L27i1lWHfJptKpRqVbIKC7lbX7WXRWLfttw5JrwZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzhb8ycNmFa/GqFAvUh6hGKrex9dnOELX6NJdv6oZ+pwbF1iaPE
	Pxo33VQQFbMKo8fCTPqXkRwtFdGn/7hhHyLSlwagKMw5xU3xHXMpnwTtQFh6WXW6NFfuyjxbVYX
	LNzQ9K0be8zaovhaz9Zq+ohQLthvxza+do5TLzadIry9/oXm+Q9u52IfcOUp75cQO9Pe6
X-Gm-Gg: ASbGncswpRWbdO4P/Lf8IZxtcgOWJbJ8mWWGQfmDe+H8lZ8zPhEPANElic023wgjdKP
	JrTD737ByPoVRMdmWFahowC3znA1OaL0VMSUPjipGQ0/v4R+wpJrIASKBmu7R3qPH3jDk0uDCQb
	8xi2zcb+xGf7bxZTA5Ez2jLmoxDVYA0gBmF5aNFN2AWCLeEJLTupx5mxPXM4oY12A8kgN0J6vCJ
	oKUkO+hbcJ4DbftXAHtUYUpZp/ubgrhOTYun5XwMAEtF0ySu+fzK97xHDRuf2F5pFyEmsc2W9kj
	SOc1e5rdrCla12TdMgUGabZ3Yr0oxJmZqPr5OwlkyGjEVWFAxqXMKFEW+9jAr2zTUdrYV4cpAcz
	DjfOL0Q==
X-Received: by 2002:a05:6000:2f86:b0:3a4:fbaf:749e with SMTP id ffacd0b85a97d-3b4964ea59fmr1485325f8f.49.1751624733757;
        Fri, 04 Jul 2025 03:25:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzOdZy9kGaBK2IhW4pGMieYfGDGuCayvREmmwE/RZquZQddy2FKZttIuDRBnk85RTka/4UcQ==
X-Received: by 2002:a05:6000:2f86:b0:3a4:fbaf:749e with SMTP id ffacd0b85a97d-3b4964ea59fmr1485265f8f.49.1751624733234;
        Fri, 04 Jul 2025 03:25:33 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454a9bea4a9sm50548875e9.37.2025.07.04.03.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:25:32 -0700 (PDT)
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
Subject: [PATCH v2 02/29] mm/balloon_compaction: convert balloon_page_delete() to balloon_page_finalize()
Date: Fri,  4 Jul 2025 12:24:56 +0200
Message-ID: <20250704102524.326966-3-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704102524.326966-1-david@redhat.com>
References: <20250704102524.326966-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: j7qj8VmRLt2BhSNj9-IF4emgBbOyHmINirXTM8xskhw_1751624734
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's move the removal of the page from the balloon list into the single
caller, to remove the dependency on the PG_isolated flag and clarify
locking requirements.

Note that for now, balloon_page_delete() was used on two paths:

(1) Removing a page from the balloon for deflation through
    balloon_page_list_dequeue()
(2) Removing an isolated page from the balloon for migration in the
    per-driver migration handlers. Isolated pages were already removed from
    the balloon list during isolation.

So instead of relying on the flag, we can just distinguish both cases
directly and handle it accordingly in the caller.

We'll shuffle the operations a bit such that they logically make more sense
(e.g., remove from the list before clearing flags).

In balloon migration functions we can now move the balloon_page_finalize()
out of the balloon lock and perform the finalization just before dropping
the balloon reference.

Document that the page lock is currently required when modifying the
movability aspects of a page; hopefully we can soon decouple this from the
page lock.

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
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

