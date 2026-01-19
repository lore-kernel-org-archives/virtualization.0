Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81F82D1F7B;
	Mon, 19 Jan 2026 23:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768863799; cv=none; b=O9AefXIcQv+gBYYFtCJuIqsQgcYwDjgbCPY+CJVrBMa863QvmIBqgYZDVdlAH9rsoUlM7KR+9Q2tvAoIr56Kuwhs63t7ZnHMvymJ3VKogKQ4kCwtVqJewDT9zW9vhu/bltErIzi/6++gB/jJIqS/M0rlBli7DOF3/Dzs6BuG+QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768863799; c=relaxed/simple;
	bh=hAWBq8N2XzK189AInPRuJ5pazUVvYkJ/XMbZxTDq6Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNCdy0BoEwibqab6CoK4puBsoUAaL5YaHHtmdYL3U9BpRnyCDqQ50aW/1OD77Tk9Lw4fSZpy7mNLZO1q22zM2On3so+c1YTg8o1CTvz86/Np0esIx9HE7AuwmXkfrvHHs4dY/Vq+4qlxDLdJ1OE+qf+JtKUWUcp9a4MCPDCV7oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFA8vN+u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFA8vN+u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5E1C19423;
	Mon, 19 Jan 2026 23:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768863799;
	bh=hAWBq8N2XzK189AInPRuJ5pazUVvYkJ/XMbZxTDq6Xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NFA8vN+uYHR1P2fcxt6dMoEyzFf4LfnUtoYyt9jx8oJu4wPKt6rnUGaOTyEZYUT6H
	 dwRMcM3AoTHnOBj7Y7SeG8+dLb70NLGg6HzZVhlzoAopdTAJL5pwYzJCUst4v5Nryg
	 LUAQfpNqqCc2x/VlxAiNNMB/3Eg1QT/Tp5j+5Itm9maLATp737NmUvp96+XTGqU5WW
	 SUmW/x5bmEkWKMAH6dTnU9DSZfEc83G8WzB/PDYui+mc+2Bww/LK/PRCNT6Qzfu/dg
	 0n/5PvsszAJAl61QvjQpjJcfl3ka2RgTgd29liaO1naJSGx2w/SbzGWfP2kTIAK5Vu
	 lvGnoxIaRtZwg==
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
Subject: [PATCH v3 14/24] mm/balloon_compaction: fold balloon_mapping_gfp_mask() into balloon_page_alloc()
Date: Tue, 20 Jan 2026 00:01:22 +0100
Message-ID: <20260119230133.3551867-15-david@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119230133.3551867-1-david@kernel.org>
References: <20260119230133.3551867-1-david@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's just remove balloon_mapping_gfp_mask().

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
---
 include/linux/balloon_compaction.h |  7 -------
 mm/balloon_compaction.c            | 12 ++++++++----
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index e5451cf1f6589..d1d4739398978 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -106,13 +106,6 @@ static inline void balloon_page_insert(struct balloon_dev_info *balloon,
 	list_add(&page->lru, &balloon->pages);
 }
 
-static inline gfp_t balloon_mapping_gfp_mask(void)
-{
-	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION))
-		return GFP_HIGHUSER_MOVABLE;
-	return GFP_HIGHUSER;
-}
-
 /*
  * balloon_page_finalize - prepare a balloon page that was removed from the
  *			   balloon list for release to the page allocator
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 5e1507a13a52f..1843e168db3ca 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -112,10 +112,14 @@ EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
  */
 struct page *balloon_page_alloc(void)
 {
-	struct page *page = alloc_page(balloon_mapping_gfp_mask() |
-				       __GFP_NOMEMALLOC | __GFP_NORETRY |
-				       __GFP_NOWARN);
-	return page;
+	gfp_t gfp_flags = __GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
+
+	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION))
+		gfp_flags |= GFP_HIGHUSER_MOVABLE;
+	else
+		gfp_flags |= GFP_HIGHUSER;
+
+	return alloc_page(gfp_flags);
 }
 EXPORT_SYMBOL_GPL(balloon_page_alloc);
 
-- 
2.52.0

