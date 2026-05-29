Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845B6367F36
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068141; cv=none; b=YcjnxjL9dXg6i/Qosb3ShvZIoc99N8/t/kxEzc8GUE9Xf3bp6My0dJag3ZAiwjuMOTmmdC+5zMCxhNsnhOkjxfhfgs0waDU/wZWoZ2Njg9zJECfigwglYJXEjk7TuOuQxKZxN7NrRVxKwTF6GvEag73Gr5gQ3yCtNMonfOvTpao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068141; c=relaxed/simple;
	bh=B9hCuvGWJTakJ4KIERi0AyOg+0/ybGKp5cfFr2jdtWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uDoo/BnWbaGX8a8OGJDAvZRmUYc4RXpHH3TpXVfiGVniEjeVDjYIO+6uFLJRnhVBwR9O/uaMbCCAJlcA0ggvEFOaBLS9kI7j+ZlJg2dfEslM35wnI4GATsRM6Xijl8vCjDjOsegrvnnAroOOOvcQTsFw64BfVGYlTjRuac821wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H9olcQq8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9olcQq8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780068139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=apkJ3vhwafShLYfDd+RnV0F+C4AxcxVXpW06K2eXGn8=;
	b=H9olcQq8GwknshUs0w5jZqcG6v8WeskuNJn2exfiI6ep0ps3cn9Hxftv/Yo0cqiTayajIC
	UsUeGloOYYhsRsqt0Cz5CwbIGExiX8qS+3a0ZByHXvQ+bxDwEVMLf5knUXoah4AgC3P+0S
	7lfJB6x6gRoUOafidMqsjX7ZmHnIA2s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-uknw5_d3Oc-A36-sceliuQ-1; Fri, 29 May 2026 11:22:18 -0400
X-MC-Unique: uknw5_d3Oc-A36-sceliuQ-1
X-Mimecast-MFC-AGG-ID: uknw5_d3Oc-A36-sceliuQ_1780068137
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45eef10d5ebso681211f8f.0
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068137; x=1780672937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=apkJ3vhwafShLYfDd+RnV0F+C4AxcxVXpW06K2eXGn8=;
        b=app2xfMO4Wp46QybHRgEudzdm6vJuOzG5l6GgH/aAVaRJCMCuDakLokpDrd+wHpw6m
         /adDcBr09+UxmwaXcoj3vztJA1HWdtYxHaLyRku4smRo+ErxXadgoYxn5aREcvMWUHaQ
         uHnbc4fo93pR6XP8hG6swlkRs8tFH/vVA5yMjXmzD22j/T8J7inQYBIHvpLOvjw55vuD
         XPuokvJFs5EImY/IS8B9OYQJcOfcikrG/IGzdrUCj+S9ngt7kU0I+dq1kdqHtdlLBf2a
         07y/YC5QMWXU6/kpUfffMIpzzecdqo+u8LzHxjWdSEeQmlHU8lChPONalx3J0x3dbjVH
         2qqQ==
X-Forwarded-Encrypted: i=1; AFNElJ8MjFhtIH+gBxr3kaSW8cC4zROjj8SvkUEgg2y6KD/iFmXnBr+a7Kh7Ho1FJIeOf6puEi1IM7AJ6nLw9VNCVg==@lists.linux.dev
X-Gm-Message-State: AOJu0YydiTQ7n1RvcHsWsxILo46z6H37YUKy1Q9trooo4wfsIWLkm/ia
	y50uq/Vv3goo75sh8sMYRJT7Q2NFickmlm8VMrrMB1W+Rdo6lzBa3/Kbn+6bRy5EFYdaEM1QSIS
	SbNtt6GL0qjrw3Ns3x2Y5k8pedRdF1i5VpO+J2Ilmlm5RBRAF4UEbfmzi2L4JZ+7P2KIn
X-Gm-Gg: Acq92OHMsQSapKZdyByDPGVWlNLVfmKyWmXABVC+4IabbgmLKI3x0bCmpmp7u1oldiU
	aG69r2xYLNLl0sbJCP9o5k0nDomvdYTJK3xlxwzNkJrwOEH1+VPYEKJwUyu1CexqRi8hiAzAYBx
	9btf4hjneHkrfJvaudTOs2eXQb2Vn/FwaOzcdh1G76mpOusw3Oax+DpEwNBcnO7d/7r1hyDtKLo
	Cd//f7rzjtwjihboIY7GiTo/inz/lXTsov19e3kdenhmAkLX7rcBihK5kbLu9zQZKy49oBbqQRU
	RHzMnhUvNRA2Jbphzvr5orFLEoSC1tpGWhT4yiR0umzqMoGOlAWXyReUPuC/KXFVI/JxPd5BgN8
	TVSBYWw9hju7P+Z1pEU0sZ4eUZ1JlcpvyNi8iu9izcXFqkwdXdeqmsA==
X-Received: by 2002:adf:e684:0:b0:45e:f31a:7ae6 with SMTP id ffacd0b85a97d-45ef6b8aadbmr345882f8f.30.1780068136675;
        Fri, 29 May 2026 08:22:16 -0700 (PDT)
X-Received: by 2002:adf:e684:0:b0:45e:f31a:7ae6 with SMTP id ffacd0b85a97d-45ef6b8aadbmr345803f8f.30.1780068136163;
        Fri, 29 May 2026 08:22:16 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34b7d6bsm4708531f8f.10.2026.05.29.08.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:22:15 -0700 (PDT)
Date: Fri, 29 May 2026 11:22:11 -0400
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
Subject: [PATCH v9 02/37] mm: memory-failure: serialize TestSetPageHWPoison
 with zone->lock
Message-ID: <2c527d20c99cdfe64a77bcf8da75f742d4c6991e.1780067977.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: faFqI8AHYXLOgMSAPoF4-NgokhWMk3mnatiGPkTfPYk_1780068137
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

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/memory-failure.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index ee42d4361309..d106f2c135c7 100644
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
@@ -2420,7 +2426,9 @@ int memory_failure(unsigned long pfn, int flags)
 			} else {
 				/* We lost the race, try again */
 				if (retry) {
+					spin_lock_irqsave(&zone->lock, mf_flags);
 					ClearPageHWPoison(p);
+					spin_unlock_irqrestore(&zone->lock, mf_flags);
 					retry = false;
 					goto try_again;
 				}
-- 
MST

