Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ACA3BFAD4
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 22:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315685; cv=none; b=KYmcBYjDy33UIo+C9038l710ZpdBYhAhPzw4w6Pvzej5gwqFVT70IHspnUhibUvV3SlulNwpeEcl8XAsRZIsNqXmvwoIUXwZ16MnntDBul776ppyqkA0GYSN6NGGZyPWdAFskAblng5m/h4CzeX7yHv9NI1VpnGaI0ktXgmMn2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315685; c=relaxed/simple;
	bh=nrsmIXcyZYzWzlqPkl9t9uUpVmTvW8/nYuSQvt237DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sEqP2ZXE5s2+Tp73tCcyA/mNKnx3b49ML4PFrMOkIhQU4V3+IgzwDuDqNNZtaFIULVqm8p61Cc1molOSApp7V0sfO7WiUPS9L7iTOMAOJKz8pSr2iM1YVOOFBjkg9fFGwFGFXuQeLWA47Vbsbke4itR+1cgths4WysS87nYXmNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aK+bVt0G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aK+bVt0G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779315683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gi0K9k7DoK/Ig5tkAzEbdYCqiHQSfFH4LjBzL6zaPFI=;
	b=aK+bVt0G+VuzfhOtH+ro5R5QH6TRkSMiJg9waW9h1MWuDf13DUay/Z3cwiNr1xn04Ssdne
	mmJea2jPpA+K/xUfvOE/qD8I+QsQgf12c4Y1Dzi7jQZGkAwW3WAIleqqK+5snlzpfdc+5M
	I8Nej9DR8R+6xMmBX3Kp0isCiJ+6rVM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-Ks5rA3SYPo2hPlqlt_zFuA-1; Wed, 20 May 2026 18:21:19 -0400
X-MC-Unique: Ks5rA3SYPo2hPlqlt_zFuA-1
X-Mimecast-MFC-AGG-ID: Ks5rA3SYPo2hPlqlt_zFuA_1779315679
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6852c63bd1aso6558075a12.0
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 15:21:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779315678; x=1779920478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gi0K9k7DoK/Ig5tkAzEbdYCqiHQSfFH4LjBzL6zaPFI=;
        b=SlrTyMv9ggy3a/LZLVLDGy8hSidKlwGJl8zGwil5Rt9hlLedcpx+J97ogCNSeaBE3n
         EZK+9xZ1zJ9N7WM9v70QEvrK8EbWOKHPs8XnCW6tHC6prfQAX5/PsDlJKwFCR7/rQWjf
         AuSJCFJdvDN97N9bf5P9y6uk7GtE3k+buxqgUlzyLbiLY6o0iwsUyzocj3oaga9F3t1Y
         FniA4pbUIAjFW0o3lG91ZgqabqG7RFTMCZzIQpfMQMqFrqv9Sms3HWkKcJqD53ypp52y
         MH7qsYHfZG2Z9fxjoUAoDGlhttZHLSGvBHWK6lxH2llrkCQBEWBnHKtwNgxjYBV/Diyw
         PKFA==
X-Forwarded-Encrypted: i=1; AFNElJ/a4Ao+W0p4UVd9+LrkrEMYf77zfP79jLiGxAKRNPAsBejSiOmmqcIqmX5M7qqriBkHM6yWGszLp5roxE6NRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwBToORbOjkESNKdsF/qhQOg3K0X871+TYNQ29kdfj11D5hF59X
	zipedIEqb/G0cO4gH06T8WyPjJUBiKYDaXl8eHR9n74F1lp7a8PM4roS//UaXSD02HKgBUPVIhg
	+LBL69+PcAb0j5FynY3rxMlHKJkn/EK8whlx/jM7pxLhkyq9U/6LsvM4HVQYJ7IvbPGBD
