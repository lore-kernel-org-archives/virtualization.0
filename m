Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFFC3CAE97
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 21:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620003; cv=none; b=S3NwpGcZiwdBS6JICt9wvdqtsFMN/1MJwVURVuR77uWOg6sWeBw5Iyd1A7ItanfIaxkPcYbq1hwS/jRovfxZc5DnLHwQNtrQnW0zlCOWj3w1yippXWq6FOdjdyVRYsHeK3pnjMrE/tnUwoYOqGmsrwC+akJekSjeHk0Nusqcujo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620003; c=relaxed/simple;
	bh=xei+ncw22Azpj2W0VX9NF9tpXBP3CShNLWL9kEAMTtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NTKyXy4v5um7jiY31eNEIfFc42yJzLWJW3Jc8tyvcQzRWab9E8lpZ4/hLKAPZTLmrvgEKe8o7jXYHEs0ZAS2pIe+XDuZXgvK2eaugCF5zRe4lWaNwQ38r/y5vo6mQkSiD3DhIFoEUgxDjsbZj75FrIGGBkieFr2dIIWRAluoQtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FN9EkYSy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FN9EkYSy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778620000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=igR9Hw7C9olHKTfwoHAKRKmu59bne/n7R/dh04grefg=;
	b=FN9EkYSyeDOcQSPDViEWO8v/SeEIB9+cDCee4/+2d/WNlkwZRkvT9KQq54PY4a8Xjtn4wu
	jaMuQUXD6jECrc727lTaeujkEyfc3eMvjm0MY579O7FWaZXpiXZEnI8oYPo0kvkzrqB/9J
	S45niQqvSN3ySG373h6SVlBpcA9hoHk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-FJJp31KKNWWf2PrPzVmtrA-1; Tue, 12 May 2026 17:06:39 -0400
X-MC-Unique: FJJp31KKNWWf2PrPzVmtrA-1
X-Mimecast-MFC-AGG-ID: FJJp31KKNWWf2PrPzVmtrA_1778619998
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44a52d5e572so3892092f8f.3
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 14:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778619998; x=1779224798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igR9Hw7C9olHKTfwoHAKRKmu59bne/n7R/dh04grefg=;
        b=KJMBMJ1HG1rNRbu3F47dhLBa9oGHkhn9dvLLmNKUHFmidXQJYU66r94t00Z/79g1QO
         hmpS2JiX2rPly0iCsnGAfd+wrL+AfTabzHmliv17BS9oF0AN8rWZUbZ1UfdIpScfI7U7
         VGmNfJYDzdvGnjGLHKoCU4LtBB/zbA+vPaEzlSjaQN0YWO5nDId3CBqRPnyBrrGWhbz2
         wcrz8g9UlpRfhaFcKtlkHgK9ox8MPZHta3eGBWxf5ohI+itxV7iYfXiF2vvUfvnolltK
         riBrG0I97zsSWkb3N1SmtXUI9YWrl3TY+13Y41qxatmJBK8cQ+iu4ugoXzA/3sF3iMi4
         m4vg==
X-Forwarded-Encrypted: i=1; AFNElJ8Ic0Nk9jUdQ2IPZAH+a6nMFUDPIZRiFaPCPBZJ5INOPaQzp1xa5Tdx/gLiAoQWhK+V76UVYqBSOxgICJ07cA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yymj1phsuVmv15dzPOXOqF9KebeWlqZg7S7sj2grAqOzjpxEQDj
	h5F1RswsZfxc55YX1GTcVMsxJtJEw4uqiRsOy8TW/lvNLxtKHTiA/YyehOfX4YNi5cHRUzw/KUx
	DNQZb4EqMZpGcdLBjBgUbb28KWHAqTbQ1o+msS3AT4cwmS5BeEWucN0OlyRo1CC4Gvg51
X-Gm-Gg: Acq92OHQxDpXR6LDDC5QTij6xbVJu1o6/vr72pHS6WmRKLOUYO17VT0TVBcr26nLw1k
	cJk46v8MhJrAX2x+cznvpGw/kL7Rh2zxbpzQMjdnadBjS/ZwWbMaPm0Nq8NN3fjEOPIgCnKyIvX
	WTwyh8MFMXxz/jP8Zelrxk1DQZRdPY0hvxxnCep8ReI8wDDjDdpUS/dBaJ6HRFfwcLHr7o2AaXL
	4rHeXc8iJzPgZZLh0u1/Gt5cyIHTiJcD72g7Eu3m+EoPwTKzUEwOhVffhyMtgQRQwBGjTgqantI
	BvRUMCfDtVpFnyvg1UWj8gLdZr6Cva7Xtj/2WnAlR6K9Am8XsgLeBwmwZ6Ztm3VYJ6ectpeEaBm
	U+8CdIQiD3/nS8N/SxMdSvEa4MJwt4B2CQOF/ghMM
X-Received: by 2002:a5d:5f50:0:b0:43c:fbfa:20a0 with SMTP id ffacd0b85a97d-45c79f29848mr16455f8f.25.1778619998219;
        Tue, 12 May 2026 14:06:38 -0700 (PDT)
X-Received: by 2002:a5d:5f50:0:b0:43c:fbfa:20a0 with SMTP id ffacd0b85a97d-45c79f29848mr16404f8f.25.1778619997694;
        Tue, 12 May 2026 14:06:37 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6b071sm35131308f8f.14.2026.05.12.14.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:06:37 -0700 (PDT)
Date: Tue, 12 May 2026 17:06:32 -0400
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
Subject: [PATCH v7 16/31] mm: use __GFP_ZERO in vma_alloc_anon_folio_pmd
Message-ID: <94f20c24024cde2587026ca881a6a7ec64e264d4.1778616612.git.mst@redhat.com>
References: <cover.1778616612.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778616612.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0BimegdCxqyArDN9bEWaAU0UKvBfTsw8IC-lVaMZdcA_1778619998
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert vma_alloc_anon_folio_pmd() to pass __GFP_ZERO instead of
zeroing at the callsite. post_alloc_hook uses the fault address
passed through vma_alloc_folio for cache-friendly zeroing.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Assisted-by: Claude:claude-opus-4-6
---
 mm/huge_memory.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d689e6491ddb..9845c920c29c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1333,7 +1333,7 @@ EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
 static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
 		unsigned long addr)
 {
-	gfp_t gfp = vma_thp_gfp_mask(vma);
+	gfp_t gfp = vma_thp_gfp_mask(vma) | __GFP_ZERO;
 	const int order = HPAGE_PMD_ORDER;
 	struct folio *folio;
 
@@ -1356,14 +1356,6 @@ static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
 	}
 	folio_throttle_swaprate(folio, gfp);
 
-       /*
-	* When a folio is not zeroed during allocation (__GFP_ZERO not used)
-	* or user folios require special handling, folio_zero_user() is used to
-	* make sure that the page corresponding to the faulting address will be
-	* hot in the cache after zeroing.
-	*/
-	if (user_alloc_needs_zeroing())
-		folio_zero_user(folio, addr);
 	/*
 	 * The memory barrier inside __folio_mark_uptodate makes sure that
 	 * folio_zero_user writes become visible before the set_pmd_at()
-- 
MST

