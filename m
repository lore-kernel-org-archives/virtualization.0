Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8AB3BFE4F
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 22:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315794; cv=none; b=K6PKEljfgZvo1tBbbwD6qaXhA3yIZgTHOml4YPVrFE3CBmv7RS2rY7xR+pjSwUC1+uk0ncUxa6mgSRMBPMQhUqQlSEiQ9GtAe3DxzH+TQrqrflfefRbcfekKL4vb5MLt2uw8EEwEV76Uec+LsczWcxu/ElOmnKpoitTBVs+NdXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315794; c=relaxed/simple;
	bh=gX3aTYbHX/GyGonutM5PlW3FkeXMFkBsDPOEXbSa+qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QbV7g2srGZ8DEwPIVaZgp+oxDplAPB/o5Sa41HVkADM9BBFk5n7sazwUlrbi9N+wIEb5UbN7aFgB1qHn65Hn0LvJCmhn0C/A2r5W64NDMJ/TPCpDRH4eJZ4VlEuymFM1RFyeh9VSXmIXzUfgrAlYDa7V3Nyr8eB5IhVMVWn1xe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XrC6ilrs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XrC6ilrs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779315791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yuucL8pRyKGlavgC043yPLfH9MArN/0/T/V0zfd6qpo=;
	b=XrC6ilrs/xio5OzIeuXmic0SrHw2NYcD5RQNU5IGaU7BWUSWDQzr/es5ZwQfsss5kLw3Z0
	FS7tAPQ9IleuqyqJUwkjsEnZjtf8s68w8EUxRnzbJvhLydYsdCxlIPNAYT1FS0aF5C54/2
	3IkR3WFRKJLwmOuWp51ZVobCg4X2CkA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-Z5B3KuMOO_ypveNAr9QDig-1; Wed, 20 May 2026 18:23:09 -0400
X-MC-Unique: Z5B3KuMOO_ypveNAr9QDig-1
X-Mimecast-MFC-AGG-ID: Z5B3KuMOO_ypveNAr9QDig_1779315788
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45e2f74da10so5973300f8f.2
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 15:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779315788; x=1779920588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuucL8pRyKGlavgC043yPLfH9MArN/0/T/V0zfd6qpo=;
        b=EBEks7tBUxSgP8YiqsSQJYJYEKVOsitnIUqG09neQqh7vCGrDrfuY23/MfnQgLkwOx
         3K4LeQnWj0hm7EQGwPQXLWM3M84w2VczWzwy/Qpn6MBqxgU4gjbM8x6776CL/K6z4Xru
         snJK6r472Ey8ckcJyInLhC9W0ojX8n2BSsw2AIVsc6SaXu3i9of4Po2PCmUQHNY8qQ1L
         GOlWHBvcYL90BZ2tuXEdvj++Gy67VQExxHkezj8eH0p/qUpX/NQAeHouM2T3E6br6Eu7
         MB0jsYCk5VJd4gK4zyuV4Ow5ZfN/AMQYaej3wrBUrKvIaHs/4cGJ3tZlYYk+0HX1jEtN
         TQMw==
X-Forwarded-Encrypted: i=1; AFNElJ8q8mVx+IUIlloTZWf85Z7OgX0SsDOKrL0cjoG01ZT0xplZxvG5Sv0iCFyOT1hSUm89Ruy4QsTlq3C02+D52Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7jMxtMhh5zflUi8fZN1zjGzvDZSu1WKB7GLnWfKgDrqMy3SvZ
	71qxGGlz3chzIrFyUQG65s2DvlMgwNznU1MfSOq3t5mPSYgw/53lMx+WCKb8Bexhl8DYUU1c+wm
	E3DV9tPAWEYyZZO393rDXaOhdhcC4ZR3PnCcLte1pqCfYp5o1jh0qVA0owrJ2S66LoG6L
X-Gm-Gg: Acq92OEfQuRB/eXZ0FA+uN2qITRCORX3DepWTGE9H+wJrKunn3/NkVh8WFr+VrYLl/7
	+7ru9ft6yhJSVctNrJqPdEqxQJ+KrkVWQj0LERzfCRVt+5pMyNA5827NhcI3FRqc4ZvHX9zh2TY
	4ziKQEc1SPalYopGT+YPhn492ka1mwUOXw/9K0Vs7sxN3Ft6Etzt0x+DI03VtTCBtRKjN6gC06W
	tn+5GWKtAMUh+Nd3b3DiyoD0LnT65RjyDDQjxgkPDyX5/FEz1kJkVDW3Kpsmz0QCp2m46Sl7vwC
	t9UT5r5kshOCn9rwCZY5ivdEmCLXHn9nAlo5aQGYjFnttO5DyycSWvDIZtqL/CnE+R2Cau26o4a
	4KVq9Agl6WCSqCWuuvcl+VIRrJp34s+ohLDjgMp+vFQE=
X-Received: by 2002:a5d:5c81:0:b0:43c:f3ef:ee36 with SMTP id ffacd0b85a97d-45ea3ff957amr218739f8f.33.1779315788394;
        Wed, 20 May 2026 15:23:08 -0700 (PDT)
X-Received: by 2002:a5d:5c81:0:b0:43c:f3ef:ee36 with SMTP id ffacd0b85a97d-45ea3ff957amr218690f8f.33.1779315787876;
        Wed, 20 May 2026 15:23:07 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe1a41sm61756873f8f.31.2026.05.20.15.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:23:07 -0700 (PDT)
Date: Wed, 20 May 2026 18:23:02 -0400
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
Subject: [PATCH v8 30/37] mm: page_alloc: propagate PG_zeroed in
 split_large_buddy
Message-ID: <ba7b9fea071176c81dad6d0b8823ac1b75ec3d4f.1779315441.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: FgKJ7tF3dMEftre1SKRPCgwp-yQ2XtxZzb718K7Qa_0_1779315788
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
Reviewed-by: Gregory Price <gourry@gourry.net>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/page_alloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 72e52f049cf0..702fa2ced1e1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1524,6 +1524,7 @@ static void split_large_buddy(struct zone *zone, struct page *page,
 {
 	unsigned long end = pfn + (1 << order);
 	bool reported = PageReported(page);
+	bool zeroed = PageZeroed(page);
 
 	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn, 1 << order));
 	/* Caller removed page from freelist, buddy info cleared! */
@@ -1537,6 +1538,8 @@ static void split_large_buddy(struct zone *zone, struct page *page,
 
 		if (reported)
 			__SetPageReported(page);
+		if (zeroed)
+			__SetPageZeroed(page);
 		__free_one_page(page, pfn, zone, order, mt, fpi);
 		pfn += 1 << order;
 		if (pfn == end)
-- 
MST

