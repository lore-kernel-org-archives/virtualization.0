Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7EC333452;
	Thu, 15 Jan 2026 09:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768468866; cv=none; b=foRWnEgS1F3M8RCc8kQqmOs89xJuuWvyTlErdfMoqVkOLXfQUCOhdfFzSoBeqypDF4rtZjJg3e0qkTsSNxm0TSIUlwbyeh9q7maVXDkQE1tcNsbyveKmAQ2DWuQAB/7KupSAPCUe6+Vtx7KpX6wpadko7d3QVO9+dTj/bgBubMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768468866; c=relaxed/simple;
	bh=q+Q0Uz5/ogC154Dbd2goOOehqbQ7Ij08x/c47bAW3yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W3kFcaUPrcrNmsaFNFNUg8tnqdkfr2H+VRXkyBQGljQ3pg0f90cZJJrsbT503vbHMxrUxsLR0piW87qIkXu6aLT88SpQviKR6NhSL+O8A35qG9wtrfiTHfxjGOB3mnt043XTwAnxF6x6o21Cptdwus1g7syhH0DmxLFlsEVYRMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXLQM63O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXLQM63O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD927C116D0;
	Thu, 15 Jan 2026 09:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768468866;
	bh=q+Q0Uz5/ogC154Dbd2goOOehqbQ7Ij08x/c47bAW3yk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YXLQM63OvUIAXjYM+1gJ3tSen1quB36s7/mPz09KWLc8uyMyUjvkG+5++fUqmVxEC
	 Ykn9RLJBfr+XLAQCzsxuqPR3iFk2NH5/VUlGWjrSQvbN6yRv6MdW+RPqgfBGTpbb7s
	 yNUtgwNE0o8ISZJVBv0oWmfNnm2mXPLKwkfb9gfxKlvygbG7+Qgtuzt2sunaQRDlew
	 /SjsLbp9llx3T5l3KcqqQxexGe+DtC/i7Rli1miNq1yQYMRLazApEy59dXNa41Y9aj
	 sEY7jrlMhmyPaOGOgRBrG9ePy1z2tZsMKrJJKpCEre3nCdobOpHUefVnVn5mBk6HET
	 ZAoNRBLwYG8TA==
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
Subject: [PATCH v2 06/23] vmw_balloon: stop using the balloon_dev_info lock
Date: Thu, 15 Jan 2026 10:19:56 +0100
Message-ID: <20260115092015.3928975-7-david@kernel.org>
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

Let's not piggy-back on the existing lock and use a separate lock for the
huge page list. Now that we use a separate lock, there is no need to
disable interrupts, so use the non-irqsave variants.

This is a preparation for changing the locking used to protect
balloon_dev_info.

While at it, talk about "page migration" instead of "page compaction".
We'll change that in core code soon as well.

Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
---
 drivers/misc/vmw_balloon.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 52b8c0f1eead7..53e9335b6718c 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -354,10 +354,15 @@ struct vmballoon {
 	/**
 	 * @huge_pages - list of the inflated 2MB pages.
 	 *
-	 * Protected by @b_dev_info.pages_lock .
+	 * Protected by @huge_pages_lock.
 	 */
 	struct list_head huge_pages;
 
+	/**
+	 * @huge_pages_lock: lock for the list of inflated 2MB pages.
+	 */
+	spinlock_t huge_pages_lock;
+
 	/**
 	 * @vmci_doorbell.
 	 *
@@ -987,7 +992,6 @@ static void vmballoon_enqueue_page_list(struct vmballoon *b,
 					unsigned int *n_pages,
 					enum vmballoon_page_size_type page_size)
 {
-	unsigned long flags;
 	struct page *page;
 
 	if (page_size == VMW_BALLOON_4K_PAGE) {
@@ -995,9 +999,9 @@ static void vmballoon_enqueue_page_list(struct vmballoon *b,
 	} else {
 		/*
 		 * Keep the huge pages in a local list which is not available
-		 * for the balloon compaction mechanism.
+		 * for the balloon page migration.
 		 */
-		spin_lock_irqsave(&b->b_dev_info.pages_lock, flags);
+		spin_lock(&b->huge_pages_lock);
 
 		list_for_each_entry(page, pages, lru) {
 			vmballoon_mark_page_offline(page, VMW_BALLOON_2M_PAGE);
@@ -1006,7 +1010,7 @@ static void vmballoon_enqueue_page_list(struct vmballoon *b,
 		list_splice_init(pages, &b->huge_pages);
 		__count_vm_events(BALLOON_INFLATE, *n_pages *
 				  vmballoon_page_in_frames(VMW_BALLOON_2M_PAGE));
-		spin_unlock_irqrestore(&b->b_dev_info.pages_lock, flags);
+		spin_unlock(&b->huge_pages_lock);
 	}
 
 	*n_pages = 0;
@@ -1033,7 +1037,6 @@ static void vmballoon_dequeue_page_list(struct vmballoon *b,
 {
 	struct page *page, *tmp;
 	unsigned int i = 0;
-	unsigned long flags;
 
 	/* In the case of 4k pages, use the compaction infrastructure */
 	if (page_size == VMW_BALLOON_4K_PAGE) {
@@ -1043,7 +1046,7 @@ static void vmballoon_dequeue_page_list(struct vmballoon *b,
 	}
 
 	/* 2MB pages */
-	spin_lock_irqsave(&b->b_dev_info.pages_lock, flags);
+	spin_lock(&b->huge_pages_lock);
 	list_for_each_entry_safe(page, tmp, &b->huge_pages, lru) {
 		vmballoon_mark_page_online(page, VMW_BALLOON_2M_PAGE);
 
@@ -1054,7 +1057,7 @@ static void vmballoon_dequeue_page_list(struct vmballoon *b,
 
 	__count_vm_events(BALLOON_DEFLATE,
 			  i * vmballoon_page_in_frames(VMW_BALLOON_2M_PAGE));
-	spin_unlock_irqrestore(&b->b_dev_info.pages_lock, flags);
+	spin_unlock(&b->huge_pages_lock);
 	*n_pages = i;
 }
 
@@ -1828,6 +1831,7 @@ static int __init vmballoon_init(void)
 		balloon.b_dev_info.migratepage = vmballoon_migratepage;
 
 	INIT_LIST_HEAD(&balloon.huge_pages);
+	spin_lock_init(&balloon.huge_pages_lock);
 	spin_lock_init(&balloon.comm_lock);
 	init_rwsem(&balloon.conf_sem);
 	balloon.vmci_doorbell = VMCI_INVALID_HANDLE;
-- 
2.52.0

