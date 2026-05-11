Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AB13BBA04
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489637; cv=none; b=CwxroTi+xJ74vGhOKOUbjvH0WdgKLwIcXR4f+VkjfHzjNypZOkIpCw9nG9aYLJGxWHr3pqRJD+UKjMyDuyWzc8jd1JLoVHB9wsYuUU7urDOVe1zvY+V/9Z37TCz7PSHuUc0k/Xjo2mjDK3jjmL6vuvF6QElWEjqJceZxT4TTieY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489637; c=relaxed/simple;
	bh=WO4MHxi65GFX0xUNciL8bEMuUsPiR9dGIohoqGtzw3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=K6OyR5Td936JVXdKmsUFYlDktp/joSa77RiKz2stZg+F8EgsoVcF6qYFwdQEcgw/K+W5fzDCbzGFwjoTQJMyv1SXOatHd5b1wpe/z6wlTr4qpOEqd11oDrVxTM3BWL7UcMyvJwh4CwCBLrSbAbEQX2kHTJIK8LuWHDVvclbZRM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KCJ4bNZu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KCJ4bNZu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778489635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XL/pBrxkXlfOOto9pZb2YfWp+jJTrqFtHfQ0Ihv6FSM=;
	b=KCJ4bNZu6QHXlw1ht4MRSkOV36aMMeDc7UwbqVfeGldFscjCo54v1W5dpUbb9N4dLadBAf
	w1m5QAr6VpGG/xVX+rR2W0JKYz3jmOe3eN92RpYVLkzFU+05SbZsWKRCG3GQ3Y7J+kd+Vq
	IWUJSvCFED0Kph70VRIUMtP87yo2Y2s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-0UUzjSpmOuam8l9KJ2qJLw-1; Mon, 11 May 2026 04:53:53 -0400
X-MC-Unique: 0UUzjSpmOuam8l9KJ2qJLw-1
X-Mimecast-MFC-AGG-ID: 0UUzjSpmOuam8l9KJ2qJLw_1778489632
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48d1bc85bb3so20597455e9.0
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 01:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489632; x=1779094432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XL/pBrxkXlfOOto9pZb2YfWp+jJTrqFtHfQ0Ihv6FSM=;
        b=skGzpc34JgpO6E6VYrKZhNTxLBHzjaQNYkV4PFmXRtbJJ4SjzZruRV/n21wccnruel
         NZLYgZ3hiu4EeHOwxeWVEiAZyQKxo7aERZRkv1tRZubeHQ0wfaVE3ajtK2r5OKUL0lY4
         IOVoqsZxon5ttKO5mBZVIuDAvIsdWpKVc5cnYmIHd0NMkkYDbrKCv2JeQhIxI27CbMJq
         0Abx3N89r/BcUU0oN+uPOhXQB4FgxuJZFEeRqvWvvZlOdtTwXp8Ok+irR2T5bzdSgr6J
         ZPAWtkZkCoAxV/oyyAz3+8OEJ88rYUM2YZJUXqLv2dNPqx6c46ibHbC107upkKZpfSbl
         YujA==
X-Forwarded-Encrypted: i=1; AFNElJ91ZQcxBlFCB+AydGHHmEgBpim0PMJyfKwtKJ2zRdqNXG3/4C1MxaomaXnVPur/pDdMT+l537bvkXA6QInJAw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0wsiFL5wWwWoUEvsT3vpWMV8St0K+/U/Wb6+jVObKtsR7uWiX
	cNDFiPjZ0EK++2wgPaG3dEcc4HnPnvVbPKdE3Bu2hYyZMXtM/bBBAJRnMDIxT9k+uTFVfKZcSj3
	4ktDepeMzV3911CP9lzFMSv4346u0eTVPAfd7CkaJvi9GDU+jV4e+VlP2j1yUOBafboTL
X-Gm-Gg: Acq92OFUt3mdNZ73szeaC+uDNB9+r3LjR2aXNHOBwhvB7sATePnk6djFNOKbYqakdUL
	3rJyL6U1at8FEYR+TUug2Kjjh+01VRqhSgNj3JXpw5Mk1oDeqo90shFJgRVLCZtpCeCWRUpCFsR
	v+TubQ2AvaoeQkCzzVTuqDGu1kjuksaquT5X+EfAAsN0zwOpExZZ4rK9sJWThGB6mnXngD9hCN2
	J1PttKeNm98ON/q/1XfLqitmKxeA5v0xXpw+qvC1Y1wazkGBPQK23YRtuwvig2m2Hi6mFMC7voM
	0YBxXMcvgxprbXWDPLrk/pn+9Dw5OQKRrt9JfvYeaQ+SSgsk3KZbwos5UgZqxwu7+KR6vf6mWzR
	k8fjlDKTyc/fmXw2vEnU5WY705nbIs/KwllYq2zYf
X-Received: by 2002:a05:600c:3e10:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-48e5e0089e0mr278415575e9.13.1778489632195;
        Mon, 11 May 2026 01:53:52 -0700 (PDT)
X-Received: by 2002:a05:600c:3e10:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-48e5e0089e0mr278415135e9.13.1778489631562;
        Mon, 11 May 2026 01:53:51 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702e0bf2sm299190565e9.4.2026.05.11.01.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:53:51 -0700 (PDT)
Date: Mon, 11 May 2026 04:53:46 -0400
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
Subject: [PATCH v6 10/30] mm: alloc_swap_folio: pass raw fault address to
 vma_alloc_folio
Message-ID: <369a08b86f51572b2715a9ec577de27ea98000d3.1778488966.git.mst@redhat.com>
References: <cover.1778488966.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778488966.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ecTL8Mh3DdhvLE3O59vlkglpyxEgdHFcZ_JYkXVPDx0_1778489632
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Same change as the previous patch but for alloc_swap_folio:
pass vmf->address directly instead of ALIGN_DOWN(vmf->address, ...).

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/memory.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 0824441a6ba1..74523bc00d8a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4734,8 +4734,7 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 	/* Try allocating the highest of the remaining orders. */
 	gfp = vma_thp_gfp_mask(vma);
 	while (orders) {
-		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
-		folio = vma_alloc_folio(gfp, order, vma, addr);
+		folio = vma_alloc_folio(gfp, order, vma, vmf->address);
 		if (folio) {
 			if (!mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
 							    gfp, entry))
-- 
MST

