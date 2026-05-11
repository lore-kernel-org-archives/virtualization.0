Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB833CB2E9
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 09:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490167; cv=none; b=GHRzFGyjRwkPV+g41vQ14Uxf6NRJM19JwehtlaQouxaxPENfbRD+M2NsB2xH82TPhXAk1YOCycSVr/dVLQotn89FONZapQp7WlSCoaIDvdGT0M8mGt5KhCKINpaIXLeBJBn9giSr8rIlgIFT36g2Hfbjt/Xj1J43DPxpiXQsWTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490167; c=relaxed/simple;
	bh=MamMMWXXtV18pX2Nm4tlwaTMDaamkDfpCh9w7kBXTEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZQ4EJ3ynaFw+Q9je5Na2N2mp/s1M9y/eDkGg26RqEs/l3NP4rGKL2/gl5Y7u8mc5fAK+Xe2Uz+sm2tHu7XRNUMt8q5Xh3RyNB3QBsIgx9Gg2OjNgJDhWQ4da9OANe6SbBfA5RytP1i3rNIGtrDUGTjXOq6HgVx8LUXZOcgqLgO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yrpvdk95; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yrpvdk95"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778490165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PyhJPD76XSlXOLIxrgX26vlRXB2m99TPkgzm+4tnrhY=;
	b=Yrpvdk952whr7Rz8q0zxP7rjySwb9WgbWFP0HMEj9bmZ9SViQX8/qoIyTWMAfLbAq45Tat
	agKWMIOXTwhVy6E1ZIBiqZrRtc7cuFPRrLXMovVagdUxCKB8XqDPCiK2PoMen7wOToQMsJ
	1vj1s5R08QNf0x9/+Abz/kIbx3nqONQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-I9MRam1QOHCCzjXGK-nJdQ-1; Mon, 11 May 2026 05:02:43 -0400
X-MC-Unique: I9MRam1QOHCCzjXGK-nJdQ-1
X-Mimecast-MFC-AGG-ID: I9MRam1QOHCCzjXGK-nJdQ_1778490162
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44d9ace59efso2739252f8f.1
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 02:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778490160; x=1779094960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyhJPD76XSlXOLIxrgX26vlRXB2m99TPkgzm+4tnrhY=;
        b=NmIqbhhCS4Tm5Y2+ZkLxsOKZx4JvBSG1Nt64sSYHgHkb288sw0nURSjt6T68ws+RHX
         nHS4NS74a4xIhQ9Y5fAbUUK8iPIc7/gVFZX0P0k/6E1/JyJM+AuOyJSWyh2HdTBUHIJj
         CJOP84NC4utZLpM+Y0+PQ+laz3jqNk0FB025r+yFVKklopPzjhvwDhEGmkukTZYFRKW7
         OhtCyIJpMrtpHOxeB2VIZ4g3Ge8sdSBD+/eud5kVwF/OTR/KiCB33SmhQwjttMt1kODA
         P0MJ51XV0P5CcJ6QOKLRLSPJl9Ywp0KAHrab7ZncYF0BGlLtkkBdUUdphj+Vq8px+dmi
         O4VA==
X-Forwarded-Encrypted: i=1; AFNElJ8G7rqrCWf0rjr9z2LFeocFYk8FpSNNOrb/zYY8gLfjg17Xz+9MQbxBkEzd+p4wt0+6nC1Ae3pAQBDkVZwgxA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZPEqinBhArluKIaQ1sOsRrLE6TNfqNdX4Ica0ygtveZQGlIAI
	9CuYN74Idmhnva61UEATQrfZxGC+Yb92lEE6gpBsbpVpkx5aaKYOLqeoL++F5PB/HvuxcFU39Wx
	PY/pErKNSsUQJtRXaZB5PCmpJWrSPCXJX4rp7D37thHZqVdbzlAc4cLJGz2csOG0vyRkL
X-Gm-Gg: Acq92OEJuXpoP/SsZlwCLPjFGyEGd1x/hEnyEO0/9/lOSvkDquBxk6xhKSBYfjR5J26
	QCFCMycpfUx/PXcqeEzjIjKlkmEZipX/vZK+n7aHVmUEgkwkY4zCbhWJoop0Z55LIRTyHHAdfn8
	Bo2rPvGOm6xEzFr9pD6YRaWLCPrWncoTFgFx36YXLDkGm9Chv7i9qHd0NSszdC+ETcr9qnL2RkY
	5SCxA2SCgxEE3+JRYEuuiJtFmZbTkj2ke9LtGDs5rGLJ3TfwX7RN4Sl+/RCpiWSkvmJ4dmrsocY
	qwm62nTj/GvJ2yzbN+se1I+EQr6G9Ru1Gmgpn02OUAssX7+quFkcb5ruUVm4xsoCy9xGttvV3yP
	axcG5fznSMccxTQdeYlJ77oLC66SqkEdVTWnaw/1p
X-Received: by 2002:a05:600c:628b:b0:48a:557e:6b4f with SMTP id 5b1f17b1804b1-48e706cd77dmr153153265e9.23.1778490159963;
        Mon, 11 May 2026 02:02:39 -0700 (PDT)
X-Received: by 2002:a05:600c:628b:b0:48a:557e:6b4f with SMTP id 5b1f17b1804b1-48e706cd77dmr153152205e9.23.1778490159368;
        Mon, 11 May 2026 02:02:39 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702e5516sm264424385e9.7.2026.05.11.02.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:02:37 -0700 (PDT)
Date: Mon, 11 May 2026 05:02:32 -0400
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
Subject: [PATCH resend v6 09/30] mm: alloc_anon_folio: pass raw fault address
 to vma_alloc_folio
Message-ID: <96bbd5dcc37aed93a9b7733780bdcba4fdacfa3d.1778489843.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 9ALC-vEzwncf90V5kmk4AACQimQHTBaCjXtOb5N5JVI_1778490162
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Pass vmf->address directly instead of ALIGN_DOWN(vmf->address, ...).
vma_alloc_folio_noprof now aligns internally for NUMA interleave,
and post_alloc_hook will use the raw address for cache-friendly
zeroing via folio_zero_user().

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/memory.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index ea6568571131..0824441a6ba1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5252,8 +5252,7 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 	/* Try allocating the highest of the remaining orders. */
 	gfp = vma_thp_gfp_mask(vma);
 	while (orders) {
-		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
-		folio = vma_alloc_folio(gfp, order, vma, addr);
+		folio = vma_alloc_folio(gfp, order, vma, vmf->address);
 		if (folio) {
 			if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
 				count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
-- 
MST

