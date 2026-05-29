Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2443F6614
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068325; cv=none; b=ulNTMzotYwVlozmG+tVmYMA2HZnhp1SX5xB4iBF9xzZcL1G0F6I7nTVNm4OoJ2tPdpt49dSZB9K2YCmk9E5xGDjZapE3xVyvu4ZlLKN8vNxgMxN4V+xBNM3C0LsFNvWeJTwi6htViNjaBW5LHXlWjRrFbTHklcIRetCosWD7JeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068325; c=relaxed/simple;
	bh=V5Y93H57q2xi9ZVdVLl8OLD+jeqpAWNwQzgfVZDhJj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TIfVkktjvaolHAsWdPk0X4+gXhlcycPyVbOAVh9jx3jsgeOEJpybmG+EMKL22+pfeAP09eM7PoQAm74zkM/Vhv5lhe85Cr5TQyhhFkWXrIZqo0CKfZf92skFaCxZWDTp1rrQXudJpgMkWdhp+krwrCea/1H+Y4UUcZMVP7xxWJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DIEMBlGa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DIEMBlGa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780068323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lR7ppjC8ZhT95gw1LzQhYf3JteDpTHqAJsB6tR6PXLg=;
	b=DIEMBlGa74B0rbEhSC6C406r7tNHFHOHK9ASzD75T0nBrByukcq+sH4b0DTtNcZX2vNv1q
	6wqZx1491ZU8Vs8jfnNK6lqAgXC2n2RWtSbnPqwK7KXC8I/eTM/UAA9oDUBN+2bnLI/05M
	/PH8jxQUjgCmFpFD7pNRXM/wp/fj6hA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-ZBIdmXt7Mj6JnFnz_U4NgQ-1; Fri, 29 May 2026 11:25:22 -0400
X-MC-Unique: ZBIdmXt7Mj6JnFnz_U4NgQ-1
X-Mimecast-MFC-AGG-ID: ZBIdmXt7Mj6JnFnz_U4NgQ_1780068320
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4908af8d7f9so20096765e9.1
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068320; x=1780673120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lR7ppjC8ZhT95gw1LzQhYf3JteDpTHqAJsB6tR6PXLg=;
        b=T0PfZiTizvmpZ9QrHqMrlwa+c76JWPWolS+Ho45Zr7ENz8cQzrX/hdlT/w+H4VcHYT
         Mtv/YqFXRPv50o9amZcMjtFaeMRLOKFbMSHVIClolBF6cjCNpTLCfvoUFmH4mw+Fe5JG
         wROfZZm+scmPMWlxbSWUQ+Cz5aA5IekCuB6QiO98N/Vd/N0VZgysweY2iSyTDQwA2RAH
         M+hDm7fZVUeOtI6NdxAnzkc8rYHEhgqY1nSdKhQmDUj7VX2AAkEX+22XZ55RV6FMYO/f
         9ARGBoLO+aQy3EubF9iznQxqHfT+Sqsh08Bgk5J9iIc0DCqEfjk780XYWzwB4eCpTmLi
         Cf7g==
X-Forwarded-Encrypted: i=1; AFNElJ8Z/8lNSun5y8UXw4uoem/PM5UFsYon5BYldpczhRl9gl5e11DqfxesvW79PNDgTe7BphGu8/dxUTYtnt8qWg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxd70XaY20oi8bK+ixHYhRThdNkdPJ3fOqROI9OO/Aa2OjXq5gk
	PpQz+6S1w2+HsDP/j0Tb45yyjtPfbtMRB6++eUvPEZshKmpFsoDE4eqwVtoBtrIQeSqPRKZpUYZ
	AD6UJLHVyTa8/fm4sqQgt+ICtgm6CzIWYL0um69BHmjEEGN//7dvHMW5BTY61y1uRSWjA
X-Gm-Gg: Acq92OG0qNCn8DW7lB2GUx0h07omHneEFcUtURGP2TzBWKlgsYNtUx1ylhpkEer5+m6
	gXm8U6UCigRoS8af/z9YiQcXSNjuP2rZtlk++QTGbpITphJlrUQ5NAnLcwlxR7MNcBn/4WsM/o2
	hHVcOt+9vxmkCfc7SZ1n8vQsotCZSWKe9eXHuzADdvgaDiUK7YFRDTSlUjhFVQHBj7mNT5wZn7W
	InDvF9EMlPZk1+SlGiSPZVcrF+AL60yN5ufAMDYrUwPnrqhXmEFA/NzNfXyfeB1bNPJhH3VgByI
	t4WhoU5X5wppKLIhEISHWftYg+GEZ7VSC86EDDqP9kIc8Mw2hPWwjuK9a0EJbIJxheDNBwaF7g+
	es0j66W+FzV78Wh4WSYpGPwQ+S2VAn7dQzAp95VnStCS0cDfp0EqZaA==
X-Received: by 2002:a05:600c:c3c1:20b0:490:9d1b:2022 with SMTP id 5b1f17b1804b1-490a2938ad2mr1299125e9.13.1780068319731;
        Fri, 29 May 2026 08:25:19 -0700 (PDT)
X-Received: by 2002:a05:600c:c3c1:20b0:490:9d1b:2022 with SMTP id 5b1f17b1804b1-490a2938ad2mr1298395e9.13.1780068319303;
        Fri, 29 May 2026 08:25:19 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490a25e4fe7sm7967095e9.0.2026.05.29.08.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:25:18 -0700 (PDT)
Date: Fri, 29 May 2026 11:25:14 -0400
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
Subject: [PATCH v9 34/37] mm: page_alloc: skip kernel_init_pages for
 FPI_ZEROED when safe
Message-ID: <5c9d3afebc53d21cd13feb05b27f503f367d46b2.1780067978.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: c_Le6HNqjA1HRym5B--mHSKkdfIZio2t4qsLJPLP-kg_1780068320
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In __free_pages_prepare(), when FPI_ZEROED is set the page is already
known to be zero. We can skip kernel_init_pages() if page poisoning is
not enabled (because poison would overwrite the zeroes).

This avoids redundant zeroing work when freeing pages that are already
known to contain all zeros.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/page_alloc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 399e2038dcd9..90a92be96ebf 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1447,7 +1447,14 @@ __always_inline bool __free_pages_prepare(struct page *page,
 		if (kasan_has_integrated_init())
 			init = false;
 	}
-	if (init)
+	/*
+	 * Skip redundant zeroing when the page is already known-zero
+	 * (FPI_ZEROED) and page poisoning did not overwrite it.
+	 * When page_poisoning is enabled, kernel_poison_pages above
+	 * wrote PAGE_POISON (0xAA), so we must re-zero.
+	 */
+	if (init && !((fpi_flags & FPI_ZEROED) &&
+		      !page_poisoning_enabled_static()))
 		kernel_init_pages(page, 1 << order);
 
 	/*
-- 
MST

