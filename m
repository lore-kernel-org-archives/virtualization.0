Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC9C35B122;
	Thu, 15 Jan 2026 09:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768468852; cv=none; b=sbd+VKm8mqC+lpn2tjhsd2pYUidNCqgVr+ta6R/r6EvU81T6cTZ+XI59xUlg27TzzLKnhOMNTDfISiDWQM6kraOsk1i4T5YcOw0cCHda+aV8EJUdas1ci2RcESpjxBF5t0XuZ9i9dd5j9eOhFr/RWulD4WsMKwI/ghqhKuFf5m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768468852; c=relaxed/simple;
	bh=w4KcHLR+BH8XcJwxxcNytMND/0cbiSTTskBUX/GwE2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VyroBkw6LSllfLaxrZeW5C0K7L3gm7GM/Epet/nverEjCLGKu5Jchpt57ysbLZGhJ20ZdfzyYAKvLIMSL1RkWTpgl+J18X/6bDIayBVBVwXk93MlPCvH4jl5jBn2hkCMBLy81SgUSxYNC9QdCbk46Ae1Js9ZpIC5bzX45c6pVQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mr92APs5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mr92APs5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A1CC116D0;
	Thu, 15 Jan 2026 09:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768468852;
	bh=w4KcHLR+BH8XcJwxxcNytMND/0cbiSTTskBUX/GwE2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mr92APs5Utiee9xvMBLboUUTDgM0ap0b5FPXynhnef271Ip7h1Y0U7ViG/f/yERpz
	 grC7h7iFLv7vSBxlDgzUvpHtw4xj/FB8+Q2m0ytRi9uVgqtrEtfCKxSnrLukHF9Gh8
	 LY7hCQRU+XGBRFqvQ7x4opgkMp+KEWTpBWnZx+xcsns1RavhWR5feNPh6OmKfNALn/
	 vhqH7OGIpuNY18FGFgnDnPHMAilbZSoxLfAvZ+stEdCBuXqIE4+mUF1ulfKBea8RBA
	 hklYllWA2Hibwj7VZ7fctrerV/2Ula+CedMaEvanTiCpeXX1yf5iXU28VO4TRw+16w
	 AEFeqZbVyZYvg==
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
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
Subject: [PATCH v2 04/23] mm/balloon_compaction: centralize basic page migration handling
Date: Thu, 15 Jan 2026 10:19:54 +0100
Message-ID: <20260115092015.3928975-5-david@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115092015.3928975-1-david@kernel.org>
References: <20260115092015.3928975-1-david@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's update the balloon page references, the balloon page list, the
BALLOON_MIGRATE counter and the isolated-pages counter in
balloon_page_migrate(), after letting the balloon->migratepage()
callback deal with the actual inflation+deflation.

Note that we now perform the balloon list modifications outside of any
implementation-specific locks: which is fine, there is nothing special
about these page actions that the lock would be protecting.

The old page is already no longer in the list (isolated) and the new page
is not yet in the list.

Let's use -ENOENT to communicate the special "inflation of new page
failed after already deflating the old page" to balloon_page_migrate() so
it can handle it accordingly.

While at it, rename balloon->b_dev_info to make it match the other
functions. Also, drop the comment above balloon_page_migrate(), which
seems unnecessary.

Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
---
 arch/powerpc/platforms/pseries/cmm.c | 16 ---------
 drivers/misc/vmw_balloon.c           | 49 +++++-----------------------
 drivers/virtio/virtio_balloon.c      | 12 -------
 mm/balloon_compaction.c              | 37 ++++++++++++++++++---
 4 files changed, 41 insertions(+), 73 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 9a6efbc80d2ad..15f873f733a41 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -501,8 +501,6 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
 			   struct page *newpage, struct page *page,
 			   enum migrate_mode mode)
 {
-	unsigned long flags;
-
 	/*
 	 * loan/"inflate" the newpage first.
 	 *
@@ -517,9 +515,6 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
 		return -EBUSY;
 	}
 
-	/* balloon page list reference */
-	get_page(newpage);
-
 	/*
 	 * When we migrate a page to a different zone, we have to fixup the
 	 * count of both involved zones as we adjusted the managed page count
@@ -530,22 +525,11 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
 		adjust_managed_page_count(newpage, -1);
 	}
 
-	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
-	balloon_page_insert(b_dev_info, newpage);
-	__count_vm_event(BALLOON_MIGRATE);
-	b_dev_info->isolated_pages--;
-	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
-
 	/*
 	 * activate/"deflate" the old page. We ignore any errors just like the
 	 * other callers.
 	 */
 	plpar_page_set_active(page);
-
-	balloon_page_finalize(page);
-	/* balloon page list reference */
-	put_page(page);
-
 	return 0;
 }
 #else /* CONFIG_BALLOON_COMPACTION */
diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 07e60a4b846aa..52b8c0f1eead7 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -1724,18 +1724,17 @@ static inline void vmballoon_debugfs_exit(struct vmballoon *b)
  * @page: a ballooned page that should be migrated.
  * @mode: migration mode, ignored.
  *
- * This function is really open-coded, but that is according to the interface
- * that balloon_compaction provides.
- *
  * Return: zero on success, -EAGAIN when migration cannot be performed
- *	   momentarily, and -EBUSY if migration failed and should be retried
- *	   with that specific page.
+ *	   momentarily, -EBUSY if migration failed and should be retried
+ *	   with that specific page, and -ENOENT when deflating @page
+ *	   succeeded but inflating @newpage failed, effectively deflating
+ *	   the balloon.
  */
 static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
 				 struct page *newpage, struct page *page,
 				 enum migrate_mode mode)
 {
-	unsigned long status, flags;
+	unsigned long status;
 	struct vmballoon *b;
 	int ret = 0;
 
@@ -1773,14 +1772,6 @@ static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
 		goto out_unlock;
 	}
 
