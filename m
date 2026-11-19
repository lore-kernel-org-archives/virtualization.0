Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795089778;
	b=zXO4hL64LVYBIz+mLJRCyLnT25if2oNEwGTAhKpUgIoEBfo3fOM0+NT1DPQo6K5c2+1a
	 sDrd74EzYptxUgZab4CCmno38oO63KqLUx5NLR63oIDH4KjefUUNH40jDfA5di3IIEI5W
	 1ZJn4dMsouQ29k3C1ECnx4UrrZoz1F79J3h5TzVJl7mV16321BqaQIr2nV5hJj7LSzq1j
	 Xd832ctxGMSJUIUGPr20LypP9FRhNXQyNE1yaM1A+TogduEOb6LTbzZGFEe+69cexvjRq
	 CM03aXOy9nk1hk98s9FaEW4vm91ArWqvExJvkTwgJ0TohSXYnR9ek5qKTNXt3ZJ0KPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795089778;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=kbCSLrCrP7oRdquD/0Llnb20nwRhMvgzSZfeCvbl4HU=;
	b=w8Hk9F5LQotxF3pzPOVXdNEVPzWEAiybxX3CMlA8djIu7Bz48tDi0oMDiYQQgAhUquTD
	 cYVpc8ZA5MwXZEEJ3Y2lPdmPYj/W1BwmeiP/uIiK6pIXFCbxSYj4g4Zlvx9f6ZTwx0Kk6
	 y1bIR7Bl4tfBXLf9E9epbQQJ0e+BZmsy49o4syAeEXvYg1nYg04mU7ERGkIAomzB6vsFb
	 uOnHVqQXoQfQAy+7RBWmU+vFXs/lMhMxOa1DO2CcDRaIr0NxhJ02At0UaMVBsDpL2iWq4
	 urwJQetsGmtHQkSkDZa/DXNDbQggZ/qFvsgcqrTOLhRBLH0h/AqVGuQDjqqfCnKzyLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WbUiMHBE;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E67C606A326
	for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 12:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E67C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WbUiMHBE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795089777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kbCSLrCrP7oRdquD/0Llnb20nwRhMvgzSZfeCvbl4HU=;
	b=WbUiMHBEuvIDHAG3Mk9l9D6sMtH4mX6/CydEmVUXLD71Ewfj/XTRiPATN+SDiHCjhf823j
	tX2b+hpGnoF1j6f9+cjHbe2wB0STZ5zSU1qs1AC51F+N0fRC+pnDWrzioy7AXDZaKdD0gj
	4FxIv9zO6PWEY+1MwbeAr7lWpUJs4Hk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-gIVv_fJmO7etuf2w-hezHQ-1; Thu, 19 Nov 2026 07:02:54 -0500
X-MC-Unique: gIVv_fJmO7etuf2w-hezHQ-1
X-Mimecast-MFC-AGG-ID: gIVv_fJmO7etuf2w-hezHQ_1795089773
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48fcb657f32so1307151f8f.2
        for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 04:02:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795089773; x=1795694573;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kbCSLrCrP7oRdquD/0Llnb20nwRhMvgzSZfeCvbl4HU=;
        b=a4DZuF9cP5Gl+rAz9cAR7H8M2XPfRIA004qsO9t/mm2e0zaLx0ULfM4xw2FzPnVINc
         RL4Hg8t6NrO0oQ6r8mDFbmy+F3rHmUfHa4vQT62BKp9NJrPOUvuqnQd6Mn8gAWz9F28k
         LGIftl5PxW60E6ir+T4vw5YPBOAvGxajCOWGb1hMkm4AeHa0XWhMA1UsZ1a31Gp+KBK3
         0fN5tnPgikbXmlnaA06xfFNfuEHdm9nnJxf2G/yz0N1p5l+UFdWNnbEmj9KV6TrYvCaE
         45o0tEO6LLoZJaHRkjloJUW+ZaIDGKXvM+gPg09Z0gy5EFI+F/lxVwWgMKFTQdbhtI2C
         yRng==
X-Forwarded-Encrypted: i=1; AL+hErHBnR9h3QSsYwbhh4XxmVGITMp+n6T+i8JG5nEWA8U4jfIJETULSEL7RIKIw2H+rsc3mvNxXg7H4cjz5A/Mtg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/bF+638n5UQqH6NmgFhANmurgE1n2oE2lNl0oM8wkCgPE2WMaw
	hgt3TdQSTepmdPzkF45s/jUsNuVD2nFMlYs3W9WAbPQx4+xw2C3b8LIgd/vcbkVINVLutpKODBb
	asqr2CwaVxmH7KkQ0PuqeImGLSFbZWu1XhWGDv8LSxKVoQkxZvS2rjJMwh3twYaXA/tlx
