Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593E52701A9
	for <virtualization@lists.linux.dev>; Wed, 14 May 2025 11:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747221354; cv=none; b=P4cySLApT2g8utBBq2iuG0IbgBXt54wAze0zsweVmdm3o1TjOah+W9LwPKHwlx2FZeA5LzuZHUHmpaBz5R9UvhiUNaHBBbLB73HqvX8JqGJ/vm3eZBCNwXx+yS0P9bS3ynkuNn/DjYnaHxRJLFGAiBXRmX5qxjWuvPU7bkV0xc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747221354; c=relaxed/simple;
	bh=EYy80QvFPLAsyMRBPjLHLuQ7h1+xF2rxgoOxEZ5Bmto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=lL+oHRJNmsACk32jggQXqqMr79uBZ5FtaB1UEmAt6sRRNSXiJgcfc1iQe3zGIkRG+0AFV7qMci35EVcfO5XaFrZrgR8rZtgRkNenOdL5UiGwfleL9/ez75E2jYG/SDIwkcgC+XCiUUzLyGQ45DW2zYf7OPaq1Jjf7/6Bxf1XGFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZTHROWUO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZTHROWUO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747221351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NgaU2cojvSHZOhTlL/gSvGFx2nqC7vuEv4nsiMuIuxo=;
	b=ZTHROWUOgeBeudyhQ3ygKt/OQSBBeLaLbgjVCMQwx93d7p93v/TOeOb8BR8wAs/gfEQNks
	T9n4S1mPboyK4hKAuk9cqgLwKHcLPC/N5ubw7NTW8vmrWCp04hU639Gnrs/EK6jjii/G3f
	JgI6A+2H9Xxb4bWv7DedQ9Jktp1OxIY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-buiBWf23NWGW9eAUjA5eKg-1; Wed, 14 May 2025 07:15:50 -0400
X-MC-Unique: buiBWf23NWGW9eAUjA5eKg-1
X-Mimecast-MFC-AGG-ID: buiBWf23NWGW9eAUjA5eKg_1747221349
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a0b6cb5606so3083613f8f.0
        for <virtualization@lists.linux.dev>; Wed, 14 May 2025 04:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747221349; x=1747826149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgaU2cojvSHZOhTlL/gSvGFx2nqC7vuEv4nsiMuIuxo=;
        b=KJFr8a0NujOZNrVjFXZ6CwcOyx+HB8QBasKKFwVmqIBd2KUMwbD7oRIi/lknMv5r17
         AtV2bXLhPI5umpDOAcqbzn5h/g7+/Cw0Z7e6HTBJ9Z2n/85KceLe3K++D7zdtqsg5MIx
         1+URkYjOUlGHtLKr31hvVMilFTontyjhr/fCLPrmWBX6VbfqiPuT3CZ1rYHUHcNkWHrO
         9y5fQs+6/2iBddPRwxX+Lz+/P0tbzAiw480jl8fF/mFXgXo4tD9uO93OnxrcdO2Mt0qv
         f/FfzTKvALguwKp5HlLjJTALdy1pTtc4MDQcihqno8BM53gJrk/QEoFdxi3eY8rZk9q1
         ktXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQGtAmuw3wlC5Y7TvLWcO+Z0IrRplffUy/mmSsW5t0XTUBuK/JoZf0zW0yK9gEMl/jq4pUbtzntiVt1NWfHg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzwI+AE2eUKA43ZpPlJH0wJLwyM3wCxi+w4Vqgb/6iKqjSD1oXC
	yzTOVk3mrftZ081DK1kp2cGl6PT70QCmFbX9j7YSVoj9Bt72Wmr487NbOnFIGwcAcd84kyeP7OH
	IGloC90Qk6LxEmKWr/xXtTBm03IokV4kjdDP0M5Vb6t73Dds/zaMxINIWXotVju6E
