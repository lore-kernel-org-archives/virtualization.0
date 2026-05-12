Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D2E34DCEB
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 21:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778619923; cv=none; b=bXX5+FJkBo4R2XN+FbjIPc6lPP00LtCxH5eaKJE7mQdTKBR2cl7cykoqSPouRWqPdqAUnX4/bM/BbnmGHxu6gTF28OUqDsr4+c327ln5PQBp7UIYVYkiZuOwF0OfWBQah8+pnB4WMHSKC0McIx4ZTtBwr1jVb1sLUc6lY0IpBM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778619923; c=relaxed/simple;
	bh=5WPB3ZBqh71XoLzj1Vvh/y3ryxaNlqNoDwWwMbiSDuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JQDn4QY0S9kBUhY5VDkENuOjjoQjl08oEQeUW6JD2EOKkov92+MO+cn0S3JWZxKUsX+Ax6aDeiMudpiI3G+6/nMAdmQJ5UTfc9i3eSvMVKk6Udax5463rk1oT1+nY/OorSSIRgK+gK1eikHF1GlPoKe559hbpjuWi3iAhNkfZOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DtMG6Jun; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DtMG6Jun"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778619921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=axwB8YBt76LIJzhy+Beipy/onk26AHGibl0rZie+Elc=;
	b=DtMG6JunhsDXbJX3RJ4ksUzythtyZTj7xgwMedc6h/4xp7prEAmaxkCqiqDU6PDLgBDFD6
	VzPKaHyqlSIgFOuynaWPaPr30ppoFcooeLLG600dXt13fNPtE8mhufjBH+lW6RtLfhf0pR
	nhUbPNFeUM+d4GLEd3pegUm/5M/807Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-yiavjnjFMcOMjoTKvnn-Zg-1; Tue, 12 May 2026 17:05:17 -0400
X-MC-Unique: yiavjnjFMcOMjoTKvnn-Zg-1
X-Mimecast-MFC-AGG-ID: yiavjnjFMcOMjoTKvnn-Zg_1778619917
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48e79219704so19971335e9.1
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 14:05:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778619916; x=1779224716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axwB8YBt76LIJzhy+Beipy/onk26AHGibl0rZie+Elc=;
        b=Vx+VVO2ehcvBBDU9PKZ5ZD0FsCOxaRg+DmNz+syMoPOJh2x4z2tV2Fnjt2ZA2sKhcF
         53Xr2okdyTIcjLIehr3uKNYHg5yDA2Mn2b3/+gPjkRCCgoHbAxL9kA0b+pLKzYqmH1K7
         T4ObQx+YJxfk6Pq2Dk1LjmQhS37dVmiLL/RxsSsQERJnAKK+ZZqjrF7HF7wU2hI1Koto
         pRuEgnQLj9yfr70Fdo13IemsXQTwuqkjEqNHWTXTnZkD+45M6EG6VivknDIt4LebD+1R
         xM6gCvrCBp3EHIlTn3BKzyU/He4sKDme1OFtbcJAZV1+w2XammQxiyE2NwIl6UCOtzyo
         wEYg==
X-Forwarded-Encrypted: i=1; AFNElJ85/gsjCukhU7RKvWM2CCgBJEUXVIWt4H2+9u5howgNAlC6dSgGTa5Uui2H6ACFmUEW11JB4caMumFqA2zibA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyb69Ht8W3lilWlXLKIa/1TaGCPnmnBX/s9Dt+ZscA5ok2NOigr
	YaP7Yqhzyv0tvNHHLxWm/ssDKk5Lymffdtw+kogvNaHfjrCwyHRxxZuQtE+BSmrE20Oxchm5rcH
	zGMFmKJs8boP9GjQC/qo+qNPw9ulwcxYwpGPnc84IwCJjdgZcfYv9PY69X7jv7U6UT5Uh
X-Gm-Gg: Acq92OFr3NIrbSTzKkqjM7gKhEbppCNj5dCvS1x8mm+8cdK5jMsly3oVhLtNusomaJw
	ZXootbW1M+DG+Cl/RjQPzWIGNj8evWwL9tDrtE5TXKQXLYgPJnQyb3pbLyaIlv+rplpGGZfh5qJ
	Dr7Sam/J0NizAEFs9vkSUwSo4Hx3WjUsswMcW2iDDrbGkd9evX4Pc2/Bbb9R3UgpGzUxJs8Iqh9
	d8ujxwujB4Vq6LQ1buR9MvsBeH0WQIp2hCqKS8TkovRa1MHB5xtCCFMabMbpef1NJPsnEADBCSd
	CMRV7SLEJUF7awz+qxu+3AkE8gLun+HMimqcadAioZGW+LDPA7+OJMIvgXnM+AXsYYUVthMJ/UA
	S6Fs4aaFiNYHueoiHbnXz/1ToCPDVkObZ7EtHm0Ky
X-Received: by 2002:a05:600c:859c:b0:488:c683:be89 with SMTP id 5b1f17b1804b1-48fc9a09ca9mr4482475e9.9.1778619916318;
        Tue, 12 May 2026 14:05:16 -0700 (PDT)
X-Received: by 2002:a05:600c:859c:b0:488:c683:be89 with SMTP id 5b1f17b1804b1-48fc9a09ca9mr4482015e9.9.1778619915787;
        Tue, 12 May 2026 14:05:15 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fc8d624fbsm57846605e9.10.2026.05.12.14.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:05:15 -0700 (PDT)
Date: Tue, 12 May 2026 17:05:10 -0400
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
Subject: [PATCH v7 01/31] mm: mempolicy: fix interleave index for unaligned
 VMA start
Message-ID: <d254b3b52b4d39a5c2ca73abe49cc13d3c4427f3.1778616612.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: pbwea95MMCGkGI102E_2z_0i_YlBQttWimTwk6ogTkY_1778619917
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The NUMA interleave index formula (addr - vm_start) >> shift
gives wrong results when vm_start is not aligned to the folio
size: the subtraction before the shift allows low bits to
affect the result via borrows.

Use (addr >> shift) - (vm_start >> shift) instead, which
independently aligns both values before computing the
difference.

No functional change for current callers: the fix only affects
NUMA interleave and weighted-interleave policies. Current
large-order callers either pre-align the address
(vma_alloc_anon_folio_pmd) or do not use NUMA interleave
(drm_pagemap). All other callers use order 0 where the old
and new formulas are equivalent. However subsequent patches
in this series add large-order callers that pass unaligned
fault addresses, making this fix necessary.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
---
 mm/mempolicy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 4e4421b22b59..b2c21ed1fd84 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2049,7 +2049,8 @@ struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
 	if (pol->mode == MPOL_INTERLEAVE ||
 	    pol->mode == MPOL_WEIGHTED_INTERLEAVE) {
 		*ilx += vma->vm_pgoff >> order;
-		*ilx += (addr - vma->vm_start) >> (PAGE_SHIFT + order);
+		*ilx += (addr >> (PAGE_SHIFT + order)) -
+			(vma->vm_start >> (PAGE_SHIFT + order));
 	}
 	return pol;
 }
-- 
MST