X-Gm-Gg: AZFdTZeFhgUbn9tsncuxGQwcGfzlfFM6W3iRi5uU6AKq8xJidsVxz4b2kgWuAKvdvX4
	tK4ZoDuLB/g8IcL4kkFAKNkNGex1Q/n80op07SkoPw5bB5l2PML6z8onp4F7mW73SBnc10z5Bhv
	prfAvOXoe1W43KzegTN55k/qBiGJDAIqFBpiBf+WXn4umSfSiAtIxD3THuYp50l3zxX5sggTkV6
	7hoYPgcj9pAwhHDORsBkuIox8zHYod5WepOEuyjvBq09WOnZxfBST0tjZ/O+dfDM1MAucDv/kMZ
	Akv3NbXSWLKTgDEC2gDemdFa6YBFZsZpXZjVh0Cn+Tn9G6TzkWFVzL0NLaj0e+rLXFaw4r5RnN8
	sEDP2V8/28ug0Ajdq1gGDyl6nDOme55IY76rLkuw1Zpc=
X-Received: by 2002:a05:6000:4283:b0:4a9:b2f1:aac4 with SMTP id ffacd0b85a97d-4a9b2f1adadmr3551656f8f.22.1795089772533;
        Thu, 19 Nov 2026 04:02:52 -0800 (PST)
X-Received: by 2002:a05:6000:4283:b0:4a9:b2f1:aac4 with SMTP id ffacd0b85a97d-4a9b2f1adadmr3551587f8f.22.1795089771908;
        Thu, 19 Nov 2026 04:02:51 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1520:4400:d78d:7b2d:2f5d:e08f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a65560b5f1sm10622532f8f.21.2026.11.19.04.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 04:02:49 -0800 (PST)
Date: Thu, 19 Nov 2026 07:02:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, Dev Jain <dev.jain@arm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Gregory Price <gourry@gourry.net>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Lance Yang <lance.yang@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Miaohe Lin <linmiaohe@huawei.com>, Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org, virtualization@lists.linux.dev,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Brendan Jackman <brendan.jackman@linux.dev>
Subject: [PATCH v11 4/7] mm: skip zeroing of pre-zeroed order-0 user pages
Message-ID: <73917d7bc27d763dbcdd2044d311acaf452144a0.1795089715.git.mst@redhat.com>
References: <cover.1795089715.git.mst@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <cover.1795089715.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TEJrdCIA4rq10FBem0CYUXa_4tmBcTlc7MpL7lOARE4_1795089773
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Skip initialization for order-0 PG_zeroed folios.

For the generic vma_alloc_zeroed_movable_folio(), skip clearing known-zero
contents and unpoison KMSAN metadata.

On x86, vma_alloc_zeroed_movable_folio() requests __GFP_ZERO, so check
PageZeroed() in post_alloc_hook() to cover that.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: LLM
---
 include/linux/highmem.h | 8 ++++++--
 mm/page_alloc.c         | 5 ++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 70bbe93b8d669..4abd2a0fd82f7 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -344,8 +344,12 @@ struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
 	struct folio *folio;
 
 	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr);
-	if (folio && user_alloc_needs_zeroing())
-		clear_user_highpage(&folio->page, vaddr);
+	if (folio) {
+		if (folio_is_zeroed(folio))
+			kmsan_unpoison_memory(folio_address(folio), PAGE_SIZE);
+		else if (user_alloc_needs_zeroing())
+			clear_user_highpage(&folio->page, vaddr);
+	}
 
 	return folio;
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 927a288eb419b..c2cb2f66c1736 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1829,8 +1829,11 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 				gfp_t gfp_flags, unsigned int alloc_flags)
 {
 	const bool zero_tags = gfp_flags & __GFP_ZEROTAGS;
+	/*
+	 * Skip zeroing if already done. Sanitizer handling still needs to happen.
+	 */
 	bool init = !want_init_on_free() && want_init_on_alloc(gfp_flags) &&
-			!should_skip_init(gfp_flags);
+			!should_skip_init(gfp_flags) && !PageZeroed(page);
 	int i;
 
 	set_page_private(page, 0);
-- 
MST

