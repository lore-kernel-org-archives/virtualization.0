Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C51B3358CA;
	Thu, 15 Jan 2026 09:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768468913; cv=none; b=l407bT4HKIHvRfaPZihXur53A3h6F9z3vbuT2ZuQvjrPWKOa+t1DvkcRtuJPvlVIxwF8qQOrKGDL47lWDbS97j31snIshvE3DiysxGwuITpJ1POp94BJ7PP9W4MEAxEORSMTQ/W8ZUULKY7bLuXoTe5jnQxYVOkRwVWui1eoLSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768468913; c=relaxed/simple;
	bh=plBsJJDsOVKU21GBNZQ0Y8RZZjUVLRU39NQAtNsDJJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFsct9xzgxB2HYPQ8wB5wgV69dyZvjWO0ktIWs9NeNM4yoB2SYm/u1RocPIOUYSV8TXLpLBdiPhrnyl3z4B70WEKb1Qn+GaLnso+mLd2C3/Za3Tc5QP/jrd98JzxmTNjzQu2GI0HRGJfHE+PPBxifa9Wix620X2KbPyiGyYtFvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRoEkz+a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRoEkz+a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4188CC116D0;
	Thu, 15 Jan 2026 09:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768468913;
	bh=plBsJJDsOVKU21GBNZQ0Y8RZZjUVLRU39NQAtNsDJJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hRoEkz+axwnx4uvOCDJzNCaEEpypD+Or2qirVm812qm0RODJPsAre4QcDoHRFY5vA
	 VvzJNNVDMVeOZ6M0jX2zENDqjSJgKmq3oifv1Lk3etoFnUduMtCuUDCWdad/m0rnth
	 UnuLcfh3utfedo46BP5h6OyQngyqEhhAbE2Klhz/a95rbb9AT3GYON8iv7QnS6qRu4
	 G+T4YFdkhIO2gvjUSbyHvhwkF4qJtcMlxNTDtkxSYXkZAcUrkfDBJFnNlGgn4/p/ar
	 9SlBNZXOdFDnUFDs+pp4AAM2r7MeE4fv/JvsPM8gm+cbiSWlt4pF5pLkt0vvE04HUX
	 IuUAF6cCw2KaQ==
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
Subject: [PATCH v2 13/23] mm/balloon_compaction: fold balloon_mapping_gfp_mask() into balloon_page_alloc()
Date: Thu, 15 Jan 2026 10:20:03 +0100
Message-ID: <20260115092015.3928975-14-david@kernel.org>
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

Let's just remove balloon_mapping_gfp_mask().

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
index 90b2d61a593b7..709c57c00b481 100644
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