-	/*
-	 * The page is isolated, so it is safe to delete it without holding
-	 * @pages_lock . We keep holding @comm_lock since we will need it in a
-	 * second.
-	 */
-	balloon_page_finalize(page);
-	put_page(page);
-
 	/* Inflate */
 	vmballoon_add_page(b, 0, newpage);
 	status = vmballoon_lock_op(b, 1, VMW_BALLOON_4K_PAGE,
@@ -1799,36 +1790,12 @@ static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
 		 * change.
 		 */
 		atomic64_dec(&b->size);
-	} else {
 		/*
-		 * Success. Take a reference for the page, and we will add it to
-		 * the list after acquiring the lock.
+		 * Tell the core that we're deflating the old page and don't
+		 * need the new page.
 		 */
-		get_page(newpage);
-	}
-
-	/* Update the balloon list under the @pages_lock */
-	spin_lock_irqsave(&b->b_dev_info.pages_lock, flags);
-
-	/*
-	 * On inflation success, we already took a reference for the @newpage.
-	 * If we succeed just insert it to the list and update the statistics
-	 * under the lock.
-	 */
-	if (status == VMW_BALLOON_SUCCESS) {
-		balloon_page_insert(&b->b_dev_info, newpage);
-		__count_vm_event(BALLOON_MIGRATE);
-	} else {
-		__count_vm_event(BALLOON_DEFLATE);
+		ret = -ENOENT;
 	}
-
-	/*
-	 * We deflated successfully, so regardless to the inflation success, we
-	 * need to reduce the number of isolated_pages.
-	 */
-	b->b_dev_info.isolated_pages--;
-	spin_unlock_irqrestore(&b->b_dev_info.pages_lock, flags);
-
 out_unlock:
 	up_read(&b->conf_sem);
 	return ret;
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 74fe59f5a78c6..df2756c071dae 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -827,7 +827,6 @@ static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
 {
 	struct virtio_balloon *vb = container_of(vb_dev_info,
 			struct virtio_balloon, vb_dev_info);
-	unsigned long flags;
 
 	/*
 	 * In order to avoid lock contention while migrating pages concurrently
@@ -840,8 +839,6 @@ static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
 	if (!mutex_trylock(&vb->balloon_lock))
 		return -EAGAIN;
 
-	get_page(newpage); /* balloon reference */
-
 	/*
 	  * When we migrate a page to a different zone and adjusted the
 	  * managed page count when inflating, we have to fixup the count of
@@ -854,11 +851,6 @@ static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
 	}
 
 	/* balloon's page migration 1st step  -- inflate "newpage" */
-	spin_lock_irqsave(&vb_dev_info->pages_lock, flags);
-	balloon_page_insert(vb_dev_info, newpage);
-	vb_dev_info->isolated_pages--;
-	__count_vm_event(BALLOON_MIGRATE);
-	spin_unlock_irqrestore(&vb_dev_info->pages_lock, flags);
 	vb->num_pfns = VIRTIO_BALLOON_PAGES_PER_PAGE;
 	set_page_pfns(vb, vb->pfns, newpage);
 	tell_host(vb, vb->inflate_vq);
@@ -869,10 +861,6 @@ static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
 	tell_host(vb, vb->deflate_vq);
 
 	mutex_unlock(&vb->balloon_lock);
-
-	balloon_page_finalize(page);
-	put_page(page); /* balloon reference */
-
 	return 0;
 }
 #endif /* CONFIG_BALLOON_COMPACTION */
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 03c5dbabb1565..5444c61bb9e76 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -232,20 +232,49 @@ static void balloon_page_putback(struct page *page)
 	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
 }
 
-/* move_to_new_page() counterpart for a ballooned page */
 static int balloon_page_migrate(struct page *newpage, struct page *page,
 		enum migrate_mode mode)
 {
-	struct balloon_dev_info *balloon = balloon_page_device(page);
+	struct balloon_dev_info *b_dev_info = balloon_page_device(page);
+	unsigned long flags;
+	int rc;
 
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(!PageLocked(newpage), newpage);
 
 	/* Isolated balloon pages cannot get deflated. */
-	if (WARN_ON_ONCE(!balloon))
+	if (WARN_ON_ONCE(!b_dev_info))
 		return -EAGAIN;
 
-	return balloon->migratepage(balloon, newpage, page, mode);
+	rc = b_dev_info->migratepage(b_dev_info, newpage, page, mode);
+	switch (rc) {
+	case 0:
+		spin_lock_irqsave(&b_dev_info->pages_lock, flags);
+
+		/* Insert the new page into the balloon list. */
+		get_page(newpage);
+
+		balloon_page_insert(b_dev_info, newpage);
+		__count_vm_event(BALLOON_MIGRATE);
+		break;
+	case -ENOENT:
+		spin_lock_irqsave(&b_dev_info->pages_lock, flags);
+
+		/* Old page was deflated but new page not inflated. */
+		__count_vm_event(BALLOON_DEFLATE);
+		break;
+	default:
+		return rc;
+	}
+
+	b_dev_info->isolated_pages--;
+	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
+
+	/* Free the now-deflated page we isolated in balloon_page_isolate(). */
+	balloon_page_finalize(page);
+	put_page(page);
+
+	return 0;
 }
 
 const struct movable_operations balloon_mops = {
-- 
2.52.0

