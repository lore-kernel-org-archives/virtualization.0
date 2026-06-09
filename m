Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF9D3EFD36
	for <virtualization@lists.linux.dev>; Tue,  9 Jun 2026 10:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999982; cv=none; b=cU8Hn2nyp17LeafLB1sqMSBPZPmTuJyzsmyJYqwT2wYLBveTNl6xWYpWgXVEfbl52ka58iq34k3zPqTqjFxePMjYtCwkzTfq+Zp7sABSgBDrypfw0xpC9UxQyAW2E3m/T1Jjx5GP/xBJ4nSpg4dSCZp2dHtQkwN0cqumDXB8WwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999982; c=relaxed/simple;
	bh=j2WAVOhcptz6OyUHo47zZkLVi+TN8pUJ+4T2CAdtlag=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GYqicWV2dytjtThNqAuWQhsXq9wRSG5AZlrbGp5NMuHvwaSGwXK2rA3Mje7bn76kBtvP/vIbwfXPupTurPWbHeYfD2Cskcb3YMqYK6+4ZhjdsWlr2rUttE5y0EwAwHEnambP56FO8T2XwDVceoKYY/ri5e76TbxAUxM/VmcFP8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DfI3YrE2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DfI3YrE2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780999980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=eG5xXsnRbSzhdk92bHjLO+lAL03tD8JhyLJB5wX13vg=;
	b=DfI3YrE2xijM+LjTTuRnS0v4onpTBjVp09fDkpeIsxwaaVDGj6sKpgKyuXF/BHYW6YkHIq
	MkyPi7gO068mxk5z1kzk8KVllWDfVQyHXmFCzQD7CyHkgar63rFU1Uv3Xum5a3D6hbPZwY
	yFYXhjtk3+SQ6Hutig2mW0VsDhsrisE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-6tFQfqbAMs23zZ8zXBNo6g-1; Tue, 09 Jun 2026 06:12:56 -0400
X-MC-Unique: 6tFQfqbAMs23zZ8zXBNo6g-1
X-Mimecast-MFC-AGG-ID: 6tFQfqbAMs23zZ8zXBNo6g_1780999975
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490bfd70b0fso54618235e9.0
        for <virtualization@lists.linux.dev>; Tue, 09 Jun 2026 03:12:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780999975; x=1781604775;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eG5xXsnRbSzhdk92bHjLO+lAL03tD8JhyLJB5wX13vg=;
        b=FUuR5QXDgOuw8Ii7BerEOmmUga54Lt+bxsG+rjQe56+wAItdUbiwEi/GTxzjlF2Bw6
         eGHT47cFfxascbNllnABp0cpfzG/OUPv4e7WnsWLxSqCJLTLtujI+tMHTp3ejPHHIwpr
         584IfkylngXgOjdahmJSkhwY0OBhylIp/35nJSVVJ1RZfSw/vim5fCSY2h7nBiJEgbNz
         ekVSqC3VeSghnwo9Tp+nA51gO72cwgP6qIDP7nvLwCY/pLiMvkslLVw3GvsImhDpgrX9
         heEihygTNrOcBDi3r2tRHFgziViR9y5TT0nZmGZn4WwjtSocwoabvZzILOFk6i8MgPP7
         LcFg==
X-Forwarded-Encrypted: i=1; AFNElJ/BF6ekA8y8AzQuS2Dvuo95d7j6KmaRSnlwCvbCj6uuh6+fSjq8uoXpUHKEzESHva+XYzYinym8zS27vqC8jw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBPQ3Ilz516WciLdnFFVfzoMWJxOUZsA7xW8FHPOFcNQngki7V
	6QjGspTxXqWElDHtFu4Gxg+KNtu9nmYx8ND2Wbt06BR/Ll3GakTdq3C23e+Mkazr8B+Jcmlbvot
	qCtQizGvh+M4114sEK+R1zSc16IQxY0ngvoHQJ/FSJOzjVB4/Mi/24y5l6DFx940e81DP
X-Gm-Gg: Acq92OGRm+aJFtX8/TnobbAHDqX9XE0kAjWRPB31S6kDedKlWd6pqkceZwpcEZ85P+E
	2IAUfG0IPVksOAGI8Y0YJp6ckh3SbfmOzuKCxOOushy8jD/TbMsCE2kepi1fNiMAj+Zkj3z5HTy
	maWpMDQEv49F7akq7MxHMUa0hBxQlnOpC15YNCnYFvHX1r2jna62DXWOPf3crTHncARGN/iHX+C
	r97vAi1R/CU7k58s26Gn2t+5ER0ov32VDlqwQBXloCUfUsfuMPPMJ7w62JZ0Y1lDajVlZ2VEi3s
	DAy27ORJT9twV1jL8+PlLCq2wKQFP3rTmiGyVPrayZ0rgPaCsDNVcrDFdj3pGNLJhePY7HCwIEj
	s/7/d83tRrp/eJzaMtILAi3qyHF9jpKb6ml3At0Wgfi9QhgQ7PALyng==
X-Received: by 2002:a05:600c:3107:b0:490:9588:bdb6 with SMTP id 5b1f17b1804b1-490c264cc2emr328880135e9.33.1780999975317;
        Tue, 09 Jun 2026 03:12:55 -0700 (PDT)
X-Received: by 2002:a05:600c:3107:b0:490:9588:bdb6 with SMTP id 5b1f17b1804b1-490c264cc2emr328879275e9.33.1780999974756;
        Tue, 09 Jun 2026 03:12:54 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c15cesm460773715e9.5.2026.06.09.03.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:12:54 -0700 (PDT)
Date: Tue, 9 Jun 2026 06:12:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Miaohe Lin <linmiaohe@huawei.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
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
	Naoya Horiguchi <nao.horiguchi@gmail.com>
Subject: [PATCH splitout] mm: memory-failure: serialize TestSetPageHWPoison
 with zone->lock
Message-ID: <df06b66fe4ff8e925ee0714955abc2183a727b90.1780998980.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: q781gvg9NAVQ-g4Cx2ZahR1RfL6A3Nqj6pN8DGnEFQ0_1780999975
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
is set and the write happens after.  Will only get worse if/when
we add more non-atomic flag operations.

Fix by acquiring zone->lock around TestSetPageHWPoison and
around ClearPageHWPoison in the retry path.  This
serializes with all buddy flag manipulation.  The cost is
negligible: one lock/unlock in an extremely rare path
(hardware memory errors).

Note: SetPageHWPoison and TestClearPageHWPoison calls elsewhere
in this file operate on pages already removed from the buddy
allocator or on non-buddy pages (DAX, hugetlb), so they do not
need zone->lock protection.

Fixes: 6a46079cf57a ("HWPOISON: The high level memory error handler in the VM v7")
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---

Sending separately as suggested by multiple people. I also added
a Fixes tag.


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

