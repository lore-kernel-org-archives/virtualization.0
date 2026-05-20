Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B66A3264E7
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 22:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315688; cv=none; b=q9EZcK6JVkC/ZDZenYjQWg3Ka9neCtAnasFTGpRR9vUEGAlykJm3LLtJuYAnjjFNqSARXlYfRUzil6S0/K7NmKb3yCBmWmcXQwtFavsfj2MNGZMO89DJA8cp0iQqnVbCHq0vJrvP8LBjoyeQn1exSUDiXxpIGp88t7XWBksCjQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315688; c=relaxed/simple;
	bh=nrMNVIUtRT6KxUfPFXjAD5jr466RgmTT9RZMroXpfzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hxsYBIxkQgHRDnGnB3Ue4JYebjsFKSYN5Oe2cpiwai+aX61kKfD/At/TNq41sdlJOaxyX0yIAWtaK+8xPNqfQjgo05u00GCYiLm4Tv5f2pjIPUAfBDWEtAyQapvl6u7Iloob+CXVBXLUGEae/ER1v0GW1pOHAScRFHsSHuswGs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BLox6b2b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLox6b2b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779315686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=phYVyxy4NXZDWgDwVjZEeX0+DVaGt3sk04puvAHm6ak=;
	b=BLox6b2bqUO68wHW0ta08CFNoOF7XaUJBm9oGQ/UGzqEmk9urwDFmyM53USjrwbuSK9Tw9
	tCrwLT6WFdIbD39FfoR3Dz8HFzQT0x0lli7NVAt+tjcnR1ApZobdA9cQ0XIwb4sofEydJ8
	X+PSOsm4Dqd4xW1dVQ92stUsahEUB3s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-2rElWir4ORO1MrODu6yjug-1; Wed, 20 May 2026 18:21:25 -0400
X-MC-Unique: 2rElWir4ORO1MrODu6yjug-1
X-Mimecast-MFC-AGG-ID: 2rElWir4ORO1MrODu6yjug_1779315684
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45ea38c03a1so46095f8f.1
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 15:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779315684; x=1779920484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phYVyxy4NXZDWgDwVjZEeX0+DVaGt3sk04puvAHm6ak=;
        b=nzd9Kq0VS/uitTSGnYdH/ZjX4JIlzVqG5lV74YWLUVGdJhFndNw+4etYc0+xjEwCXE
         weEsKS10MFyd/y5imt3n5yx2tTzq2O4yHduTMYddk2U8S4tmJGA+G4eaA8x6MJRiyTHo
         K/GZb5UbEV9oI6Y/3AlBpnzlicsd+k0S1gsYIJhe8gd3sVD38mOb8JlX+YHtK0yIKesg
         Cqy+6S66r1XQ2R8MvpYVeTk6oBGSjgStJ2nMsL6sgR2JRaLSmt805U/hx/cfBpKb2C8N
         cpF3nyp7VPbX9q75LTnZqStWcka7pHU8maOt13Unpnj4aUuXRgiMKY4hZ+SERLQmTiSb
         PXNQ==
X-Forwarded-Encrypted: i=1; AFNElJ+aodYP+OEgEx9jx/HPWznNeM11bLI05bRG8xAsFmaH751R3UPAfAwe9jOWYOef+IH2QQHwdyFCEoCRgkAN/A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNAEev/rrbLbEhxT+teajUC6Q4CZrHGFsE6yp938TNvfJGSPAV
	FmI7Lwl+KAeIZxMcpddEEvh9BFOHv69IS3cLpX2+2BUZ3R+c/njCnWHKYvEMDNiks9z4r4QEp4H
	nYsA3Re3/KBMbAX9CPZQjO7NhrhO2XXvl0NuZPHxTJ/GcCt3/OwZL/sh4OCL6Y77xFELp
