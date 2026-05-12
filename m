Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1E03C8C51
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 21:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778619994; cv=none; b=aJdUpDljvJBlfBEv19MIzrsitpXdODBA46VuSb5pgSDWoOxwILINHg9n+h4myww5TfGF0mqu4QdiOq0iro1+CgGEM6c6xOrNyfr+RttbWb/+s9/hBjO1u7V3a+5vfg6Vg77TxQ2/KPYlm0zw0R1LzY902eQIRAOQy9e9UG/p6C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778619994; c=relaxed/simple;
	bh=Y4i87gvPLne8uDYdZdRz0YtVJ2giC7sgZxD0jT2a23c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Dup6H86SY63+oBny4VY6UnhjFS5+5CB3HHgYxUeywUwojOgAcJW7HbVQvBnfY7dMpjYSZUyd0zThNERN0VYkKLRbNTILlZaXqOpT/ZxPStc9qJXtw2u3wWqjO3U+VYL6iPZeQnLWAfPgrIQrDzfmzUxwvPbgikhpnwa1+rKBWZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DjWLJlcq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DjWLJlcq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778619992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kWQzvk6rjiRPyM3eAZla3ajwvkAoYuOsF+wH5y3nY6E=;
	b=DjWLJlcq2873ifJxugTv6lpwOsWoRy6YPVsq0adrl+mWFL3pmFQz2sJw7k/kPoKt+vDiyJ
	V42U+I4kHvFF0ESflhJ8cTSieSwRZTp3bWbvbpf1MrL3hrB7aYfSPK3kauBi4aotq/SgX0
	6FjQF1jgGxE++MDCcqTvoO2VOOVztfc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-sb5KMiAcMXWR44QRRZhPRg-1; Tue, 12 May 2026 17:06:29 -0400
X-MC-Unique: sb5KMiAcMXWR44QRRZhPRg-1
X-Mimecast-MFC-AGG-ID: sb5KMiAcMXWR44QRRZhPRg_1778619988
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488c0120047so34769715e9.0
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 14:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778619988; x=1779224788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWQzvk6rjiRPyM3eAZla3ajwvkAoYuOsF+wH5y3nY6E=;
        b=VwV8sCNcKuAGqqxLnqvwxmKGbzkcKAM9IwJCTugizUq16EZ0jfrNKXr7SwSL91FbEs
         jsFqsSE18HUMNVgmBvA9zVjpdrLtu05JITaBVQFfplD9w1PQPxQO6+8k/KCvpfqO1K5s
         hepH+ixyYcp5xrSDq1xWERenRR0esD+F44gMYDJR65V/HcFeKpN7FkU+Nj4RtpfgfYTz
         10c3Ls8TIFhDyXMU1TSd8g0VKCnXb1WNIgPrSUvjWpMvVD0PV9wDd4EJ88aVQsPTCmFZ
         j9at07cjG9Q88SV5rM6ihJcAtmxbVQdVhru3jGjng31czuVTp+yXFTYBxVjMPfsnZfos
         0ogw==
X-Forwarded-Encrypted: i=1; AFNElJ8twUJ9VxSb/rygMDqNY/8k+w3Mp1wEJ+38Bq5xRA/Qh3yC8HFoXs+mA925eMuTrFEfKeH9kb0GnThmyuZUEg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwhpqMjGo/+E6zDYP432QKxnWKj667UdtJAZgVME/NvHCAZzBTB
	zgf9lRkWglgy8LBEvJYcIXO9yLxvsAIOrdU59LHUOPlR0jnNYAN2sI3iXMxVOBfOtYydHcKOsf1
	80ITXYERRM1lJn+2Gin0MkSB9A5qPFKeCN9CojgAf0VnG61qsdzAH7NyE+xJ5QPw8is9U
X-Gm-Gg: Acq92OGrW1IXXVWJE/43RmkMHMHPy2PJzlmNPijE3TjVYbFLh5PXmGw4DvzZ+a8joEK
	/TII4lg48N1BjNkXpvpraPyfiStcWhhVmtbMNhtpF2KiCG4iEzBCRgSAH4JhAnV8YudOBqtDwZv
	8XqkM2L3IS+N70wx9/5oS3k8+mUGYtAHRev7+ANzdHH9SvMivtrYsMabzmKyD9byr/uJzr9OO/M
	oI1ESNveTKUboW1s5x51U68lADhcoqivU38jC3SvfsuAG7iRMBLqiiKGTYxqRE03Yfgq7qDKcd+
	6YgRI77UA5raYwhx5AacbGgjfMtqbm49XN3h75dFqLE8fp2zmjsvMmbwgy6vSsZq9cWs8A2NYCc
	f78XDg9v765yhN84UY/xhp3NhsLmt2dZVRpJ1UCoS
X-Received: by 2002:a05:600c:4fc9:b0:48a:7a10:4f47 with SMTP id 5b1f17b1804b1-48fc9a023a6mr5599195e9.3.1778619987590;
        Tue, 12 May 2026 14:06:27 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc9:b0:48a:7a10:4f47 with SMTP id 5b1f17b1804b1-48fc9a023a6mr5598765e9.3.1778619987004;
        Tue, 12 May 2026 14:06:27 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f3f5174sm40737105e9.5.2026.05.12.14.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:06:26 -0700 (PDT)
Date: Tue, 12 May 2026 17:06:22 -0400
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
Subject: [PATCH v7 14/31] mm: use __GFP_ZERO in alloc_anon_folio
Message-ID: <b74f5e68c5879e2a9d28df1af71ec3d798b74dc4.1778616612.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: keI4Q8u5vjUvUqT9g0AZNBgw6iscyCyzYsaZsmXGqf4_1778619988
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert alloc_anon_folio() to pass __GFP_ZERO instead of zeroing
at the callsite. post_alloc_hook uses the fault address passed
through vma_alloc_folio for cache-friendly zeroing.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
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

