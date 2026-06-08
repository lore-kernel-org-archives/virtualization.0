Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503553B19D1
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 08:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907694; cv=none; b=CxjmQteb02biO1norr1a71os9v3ZLmXeNKG2t7PI9R6mcWC1i+ph2iUH2pgAiRXNU+Q8a6Ke6scQg0qN1bbC1MFDrFVifNqM4AbdFdoVh8be6SgIIXsvxE4d5IVIf1jdUZK6DV89qEtEoELZYCnmbDimKo2hCQKXBw7itPjwwHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907694; c=relaxed/simple;
	bh=lgTFAAybKpw8Lv7QpTHpNFrj++hl60eW9AsRt64i/XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Jr1zyhI9b6xNajALE+/kkaTexFgbHEyQeYjYnCcdDGFRgRQyPicsvymG1UTzF/BF41a+ca65MYnQmWFTh+my3v69OWRy8V6tvFD1lbHkCpiAme5TGUwn9iQrmg83YeVMI6hEgc2GPpqp6ys5l6YYUVcSx295l5lst4ydovYd310=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WIHWQN/k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WIHWQN/k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780907686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NUdBC37dWtUhtr3poKTRLbvv+0k/F3lQxPVXzGOdb1o=;
	b=WIHWQN/kExgHpCnWb24i6Dsv3BwHmDUjzRu+SLlnCjWVQUyiC//NCl2MZKIJrtUaQDQtMh
	mZCIfrpm8JJdb5Be8oA3ntee1E3kCo/yPpNuZp5mxGuktmr0iXSX9cqcOLSzD8lOT16+YK
	mN7CkIxQMV6NVtZSVeaMIZ9xa7SH9Vc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-oiQ_o4yROJKZ_EKnq6KzKA-1; Mon, 08 Jun 2026 04:34:41 -0400
X-MC-Unique: oiQ_o4yROJKZ_EKnq6KzKA-1
X-Mimecast-MFC-AGG-ID: oiQ_o4yROJKZ_EKnq6KzKA_1780907680
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso32883945e9.2
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 01:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780907680; x=1781512480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NUdBC37dWtUhtr3poKTRLbvv+0k/F3lQxPVXzGOdb1o=;
        b=Wzm3G4OrKBmcWZU/IdS9nfUggWEIPpsYM6ehJfPsrssI1r6Dng/E3bwlNTS7fBJfkf
         /zaSHBt9phjwqsIaBfpE2w/P3xiOP0lpPhUtyoPtTQljtMXfVYq3OTsaAGR3cZE9tsXL
         M0LRCt/jFQRqMeMXLTGX7Kk5AsxUzcF8DBeZAt9Z6EP9acBmNAgAyd2kHT41/j1c9pSA
         02s2+ov4KErZ0BlBmFHTBsVDNUo63AYyfDSGzR5OGOyyzdVaG90bKdyPz5uIZhfKyx44
         ho5hzhKclfCFSqMU23j5T467MENHf+DtjG1NvxWWn5970a8j+35I1cWdbjysnSJ/Rg06
         WZFg==
X-Forwarded-Encrypted: i=1; AFNElJ/d40xJ5ZmtSSiM6XTw1csox45I25pTIeYZVrNzu1u0fcR8FCRy2fvJJrZucMDDgaUqVhnhFiHQuYC+8JMwAg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwY4Z9lcgREM8hcpwbQtQhtN+FdVpgPgszH3/TalwS/qFnexHw0
	3Ip0ftiqVdoMJtjdKjWVLzb40Tj5u8KAP0Pve6Jal1inw4YIbvEDJF5wcGnOaNk3pcePxAypV8U
	MiqlnlDrQEL3S5IqAg3YZ8sL3L6ntaU9GOdGHHSph7Qssz9uENUiBBzM2xPkaONeNcCwL