X-Gm-Gg: ASbGncs/J2HFQaQ928mtRpXdlD0LEy3g3EpIb7j205xAwtSnORfob3vU+oVQjN8diGs
	IqFpd0Fwfyan5gKWReRYKLV4MehENn8XToS2dmYHJxCKwrQpd+qqREAY030icW6M4embL4HJiUc
	x42CsmYCDCf3X9moS29S2GgkP/YqXofUA7GOiRLASXFK369KZR4B2c6ekrxNOM4zYP0ogzAjAZE
	U3Cc/LYos55da0VChbF5znWdqoJ4mMKW2VKUHukZquWsqcGQDoY5OWMYCcMDE2PjP01/2dUini1
	TmqhK3lBWfOsvXha7ZYoLle+2UZIBAJZDJYguOylojVQuAR1Pn0TEsE4OWo1sgXN6kYKX16u
X-Received: by 2002:a05:6000:2406:b0:3a1:fc91:2819 with SMTP id ffacd0b85a97d-3a3496c28afmr2276671f8f.32.1747221348701;
        Wed, 14 May 2025 04:15:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdMNnEs7SVCSjUjETvSOmO+0C2eCjnR51Pc3NLZG5gxSfyguQfiUVzfZcujQgkhCPaGR26qw==
X-Received: by 2002:a05:6000:2406:b0:3a1:fc91:2819 with SMTP id ffacd0b85a97d-3a3496c28afmr2276631f8f.32.1747221348156;
        Wed, 14 May 2025 04:15:48 -0700 (PDT)
Received: from localhost (p200300d82f156200d4851bcdd708f5df.dip0.t-ipconnect.de. [2003:d8:2f15:6200:d485:1bcd:d708:f5df])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a1f58f2b29sm19641998f8f.53.2025.05.14.04.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 04:15:47 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v1 1/2] mm/memory_hotplug: PG_offline_skippable for offlining memory blocks with PageOffline pages
Date: Wed, 14 May 2025 13:15:43 +0200
Message-ID: <20250514111544.1012399-2-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514111544.1012399-1-david@redhat.com>
References: <20250514111544.1012399-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cs1mmgmhqW2egYH_wFiwL-9mu4g28fEM50MFUUffXws_1747221349
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

A long-term goal is supporting frozen PageOffline pages, and later
PageOffline pages that don't have a refcount at all. Some more work for
that is needed -- in particular around non-folio page migration and
memory ballooning drivers -- but let's start by handling PageOffline pages
that can be skipped during memory offlining differently.

Let's introduce a PageOffline specific page flag (PG_offline_skippable)
that for now reuses PG_owner_2. In the memdesc future, it will be one of
a small number of per-memdesc flags stored alongside the type.

By setting PG_offline_skippable, a driver indicates that it can
restore the PageOffline state of these specific pages when re-onlining a
memory block: it knows that these pages are supposed to be PageOffline()
without the information in the vmemmap, so it can filter them out and
not expose them to the buddy -> they stay PageOffline().

While PG_offline_offlineable might be clearer, it is also super
confusing. Alternatives (PG_offline_sticky?) also don't quite feel right.
So let's use "skippable" for now.

The flag is not supposed to be used for movable PageOffline pages as
used for balloon compaction; movable PageOffline() pages can simply be
migrated during the memory offlining stage.

Let's convert the single user from our MEM_GOING_OFFLINE approach
to the new PG_offline_skippable approach: virtio-mem. Fortunately,
this simplifies the code quite a lot.

What if someone decides to grab a reference on these pages although they
really shouldn't? After all, we'll now keep the refcount at 1 (until we
can properly stop using the refcount completely).

Well, less worse things will happen than would currently: currently,
if someone would grab a reference to these pages, in MEM_GOING_OFFLINE
we would run into the
		if (WARN_ON(!page_ref_dec_and_test(page)))
			dump_page(page, "fake-offline page referenced");

And once that unexpected reference would get dropped, we would end up
freeing that page to the buddy: ouch.

Now, we'll allow for offlining that memory, and when that unexpected
reference would get dropped, we would not end up freeing that page to
the buddy. Once we have frozen PageOffline() pages, it will all get a
lot cleaner.

Note that we didn't see the existing WARN_ON so far, because nobody
should ever be referencing such pages.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 111 +-----------------------------------
 include/linux/page-flags.h  |  29 +++++++---
 mm/memory_hotplug.c         |  12 ++--
 mm/page_alloc.c             |   8 +--
 mm/page_isolation.c         |  21 +++----
 5 files changed, 42 insertions(+), 139 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 56d0dbe621637..77b72843c4b53 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -278,10 +278,6 @@ static DEFINE_MUTEX(virtio_mem_mutex);
 static LIST_HEAD(virtio_mem_devices);
 
 static void virtio_mem_online_page_cb(struct page *page, unsigned int order);
