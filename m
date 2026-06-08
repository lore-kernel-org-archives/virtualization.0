Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6F53B9943
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 08:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907941; cv=none; b=ch79v8fUd8iZp+wHf6RSNPBOt0ZYYFD15lBobFoBtQsq14OcC/oXHkhYZTGG9da3Ngcjc/NJp6d5n6AbajMDNnA23UQYLfFQUzEZ7A0vr88mCi11jpIyRR2WjKOMvkL/EhGVFbjjcP2DDXearu9Ma+uSahAFhCpSf1iIR1i38kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907941; c=relaxed/simple;
	bh=9G4viGLxhnf9wEDx0vlsgDGsNz6CjvZFH6MPF7/wsQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Yf4DG8e2Sw3VahBn7hIBEanZNG+GGGNR+696SoOngZ0FfxnGxxEdi6hRqrxRPOrQ/rcrtUNq3GODRLo07U7qrSzQoyDcFak4oymBr55/+RauvAnTUHzLw+wnQRs7cjTRh58hKns3QXmNamch1J+BdqHdiC0bTbev0SsrN6GNZi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AFH0W5OE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFH0W5OE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780907937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EnA3ajreXHx2VoG4/VPZjRVpyyF9Dgnshjyr2lhZIq8=;
	b=AFH0W5OEo2Qn1vreC/ANDj0Uke9EOnTnojRzUPtxHwhOyPLsqyhbJ4vnDk42ye+2NOc7+Y
	neqDHwvsJuKvjmSnIv17X98aQvT9RweaR5F78FD2T9YDfLXAcmtCCVyGgNEsVEchwRisLC
	Bn/b9HFG6dQKzmA/7qMgDS/81TtC+L4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-VgLwTp95PRKHUWky9usv7w-1; Mon, 08 Jun 2026 04:38:55 -0400
X-MC-Unique: VgLwTp95PRKHUWky9usv7w-1
X-Mimecast-MFC-AGG-ID: VgLwTp95PRKHUWky9usv7w_1780907934
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ef3aeeb41so2646451f8f.1
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 01:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780907934; x=1781512734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnA3ajreXHx2VoG4/VPZjRVpyyF9Dgnshjyr2lhZIq8=;
        b=JP/YCbWIP3QTe5QIQAxGYOy6hUOkJoFR+pkOO3KIp1gD2rzvpo4g+gA1Sq6UbJ72/h
         /fBiTYbRhvdNo1tyOMus0xrOureAbNN/eyElv/REDtJHhDowaDQbUVX5dO9WCqUiDxlS
         2QJVYbg7RmPMXIob8+r1zqoiqIUnx0GCCGAPFJ6NyehXnjUTPq2xaQvvoN0F8fdhaxz/
         GRXaxWAy9HG/paTYKeKJSSdEmxjDMkFSGj2nl08oZ0FuY8sfBWRl+hzUAvpQq9s4+pcD
         xRlAuqe0rJyPYTp6R9rpf4sZParBG5vxyKrJVcktDcoOmMsyRPWONwXpjVujR63AQ6Ie
         85SQ==
X-Forwarded-Encrypted: i=1; AFNElJ8UI0fWwA2rVFUiQhI2ReK9HhI7UHOfz6/94nXbBb7TfM4dS7XOAsOd9LhBYO3Y/nOEXe4pzpexEGveUESFxg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvnuAKM59B48f5Iihc8b+MclkX+Go9QQkErQix0GeYg0vFBEPQ
	eYGrgC93z+lhjjU5PinvG8kqPH57PM5wm4ATKknTHlHDkozso0QiDA+xoAA6HY2/dYmFzTC5yxu
	xbN1qmVXp4RUpB4I2ZmFQzva6w3niFnwTVpyYBiQJ4GNtPinPtwCinlclgb7Gf9I7OcWX
X-Gm-Gg: Acq92OGx+s+OsEVl7EeHUHlMG9VpENJ95JMt8+AT40TQ9umPNS5zyHDNO47YIzMQHWF
	WnxtF5o2ywTkfHw4R46Sq2eBtDCPVNirszO85Gvlbf3nz19/0CfGxq+nnYz1GYSSE8GbLSDD78d
	zemavBPbeinILSPoXDuNw4G6Yhb15OLwf1s/Qq+YwT4VWwNbB0oRda5W2ZJ0021ywvS/RvS/rkS
	wOqrWzv21P8bXLvNBJFRWO72uCLswGXgAbkH1pypeT/y20dqEDMXzaaluoLe48SVEWcMDsOGYM0
	ikI1NWoKk9f0xzRGf5udmOfKYl6B+dis66ndQJKIlpjWYtJWSwyN88AE1cQPW0PlaTdbH8NpFFn
	4dmbVviMa0BAnJ8I/aan8Eg0=
X-Received: by 2002:adf:fcce:0:b0:45e:df08:b18 with SMTP id ffacd0b85a97d-4603075ca65mr15338397f8f.32.1780907934354;
        Mon, 08 Jun 2026 01:38:54 -0700 (PDT)
X-Received: by 2002:adf:fcce:0:b0:45e:df08:b18 with SMTP id ffacd0b85a97d-4603075ca65mr15338352f8f.32.1780907933822;
        Mon, 08 Jun 2026 01:38:53 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3446aesm55104695f8f.24.2026.06.08.01.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:38:53 -0700 (PDT)
Date: Mon, 8 Jun 2026 04:38:46 -0400
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
Subject: [PATCH v10 23/37] mm: page_alloc: skip kernel_init_pages for
 FPI_ZEROED when safe
Message-ID: <7de6959a0fb1b255dc9bee2de494f51a6c21e468.1780906288.git.mst@redhat.com>
References: <cover.1780906288.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1780906288.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uNSCwKsjpdQl2-so4eWGlUpdyFzSLLiLAt7DyeyPr98_1780907934
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In __free_pages_prepare(), when FPI_ZEROED is set the page is already
known to be zero. We can skip kernel_init_pages() if page poisoning is
not enabled (because poison would overwrite the zeroes).

This avoids redundant zeroing work when freeing pages that are already
known to contain all zeros.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/page_alloc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 008f1a311c40..e3a7c40c769c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1443,7 +1443,14 @@ __always_inline bool __free_pages_prepare(struct page *page,
 		if (kasan_has_integrated_init())
 			init = false;
 	}
-	if (init)
+	/*
+	 * Skip redundant zeroing when the page is already known-zero
+	 * (FPI_ZEROED) and page poisoning did not overwrite it.
+	 * When page_poisoning is enabled, kernel_poison_pages above
+	 * wrote PAGE_POISON (0xAA), so we must re-zero.
+	 */
+	if (init && !((fpi_flags & FPI_ZEROED) &&
+		      !page_poisoning_enabled_static()))
 		kernel_init_pages(page, 1 << order);
 
 	/*
-- 
MST

