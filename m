Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2CA3C988E
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 21:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778619988; cv=none; b=WUjxJYdUkAT1sSBNVfgHge+WvGh+lu7NDAGcechZDnJIZDvQnZMxC84tXdSC/gMiFR4J5E/3gQuKXVJKUP7Ha0Yx2IgMs4M/14UP0/jeqUaGzZ3Fdo76Ewp4JJbE+nrN+Iuan/BHSdADHiyA2UrkOs7gYC4S+1nacYj1XBxc4yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778619988; c=relaxed/simple;
	bh=WO4MHxi65GFX0xUNciL8bEMuUsPiR9dGIohoqGtzw3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Prf8N1nxdOU37cgAeSbDvH19Z2gPv8p25vkZsO3zkMqsUs4pcDaCTQUKos9Ukr7RQaj/mhO6KaSN5wRaLxLGttNLd+latzLflcFJvr+/0UlWakdJvSFPRgTXm7poQAnGb0bHE5vhYIWNlQyJvOspUtqZiguRN5FnBFHQDgP17yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H/5ZgCXH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/5ZgCXH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778619986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XL/pBrxkXlfOOto9pZb2YfWp+jJTrqFtHfQ0Ihv6FSM=;
	b=H/5ZgCXH3xdYsgzKo+rCVIYW5/449TEPx6zh2D1anLVZ4Q/vWIJ7GwqnjSz+Kup5WkprLd
	QV9mJiFlqQSwHpOs9qPJAtpnBFVkr6ftImy+Xt44B7tfOYNuO+MAMiJZ1UzNrJPaVu+UGx
	EUOwNrNwKE0e0JMtu/Jy1/SR+G18iVw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-3hCq9DMGP8-EK3YzugAflQ-1; Tue, 12 May 2026 17:06:23 -0400
X-MC-Unique: 3hCq9DMGP8-EK3YzugAflQ-1
X-Mimecast-MFC-AGG-ID: 3hCq9DMGP8-EK3YzugAflQ_1778619982
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48eb0da933fso5867715e9.0
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 14:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778619982; x=1779224782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XL/pBrxkXlfOOto9pZb2YfWp+jJTrqFtHfQ0Ihv6FSM=;
        b=gJUgM+nA741yGchnXq9Z98OTBpTmaWqqnTk8IFHHlSyZTnO5ybZqbwtnVt8DerqtSr
         i0/xYbZs19KerRAcOMFBQ3abAq1h4XRd5SZ6OJ8FhjIbiQ43M1ddHgBJlrigDGe0DPoC
         3bWQ+siWUhZxcEZTOA5cjQtpk8yRNIU2LICjUpPtAXU7TQoMJ8lAW1V1SaRhuMsPjVZ0
         vqpTCs5o1piCgJvISSMww/s3sQinpX3ci3mc2IPvtFtco49TAhkcyLAgpReoLtprIPFM
         KsSxrTFa3IFMVjB2TqGRicmKtkKRbIKiMLO6R1WCE0KI2AsorSzABxmmyJNWsiLu11ew
         dRPg==
X-Forwarded-Encrypted: i=1; AFNElJ8Ipv4wWGo+odu8TeN4ltnD1C1k4juQa8FlBx4QLlPGPFT16eHFIlbUGKSZ+8XX3V+pGrH7cl42ME31vh5epw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWhQhn9q+RJeVKDGGPvpMRWiqlEFoJ6H2KfgXvyrbe+o8MdIxO
	3VQ1Vsu8yhM8VsjGupkffk2byr/r0AYYLtNEgTgR8MGnZjd0VHP3yaG99YYXcw+b2prz/eFKPwn
	QVNSjua68IU2c1ZqNsY8Bm8ItrpcFeaZSf0T3MEcQuh5/ayK19sIxDL4vLmK4+0G0HJY6
X-Gm-Gg: Acq92OGKS57yOwYXAsvSmTksOIZKGUBEJA7pybE0rfPdcu1c/4zgfHR/S429+bOgGbH
	fh5Ugx/mjsMdKcsxOBHXjgd9ZG8XR7XTo0N+zHB8Qq06AwVxB7qPdDh5HoD4hWkmGR5ZkESDgkI
	QKq381drxzkaYZI0NQ1fdM+mlbeQ7gDO5VyJAd4EV4k0ALXOiAyoFwdIgvRCp9zOISMFbTBiA4s
	YYMzYS6nojQ27OYpc/M6onBcTvZulo3n0jE57WIcjYgpyIbwMCCGv3LawSL7fZzaAVvAaMKob9E
	lUjxnJCDeHqpW61u+azZDvi5mHQGgqac86+fUZa1IKhH+fVMt3uUPIdXgjz9L7+fCu0TRUxhLaV
	iCLuVzc/ERrMgA+5eHmaoKYjJx1eezGCfxsmIX11D
X-Received: by 2002:a05:600c:444b:b0:48e:706b:53e3 with SMTP id 5b1f17b1804b1-48fc9a0231emr7732955e9.1.1778619982329;
        Tue, 12 May 2026 14:06:22 -0700 (PDT)
X-Received: by 2002:a05:600c:444b:b0:48e:706b:53e3 with SMTP id 5b1f17b1804b1-48fc9a0231emr7732775e9.1.1778619981835;
        Tue, 12 May 2026 14:06:21 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491cab9c2sm37226840f8f.31.2026.05.12.14.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:06:20 -0700 (PDT)
Date: Tue, 12 May 2026 17:06:16 -0400
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
Subject: [PATCH v7 13/31] mm: alloc_swap_folio: pass raw fault address to
 vma_alloc_folio
Message-ID: <66119d3bab318d74c1586b99dd70fb74e2da1ec0.1778616612.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 0RJdIY68a6n59kmB4922QbuthfNJCI776aDXP70azi4_1778619982
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