-static void virtio_mem_fake_offline_going_offline(unsigned long pfn,
-						  unsigned long nr_pages);
-static void virtio_mem_fake_offline_cancel_offline(unsigned long pfn,
-						   unsigned long nr_pages);
 static void virtio_mem_retry(struct virtio_mem *vm);
 static int virtio_mem_create_resource(struct virtio_mem *vm);
 static void virtio_mem_delete_resource(struct virtio_mem *vm);
@@ -924,64 +920,6 @@ static void virtio_mem_sbm_notify_online(struct virtio_mem *vm,
 	virtio_mem_sbm_set_mb_state(vm, mb_id, new_state);
 }
 
-static void virtio_mem_sbm_notify_going_offline(struct virtio_mem *vm,
-						unsigned long mb_id)
-{
-	const unsigned long nr_pages = PFN_DOWN(vm->sbm.sb_size);
-	unsigned long pfn;
-	int sb_id;
-
-	for (sb_id = 0; sb_id < vm->sbm.sbs_per_mb; sb_id++) {
-		if (virtio_mem_sbm_test_sb_plugged(vm, mb_id, sb_id, 1))
-			continue;
-		pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
-			       sb_id * vm->sbm.sb_size);
-		virtio_mem_fake_offline_going_offline(pfn, nr_pages);
-	}
-}
-
-static void virtio_mem_sbm_notify_cancel_offline(struct virtio_mem *vm,
-						 unsigned long mb_id)
-{
-	const unsigned long nr_pages = PFN_DOWN(vm->sbm.sb_size);
-	unsigned long pfn;
-	int sb_id;
-
-	for (sb_id = 0; sb_id < vm->sbm.sbs_per_mb; sb_id++) {
-		if (virtio_mem_sbm_test_sb_plugged(vm, mb_id, sb_id, 1))
-			continue;
-		pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
-			       sb_id * vm->sbm.sb_size);
-		virtio_mem_fake_offline_cancel_offline(pfn, nr_pages);
-	}
-}
-
-static void virtio_mem_bbm_notify_going_offline(struct virtio_mem *vm,
-						unsigned long bb_id,
-						unsigned long pfn,
-						unsigned long nr_pages)
-{
-	/*
-	 * When marked as "fake-offline", all online memory of this device block
-	 * is allocated by us. Otherwise, we don't have any memory allocated.
-	 */
-	if (virtio_mem_bbm_get_bb_state(vm, bb_id) !=
-	    VIRTIO_MEM_BBM_BB_FAKE_OFFLINE)
-		return;
-	virtio_mem_fake_offline_going_offline(pfn, nr_pages);
-}
-
-static void virtio_mem_bbm_notify_cancel_offline(struct virtio_mem *vm,
-						 unsigned long bb_id,
-						 unsigned long pfn,
-						 unsigned long nr_pages)
-{
-	if (virtio_mem_bbm_get_bb_state(vm, bb_id) !=
-	    VIRTIO_MEM_BBM_BB_FAKE_OFFLINE)
-		return;
-	virtio_mem_fake_offline_cancel_offline(pfn, nr_pages);
-}
-
 /*
  * This callback will either be called synchronously from add_memory() or
  * asynchronously (e.g., triggered via user space). We have to be careful
@@ -1040,12 +978,6 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
 			break;
 		}
 		vm->hotplug_active = true;
-		if (vm->in_sbm)
-			virtio_mem_sbm_notify_going_offline(vm, id);
-		else
-			virtio_mem_bbm_notify_going_offline(vm, id,
-							    mhp->start_pfn,
-							    mhp->nr_pages);
 		break;
 	case MEM_GOING_ONLINE:
 		mutex_lock(&vm->hotplug_mutex);
@@ -1094,12 +1026,6 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
 	case MEM_CANCEL_OFFLINE:
 		if (!vm->hotplug_active)
 			break;
-		if (vm->in_sbm)
-			virtio_mem_sbm_notify_cancel_offline(vm, id);
-		else
-			virtio_mem_bbm_notify_cancel_offline(vm, id,
-							     mhp->start_pfn,
-							     mhp->nr_pages);
 		vm->hotplug_active = false;
 		mutex_unlock(&vm->hotplug_mutex);
 		break;
@@ -1157,6 +1083,7 @@ static void virtio_mem_set_fake_offline(unsigned long pfn,
 			SetPageDirty(page);
 		else
 			__SetPageOffline(page);
+		__SetPageOfflineSkippable(page);
 		VM_WARN_ON_ONCE(!PageOffline(page));
 	}
 	page_offline_end();
@@ -1172,6 +1099,7 @@ static void virtio_mem_clear_fake_offline(unsigned long pfn,
 	for (; nr_pages--; pfn++) {
 		struct page *page = pfn_to_page(pfn);
 
+		__ClearPageOfflineSkippable(page);
 		if (!onlined)
 			/* generic_online_page() will clear PageOffline(). */
 			ClearPageDirty(page);
