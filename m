Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777E33C4576
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490149; cv=none; b=WjLGHTZkiga1X+c5CCEvk26AO//wSCsNT+2w3RHU+Dkm9THN5ztwl0+eZvWyTO14S0IUU2Crtn1CeCPA3tFvDJ9H8kmjpG2x/QOKx1XiOd85CGVSY7K3Mc0OElZv5v0kTuGXVt4LT61mcKMjgP7SC11WVEJgLUVaNEi7z7QxI9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490149; c=relaxed/simple;
	bh=B3Elvsk2QbFB4j/MM54kU4HNtRj52gz2EfVB/ero4mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uSyJ99Bfg+5HTutTy9OvOQstOue5YZXmwiAGbePPHbTP4NYG8+br1L+t64ozg3A+HgXCGnRFb2jp6RZh6j4Ii/o62klhWOjDoq/+yZrFSF1DWsHCe/mfkOsMFrt8kP9amEVUjhYagXyHGsQ3UQpnfEJ7zNuF/W2rewWuBwEid0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gbv2WKBI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gbv2WKBI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778490147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zuBj5G8Fe8DfsQghniXtZy4OYrf8Ud9rSYDvYLkW/0M=;
	b=Gbv2WKBIhPcE90zbOi6qGxO6AD7JnKV3jF+zhtchvqMKE3N09mwiWV3tVU3IcK2yAeWGHt
	AOGjeEWCbOihvihU/KEEPwJEvMNx008cbO/GmJKs+8QVkQXVV8TClzL4F3MJf4fZqwQQ8P
	BYYM6JUhH/9QeeliJyZZaBBZ2yYJcsM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-5qJY1qEkO0yOnrK17moZaQ-1; Mon, 11 May 2026 05:02:26 -0400
X-MC-Unique: 5qJY1qEkO0yOnrK17moZaQ-1
X-Mimecast-MFC-AGG-ID: 5qJY1qEkO0yOnrK17moZaQ_1778490145
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b8704795d25so326915166b.2
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 02:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778490145; x=1779094945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuBj5G8Fe8DfsQghniXtZy4OYrf8Ud9rSYDvYLkW/0M=;
        b=MLYlmTUYio/2fgignpmCevaAek/wzYwTel2iYqbQPzUD/2Y8YEc71HqAdVYQIbKtlO
         eMR+zDPg9qxtXrSCHjFlgwV9fpFntIEVvHDWLPSkw3p55YARcOkNotRdlx3Qnz5C9Y5z
         FBLEvzNBNroHLNjcvAxrXLuxpxMDEgj33UJR8mYrbZxS6mRRsIBWfLGVIIIX9hyW7+HC
         ENeudcl2p0UNcmlsPqrc0+xov49U7Fyb2a0Tr5TuP3eLmgjU8WMgkrbKNZIXXc/h7ern
         RzTMNR+eIkeGk0/c6myG9WcK7pH+/plUqInNKKgFF5gFkvq7NRvKJ+RZvqjjtS6rHxDQ
         edFw==
X-Forwarded-Encrypted: i=1; AFNElJ/8/y2l4HVRA3Kd040DzDjRx5vmHXK8cIxNWL5urV8MMe5OaXRXdHyuXVjYrMpFS/3ZHXQv/evkyaWFOzC8WQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8qDQlkCIaconmF82ftSrj4rLF7GeAFzLXBzRkrh2WoAwsq44X
	blz0T2cUidCGV0Z1oVA8RWzj6sqi3Yffeb/Y1X6zIsygTatOKfuJl0OHWfqvXSG5xWJyVO5f0f4
	irD7o/GBW2eGk+fGVOqZiq3pXNhSpHU9jfPDKrE4AaZ5OlD+ipu6ORlh/SJvss+Uxa2ka
X-Gm-Gg: Acq92OEQZB78mlbpDSYCb+FWeb+QUqLyJ6IDUlTCL9WR/SRwrwsNf2R9VKtoM41mcMj
	dQDyobAPIn2Vz0+enZKKXjqzKNdlJ5h4FsQtKXTkFL85K5Iktb7BYXjqar7mgH7gQiyFkoHZzy6
	3wuhkToCtqdhTrhOoH6BTJWsSbnExQ8uWiIL9nTSWVIvDVFngFwCeUt0pZqzj9c/cJBTNBfFpgv
	nF9jWQlBLnxoLxvMJRLHvQ7YEMHA3b6cFG3mP5tV8HH6UdiNbgkHgzejOE1lOlp2ZkCns/VW2LW
	tBDLskDO9U1YFj+usds+R8aFzkDL0aoX1lS5yicYjdQeHH5K4RCMoM059XOcMVwUr1I8YEGt/CR
	rIANoMoI2Xc8MCNhrc1yGDSg8gLEN8LMqWLtnO89/nSQWggy89Ic=
X-Received: by 2002:a17:907:1ca8:b0:bc3:783f:1da9 with SMTP id a640c23a62f3a-bc56d13123amr1190870566b.33.1778490144499;
        Mon, 11 May 2026 02:02:24 -0700 (PDT)
X-Received: by 2002:a17:907:1ca8:b0:bc3:783f:1da9 with SMTP id a640c23a62f3a-bc56d13123amr1190817666b.33.1778490138948;
        Mon, 11 May 2026 02:02:18 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e4bb87bsm23408179f8f.2.2026.05.11.02.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:02:18 -0700 (PDT)
Date: Mon, 11 May 2026 05:02:12 -0400
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
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
Subject: [PATCH resend v6 06/30] mm: use folio_zero_user for user pages in
 post_alloc_hook
Message-ID: <87e7ec6a9722ebe27a837a29781547d0d210147f.1778489843.git.mst@redhat.com>
References: <cover.1778489843.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778489843.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: slLMlshNtn-pHnNXGLVtlXHECCQ5Iqr4fdfNN4diwnI_1778490145
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
 mm/page_alloc.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f76d5271b5c6..842f5080d728 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1851,9 +1851,20 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 		for (i = 0; i != 1 << order; ++i)
 			page_kasan_tag_reset(page + i);
 	}
-	/* If memory is still not initialized, initialize it now. */
-	if (init)
-		kernel_init_pages(page, 1 << order);
+	/*
+	 * If memory is still not initialized, initialize it now.
+	 * When __GFP_ZERO was explicitly requested and user_addr is set,
+	 * use folio_zero_user() which zeros near the faulting address
+	 * last, keeping those cachelines hot.  For init_on_alloc, use
+	 * kernel_init_pages() to avoid unnecessary cache flush overhead
+	 * on architectures with virtually-indexed caches.
+	 */
+	if (init) {
+		if ((gfp_flags & __GFP_ZERO) && user_addr != USER_ADDR_NONE)
+			folio_zero_user(page_folio(page), user_addr);
+		else
+			kernel_init_pages(page, 1 << order);
+	}
 
 	set_page_owner(page, order, gfp_flags);
 	page_table_check_alloc(page, order);
-- 
MST

