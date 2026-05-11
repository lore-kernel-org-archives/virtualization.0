Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F833C3BFF
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 08:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489642; cv=none; b=gLu5JNNrOGEaVgsnALH0u3fUb+pVXAUz4PguaMhThYEw21/szoZ5DL/Ys/lxoHG+d+9PYYidhHP+TaxgoBjqbJundkmySL6vLzLnaFDECtbpCdCZIzQRB9pLmqmGf2piC6CqhiciJifu7v7KidEF9P23WSxA2lB6MOr96TwMr0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489642; c=relaxed/simple;
	bh=oLC9kYur6b/H/9DjaJgYZkAV9obgkYCnPswl1inVcjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IXFuUxAwXU5rqHeh1zU78ciObfgbR8S7M0FThZUzn2KpuVU0UhjnEKLV0Y8rx7uqlKTcrhkh3bU84J6x1sOM9GGylVi/4Pxl/DvKGwvh0UX4qwmoD2vEEtqjsBmW45tXWXA8x2CxQJMhtLET6XVAkHJqPzITiMzSnlVtKU63M/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OQMyBcdn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OQMyBcdn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778489640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2eYp/q7ILAhscET8EXyPBKCW0KNcPEmiVquSYEOS+Yg=;
	b=OQMyBcdne3sfvGht8KXyLj4BUrK8NRXpwcctiq2eSdI1GqkkaXwil0al6s9zI94voosQwF
	s5w79orrlAYBqdJ5plOwchVpl+Xl7BhbhnsTig/UEcDU2S/sn+oRydaHEkeUkgwCUnzHsF
	c0mAnT1PicjskCe5fEfu3tWWEUiwgNg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-De-nHWH0Oz-DSmUFS7bukg-1; Mon, 11 May 2026 04:53:58 -0400
X-MC-Unique: De-nHWH0Oz-DSmUFS7bukg-1
X-Mimecast-MFC-AGG-ID: De-nHWH0Oz-DSmUFS7bukg_1778489638
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44bf1ac8893so3510288f8f.0
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 01:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489637; x=1779094437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2eYp/q7ILAhscET8EXyPBKCW0KNcPEmiVquSYEOS+Yg=;
        b=h3NuuZL22+vi5xaPKaMUwl/AL252DVhE515lW0YtnWMtNbnpfGn+OrKSCJoFU5P4ZJ
         fL9h5XtkvOo+q3+xSOlAU2iU57+B/XmJOvZe/YsNjMEvbrZZYvhdpJe5bXJ4vm9dZJ0F
         JIYw6VNwBjhuOD6iMDL3dhfZa8jPODlan0PqeIckSxpnBdf102on2yx8E/SEVsfq+Z6Y
         v6NsmmGvTVLAWIzX/YoH1nEmD+m6Fi4laPK4Yum4Yt0Ih0VwOuv6jrT6TdRjpc6MM4eu
         mgKEPpqRpMURLpwo84JfZQ9R0CMn1stZQLDUtOc/PmITOawQTIZJOoiXOi8zAkuRMY4i
         HdBg==
X-Forwarded-Encrypted: i=1; AFNElJ+oqOlvRgFQf50In2lO4AOj+usr1boMHdj0na2Vwv5/Xt/qJ227yXtLXFl3sqWaZw0/4AwRk+G5dZ3TusIjgg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBEpAxDOcUHVkuxUWLYBs30nwrewAr85ujVH1ZMw/8pPXd/Csa
	ovz8avuWr2Hz1U++dHYbA34MuYxiBU3vxcbO8dwKNAvDJG4CKpfcsMePuxpu0DMYEKWok7RQgtE
	Ki0yUbENcIRJJ5PsuRRfYK/PPx25+aDOsu/yZYQrkHhiUAgHWdVsdVlOaGc5zpKVpy3Hy
X-Gm-Gg: Acq92OELP3oosmSOqbJWHQsVGt6+1to0lHux21ptTXq0oR2yeYTtu0wxmzb05rOSTHy
	HUAbFiTr9jwEokfXvZYWM9VDWj4YupoZQV2Nsb6gGWQRykNSuPjvJWIyEisV/5msxHLSFo3VZuq
	VULvHsUN4FK7yDtQnb5NDtRlJezTLjhjmu2dQHc2ZVSyfj1tC/PQrb0fbuNnyu1y6hUydKjitN6
	yD50Gp/Ts7mlZdhyWgS3s2sSAF32ZvSHDVK2DlwC306cuvYiJTEWZVyCiy7czBJJnlAGDqwwDa4
	r8EEnZ/NMHmiFg4CquXzp4g4wLFYwUHMIGpv3QSUaETzdry3LseqE1hgqDciV6oJKA2IGyut+8h
	gti8v5jQultUlUVs2NL9/ZAvC9qbtV0zuqA1ePA+gWq2YIJOEouw=
X-Received: by 2002:a05:6000:2013:b0:43c:f3ef:ee36 with SMTP id ffacd0b85a97d-4515d4d0fbcmr38974665f8f.33.1778489637310;
        Mon, 11 May 2026 01:53:57 -0700 (PDT)
X-Received: by 2002:a05:6000:2013:b0:43c:f3ef:ee36 with SMTP id ffacd0b85a97d-4515d4d0fbcmr38974556f8f.33.1778489636576;
        Mon, 11 May 2026 01:53:56 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6b071sm23659472f8f.14.2026.05.11.01.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:53:56 -0700 (PDT)
Date: Mon, 11 May 2026 04:53:51 -0400
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
	Andrea Arcangeli <aarcange@redhat.com>,
	"Liam R. Howlett" <liam@infradead.org>
Subject: [PATCH v6 10/30] mm: use __GFP_ZERO in alloc_anon_folio
Message-ID: <8b322b8e82bcfac5873c6801a26dad18e8e1078d.1778487000.git.mst@redhat.com>
References: <cover.1778487000.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778487000.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: a-I4bAfkjZEsYUpmmVYmgZGXnIVQ6jaZ9-nfsctF6ZE_1778489638
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert alloc_anon_folio() to pass __GFP_ZERO instead of zeroing
at the callsite. post_alloc_hook uses the fault address passed
through vma_alloc_folio for cache-friendly zeroing.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/memory.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 74523bc00d8a..f3f1bc66366d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5249,7 +5249,7 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 		goto fallback;
 
 	/* Try allocating the highest of the remaining orders. */
-	gfp = vma_thp_gfp_mask(vma);
+	gfp = vma_thp_gfp_mask(vma) | __GFP_ZERO;
 	while (orders) {
 		folio = vma_alloc_folio(gfp, order, vma, vmf->address);
 		if (folio) {
@@ -5259,15 +5259,6 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 				goto next;
 			}
 			folio_throttle_swaprate(folio, gfp);
-			/*
-			 * When a folio is not zeroed during allocation
-			 * (__GFP_ZERO not used) or user folios require special
-			 * handling, folio_zero_user() is used to make sure
-			 * that the page corresponding to the faulting address
-			 * will be hot in the cache after zeroing.
-			 */
-			if (user_alloc_needs_zeroing())
-				folio_zero_user(folio, vmf->address);
 			return folio;
 		}
 next:
-- 
MST