@@ -1261,41 +1189,6 @@ static int virtio_mem_fake_offline(struct virtio_mem *vm, unsigned long pfn,
 	return -EBUSY;
 }
 
-/*
- * Handle fake-offline pages when memory is going offline - such that the
- * pages can be skipped by mm-core when offlining.
- */
-static void virtio_mem_fake_offline_going_offline(unsigned long pfn,
-						  unsigned long nr_pages)
-{
-	struct page *page;
-	unsigned long i;
-
-	/* Drop our reference to the pages so the memory can get offlined. */
-	for (i = 0; i < nr_pages; i++) {
-		page = pfn_to_page(pfn + i);
-		if (WARN_ON(!page_ref_dec_and_test(page)))
-			dump_page(page, "fake-offline page referenced");
-	}
-}
-
-/*
- * Handle fake-offline pages when memory offlining is canceled - to undo
- * what we did in virtio_mem_fake_offline_going_offline().
- */
-static void virtio_mem_fake_offline_cancel_offline(unsigned long pfn,
-						   unsigned long nr_pages)
-{
-	unsigned long i;
-
-	/*
-	 * Get the reference again that we dropped via page_ref_dec_and_test()
-	 * when going offline.
-	 */
-	for (i = 0; i < nr_pages; i++)
-		page_ref_inc(pfn_to_page(pfn + i));
-}
-
 static void virtio_mem_online_page(struct virtio_mem *vm,
 				   struct page *page, unsigned int order)
 {
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 1c1d49554c71a..581510ae8e83a 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -178,6 +178,9 @@ enum pageflags {
 	PG_vmemmap_self_hosted = PG_owner_priv_1,
 #endif
 
+	/* The driver allows for skipping these pages during memory offlining */
+	PG_offline_skippable = PG_owner_2,
+
 	/*
 	 * Flags only valid for compound pages.  Stored in first tail page's
 	 * flags word.  Cannot use the first 8 flags or any flag marked as
@@ -1029,14 +1032,23 @@ PAGE_TYPE_OPS(Buddy, buddy, buddy)
  * refcount of 1 and PageOffline(). generic_online_page() will
  * take care of clearing PageOffline().
  *
- * If a driver wants to allow to offline unmovable PageOffline() pages without
- * putting them back to the buddy, it can do so via the memory notifier by
- * decrementing the reference count in MEM_GOING_OFFLINE and incrementing the
- * reference count in MEM_CANCEL_OFFLINE. When offlining, the PageOffline()
- * pages (now with a reference count of zero) are treated like free (unmanaged)
- * pages, allowing the containing memory block to get offlined. A driver that
- * relies on this feature is aware that re-onlining the memory block will
- * require not giving them to the buddy via generic_online_page().
+ * If a driver wants to allow for offlining unmovable PageOffline() pages
+ * when offlining a memory block without exposing these pages as "free" to
+ * the buddy, it can mark them as PG_offline_skippable.
+ *
+ * By marking these PageOffline pages PG_offline_skippable, the driver
+ * acknowledges that it
+ * (a) knows which pages are PageOffline even without the memmap.
+ * (b) implements the online_page_callback_t callback to exclude these pages
+ *     from getting exposed to the buddy, so they will stay PageOffline()
+ *     when onlining a memory block.
+ * (c) synchronizes against concurrent memory onlining/offlining whenever
+ *     adjusting the PG_offline_skippable flag.
+ *
+ * Note that the refcount of these pages will for now be assumed to always
+ * be 1: nobody except the owner should be referencing these pages.
+ * Offlining code will complain if the refcount is not 1. In the future,
+ * these pages will always be frozen and not have a refcount.
  *
  * Memory offlining code will not adjust the managed page count for any
  * PageOffline() pages, treating them like they were never exposed to the
@@ -1048,6 +1060,7 @@ PAGE_TYPE_OPS(Buddy, buddy, buddy)
  * page_offline_freeze()/page_offline_thaw().
  */
 PAGE_TYPE_OPS(Offline, offline, offline)
+__PAGEFLAG(OfflineSkippable, offline_skippable, PF_NO_COMPOUND)
 
 extern void page_offline_freeze(void);
 extern void page_offline_thaw(void);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index b1caedbade5b1..0cc5537f234bb 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1767,12 +1767,10 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 			goto found;
 
 		/*
-		 * PageOffline() pages that are not marked __PageMovable() and
-		 * have a reference count > 0 (after MEM_GOING_OFFLINE) are
-		 * definitely unmovable. If their reference count would be 0,
-		 * they could at least be skipped when offlining memory.
+		 * PageOffline() pages that are neither "movable" nor
+		 * "skippable" prevent memory offlining.
 		 */
-		if (PageOffline(page) && page_count(page))
+		if (PageOffline(page) && !PageOfflineSkippable(page))
 			return -EBUSY;
 
 		if (!PageHuge(page))
@@ -1807,6 +1805,10 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 		struct page *page;
 
 		page = pfn_to_page(pfn);
+
+		if (PageOffline(page) && PageOfflineSkippable(page))
+			continue;
+
 		folio = page_folio(page);
 
 		if (!folio_try_get(folio))
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a6fe1e9b95941..325b51c905076 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7023,12 +7023,12 @@ unsigned long __offline_isolated_pages(unsigned long start_pfn,
 			continue;
 		}
 		/*
-		 * At this point all remaining PageOffline() pages have a
-		 * reference count of 0 and can simply be skipped.
+		 * At this point all remaining PageOffline() pages must be
+		 * "skippable" and have exactly one reference.
 		 */
 		if (PageOffline(page)) {
-			BUG_ON(page_count(page));
-			BUG_ON(PageBuddy(page));
+			WARN_ON_ONCE(!PageOfflineSkippable(page));
+			WARN_ON_ONCE(page_count(page) != 1);
 			already_offline++;
 			pfn++;
 			continue;
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index b2fc5266e3d26..debd898b794ea 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -121,16 +121,11 @@ static struct page *has_unmovable_pages(unsigned long start_pfn, unsigned long e
 			continue;
 
 		/*
-		 * We treat all PageOffline() pages as movable when offlining
-		 * to give drivers a chance to decrement their reference count
-		 * in MEM_GOING_OFFLINE in order to indicate that these pages
-		 * can be offlined as there are no direct references anymore.
-		 * For actually unmovable PageOffline() where the driver does
-		 * not support this, we will fail later when trying to actually
-		 * move these pages that still have a reference count > 0.
-		 * (false negatives in this function only)
+		 * PageOffline() pages that are marked as "skippable"
+		 * are treated like movable pages for memory offlining.
 		 */
-		if ((flags & MEMORY_OFFLINE) && PageOffline(page))
+		if ((flags & MEMORY_OFFLINE) && PageOffline(page) &&
+		    PageOfflineSkippable(page))
 			continue;
 
 		if (__PageMovable(page) || PageLRU(page))
@@ -577,11 +572,11 @@ __test_page_isolated_in_pageblock(unsigned long pfn, unsigned long end_pfn,
 			/* A HWPoisoned page cannot be also PageBuddy */
 			pfn++;
 		else if ((flags & MEMORY_OFFLINE) && PageOffline(page) &&
-			 !page_count(page))
+			 PageOfflineSkippable(page))
 			/*
-			 * The responsible driver agreed to skip PageOffline()
-			 * pages when offlining memory by dropping its
-			 * reference in MEM_GOING_OFFLINE.
+			 * If the page is a skippable PageOffline() page,
+			 * we can offline the memory block, as the driver will
+			 * re-discover them when re-onlining the memory.
 			 */
 			pfn++;
 		else
-- 
2.49.0

