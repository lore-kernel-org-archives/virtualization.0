Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2753BFE33
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 22:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315726; cv=none; b=WpJkti19ipWVBYe1aGYaBA8aNBcaeS2b66ZLSif+GO/u382X+Otyywpz+LxdVQvpwCXIp75JGWpn8R499jAJKJoQkxSfHGF/tBOhJIysozRjs0H1I7Wu3cGeTYkR9Us0v3JfT2nySI43xB1pqV1Ia7bQGN0mna/Py6RmelLHgqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315726; c=relaxed/simple;
	bh=OWZLv3RcZNMXBK++VDzgdX5Eo6g4iZLM958nD4m3nTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=oLEBQtT63NMB8m5ACt3Hh7e08FKmLCCFF/9Mosuv6uAMlAEeLD7t0sNOEEFs6Va6q3h0sbatqHnuZbEiYp1FwaGqItW2HO1SyUZh7EPxr1WfRvaP8ILcve78LUMFWfm87fA4FJaqNeorkoQnjOwLs0psx0Z0WtQ/yl7XC9Y5cLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W+ILEl2u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+ILEl2u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779315723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JxMX/pzMUOtdSR/DFO8X8z+nr68xKXZK5hfRbiRHySU=;
	b=W+ILEl2ulzPhjK7foQAj8tW4hyPNAEqLkhcYogkhdnk0TtRGWaOoLfD3hf2UA7hYI2/wYK
	FHiQYaXHrL4Edc2knaFdMWsnZy8e+8lucnU4ar1Z2A0CiA9fYwwBqZuGS0QMFgPNEXS08R
	Dj/7KNKXPXxZOyx4Y1xNgQx9wxH5fDI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-Ddlp24xLOxyyQWlsLUOgzQ-1; Wed, 20 May 2026 18:22:02 -0400
X-MC-Unique: Ddlp24xLOxyyQWlsLUOgzQ-1
X-Mimecast-MFC-AGG-ID: Ddlp24xLOxyyQWlsLUOgzQ_1779315721
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44cc3c9b2feso5149516f8f.1
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 15:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779315721; x=1779920521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxMX/pzMUOtdSR/DFO8X8z+nr68xKXZK5hfRbiRHySU=;
        b=kUnlh23AVGRcVCS2spuVsiG+JzgggLS3mYnR4NFqrizpXqiiznNQQrejq78Gq99iSh
         vlRI+R2i19WdRuBOhMS5n1+r9+nwpdJZe9Imvs4Du7IaLUb2/azKYSaB/02YVWYVI+Rj
         Ro1+5M4gNonvOdDjiZo/jPQnrw510TpDnFu9s/Mxnl8nJJLRGERn4+A/TN2psDkQENFs
         yXWjC0Tl6ekeixEckpi9xKHMwXol2bPjJTV3n6/Kkuv4b0nm6zYXNnAye/MxcBNmpKWI
         CHG3RtWAgFFOnJzhSA11MWaOOxRul5fDlElDu2ef95VuF1bn6hfRhrIueA9AqMQ8to8X
         5ckA==
X-Forwarded-Encrypted: i=1; AFNElJ9OL1uVd713ldJ5Dm3inBGOPtWX2cW2rvBALRmNNKmAxO1od96BZ86d6s6a+UCYBBA9SV7VjB+MoGghm1UrJA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyynbcfPABduhccE5pM1pVBOl/Dub0O6b6VuhMrEcc8DB1HBF66
	zOY9GwjPc8znzR6EFy8C4b5W1UIC6+hJ45uKhu0prXNDNEME6b0AKSmm/r1o/IResE3ilJQEF7/
	IGOgJQth0VJndhZCDZvX+YNl3towWvRYaCfagbe3KjgzMLdcMw4Azl3LAheLrgrR/GFAO
X-Gm-Gg: Acq92OE7xaEryTQpSobYBRFElv6OfRR5r6EhK+rC+G72eRk126X4VvJWvrBn61btjyG
	kX5yQZS68YtTyYnRRBKiaFp1o1fqtuXVSq1FWFoxM3Jt9btD4wqKzzyVED7pWcKzOWP/03ziSz9
	4LnEPrUeuu8R/J++KZOGy5VLnausNcaejXSTdD9oe+OBpid3yvsRdaeTv1q+AshnVFzJ0tSaGzp
	EZEVXIAkpd2beJlmRIYYtJ6rqyw4nBJpFcbz9WP9JLCN5Id/vEtFmL1VE7QaZCyL77/B3wZouLy
	v5IOqG+RQRvo00+LeGDNusIRpuRk3og+sJkvgl4UvU/6qYZktuPS/Ws6bnmwZWmv+mcrgSm5uLP
	eNTT+oqa89mDkkIudp3+EsxR3MQYRP0FpwpA/fW7H0Y0=
X-Received: by 2002:a05:6000:2f88:b0:45e:878b:6c36 with SMTP id ffacd0b85a97d-45ea3ce5a81mr251917f8f.35.1779315721173;
        Wed, 20 May 2026 15:22:01 -0700 (PDT)
X-Received: by 2002:a05:6000:2f88:b0:45e:878b:6c36 with SMTP id ffacd0b85a97d-45ea3ce5a81mr251868f8f.35.1779315720651;
        Wed, 20 May 2026 15:22:00 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a178adsm60809630f8f.18.2026.05.20.15.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:22:00 -0700 (PDT)
Date: Wed, 20 May 2026 18:21:55 -0400
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
Subject: [PATCH v8 17/37] mm: use __GFP_ZERO in alloc_anon_folio
Message-ID: <e1cd6cf31498f273a06a8899c737f514874d0402.1779315441.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: FtyrgyTZAddWSKcH440ZE-ik7KXRQGpdgxahHAGCmi8_1779315721
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert alloc_anon_folio() to pass __GFP_ZERO instead of zeroing
at the callsite. post_alloc_hook uses the fault address passed
through vma_alloc_folio for cache-friendly zeroing.

Note: with __GFP_ZERO, the folio is zeroed before
mem_cgroup_charge().  If the charge fails, the zeroing work is
wasted.  Previously zeroing was done after a successful charge.
This is inherent to moving zeroing into the allocator.
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Assisted-by: Claude:claude-opus-4-6
---
 mm/memory.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index adc228fe3578..895ac72121fe 100644
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

