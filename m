Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB5E35B14C;
	Thu, 15 Jan 2026 09:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768468930; cv=none; b=r3LKcPNAMdhpH05visk8NNJyiYvwUVejTT1Vj+KBPtU58+7hmjuYnWvTMWE3dQKWvUN2xxbNbKvQhxWXMrE2TCDqx1dcsgNkplFDnSxRbEy4H7wFndU28Vcw9mlpFAa3Cs62+BOiv1FITq6UFMWQ6m2MBg0XPJNaErlSnWOP1k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768468930; c=relaxed/simple;
	bh=9RrxLDqhOcILNhAHJt+XRLUWGRQWJudLU4Xe8hhYhVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTemB8VddJEawuYtkkiXighsidiycZUdE/kLoqfHbqfCtSfeaNvbkCbXqvTa2QqOXwgqEiQ8FJf/eu+Znd2YNJrLMLJyvS3r5hnoq2SMxRNGymBMC6gDFQsCprFL4CX9hFLWV8qtp0C8L+5gIJ6PlLCyGyfhKex9NTBQoBNqQH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZdLhXG4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZdLhXG4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4A1C116D0;
	Thu, 15 Jan 2026 09:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768468927;
	bh=9RrxLDqhOcILNhAHJt+XRLUWGRQWJudLU4Xe8hhYhVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kZdLhXG4JXKgdqJL7DBaf/x0yhRcWA9OMea3z22FVMpb45e1AaUr5hCLnS7f6YE70
	 De84oIOk6cku3p9sQhGMVZskL3VdEGt9Ewx80abTgrJKY4swAbL7miB0ZBVaEtBNRs
	 LL+KhZAmuO0EV3W4N4F4/bifWzXyoSFMibubLSjNT4Lvbq01o9PD5M0/KuzxxGAlRc
	 pLcCk39qQsCsTevuPxOywxBWafY5Koq0CnZqDsn1KfM3FV/RAEoo8IJbgMX6/XoKOY
	 ukV9b8vgh4FO+UTIvYaYV/n4HqHOJpoe86jRjAMqgxRCcnPJTKAtCShqEKaeucUCQU
	 rU9hb8FynZuxw==
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
Subject: [PATCH v2 15/23] mm/balloon_compaction: assert that the balloon_pages_lock is held
Date: Thu, 15 Jan 2026 10:20:05 +0100
Message-ID: <20260115092015.3928975-16-david@kernel.org>
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

Let's add some sanity checks for holding the balloon_pages_lock when
we're effectively inflating/deflating a page.

Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
---
 mm/balloon_compaction.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 717bc43732d09..f6e0582bd7ffe 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -33,6 +33,7 @@ static inline struct balloon_dev_info *balloon_page_device(struct page *page)
 static inline void balloon_page_insert(struct balloon_dev_info *balloon,
 				       struct page *page)
 {
+	lockdep_assert_held(&balloon_pages_lock);
 	__SetPageOffline(page);
 	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION)) {
 		SetPageMovableOps(page);
@@ -50,6 +51,7 @@ static inline void balloon_page_insert(struct balloon_dev_info *balloon,
  */
 static inline void balloon_page_finalize(struct page *page)
 {
+	lockdep_assert_held(&balloon_pages_lock);
 	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION))
 		set_page_private(page, 0);
 	/* PageOffline is sticky until the page is freed to the buddy. */
-- 
2.52.0

