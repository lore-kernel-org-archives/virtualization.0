Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014342D6E70;
	Thu, 15 Jan 2026 09:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768468907; cv=none; b=FB0WK3Qrs+HiBkHhYb4mPl/FP4Cehc2432mniOOG6VFmmflGRFv0n7p1V2anQpLQ/+qutJTasEPdW2z0gVeWYCkanCk21si5gj15FoTvxIiNnOF/Kbvzh4lP0B/93K4Vx7SbnkC4BC7bgWEKQoho2xmNU0uOvd3JuQLPAp2qyZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768468907; c=relaxed/simple;
	bh=QfJODb3fLD5hI0yqpV8bPffFJbeeNR9z0J/ex3110GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEiYaL6wvPaTKvaCRogOJrbXPD8UW1n50pZ0bqfbBhmxGYkiHCLYENUCJ2qTnFnKtd5uofjKw40dD1HVIiefKnwgCkDRNtfUSHBbmsa05jUbPsqhLsIiAQjfUsFxj2C1cpqjkk5Xu1zOmyMp3uaNrZvR42SSl2RWOYcPhIg6l0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFYSnzrR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFYSnzrR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3F7C116D0;
	Thu, 15 Jan 2026 09:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768468906;
	bh=QfJODb3fLD5hI0yqpV8bPffFJbeeNR9z0J/ex3110GQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OFYSnzrRIk8CUweoFvnALc8UkccAxZt/i3iCriyBA+I/zJLMeME8Mp2WVUoiICN3b
	 CBVMgtFX/1kPf6qCUSX8OuUmfeDlgSrLnIZMdi1GXhai8maIA8s0xRP63jmbrO9BkO
	 2arju4rT7IQiibRnpqgIe+UbVDQRnOx3QuBgrDXkDgnbUIey/MD/gCgq1h9VbyOCmg
	 BMg15H/nhYtfsbk8SCZQSruMTcFGWI/6EcjjsDuezMPHOdQ9Mv/NfXCh0wJGwx2Cmn
	 MsAxSB0BlH4irDhYEedCtspCpCYR72b65QBxumJxnErOBx0dBYbhsHJdwr4/+xuw1e
	 TFQdfFS4JjoLQ==
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
Subject: [PATCH v2 12/23] mm/balloon_compaction: remove balloon_page_push/pop()
Date: Thu, 15 Jan 2026 10:20:02 +0100
Message-ID: <20260115092015.3928975-13-david@kernel.org>
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

Let's remove these helpers as they are unused now.

Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
---
 include/linux/balloon_compaction.h | 30 ------------------------------
 mm/balloon_compaction.c            |  5 ++---
 2 files changed, 2 insertions(+), 33 deletions(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index 1452ea0635245..e5451cf1f6589 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -126,34 +126,4 @@ static inline void balloon_page_finalize(struct page *page)
 		set_page_private(page, 0);
 	/* PageOffline is sticky until the page is freed to the buddy. */
 }
-
-/*
- * balloon_page_push - insert a page into a page list.
- * @head : pointer to list
- * @page : page to be added
- *
- * Caller must ensure the page is private and protect the list.
- */
-static inline void balloon_page_push(struct list_head *pages, struct page *page)
-{
-	list_add(&page->lru, pages);
-}
-
-/*
- * balloon_page_pop - remove a page from a page list.
- * @head : pointer to list
- * @page : page to be added
- *
- * Caller must ensure the page is private and protect the list.
- */
-static inline struct page *balloon_page_pop(struct list_head *pages)
-{
-	struct page *page = list_first_entry_or_null(pages, struct page, lru);
-
-	if (!page)
-		return NULL;
-
-	list_del(&page->lru);
-	return page;
-}
 #endif /* _LINUX_BALLOON_COMPACTION_H */
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index c44e0b62203cc..90b2d61a593b7 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -128,9 +128,8 @@ EXPORT_SYMBOL_GPL(balloon_page_alloc);
  * Drivers must call this function to properly enqueue a new allocated balloon
  * page before definitively removing the page from the guest system.
  *
- * Drivers must not call balloon_page_enqueue on pages that have been pushed to
- * a list with balloon_page_push before removing them with balloon_page_pop. To
- * enqueue a list of pages, use balloon_page_list_enqueue instead.
+ * Drivers must not enqueue pages while page->lru is still in
+ * use, and must not use page->lru until a page was unqueued again.
  */
 void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
 			  struct page *page)
-- 
2.52.0

