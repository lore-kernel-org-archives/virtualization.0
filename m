Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B53B3BFE2F
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315628; cv=none; b=kev9nR3ueqm+U+KgfXVFWaw/OV5mmuVNiL53Q4E+pjFOkCw/AT7nEvHch0RLF3zK25WT84EGEzV8/VKHaoitOir+j3udtA50Z+BNznZqkMrbO8mXL3fiRU5QNNh6REBYj82W2BCIpjt+GuKbNNIjwmM4rkZg93K2jQcj4XEH8uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315628; c=relaxed/simple;
	bh=BFG0o0OJVbxM+Mfp5F1a0Qegi36i+qWUB4aV2HzNESs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OtSgkN8Eqx15Qyme25kIMFw6yn//oy9wf6G+stZq4D6+0kvmxwtJ/ti+2dmtanzoEN3GOf0pKe1VLKCT/34XsPMUcf9WmIqGmV/M+MSrcka5VEZZFoVWFyKQ0kuUPkEabBbjYHNpI+bjfGkLBrUNV8etns6sP7lmdSSN/ghB4PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iNV7drXH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iNV7drXH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779315626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eAu/RRdfYrA/U3um2PuIXBOQM7QYu96dWR4U/hhBwhM=;
	b=iNV7drXHLnEhmTBIW1QD730Ep3o9ZKkk7Gb8DQ/fbH/XB6soBuxegJuQOjgtoq34sJ7uum
	FwcrpkNbpGS7C9fN65bpp7PMLH7BWuCpY/MF6JSyz5GMRe6YYgDQhG98JX9xbMON1rm/d9
	dDJlqQJMHFsOlrWXVu1lnRCBMqrdbHk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-bUY4vd7dOnuB_W1J6-uY9w-1; Wed, 20 May 2026 18:20:24 -0400
X-MC-Unique: bUY4vd7dOnuB_W1J6-uY9w-1
X-Mimecast-MFC-AGG-ID: bUY4vd7dOnuB_W1J6-uY9w_1779315624
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48a589c7879so41300945e9.1
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 15:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779315623; x=1779920423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eAu/RRdfYrA/U3um2PuIXBOQM7QYu96dWR4U/hhBwhM=;
        b=ksHeEGIWzxoWOCsO0R1xgQljseSMZngrcBDhX7s0qpyk8k0Z2oAHGgQ2Bu1fEjBarR
         TcE63Je3SRQ/A9HwYeIWWNnIkj/89WJGkhvI9mvxfXLel/wG4svJbbvX2OCEnu6ovnd7
         LiFcEkyMoXSvktbpT+3xE3jxzMSc4iOi49cwBzoUUGEp7ZKX2r65BIVaARPj8kLPHt+j
         jjyq8vkzyo7EaagvkBd1JLuZR3XBesgwCZk9yj3MpMFevu43ACKFLhZJ09L5j1Mu/knW
         kh8Z+9SSPKnR+uUtsIk9myg2gayV3caZ00PtSthpGdAqiYBz7jR/xjauhLBWvUDXvA+6
         B6gg==
X-Forwarded-Encrypted: i=1; AFNElJ9uXl9Erp2pjVRoD1ECSIHNsk606E2b691C+Mm4wpSOe2z8+EEVGXtozdnXkNnaCH5Ct668DSs1ZpJn3Nj4sw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZt6WrwHI1VMqnxc71ADjyrgBOZO0fjQ69ApRdWhFNTGhvBDxh
	pLn1TFQZMb8L8oKfF3dT11B6vyIjuicwzNXyRCgw6wFENlQSbmDxuUaPBV62ry+FstT67vU4kFI
	GwT2uplJVbxcFD+evz3ZsS//EQBEa1hmgeuR6Qkbiw5ZY8YZglMlUjtCDIRU0iFJYV+fi