X-Gm-Gg: Acq92OHlmPKmcCnzUY5P/KMGdteWMpIOy6OYZslzZu6JOFfJe1wZhUCZUZl6+PdiptO
	EiyyiHLq2TL7h7IbyT1IkVxdTqc47aiFVQ1YiX0dOSRF3ljxXrGI/7pyVSDoipzAZLmTSkz+PNy
	yM/FAsny0gnyDxbN6+iX2U7a1gVybM/DipiActW7ZFdKVVXFtq/5cTo5v77yDNV0VNkacP2HFuy
	2GIV15r7d2e5BMvQ1TCSTOrxWIazmWGqVd+WDgRe/dIGzvLlkw1cOBUlTWq25w4foWyVVg9x7eA
	orOH+SSl7EURSGWonze8hV4+Dclg/rOAMhfGRCgHizRXXzgNQr6F6CScf7miXr3vUtau5rTdu0h
	5pTPxx17LGebCijkYyOLNIjU=
X-Received: by 2002:a05:600c:154d:b0:490:44eb:c1ec with SMTP id 5b1f17b1804b1-490c260f3cdmr236254745e9.27.1780907679616;
        Mon, 08 Jun 2026 01:34:39 -0700 (PDT)
X-Received: by 2002:a05:600c:154d:b0:490:44eb:c1ec with SMTP id 5b1f17b1804b1-490c260f3cdmr236253855e9.27.1780907679052;
        Mon, 08 Jun 2026 01:34:39 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3d6c65sm366951975e9.12.2026.06.08.01.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:34:38 -0700 (PDT)
Date: Mon, 8 Jun 2026 04:34:23 -0400
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
	Miaohe Lin <linmiaohe@huawei.com>
Subject: [PATCH v10 02/37] mm: memory-failure: serialize TestSetPageHWPoison
 with zone->lock
Message-ID: <df06b66fe4ff8e925ee0714955abc2183a727b90.1780906288.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: keh7IEppXlPDxibJ7LgwMQ1-Y6n-2I7ZoNeJtE4jLmE_1780907680
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

Fix by acquiring zone->lock around TestSetPageHWPoison and
around ClearPageHWPoison in the retry path.  This
serializes with all buddy flag manipulation.  The cost is
negligible: one lock/unlock in an extremely rare path
(hardware memory errors).

Note: SetPageHWPoison and TestClearPageHWPoison calls elsewhere
in this file operate on pages already removed from the buddy
allocator or on non-buddy pages (DAX, hugetlb), so they do not
need zone->lock protection.

Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/memory-failure.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index ee42d4361309..3880486028a1 100644
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
@@ -2390,7 +2392,11 @@ int memory_failure(unsigned long pfn, int flags)
 	if (hugetlb)
 		goto unlock_mutex;
 
+	/* Serialize with non-atomic buddy flag operations */
+	zone = page_zone(p);
+	spin_lock_irqsave(&zone->lock, mf_flags);
 	if (TestSetPageHWPoison(p)) {
+		spin_unlock_irqrestore(&zone->lock, mf_flags);
 		res = -EHWPOISON;
 		if (flags & MF_ACTION_REQUIRED)
 			res = kill_accessing_process(current, pfn, flags);
@@ -2399,6 +2405,7 @@ int memory_failure(unsigned long pfn, int flags)
 		action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
 		goto unlock_mutex;
 	}
+	spin_unlock_irqrestore(&zone->lock, mf_flags);
 
 	/*
 	 * We need/can do nothing about count=0 pages.
@@ -2420,7 +2427,10 @@ int memory_failure(unsigned long pfn, int flags)
 			} else {
 				/* We lost the race, try again */
 				if (retry) {
+					/* Serialize with non-atomic buddy flag operations */
+					spin_lock_irqsave(&zone->lock, mf_flags);
 					ClearPageHWPoison(p);
+					spin_unlock_irqrestore(&zone->lock, mf_flags);
 					retry = false;
 					goto try_again;
 				}
-- 
MST

