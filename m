Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246C33C2761
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 09:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490248; cv=none; b=fK3GGFFNiVkF69ZeUJB5Nu79z2jR8ThBJ32OisIjEnDp3BsWo+GwYFcQL6teF3ECS+7x/Nzh+CJMjED76wSfeXbQDQd5Ni32ySstvYi+M1BpRTvQfc/W8kpFQ9tKtrt4qmYZ4splRHjkMhgEVtnT1iUqmFFfEa0zCaFIR3gTlKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490248; c=relaxed/simple;
	bh=UthrZxmdWcO06HJ9ALdgvYEd0atl77MZdyNsS+qUmSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gz3ISKF9xqu8U8/e7Bnd2Vl0lyH1TEz5gmeDfkBiXt7xTj6U8nnK7lMZPBN/Pu2IH1BK06MNqBekrd1lI5w7Oc2yfn9zTIUAzmNk0f3vESIB9vqfjU3AF0Fpr6/j9/q0jTUI343sO2T3mgu9JBd77TTya6vzMhOpuCMj7ZNZFFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G82cq8U8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G82cq8U8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778490246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=91FyDo4lvxPgkiSt2vN5y4yAYQZnqJbtxElmqdOrkw4=;
	b=G82cq8U8itgozYGxboQFtoycyu2vBOs5j3ri9cnUQkhaKYNvizpMoOgNWySnvJVh0PD+nq
	ivtAkWUrofmSfnqdFNiaHeypsjkXrkT0X1E+Q9v1aIUBi8x3dfPUKV3shrYc7rZXQ0hmvJ
	q+aLUUmtxc9Dicl35t0EYKeOGc8tt28=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-BpE_twVgNfS5bjCDB9Q60w-1; Mon, 11 May 2026 05:04:05 -0400
X-MC-Unique: BpE_twVgNfS5bjCDB9Q60w-1
X-Mimecast-MFC-AGG-ID: BpE_twVgNfS5bjCDB9Q60w_1778490244
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48e6af7a9cdso16476585e9.3
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 02:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778490244; x=1779095044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91FyDo4lvxPgkiSt2vN5y4yAYQZnqJbtxElmqdOrkw4=;
        b=mk3m/kf30PSbf/xqHkMv1iyvt7mo0xT41zXhKoU4Q9TLlK1rPgOAqm14BH8+t7hd+Y
         V1KZR1ntjrzjHlVDg5XkeT0epLriJOs9GYWPvSrLa2u9lWaCSOmomC4j3G72BgYcG1R5
         8FabeH6DzyaH79fOYOrkW6e+z4PJL6foHrdEzSgwMF0vCX2+QkVWjheNfiSCj6dRcZGJ
         GX2WzwyKkwJk6Zf95jfI7U/s0xYJ1Lk9NwFJTu+GOQwdNSPfhJ8GObUIFE65s4yZrEkv
         i1V8upR8uTr5Qj9r1sIMEMJiA2Id+UxDqxaMur2yLPCsR8wv8CMNKjyF/OtNYVtYL3kh
         Z/xA==
X-Forwarded-Encrypted: i=1; AFNElJ+2V/wt9/9jk0WGLr84XLcwiJs1cfXqeU7KscqQMJYVqb3OH4fcUTtAIQIvPES7v0pqW6pxCgUdoB+9f2P9jA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwcLzuq6nkn8Dz56JHcOZjKq5Xyi5zI83ghksFpLD29DLu8tF2q
	4+3vRE3YEDttbwjSZGq8rWECjc6gSXe84+mODSVJzl9PDxo73k4DUGAFw7ODVSAefoT03T0Hnuk
	OICmKq2yJwMA+DQ+OAZRb21POeln5KwfODQI4saMEsiCGKcOCWRuUWYwSSKI5sGUcqQVV
X-Gm-Gg: Acq92OEU0Ynkoalq3qh0vWYk39AshhMZMNKuuDTGRilzGIgkUEXJ+4asFQp5lcGpgYd
	24VcYJ+WG7r/TvqLFexC6PRze8A4cu692OK/oPfmKsywuvzcnw77xEiWTxWqlLgU3+gSKXzWAcT
	I4/vIgM2as4zx9QLzmesLEwD69A5wkVCsz9U354jrBNtZC9aI+YTV/Wkxm7QGBJyL4Fvis14HiH
	l1yPS1HVbSHyv8OiX0Qmt16C/zO/E5Dlo7AmCngsi3G922FXPwzTru1PIHF0Cy7W3JT8LEgFvDm
	c+26pcVWJAygGyUskDv8xVMu1D03eBSqO9h5X3SHL4gOZsV5E7O6Utv/O8ldSOhX90baxYVV8sL
	gLPVVlX6PzEUjc/+BRMRJ9lYvw6YFLhiFWiZIuXx9
X-Received: by 2002:a05:600c:4e87:b0:48e:706b:53e8 with SMTP id 5b1f17b1804b1-48e706b54famr152707065e9.11.1778490243729;
        Mon, 11 May 2026 02:04:03 -0700 (PDT)
X-Received: by 2002:a05:600c:4e87:b0:48e:706b:53e8 with SMTP id 5b1f17b1804b1-48e706b54famr152705715e9.11.1778490242995;
        Mon, 11 May 2026 02:04:02 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702f4042sm180354375e9.14.2026.05.11.02.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:04:02 -0700 (PDT)
Date: Mon, 11 May 2026 05:03:57 -0400
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
Subject: [PATCH resend v6 24/30] mm: page_alloc: propagate PG_zeroed in
 split_large_buddy
Message-ID: <53c45baf0b66b9ddb042377a2e060f7f88b9ad64.1778489843.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: NVSfCg0a_XdKG44EEzqIOZQ4AqIko4JsG47JW6JU5Ow_1778490244
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When splitting a large buddy page, propagate the PG_zeroed flag
to each sub-page before freeing it.  __free_pages_prepare clears
all flags (including PG_zeroed), so the flag must be re-set on
each fragment after the split.  This ensures that the buddy merge
logic can see PG_zeroed on pages that were part of a larger
zeroed block.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/page_alloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 468e8bde7d34..ce43f5a3dbaa 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1523,6 +1523,7 @@ static void split_large_buddy(struct zone *zone, struct page *page,
 			      unsigned long pfn, int order, fpi_t fpi)
 {
 	unsigned long end = pfn + (1 << order);
+	bool zeroed = PageZeroed(page);
 
 	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn, 1 << order));
 	/* Caller removed page from freelist, buddy info cleared! */
@@ -1534,6 +1535,8 @@ static void split_large_buddy(struct zone *zone, struct page *page,
 	do {
 		int mt = get_pfnblock_migratetype(page, pfn);
 
+		if (zeroed)
+			__SetPageZeroed(page);
 		__free_one_page(page, pfn, zone, order, mt, fpi);
 		pfn += 1 << order;
 		if (pfn == end)
-- 
MST