X-Gm-Gg: Acq92OHRWHMFDmGGfxewPIUtjt4jOnv9jDuWRS0VhjE5wFP0BddWGwkQKRaQYBruCr7
	ekHVAv9r5FnUyA0r/xaRLm7UPVpHLzBtan7kKL4zFnoVJ3ia+0fw7wh3OTTJipYG6Qw1TAZffDh
	8AWRVHP7BnU2nAUZVIJDKHnexW7jIOBluoUdJwXjZDZQ0qZb16o5Fyza53gJ1IovM77IlhxCJmM
	8FIiicu8KwyfhFr8BgojKDVMf++K0cfWjCMELWMjhJlAky/i6EcI/AZZgyIfvf9VABLAQIs4XOB
	VkWXtVamzjS8gHX2OuuubAgOzwh2niVXYveJh/uMCkDVACxUH0NWgwwyn1OIYaixus5ubDNiKW0
	xQNVbsCOrsNZSbM6dglFyQJHnGPRCM5sfhQN0W8Sx8/dionG5TDapfQ==
X-Received: by 2002:a05:600c:3b1f:b0:490:f7c:b19 with SMTP id 5b1f17b1804b1-49035fcbd6bmr2495145e9.0.1779315623522;
        Wed, 20 May 2026 15:20:23 -0700 (PDT)
X-Received: by 2002:a05:600c:3b1f:b0:490:f7c:b19 with SMTP id 5b1f17b1804b1-49035fcbd6bmr2494745e9.0.1779315622997;
        Wed, 20 May 2026 15:20:22 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49033d9edcbsm24375095e9.13.2026.05.20.15.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:20:22 -0700 (PDT)
Date: Wed, 20 May 2026 18:20:18 -0400
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
	Andrea Arcangeli <aarcange@redhat.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>
Subject: [PATCH v8 02/37] mm: memory-failure: serialize TestSetPageHWPoison
 with zone->lock
Message-ID: <2140873c1955d1ddde7b20dc86313215dbbc4645.1779315441.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: ICAFs4OCiu9bA6HBVDZliUgGUYhtdNyYf-cbDIh9aCQ_1779315624
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

TestSetPageHWPoison() is called without zone->lock, so its atomic
update to page->flags can race with non-atomic flag operations
that run under zone->lock in the buddy allocator.

In particular, __free_pages_prepare() does:

    page->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;

This non-atomic read-modify-write, while correctly excluding
__PG_HWPOISON from the mask, can still lose a concurrent
TestSetPageHWPoison if the read happens before the poison bit
is set and the write happens after.  Follow-up patches in this
series add similar non-atomic flag operations as well.

Fix by acquiring zone->lock around TestSetPageHWPoison.  This
serializes with all buddy flag manipulation.  The cost is
negligible: one lock/unlock in an extremely rare path
(hardware memory errors).

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/memory-failure.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index ee42d4361309..a6b61172dd13 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2348,6 +2348,8 @@ int memory_failure(unsigned long pfn, int flags)
 	unsigned long page_flags;
 	bool retry = true;
 	int hugetlb = 0;
+	struct zone *zone;
+	unsigned long mf_flags;
 
 	if (!sysctl_memory_failure_recovery)
 		panic("Memory failure on page %lx", pfn);
@@ -2390,7 +2392,10 @@ int memory_failure(unsigned long pfn, int flags)
 	if (hugetlb)
 		goto unlock_mutex;
 
+	zone = page_zone(p);
+	spin_lock_irqsave(&zone->lock, mf_flags);
 	if (TestSetPageHWPoison(p)) {
+		spin_unlock_irqrestore(&zone->lock, mf_flags);
 		res = -EHWPOISON;
 		if (flags & MF_ACTION_REQUIRED)
 			res = kill_accessing_process(current, pfn, flags);
@@ -2399,6 +2404,7 @@ int memory_failure(unsigned long pfn, int flags)
 		action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
 		goto unlock_mutex;
 	}
+	spin_unlock_irqrestore(&zone->lock, mf_flags);
 
 	/*
 	 * We need/can do nothing about count=0 pages.
-- 
MST

