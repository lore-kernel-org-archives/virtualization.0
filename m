Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A04259CB2
	for <virtualization@lists.linux.dev>; Sun, 12 Apr 2026 22:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776034271; cv=none; b=hf0084HGL3fu/Cz8AmXshG7IALrUMcB4+HSNuOa0m3u7F+OTtbIgcjNq3FbkSLiUrw+ZEXEgd/f8qh3NDg7PXy8xl4Qp0YcKXx8TTDA1siYjfoj1WuybcSz2KBhMbi2gBdaRJJPNf7qhGmxO77Fs7EpVfQgeDhAAH666b53F3Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776034271; c=relaxed/simple;
	bh=wQTexAwnGytwCFSIS/P6kaYAjB5J4jvqVusvwQE/7Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nq1278REsM0uN9D8i8/UCSYvS6BJO4Br3olVQoKi1o1PYcIHP+Uhr036+GS0Gp7uIBOrS2eGz56F/IhyZy5Q5hKyxR3wZIVTh48gJpceeTjxXDW3sHjzek1DDCAlsOipxA+w7jZHxiRUrFhu1XuPEfBGZYTqMSoBn4XyvM0cUrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aDmSVEpq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aDmSVEpq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776034268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r7PQCfO1LkfIlhF+m0/p+q9abrYZpC0b3LWn2Ob4o6U=;
	b=aDmSVEpqDaFTmiJ/0dh/Wf1OvjGU84aZu21ZSUbzLWTdBfgpcrUuJ9Evx81hvFsXr6TPYN
	6tMM5C6YB8tG/Hw85ipZRqlNqlAmXx0BgN3REPON5I+/8tC96juNnvDUM+v/u+wX3ontNL
	mM9pDrxfjzdXxPGHgTN3BMnruiaZRPw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-G3xthVQCNFm9cQOv6CugtA-1; Sun, 12 Apr 2026 18:51:06 -0400
X-MC-Unique: G3xthVQCNFm9cQOv6CugtA-1
X-Mimecast-MFC-AGG-ID: G3xthVQCNFm9cQOv6CugtA_1776034266
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488c2aa6becso29333345e9.2
        for <virtualization@lists.linux.dev>; Sun, 12 Apr 2026 15:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776034265; x=1776639065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r7PQCfO1LkfIlhF+m0/p+q9abrYZpC0b3LWn2Ob4o6U=;
        b=KF58ApMfKkxYm0+qwLWjIearzCkNsSoYreWAwPqZhXAjm3r901FcWpgVMebON9X8Si
         DA2jCx79qIfsXXam6Qq4YMxgGhs20fQaQLMiMU3l/q18OKAsssL1js7Fo5drdLfFXSqq
         KfSZIC8dS40WskQhCH1VNTnJKwZ78997/AqVqcyA59zTdUBihf7K3/kzWXoJmZaD2dUT
         W0EwwFcUDLxM7DCbSdMjJ4Q4uW+yoqfsx8k/SC2yJgzzcLAJZx5qKVoehrasbgMnLQz2
         Vrpb9ye6IYQIbI1UKk5W1VrjwOJ8s4aFEQYKD9Yqa9kYQrGzh2cVNZKv0+9MFdKyV7O8
         Y1ag==
X-Forwarded-Encrypted: i=1; AJvYcCWBwGuUpVPItkkwAG4ekcD+xd+dhgjearet3BpSD4Yh8/iUgbrKg2sD1f37vSDVq83wJ5HjKo51ccfNIHJCXw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxBGtIP74/KPLG+qm3GQg0q5LUijHb9S2qzMb7qJjTQTPdPaf1Y
	FS9Neygsp98fPjEhznKO4n36ZOTxu2iWD1tdI2mOikS7LTmPCGJAOXWlpEH2DhhDaNEa3su74Q0
	4epUGZ03Ub2XI+fYxP2iSUCjR7Qlc3MufK9o7RVK3hFRN9VPzcqDQXFMWZuhv6hHMQ68v