X-Gm-Gg: Acq92OG0o+CwKVjv0ZQtHQ4wpCdxqWfUDnn8CIXknGBlE1saZErG4kCVMMgi8KvQ/fn
	DIKdetBDWrXO2BaZ/7dDSOnGKCu0PYByhnLqMg2HZjeULnskSd4KjB6qv2uWZoW57E8t+DsR9NS
	yWchnCf8yQajML9dU/EXrg2t/lew5l/REij4dB1lyutaXrRMvxOykVMwSFKOMGyMr/2yrRTRULU
	/z/LcqznWliSS/Ey7/hAp2mQBo9Ifar+MWkORw3ldYing4Bs3hRdsrB6c5nqhXDw2Ebh0URfSim
	YLFEjmwglw+JjC2lqYSFwBcp/FaCUUmBgUT1tB6XTZUkzETVXPovMt0sNLngtMcFBqbF6I/3xn6
	vPO8phN5zVNdigbTdmsIsrnhWNbeY6OnrpC2zbENdnBs=
X-Received: by 2002:a05:6000:2c05:b0:43d:309b:9c4f with SMTP id ffacd0b85a97d-45ea38cd4d7mr309336f8f.6.1779315683758;
        Wed, 20 May 2026 15:21:23 -0700 (PDT)
X-Received: by 2002:a05:6000:2c05:b0:43d:309b:9c4f with SMTP id ffacd0b85a97d-45ea38cd4d7mr309285f8f.6.1779315683262;
        Wed, 20 May 2026 15:21:23 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a1aeafsm59910901f8f.23.2026.05.20.15.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:21:22 -0700 (PDT)
Date: Wed, 20 May 2026 18:21:18 -0400
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
Subject: [PATCH v8 10/37] mm: add folio_zero_user stub for configs without
 THP/HUGETLBFS
Message-ID: <501f8a7a582a97011a23e3051f3d0999c66c10bc.1779315441.git.mst@redhat.com>
References: <cover.1779315441.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1779315441.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: x6VjjhRxTVapJCplYqCp0hhPOq96mmYyHxOUCyVa6q8_1779315684
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

folio_zero_user() is defined in mm/memory.c under
CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS.  A subsequent patch
will call it from post_alloc_hook() for all user page zeroing, so
configs without THP or HUGETLBFS will need a stub.

Add a stub that uses clear_user_highpages() with aligned
addr_hint.

Without THP/HUGETLBFS, only order-0 user pages are allocated, so
the locality optimization in the real folio_zero_user() (zero near
the faulting address last) is not needed.
This also matches what vma_alloc_zeroed_movable_folio currently does.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 include/linux/mm.h | 2 ++
 mm/memory.c        | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index af23453e9dbd..d1e768dcda13 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -5070,6 +5070,8 @@ long copy_folio_from_user(struct folio *dst_folio,
 			   const void __user *usr_src,
 			   bool allow_pagefault);
 
+#else /* !CONFIG_TRANSPARENT_HUGEPAGE && !CONFIG_HUGETLBFS */
+void folio_zero_user(struct folio *folio, unsigned long addr_hint);
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS */
 
 #if MAX_NUMNODES > 1
diff --git a/mm/memory.c b/mm/memory.c
index ea6568571131..02d3e53fc91b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -7546,6 +7546,15 @@ long copy_folio_from_user(struct folio *dst_folio,
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS */
 
+#if !defined(CONFIG_TRANSPARENT_HUGEPAGE) && !defined(CONFIG_HUGETLBFS)
+void folio_zero_user(struct folio *folio, unsigned long addr_hint)
+{
+	unsigned long base = ALIGN_DOWN(addr_hint, folio_size(folio));
+
+	clear_user_highpages(&folio->page, base, folio_nr_pages(folio));
+}
+#endif
+
 #if defined(CONFIG_SPLIT_PTE_PTLOCKS) && ALLOC_SPLIT_PTLOCKS
 
 static struct kmem_cache *page_ptl_cachep;
-- 
MST

