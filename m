Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52143FDC18
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068195; cv=none; b=k1Fciu8CjoB/FEAI40n75JwbhnLwNBnORQEyXaFo9SCvvDQioJdnu9ri6TscITZjt8XN3uEun2tvtRlEK3PNESfRkjuXeLY6rzm9v5o6OcxP4Q5UNlfMO5Y8Bd5m9riQnt9zpAl/uFNVimWheVtXGX4jlpXcUmWbZYbiZFpt5/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068195; c=relaxed/simple;
	bh=Y8nJwk5bnDwHUaiRuu38UiZrbZgOyq6/yOrVYrwIdY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kgrYXgVXFb3P6jAuOoxXOaS+b5Bp+MdMHm4uiEkHGn9xwM0++/7wzm/viY6tSEWv4Mz3RNzaFenNuGg0EEwTPp/kP/WYas0YSc3Ys5wzxXvtvP3VfTFCK3MeP7zcubkyk2BdOrisRIZDyVI19ot0o2yR2RL93cfIMlJRNc3FacQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gx5MndYD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gx5MndYD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780068191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xr0Wq/tgum3c1wWvimcTvl9O1enHA5UssViDpRUdduM=;
	b=gx5MndYDGn7iBNMrIfuLcmZxajvB7fJPXCNFuIJEBHQodNddNFbxpHY0w61DSpzfrEHebw
	NcLS4SF2NDNHeVfvZFY/Ogxq4ezRWNMJCVqeIganEU37p2uuYDvU8PeHptUMl0tm6b7zNE
	z3o4sEkEI7Xww+pdftdo9Sxmf4kj+L8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-xKX-zXNhNIqYx79T1a29cQ-1; Fri, 29 May 2026 11:23:10 -0400
X-MC-Unique: xKX-zXNhNIqYx79T1a29cQ-1
X-Mimecast-MFC-AGG-ID: xKX-zXNhNIqYx79T1a29cQ_1780068189
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45eeee26201so675732f8f.0
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068189; x=1780672989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xr0Wq/tgum3c1wWvimcTvl9O1enHA5UssViDpRUdduM=;
        b=YbyDBN1JNGcakO46Cld7E9mo8zV3FVneaGLlukWAobYqOLBFgOgqpo19KWwAHCUXZa
         yESZiNvZBOSvSgovwObfAjvkaRg8JHhtGN0fB5QHC4dn45ipHEXJKRexmQ3A1taMEl8T
         GyiZch5fLdxe0PlrbJI5REXvdCXSWsviil9t06EeXEGLKFmwlElW/C/k9srPbgrfCGvp
         uUfF0knF/mboXr37jB9puJ2YwFecH2yuN/Y3OndNRbuEsna3BwvUmo9ypIOEwMTPKkDr
         QT7PrzJobx4KLII1f5x2KTMDi7l10uS3QFzrggFYbPsFygb99Zm9gwgMDq/m+cmCZb71
         Dnbw==
X-Forwarded-Encrypted: i=1; AFNElJ9+oyjORMsD17Hner6YjhGXyXmd6NT30INjbsJl5/B87VrdLlX0cIljbpQx+zCIDmWJ+rXw+Wuj7E6Gby0UcQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYkffujDnkGSiP7qn1a05bus/UCdyP2KTLVUcOu0M7DLQ4FZR6
	ojQ0px84PhIUqYKQxGkXUileRKZYKzYQ9kok3Bxc1DqYFrwiWSVeZkhvivA0IprD/Xb+jBMNo8A
	ew1q5Z5OcdahYWE7FWsULmA01R6faz2y78FonsaUdlgLukSMjONVsqtzCO3lC/QPmF7L6
X-Gm-Gg: Acq92OGB48RH9hYE7HO34ZWEmnoEvXYqUSmtaAZl/GfyajCkb2z5HmIOWOQ6qUa9Bqq
	Vnt51dIsyuIsZKRifFZwopQUCyMyXCgoJkO2bycrERbLraQUoPlGjqbB23BK/Rvp5JsjeesS4xS
	87SPW/daI4Y1ncrYKdI6sCBYUg823jFyO3aj+W4iMpdp0bIR7BV3XoH2/6kaYabS9/LxmFbuKqq
	wDRCteXUMSG3qp2DDeTAd00g5HdW6IIhpyZN9F3j9OxXlze1is4evYCyj9G10UKESN4xApeKTQ8
	OWB862AHV7v3fBhIKEJFXP+Orysl1tPlb/zAP1aBL0TRJGElWVGtb+NM1JHMA6mwqoXXKGhV9c7
	zZJAFif4fzHNERoUi86GqfRpN9+Zfla/BKOpCXksQN05Uusec0jh/+w==
