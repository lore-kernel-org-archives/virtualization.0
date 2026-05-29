Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240AF42EEBB
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068304; cv=none; b=i9n9Uydms2uktFrd1w+7Ej40xAf3zeVHTVYFifHD3ZYCWzTuWeCtENMLB9P8cAZ3I8+AYX/uRJ6ZIyfzhczsUuqa/DCx0/rk4od3OumY1LKqogmEXO9HoaNNSdyzDEAJazD/adFQ0xlOQswivLY0FiFQwLqUB9TtcSzIlgeXRMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068304; c=relaxed/simple;
	bh=gX3aTYbHX/GyGonutM5PlW3FkeXMFkBsDPOEXbSa+qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jEApuyE+0HpOjyqFpEq5r5egkqXzmFMpLGm2+FzDk2UpmJO+RZN7RleQmpQxmB7rs2gzzWfoIarDNawZvmxpPUlyxb81UOS9SUrWE1PBHRh9ycvbMplFA871NOLOyea7v0ZzAFV4gwtDU/KsmK82GbG0YSeQ90z8lIZ2eBdpmms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BFKURluI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BFKURluI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780068302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yuucL8pRyKGlavgC043yPLfH9MArN/0/T/V0zfd6qpo=;
	b=BFKURluIe3y2KQWW3uCqt6yCGENYSjLGSk1Js0e9M03MnSzsdbZQwWrls90NV6jW2cFV/p
	nZLDE7w+1gYs6Gp4Mp1O5tKJ4566MegCT9eO1OK0A8c1AWw9QUWpd/8NsJyOv24siyB7QI
	KDrIOG9RwGicf5Tp0UyyUr6c6DDbA6Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-GYeE8ptdOL28g-fDPJ0_-A-1; Fri, 29 May 2026 11:25:00 -0400
X-MC-Unique: GYeE8ptdOL28g-fDPJ0_-A-1
X-Mimecast-MFC-AGG-ID: GYeE8ptdOL28g-fDPJ0_-A_1780068300
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49045f93baeso55197915e9.1
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068299; x=1780673099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuucL8pRyKGlavgC043yPLfH9MArN/0/T/V0zfd6qpo=;
        b=gUO5ZgbIZWS8zbIp8vg63TBAjea0y2hQAWftj9ktUD//nlgJeVsSnN7TdIREyDlDqp
         mdgiRI+b8Z7tKtIHsCUxa8w93gsoxpv5H+pbz3jKf5iXRlqop0tkhS7zgpTQNsCJ2rRN
         FvboRHm0gCmCEafZ1H4YzRZOQO+kIvljQQWPvIQqCjwgF4X2PNbNf3bBWkiLGwp8HwI2
         7jMFGBY9ZMYqSfPoVM0F0/YQc/Saogcw1qiuUanIHPaRI8IxVxmmpugWOPQ8AvXHAEC7
         Yequ++aQ9ISMvqq5sKeJWzD4JqxKQCc7H872BV9h6+nGsp01jiV0S+AjlXLQ/vKD57N6
         LA6A==
X-Forwarded-Encrypted: i=1; AFNElJ9cxTzeR4dXHR0chmKJmEsWxsi+OdDLhtFRuxQWvhaYIJ2bpw2Bf8TkjXvj4JOnHWiLk9NiNSrvM1rriDxFrg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxeMWImGZBqQ0xWj0E3nrA1yHLAYP/77+6KldBIHfNBHxNqTB5D
	wlQrSjRY31SaJgtd9Qi8SxRdoCqmVCUgM3FYCAtYD3G7IMqSbVaWJIN7GgMYUWJRRN8lSUHRG8u
	fADli1Qtdl8V5nkJDsAFBFfxuQBWB2irKzW3L6aOcCilotE6WROLcDBUHwBw6vKOdOECj
X-Gm-Gg: Acq92OHb7k3PT4UaIByxd2oDNKZpioUMmTbLcXf4DNprjXWIHymys57G9K9cEA1K1o2
	nQYH+AJieXR7sFCJuswK6vioGc+5/mKIMzUkIMssiMu3S7fgmRPjEoAjr6G6qta9/kwpcPIoxAz
	2l9h02M7NC4ajIeBTVTWbxaZtmVLR7x45xzI0KZvUk0g7GC+FQUDeTYbQyTq6v58x7RjuxlC0k9
	oJNKDDEznTlg4fXOhfHGaAuChG3tE76yfmkHGc+dasfPs1cKiNhu132XaCe8zO1ksF4jVs04IhB
	Yd6+X+mPuA77DBevqnF5NcAY4/k2KGNXVchMKqWkYrmcDCf7fkQKX3Ms2+mYh6Zeuz0nmVuadpB
	svmeSwubXNKW8MhqAwhMMxySwJq0GFRha705Cotz1n2IutWZKqyjNJg==
X-Received: by 2002:a05:600c:4f08:b0:48a:581c:ead with SMTP id 5b1f17b1804b1-490a290da24mr2201315e9.10.1780068299409;
        Fri, 29 May 2026 08:24:59 -0700 (PDT)
X-Received: by 2002:a05:600c:4f08:b0:48a:581c:ead with SMTP id 5b1f17b1804b1-490a290da24mr2200735e9.10.1780068298871;
        Fri, 29 May 2026 08:24:58 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d68b853sm49196885e9.3.2026.05.29.08.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:24:58 -0700 (PDT)
Date: Fri, 29 May 2026 11:24:53 -0400
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
Subject: [PATCH v9 30/37] mm: page_alloc: propagate PG_zeroed in
 split_large_buddy
Message-ID: <64f9b0a9c5b1a3db23b4e4d0b11c3609c248708b.1780067978.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: usLbDl7ymRzjQqvvM5ELRooAc1JSxePBXGrjcyDiBMs_1780068300
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When splitting a large buddy page, propagate the PG_zeroed flag
to each sub-page before freeing it.  __free_pages_prepare clears
all flags (including PG_zeroed), so the flag must be re-set on
each fragment after the split.  This ensures that the buddy merge
logic can see PG_zeroed on pages that were part of a larger
zeroed block.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/page_alloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 72e52f049cf0..702fa2ced1e1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1524,6 +1524,7 @@ static void split_large_buddy(struct zone *zone, struct page *page,
 {
 	unsigned long end = pfn + (1 << order);
 	bool reported = PageReported(page);
+	bool zeroed = PageZeroed(page);
 
 	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn, 1 << order));
 	/* Caller removed page from freelist, buddy info cleared! */
@@ -1537,6 +1538,8 @@ static void split_large_buddy(struct zone *zone, struct page *page,
 
 		if (reported)
 			__SetPageReported(page);
+		if (zeroed)
+			__SetPageZeroed(page);
 		__free_one_page(page, pfn, zone, order, mt, fpi);
 		pfn += 1 << order;
 		if (pfn == end)
-- 
MST