X-Gm-Gg: AeBDieuiW+lsIKwrr4WduDGPnDjtzd9bmAatQJYpwmJGxKshhS7X29zzKv6oPe6bVVR
	LLQVl6ESSZVUzT3krQUq71SaORZSBcO8jsi2PoVHZaGaONtyTUoYk/3CZ0izrsSmIpUC18wyues
	0nZHMXd647ygVWzfkujYRKCJaCPLAFHpCQnRkfUM2wW4uwICytfNwRpgXVIjnbmAmR8YbPoFaWQ
	OmUdav0F/D6RRFOYenWn9/Gf2QeU6qGlKCHrgV5baGH6HMywGHutJc06tqwSiZbonpoyt8EUdwU
	mZabMd53pnnAfWrImSfsJ911rPfeFjvwkFrX5tsG6HqfVdv9XYEMWmb1vCS/GKQc7/6WZomi+2L
	v58RhNP8qaUsVT/81+FX0piohyP8PWYO9clRjyDyOKzg=
X-Received: by 2002:a05:600c:8585:b0:488:9bf8:7f17 with SMTP id 5b1f17b1804b1-488d684bcb0mr113206665e9.14.1776034265503;
        Sun, 12 Apr 2026 15:51:05 -0700 (PDT)
X-Received: by 2002:a05:600c:8585:b0:488:9bf8:7f17 with SMTP id 5b1f17b1804b1-488d684bcb0mr113206465e9.14.1776034265017;
        Sun, 12 Apr 2026 15:51:05 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d6881ea1sm80171315e9.33.2026.04.12.15.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 15:51:04 -0700 (PDT)
Date: Sun, 12 Apr 2026 18:51:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	virtualization@lists.linux.dev, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH RFC 7/9] mm: hugetlb: skip zeroing of pre-zeroed hugetlb pages
Message-ID: <7d1c82bd0fe7f80212cb5ff7dafe24e1debca8f6.1776033771.git.mst@redhat.com>
References: <cover.1776033471.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1776033471.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YqM19W1bmVYX8oURN1Y6PCMkX4_2k6Mcr_YU0cfWfak_1776034266
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When a surplus hugetlb page is allocated from the buddy allocator
and the page was previously reported to the host (and zeroed on
reclaim), skip the redundant folio_zero_user() in the hugetlb
fault path.

This only benefits surplus hugetlb pages that are freshly allocated
from the buddy.  Pages from the persistent hugetlb pool are not
affected since they are not allocated from buddy at fault time.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 fs/hugetlbfs/inode.c    | 3 ++-
 include/linux/hugetlb.h | 2 +-
 mm/hugetlb.c            | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 3f70c47981de..301567ad160f 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -828,7 +828,8 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 			error = PTR_ERR(folio);
 			goto out;
 		}
-		folio_zero_user(folio, addr);
+		if (!folio_test_clear_prezeroed(folio))
+			folio_zero_user(folio, addr);
 		__folio_mark_uptodate(folio);
 		error = hugetlb_add_to_page_cache(folio, mapping, index);
 		if (unlikely(error)) {
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 65910437be1c..07e3ef8c0418 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -937,7 +937,7 @@ static inline bool hugepage_movable_supported(struct hstate *h)
 /* Movability of hugepages depends on migration support. */
 static inline gfp_t htlb_alloc_mask(struct hstate *h)
 {
-	gfp_t gfp = __GFP_COMP | __GFP_NOWARN;
+	gfp_t gfp = __GFP_COMP | __GFP_NOWARN | __GFP_PREZEROED;
 
 	gfp |= hugepage_movable_supported(h) ? GFP_HIGHUSER_MOVABLE : GFP_HIGHUSER;
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0beb6e22bc26..5b23b006c37c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5809,7 +5809,8 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 				ret = 0;
 			goto out;
 		}
-		folio_zero_user(folio, vmf->real_address);
+		if (!folio_test_clear_prezeroed(folio))
+			folio_zero_user(folio, vmf->real_address);
 		__folio_mark_uptodate(folio);
 		new_folio = true;
 
-- 
MST

