Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F873C9438
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 21:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778619985; cv=none; b=aG6fjuH2r3dqp4GJ6HzYuGA1rgaXzPmSElDK9WEavnznfT82+IvAwWG0GuYzMGkmJoBtcuk2Atx5MQ+4PKPg0y1kj+lrB0rQJen/U+K345jLp3Z9JEJJi1vMseUMuxHyf0OMUf0Q+T2eMZHp2LXO9joYiAKeWK8l6kn4xcZkbOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778619985; c=relaxed/simple;
	bh=E26K9MtueOnkubczVVC2xXdzWX1Y3Ie61mqNQBLBafY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YoctitVkCi8I9G7af1jEbaOP1aBB31n/sAi/HDDINJE3vpxL3NI4LzyRhBuv7gLjkZj0lH+3fCC3yHaXLW5wD0q3oGm4aJBKpk9JVY/lAmp7e2T4j1Svxlbe3mWsVj7dtc/bfcNrCKytqR3xJEa5f5Mz5Eag94qMgXRP1jiQgHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DNPwbVnO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DNPwbVnO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778619983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cj9nBXTM7Pn45uNvAdcesuQTFKdusMRl11qP0Ml19S0=;
	b=DNPwbVnOQDDWjp+FwiuEq4fH1RF1z1/WEX9CGOfQ8rTCxhjkF+2bwZ0rXchi1ZKKCkO6rq
	G9NJ5ue8dcE4l5+ospXBQz/K0INhvzXo9oeJPgUwtQiugfMIMhq3qCTopakyYDDvySaCIH
	UIhcfrqj0UQs8OBijCue48PHPqNZVyQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-M9uE3lu6MhqYi-OSSa9NOw-1; Tue, 12 May 2026 17:06:21 -0400
X-MC-Unique: M9uE3lu6MhqYi-OSSa9NOw-1
X-Mimecast-MFC-AGG-ID: M9uE3lu6MhqYi-OSSa9NOw_1778619977
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48fc9084562so3478315e9.0
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 14:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778619977; x=1779224777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cj9nBXTM7Pn45uNvAdcesuQTFKdusMRl11qP0Ml19S0=;
        b=cOEILEdjQwsD7+8g39Ffg19eMoCbYlV2LMdIzKTJ0pgo6I9BV8KSvDTheBvmEXX1Ih
         vJr58Xwp7Z85sh/Vat9dR8DKyUdKIeitsdB7/MCdYcgPkmaWLFOh0yVy8nYHdqhAn7fa
         VsP0r/ichlJOvQpNOU3OEcaQqN6Ivtj8MRqWP26zoWnfi8B/XDQ5/QM7m/veCAVgMivB
         MZ3HfsmaFDXmtgixalBgEXIa9TVZQ2spp7pVL0rCtzJQFAM1ZTImEXawN4/rbm9mmPQc
         EZZQjpGBHM9Q3gzqn0MFUyYVY44YgY8H+nsucCcrxagF+AGdp8Y1VzDXvJZQCp+Jo8z2
         vuEg==
X-Forwarded-Encrypted: i=1; AFNElJ8ZA43VrsPRbbJi33bECcAskXJ1apNJHJdlVjkOaPre6jlQgA56pqX4FAAuzM0fTTumZz5U2q3687sS+yfgyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7r4JXTM3wbW6+PdoT3XXU1BLcLyGmN8dtnhiUGkJq/NAhsXqs
	O6v1BW/J125aGJqgeNjp3hSp1yZeHBSUqiT+jKTCcJIzHAJFoTHD7Fp5AWosHcQ7SVOfqsQEL4V
	ov2EsTGbnb5boHFc76AhkK7fBjL571t67a1qRafo4B1TbAG3qyDazVdH07lGXyjTnjr7n
X-Gm-Gg: Acq92OHJzSVvp8u06gDd6GUkr2bVNwwslo/oruDpJCgV/Rq79s9wlc+cXBCnRFF4xTQ
	+ueVRYy7EOJ4pFsw0e/dbFnKaR+K613Yk4jOrva/Z+uWwk38ejF/mHLHkh8zHXToVAL8iYmlSMM
	1aONv9wrrV3MrJ0YTd2Y28Bvh3jL7KmhKXQMvX0aAkRKo7uK2ufAcZUpUCys+7Nu3Nb2is6R+j2
	Ywc+4V5b92yTzcVfgX3VxOMtBM68y8HvqLgFp95kKUMSn/YZLDCg81o40Ae9VMU8XANMLhyUGf+
	Cf20QFbG7Mpy4MZcoYD4RghxbYlcDomSpYnZTZZhebEevUUh98h/Lxt4ElB2QTfToNN6xaqfVUU
	HtUwkyIR2Hq4bq16OVFxt0VZu5a5IMYUX+1TVFBMm
X-Received: by 2002:a05:600c:4e14:b0:487:4eb:d125 with SMTP id 5b1f17b1804b1-48fc9a0eaf0mr6501235e9.9.1778619976774;
        Tue, 12 May 2026 14:06:16 -0700 (PDT)
X-Received: by 2002:a05:600c:4e14:b0:487:4eb:d125 with SMTP id 5b1f17b1804b1-48fc9a0eaf0mr6500975e9.9.1778619976278;
        Tue, 12 May 2026 14:06:16 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fc8d29c56sm22449935e9.11.2026.05.12.14.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:06:15 -0700 (PDT)
Date: Tue, 12 May 2026 17:06:11 -0400
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
Subject: [PATCH v7 12/31] mm: alloc_anon_folio: pass raw fault address to
 vma_alloc_folio
Message-ID: <865e54aad878ac6627ba6633f35ab57a5e2d3c73.1778616612.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 9b7XVtfUE0Q1QbINjeYHZkpFEdDZa212hPRakUIZB_E_1778619977
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Pass vmf->address directly instead of ALIGN_DOWN(vmf->address, ...).
vma_alloc_folio_noprof now aligns internally for NUMA interleave,
and post_alloc_hook will use the raw address for cache-friendly
zeroing via folio_zero_user().

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
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

