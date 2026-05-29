Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2006F3F86E7
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068335; cv=none; b=PUJ9ETPlhkUh/0P3UHu5lAyQ7PW4erQrd0a85rnKFL04SMQQM55+RM1rhmBt6KKhKHq4Ukd/LP2l1+5kLQ41QT/b5R2ti82jLLc9d0XnH9vwPAv4PdOY5EBmEEz6x70fL0Q8/oRlbQ2hH58IH+WRokbuftEVyJTLxxb4SXp+TBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068335; c=relaxed/simple;
	bh=Z+HYjvvqCchjYSSoU6qbOk9Gov2pfNet7tVjjUNszJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sDZLn3yoOZwQOI9+CurCk9PD+hn10LL1pF0mYh9tYDDfFS+lYbzd3N/cSWM3Hz/o5rW5ficBl4jGQ5v13tgeZbbTagbuBXIi1z2EgxKz5zx0zusqAB56Npt2aMNUnaO0uKlu07ly5E0GR+09FdQbAxud2GWFijNMIBObwRnrpfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BmMhnZBc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BmMhnZBc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780068333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PJ5vvVKjiUlKZvlIAO4D+aYwhndM/ly8HIEHblxR0ik=;
	b=BmMhnZBcbnZeooEGRJWEDpBFjKaMXv7WG4JWRasxcUPOAk18QDsLlWe6R2tUeIAG9UoCsw
	ZtaCNLgeCjYYOy9Px8hqoxQxR6g2xmzlydPcbeaSb0lddtVB+XeAgW8KxsmbSmJvYGaHln
	I4xMjB/ocJif38B9oTDJ9foErIGrHX4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-PXvt4MntOPuQzamN5dwtbw-1; Fri, 29 May 2026 11:25:31 -0400
X-MC-Unique: PXvt4MntOPuQzamN5dwtbw-1
X-Mimecast-MFC-AGG-ID: PXvt4MntOPuQzamN5dwtbw_1780068330
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4903dcb32f8so69904565e9.0
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068330; x=1780673130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJ5vvVKjiUlKZvlIAO4D+aYwhndM/ly8HIEHblxR0ik=;
        b=gZrbzWTKFQxjxoPwCjv1jpMM7Ib3rb6tQDbAvreUXygMZzUmAermuPvLMwNBwkm7Ef
         MWrruwieoeoFhzlUEyhxpFkAVy7hIHJ24RT0EZPgHBWUDmVw1gK7GqwZvN2+ksKk8yBG
         6oUINl5ObgaHSTXhuE85ht2i2UecJmbwBa9mHmjOuav8Uy+ZDwr95gmXatdAU/kFOyzF
         WyM5h4L1piwjJjo5xuaOn44Xj+SEQucxBT0Wwo8AfJpiJDZKiFksSyB03ltlJXkWrWYh
         QVmHotxDJyYYJEhJjmlL71rqYs6EEb7tczvV608A3czYBXPrp87L8NWZ2wOyEak3g/Lx
         ApHw==
X-Forwarded-Encrypted: i=1; AFNElJ8QRQmqujX5Z4ayBIvKVWQk+FJ4HK7nR6E0NkL3ljWYgjO9xiUqWGDZqgFxn3yqiZqgsC/OgHnySb+YjdZ85w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxuk9fyeeAYiub6TpDSdFqcUSmlxWYHA5HovBS72HQ559k3P8Ij
	Mr6/wphI3HqZ/iGFB1YmNy91ChTm8hNFW4Z/lHVe/3Ik3GIuLac5bERMWEcODwum6cMJNTuDuou
	Ey3vwYTrkEqJfyl4aZEubnMtPXUTkPTattkFnVEbywZBKWqMX+4FgC2fkBtit+rVpleuo
X-Gm-Gg: Acq92OGoC2DjSIdbxH17SKRCTI3bWJIUrZTKWFRcbgVL5s++tSUApP1qNPl0N63D0iU
	m1yPCFC2lryhCAS4AItvjg6tDeC0bQPm4fuOdpOaMV39spkBqcWqDS76ju1JqCqYLV+BjcdFmyz
	1qX1wtt+EbDmL20W5jnfbs39AvnAhZ6GOSSiZTn98fH766UInL3Xge7SIPxJWYlUUyYg0Qw4EB+
	l7LI4akbxAO3LNeOdxs3JXXazzn8q+tsr26abccPWBaUniqttZNICrFFnY1+9j5e7u1RPoH+g6u
	K5FekPaoM9tHRlJLrpBVJImI9dEZSu1FjnBNTOzCe/dK0OW3n1pU3icS2zPD+AL8LZUOZC3vO5H
	stjTyFgV4WZCqp5mBCcGY5DKnazNdfMy7lOurhtNMG5qzAkpRYsZBDA==
X-Received: by 2002:a05:600c:4f89:b0:490:4717:970f with SMTP id 5b1f17b1804b1-490a292ec27mr1653615e9.14.1780068330264;
        Fri, 29 May 2026 08:25:30 -0700 (PDT)
X-Received: by 2002:a05:600c:4f89:b0:490:4717:970f with SMTP id 5b1f17b1804b1-490a292ec27mr1652655e9.14.1780068329671;
        Fri, 29 May 2026 08:25:29 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d6a0a89sm62305115e9.7.2026.05.29.08.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:25:29 -0700 (PDT)
Date: Fri, 29 May 2026 11:25:24 -0400
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
Subject: [PATCH v9 36/37] mm: balloon: use put_page_zeroed for zeroed balloon
 pages
Message-ID: <c91973e21bf6f59e34a239324ae0b898525aeb9e.1780067978.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: Y2fxQYzmj4kMacBre6_9R4yal5OZlQInnsfLAswUmjQ_1780068330
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When a balloon page marked PageZeroed is freed during migration,
use put_page_zeroed() to propagate the zeroed hint to the buddy
allocator. Previously the hint was silently lost via plain put_page().

No page has PageZeroed set yet; the next patch
(VIRTIO_BALLOON_F_DEVICE_INIT_ON_INFLATE) will set it on
pages the host has zeroed during inflate.
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/balloon.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/balloon.c b/mm/balloon.c
index 96a8f1e20bc6..6c9dd8ab0c5d 100644
--- a/mm/balloon.c
+++ b/mm/balloon.c
@@ -324,7 +324,15 @@ static int balloon_page_migrate(struct page *newpage, struct page *page,
 	balloon_page_finalize(page);
 	spin_unlock_irqrestore(&balloon_pages_lock, flags);
 
-	put_page(page);
+	if (PageZeroed(page)) {
+		/* Atomic to serialize with memory_failure's
+		 * TestSetPageHWPoison; not under zone->lock here.
+		 */
+		ClearPageZeroed(page);
+		put_page_zeroed(page);
+	} else {
+		put_page(page);
+	}
 
 	return 0;
 }
-- 
MST