X-Received: by 2002:a05:6000:41f9:b0:45e:93d6:359b with SMTP id ffacd0b85a97d-45ef6b2254amr513221f8f.9.1780068188969;
        Fri, 29 May 2026 08:23:08 -0700 (PDT)
X-Received: by 2002:a05:6000:41f9:b0:45e:93d6:359b with SMTP id ffacd0b85a97d-45ef6b2254amr513116f8f.9.1780068188420;
        Fri, 29 May 2026 08:23:08 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef35874b7sm4319354f8f.35.2026.05.29.08.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:23:07 -0700 (PDT)
Date: Fri, 29 May 2026 11:23:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	virtualization@lists.linux.dev, linux-mm@kvack.org,
	Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v9 12/37] mm: use folio_zero_user for user pages in
 post_alloc_hook
Message-ID: <efa8b140d51f8993d9b11b2f69cde07b3ee1ab26.1780067977.git.mst@redhat.com>
References: <cover.1780067977.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1780067977.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: El-czsMq660Gt8v8b18ojyZYcODmc8TiP54QQNToXqI_1780068189
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When post_alloc_hook() needs to zero a page for an explicit
__GFP_ZERO allocation for a user page (user_addr is set), use folio_zero_user()
instead of kernel_init_pages().  This zeros near the faulting
address last, keeping those cachelines hot for the impending
user access.

folio_zero_user() is only used for explicit __GFP_ZERO, not for
init_on_alloc.  On architectures with virtually-indexed caches
(e.g., ARM), clear_user_highpage() performs per-line cache
operations; using it for init_on_alloc would add overhead that
kernel_init_pages() avoids (the page fault path flushes the
cache at PTE installation time regardless).

No functional change yet: current callers do not pass __GFP_ZERO
for user pages (they zero at the callsite instead).  Subsequent
patches will convert them.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/page_alloc.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3108ac9061ce..ad0655387e9d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1864,9 +1864,38 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 		for (i = 0; i != 1 << order; ++i)
 			page_kasan_tag_reset(page + i);
 	}
-	/* If memory is still not initialized, initialize it now. */
-	if (init)
-		kernel_init_pages(page, 1 << order);
+	/*
+	 * On architectures with cache aliasing, pages zeroed via the
+	 * kernel direct map (e.g. init_on_free) must be re-zeroed
+	 * through a user-congruent mapping.  Host-zeroed pages
+	 * (zeroed flag) don't need this: physical RAM is clean.
+	 */
+	if (!init && (gfp_flags & __GFP_ZERO) &&
+	    user_addr != USER_ADDR_NONE &&
+	    user_alloc_needs_zeroing())
+		init = true;
+	/*
+	 * If memory is still not initialized, initialize it now.
+	 * When __GFP_ZERO was explicitly requested and user_addr is set,
+	 * use folio_zero_user() which zeros near the faulting address
+	 * last, keeping those cachelines hot.  For init_on_alloc, use
+	 * kernel_init_pages() to avoid unnecessary cache flush overhead
+	 * on architectures with virtually-indexed caches.
+	 */
+	if (init) {
+		if ((gfp_flags & __GFP_ZERO) && user_addr != USER_ADDR_NONE) {
+			/*
+			 * folio_zero_user relies on folio_nr_pages which
+			 * requires __GFP_COMP for order > 0.  All user folio
+			 * allocations set __GFP_COMP via __folio_alloc.
+			 * user_addr != USER_ADDR_NONE implies sleepable
+			 * context (user page fault).
+			 */
+			VM_WARN_ON_ONCE(order && !(gfp_flags & __GFP_COMP));
+			folio_zero_user(page_folio(page), user_addr);
+		} else
+			kernel_init_pages(page, 1 << order);
+	}
 
 	set_page_owner(page, order, gfp_flags);
 	page_table_check_alloc(page, order);
-- 
MST

