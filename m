Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99293D1A97
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068242; cv=none; b=XMIez+3uMPYB44MW0cxQuasqiay/Rcf2YWSfbc2k23fu2tPZsa0+ZGDwsdWaaj3p0iWuxemoePLgwaa4qo1pDazFhIXnxPLLj4oTUONCNK4vaXExxrre4cpSVNfOZmT8jaZVafXYqlSpQY7etM5o7tp95YqBrCNtGrAvLCRcaRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068242; c=relaxed/simple;
	bh=3uGUVJNy6kGsME3V8gAHY8oH+alSOzgrnDm2DGDTDks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ETInecYjl+NrmH+1ZAWIbZ1kKzNFrXuSTrgYbA5hZeEx+EyDUSvoVf/zk6t5Vzjw+odVQ5jxTtZN8eAoDZlEfJLh4aebLmIcK42Bag1xSJWHa8MsNCqBrVckjdU/uXYxlrJx+vXBzXvJcA0CtwZfAFgNmL5MB7wMowB6BvPSI5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xkp2QP5K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xkp2QP5K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780068239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yH/Aq3jRD/J0BW4aKC2BcM/dVQFsNlzLQi2tKUktXO0=;
	b=Xkp2QP5KeOpHtud5b+LDenRU83+GFkeIIIFxHGdPJEu0rKNoWcspth1hNEhi+FbamZkr1v
	dJsqJyh2FFiyu5Bcrw6OacGrP6yFuek07rYPBu8LVBq109MKuWEV0hq/0P4bivuubO0JGP
	GICumbVC/a5UAPXTDOlM/UNSGfphvDo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-0An_tDjNNIaubXHQpE3TTQ-1; Fri, 29 May 2026 11:23:57 -0400
X-MC-Unique: 0An_tDjNNIaubXHQpE3TTQ-1
X-Mimecast-MFC-AGG-ID: 0An_tDjNNIaubXHQpE3TTQ_1780068237
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4904ee02e72so60967825e9.1
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068236; x=1780673036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yH/Aq3jRD/J0BW4aKC2BcM/dVQFsNlzLQi2tKUktXO0=;
        b=cDnssd8ypK8cfd/SfpxNiH2sDgq0V6tFMucClYJ+NTYPNi8qcQKcFcZFSRPeqZHpX6
         6vmEJykrJHPndWk3lYPgz24dl3cmI9TMTGGpA4M/m3Opfldxj8H5JlIbmoQrZpPw5dKQ
         pqVUgfpNaeyQ05Ls+mI9UCUpZFSue9MtuEwNmKsYEmCoxnYTbP/SmgxyczE9AKvAV7FY
         xrQSft3SOTIfjbi7z4XYlg49rzG3cuAVgvfWc2Fk+QIovfr3TlFXCuNL90mqmNX2/QYc
         Po8m/aYejs9QxQHME73s/3C6jKoPMoVK/C1lLD+yikl4TbHAiVcVSk0DuwQI2lFml39J
         oA0A==
X-Forwarded-Encrypted: i=1; AFNElJ/QLtAg6tcm3ApbkXj12q1IKJCN7vqRnk1xkH41ANrsaaVEwrCF6N8idUU0h2JDaAcwwKYENO/7d1xCjiYv8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxo6LzVAfox7duyjQNyMcxXGxBMfpvmXVYpHKCGHqezPzM4+t7Z
	mHoHuMAC8rDVgmdQPBPwXy7pVY0dH8qssZfdXizu+R8w2uMzylb0epj7zns6z9r6MWDfgFxKoJe
	wQ+q6xsvhRSJlR81WJs/EEYNCCfG2cb+srSiFdhDg7iLwdDPvuUXYUu9VdGnNOmplDq/o
X-Gm-Gg: Acq92OFCUeAFRpIlxKNyQCEb36v3dc4cpNAbsDK5jhHUehxcVpJA+5RgJQ03LjDqyoV
	8694hqUVGTufRTo2kOqJ6z8T9pDJfIJvCWHvTays/8krdfvwOl0QKCtwXqebQ6mw9SkB64UzEF9
	nd2gqU0tfVL3Pb9jGvfRrnqzzuV6TGAuegkVGDAf1ciJNn7gcb71dICSVFDjA4oIxghTelotPCB
	dKEyPNGIjvJY7a13BUjMqWHzPEYyj0QcbXmg//FRhFJLjH/vyN0iSxqF2ggkuu+N6uOGNdBbeA6
	PBi2uAYS4C44NCpUgAXJwV/sVRRP9qVyDGWh7ri8z+jBJkcMr5Zcz/Zed925e3C+uPXeF43YXTs
	gHhX1j9Jhapqf5aXaV8r/ROvLYh4=
X-Received: by 2002:a05:600d:6413:20b0:490:890a:da46 with SMTP id 5b1f17b1804b1-490a292a4b7mr1450325e9.2.1780068236395;
        Fri, 29 May 2026 08:23:56 -0700 (PDT)
X-Received: by 2002:a05:600d:6413:20b0:490:890a:da46 with SMTP id 5b1f17b1804b1-490a292a4b7mr1449715e9.2.1780068235845;
        Fri, 29 May 2026 08:23:55 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:151d:1200:7829:d653:3902:e833])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef356a4c4sm4498359f8f.31.2026.05.29.08.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:23:55 -0700 (PDT)
Date: Fri, 29 May 2026 11:23:35 -0400
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
Subject: [PATCH v9 18/37] mm: vma_alloc_anon_folio_pmd: pass raw fault
 address to vma_alloc_folio
Message-ID: <a544c8f1fb6704bfd3d7ea40c2b6b589fa288284.1780067977.git.mst@redhat.com>
References: <cover.1780067977.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1780067977.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: woKmWwUmuk6p6Ubf-tCWAXHsDrg-jDvpQVgz5N_ZM54_1780068237
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Now that vma_alloc_folio aligns the address internally, drop the
redundant HPAGE_PMD_MASK alignment at the callsite.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Reviewed-by: Gregory Price <gourry@gourry.net>
---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 970e077019b7..d689e6491ddb 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1337,7 +1337,7 @@ static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
 	const int order = HPAGE_PMD_ORDER;
 	struct folio *folio;
 
-	folio = vma_alloc_folio(gfp, order, vma, addr & HPAGE_PMD_MASK);
+	folio = vma_alloc_folio(gfp, order, vma, addr);
 
 	if (unlikely(!folio)) {
 		count_vm_event(THP_FAULT_FALLBACK);
-- 
MST

