Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFB63CF660
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 09:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490188; cv=none; b=DXTFMnepoJ+Nhv1dA2ayOhMVWNfOI4k8IK+RgCjsZdo5xPCQdgbV04kVarOA0lRn0BWPaA0Qtuoc252gH/ucrvSB+o4uasGKRXJyQaqkOz1pC2kwqNcMX+ZEWtex+c33W18z++/CVEagf2Zcxc71vF6DS3WXDUhE0+mj/FldxBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490188; c=relaxed/simple;
	bh=tkchtNB3GzzFWMQ1E0X1DKUjhQK/O579SYT7H3vP5sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hQ5i4wi/rgYi+aveCjPLj8NdwoF1s7H2n7A04dqdoZ7+Ur5HilASmcpNE0V6LW2lm1Cz1tBrDhcbJAilIC5ZMns0zyxAxGcmYPQcO2h5NCxT+XXZkYqMv4I8x0s5XgxfoAVD8ush4FrJfqI71yzFKHb+xyFHcMJ206gzK35Ighg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KaAZZ3Pq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KaAZZ3Pq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778490185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=43zcPeyEBahcbXzXBePbjbHiq0vh8NFM/GDJyyFYelY=;
	b=KaAZZ3PqMTo1j3HCQZaZ3Kno2f4m4mDJTth2TpQK67wi9YFLvMddHFfgZmSnvzm2X52aOO
	ZDDRwj6hMGVMlE/EW1B8fS+mtprzRtlGYuKggLgzwhSQAC3NByNiRW2UsIF/al0Cvf4GV0
	8y0aKvUGaBJ77GEUPT8tgf2KlAYcrW4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-d96MQAgrOEKqtOThiE9Tkw-1; Mon, 11 May 2026 05:03:05 -0400
X-MC-Unique: d96MQAgrOEKqtOThiE9Tkw-1
X-Mimecast-MFC-AGG-ID: d96MQAgrOEKqtOThiE9Tkw_1778490184
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43efc93e4f6so2768490f8f.3
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 02:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778490184; x=1779094984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43zcPeyEBahcbXzXBePbjbHiq0vh8NFM/GDJyyFYelY=;
        b=B3kTxMTm5IoRfQCryW8sSoL/ZVCMh+mojuZAft+6LaXSjLBsCX4GPQo6hcOA1uL47j
         MX70u2/59S2WKTGt5uiwp/DKmM3pJyNf2s2aZRvy9XtBtGB1Q+lpQ/qaB81hOldBp4j+
         oGQ3pdSbdMqIe9FZgnYoI+Q0QXH5Mm8Y2Knt59Wixv/eBahjTO0yVzso0SV2eO+slHfW
         EcrjsVYhmGacLb52BlP1VrhS83di/sJ68JOgwnmpt0VzUe60aJU0kPg9lABah3Jnti0C
         310+a2UGPjz+tFQnIjza1cW2yR0NXhIff93MHLvjzRTlTZ0xgYJjNSnAITWl0rjmixcE
         1MgA==
X-Forwarded-Encrypted: i=1; AFNElJ+dqxNesW5LtEfSMtOxVD72cHp0iPGxzSwXm4mLvpXtc8hGkLaHDlOtJGnxC3yKMdS20aMnufFYKbkCKhUEZw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzye1+Dz5VrC32fA/ps6bc7nTWjqzxacn1DPiwcj3iY5hwW3uiP
	safYZ1V9fpjyOWUaSlB5oyfSVg4+EY8EWkDHPuGt+8Rr6I9dmt/1mVe1nKW+bBnqonvRxfkFvw3
	eap9BpQz9sybOQV2EX9WArzI7t03uUUX0TsAvnmDPecynWNT0YP8L1TkdPdihHsfE8jP4
X-Gm-Gg: Acq92OEMNX+gsSFU3gU/peaoJSig+UQR2D5rbmzvqXBHpGQapXTvy7yYK1H9zr/HpeW
	9dJ42iygOmhreS03DsOFiG0mTbZlcrqCiXciPAcqHWfj/T6Un9bluIe99zvZyFG8M6Wmsd/zbab
	Byz5v2erNjcVizJLfSHHRcwXcTmlnd1g0nU8Ep+2CT05IC11hepgSoSyAvPuqWihaFSFHLLJdNt
	T7c4BPVBASnrw5D+RZ+/QsfleiDKTLmQeXx201McV8uRLDB0n3zfv/3f382wgkXq84jquWRdlUf
	x1OZzFLZx8PT1oHM9PJuoVrN1rKc/1OxnO8dUUIxfGTDMRtIHmjtAyVx96jj5G1glMUNzXrc0h6
	tn1B/NpliloG7Lu2Pso678VIg/Ue/DBcx1NTSGLJ1KMAKqYyzd00=
X-Received: by 2002:a05:600c:8010:b0:48a:5339:ef0e with SMTP id 5b1f17b1804b1-48e70687eabmr138059495e9.3.1778490183414;
        Mon, 11 May 2026 02:03:03 -0700 (PDT)
X-Received: by 2002:a05:600c:8010:b0:48a:5339:ef0e with SMTP id 5b1f17b1804b1-48e70687eabmr138058895e9.3.1778490182719;
        Mon, 11 May 2026 02:03:02 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a6470sm20880966f8f.7.2026.05.11.02.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:03:02 -0700 (PDT)
Date: Mon, 11 May 2026 05:02:57 -0400
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
Subject: [PATCH resend v6 13/30] mm: use __GFP_ZERO in
 vma_alloc_anon_folio_pmd
Message-ID: <c8768c7c2a4965b5e2dd78680c936b82606cc034.1778489843.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: eeM_yw6riHC2NaZBpEuyr9_eCljzjB6-taArZFtx6JU_1778490184
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert vma_alloc_anon_folio_pmd() to pass __GFP_ZERO instead of
zeroing at the callsite. post_alloc_hook uses the fault address
passed through vma_alloc_folio for cache-friendly zeroing.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/huge_memory.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d689e6491ddb..9845c920c29c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1333,7 +1333,7 @@ EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
 static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
 		unsigned long addr)
 {
-	gfp_t gfp = vma_thp_gfp_mask(vma);
+	gfp_t gfp = vma_thp_gfp_mask(vma) | __GFP_ZERO;
 	const int order = HPAGE_PMD_ORDER;
 	struct folio *folio;
 
@@ -1356,14 +1356,6 @@ static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
 	}
 	folio_throttle_swaprate(folio, gfp);
 
-       /*
-	* When a folio is not zeroed during allocation (__GFP_ZERO not used)
-	* or user folios require special handling, folio_zero_user() is used to
-	* make sure that the page corresponding to the faulting address will be
-	* hot in the cache after zeroing.
-	*/
-	if (user_alloc_needs_zeroing())
-		folio_zero_user(folio, addr);
 	/*
 	 * The memory barrier inside __folio_mark_uptodate makes sure that
 	 * folio_zero_user writes become visible before the set_pmd_at()
-- 
MST