X-Gm-Gg: Acq92OGJOk1pNoU9fWUK6+7kFkpYr3qX2eUTrbWBddpBc3prZeuKiTkaCGqtnUBPBgI
	ez6HHN10vnbEcGQGht2gwgT/p5FpVdv1dkqi0dWZ1/foIo449zALCB3R5yUHhUvatbiNUawzQMR
	EhyEDct8sZ79GCT1LjxqfWs5asTb8LXZRIfyJt0eU3euEvdt45qynVssgpACg38oJfW72Gv1llC
	YPxCqowWvTJ7I2pzi+DbjrpgfgzX+/q0QaIJxerZt1rwwMZupg8jRxmp/Ukjpc24ll+9F8WlijI
	xJoUMnuNMAEgQiVdMzeu4FYdLA1I5TQCGfECiuEy5bqUkl7VQAHdf5qWJ6/UQqgaeZd6/cnmi6V
	nHQgS/fByE9WnlHj9r21Ly3HPoTxmQge2ALIqyXI0Eys=
X-Received: by 2002:a05:6402:388e:b0:67f:d8bc:1c1d with SMTP id 4fb4d7f45d1cf-688367d7471mr20716a12.20.1779315678492;
        Wed, 20 May 2026 15:21:18 -0700 (PDT)
X-Received: by 2002:a05:6402:388e:b0:67f:d8bc:1c1d with SMTP id 4fb4d7f45d1cf-688367d7471mr20674a12.20.1779315678044;
        Wed, 20 May 2026 15:21:18 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-687393e8e89sm1281214a12.8.2026.05.20.15.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:21:16 -0700 (PDT)
Date: Wed, 20 May 2026 18:21:11 -0400
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
Subject: [PATCH v8 09/37] mm: hugetlb: thread user_addr through gigantic page
 allocation
Message-ID: <9778009828d334fd4262d60b20d8d25a54e0f133.1779315441.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: S2rTsPvRBAk6vO0yeELm9vAoRtk7VEmNsb42re9wcwo_1779315679
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Thread the user_addr parameter through alloc_gigantic_frozen_folio so that
gigantic page allocations can benefit from cache-friendly zeroing.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/hugetlb.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a999f3ead852..3a6afbe99116 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1375,7 +1375,7 @@ static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
 
 #if defined(CONFIG_ARCH_HAS_GIGANTIC_PAGE) && defined(CONFIG_CONTIG_ALLOC)
 static struct folio *alloc_gigantic_frozen_folio(int order, gfp_t gfp_mask,
-		int nid, nodemask_t *nodemask)
+		int nid, nodemask_t *nodemask, unsigned long addr)
 {
 	struct folio *folio;
 
@@ -1386,13 +1386,15 @@ static struct folio *alloc_gigantic_frozen_folio(int order, gfp_t gfp_mask,
 	if (hugetlb_cma_exclusive_alloc())
 		return NULL;
 
-	folio = (struct folio *)alloc_contig_frozen_pages(1 << order, gfp_mask,
-							  nid, nodemask);
+	folio = (struct folio *)alloc_contig_frozen_pages_user(1 << order,
+							      gfp_mask,
+							      nid, nodemask,
+							      addr);
 	return folio;
 }
 #else /* !CONFIG_ARCH_HAS_GIGANTIC_PAGE || !CONFIG_CONTIG_ALLOC */
 static struct folio *alloc_gigantic_frozen_folio(int order, gfp_t gfp_mask, int nid,
-					  nodemask_t *nodemask)
+					  nodemask_t *nodemask, unsigned long addr)
 {
 	return NULL;
 }
@@ -1862,7 +1864,8 @@ static struct folio *only_alloc_fresh_hugetlb_folio(struct hstate *h,
 		nid = numa_mem_id();
 
 	if (order_is_gigantic(order))
-		folio = alloc_gigantic_frozen_folio(order, gfp_mask, nid, nmask);
+		folio = alloc_gigantic_frozen_folio(order, gfp_mask, nid, nmask,
+						    addr);
 	else
 		folio = alloc_buddy_frozen_folio(order, gfp_mask, nid, nmask,
 						 node_alloc_noretry, addr);
-- 
MST

