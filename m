Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F776425CD9
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068276; cv=none; b=FWRahmnoI0VKC1VRLpHQudLqUDWt1Xv/OD+fDsUd2sJrqVQrHf/Mi++OApSQSU3bbICByuxrKVkrjx3XPZmBN3JWlwRTP3yRh2U/hZjUsCFRBIw1AOPrUdtm2wy7x6ZVWExRWDISc4cwiez5EA5aWKxGIQufNcsbB7qRBJG+bBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068276; c=relaxed/simple;
	bh=b0H6igos+bxXZv2CiE0eAIuacEUkYyhOa0XUsWe315U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TVgewVCVM2jUue8js0/R/iZONSppLYaYtEXElKUv/xEx4JTUQkvvg5WtFqkXckcrI5vGpEwsx2Oo96s2nW9s3Ld4JZ2G5OC7W6nOvmCHrUuGNakai86ii93ZCgFRsTs303TOXbVrXl2CzAgkgxkdUY6qCJwodT6DQ6jgFNv/NYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BD0V188q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BD0V188q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780068271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IWNxSxbqwby36tOoHcOEDoEnbpMh6i49D1nHoSwbp8U=;
	b=BD0V188qWlsxTh4yFZcMI241melFA2/y7z5qgpzucLJic0eoKBhJ4KMCWzB4e7AULinsA3
	tb9ntyRTM+rGhIkJl2AN4FGUpObkRciopt7Frj1TayJ6nLxx3LE0qZsdcxE3G7lBHpwA7U
	ZmrDgDPv70mOdxxE4cVpUsCQIjxW4Yw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-JMg2YPgRMPWjW0AHEzKR_g-1; Fri, 29 May 2026 11:24:29 -0400
X-MC-Unique: JMg2YPgRMPWjW0AHEzKR_g-1
X-Mimecast-MFC-AGG-ID: JMg2YPgRMPWjW0AHEzKR_g_1780068269
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45ef3aeeb41so385048f8f.1
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068269; x=1780673069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWNxSxbqwby36tOoHcOEDoEnbpMh6i49D1nHoSwbp8U=;
        b=DVCsQ7Sx0NBj8O3Cq5Sazq1zjcrJ1+DvHaNLOmzU5SjE0ZaqLwelNq5WaWRN4e17ju
         HlMqjkAReElSxxjVuWcO8fnkhBzihLYwJH8YtOcqhWBuXWzRDQQ9PxhvvHD+4MbcWGcF
         dg5E+a/o8Z34hql5MBkuc2rmWk5D7AA9rCuRAkBregTzUUSyyxHlNOW6BtKxxkM+qLt1
         kfN37ExcdokH0pYzQPbD1iydn26iqG2W7yNspgD8BXYI+czQD1yUNeBHq8k6ZqmlxNVo
         iAZZYlPXLc0PuISa/Wv+i1vjUfYx8zFER9fuFAUj5ZhRnEzqviN3SvVcbdHFS0h8lwt0
         yZDQ==
X-Forwarded-Encrypted: i=1; AFNElJ+TKBx5i4Ylr6Sws3eZQRWmLPOpSD9dCM2XMhOIEbWW7bdn1sVFUmkdCzcNPJfirFqfbbpyvhgkXOt6av5bHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzuh+oeFbxJC77IkL7pADanOo151luEQZIw0NDWiMTIJsQcYFqZ
	E5ea1X5eGzazXAlfRX8qq40mIphjySkW3dlu7sbIhgqb6Hz7JPq+fOuD4ChFGx0eL1jeGkJ2sae
	mcXjUy7X0duztqZbRJrjCbqEojfQqtpjNIx9sJlo3D1BXTulGKmX8Pz+NUfoAE1cakhgX
X-Gm-Gg: Acq92OG8SMQIU/Ta75EngziB4J2yhlrYnt3cJmS/4EFYsKrZyC1uXNolZWVjklzkUCV
	CNAWvG0P2oTuaFwODPcVmSIIjlBL9x9mH4qr7Enn2VolqHaHlE2hEK3HZy0WFCrp1MIOVTxpNi2
	kr0Ufw2ldcfpYmVIu+V7CumztTFdJjxe4YYtoNDOvhr8D39m9WbwY3l7YdnxPjQOMeRetYhkWQZ
	lH7wQii2ix+umn5mLlvUWioqrJax3SyE4rgdHMpksTofFX1mdaTXs8GpUpwMEK2EycG6kUCS7Xa
	S1LVsKraSt3FEKdESbliAvCreioyL8UwftdXoZTZoHqIyGDOIhpau6mjf5aRqZ59wXvzgwYjwc9
	AhO6gDK7cCJ4+5bzH9p6tOWjD4VJtf3zSwXeIcwfsb8ETVOFsHXS94Q==
X-Received: by 2002:a05:600d:11:b0:490:3d62:f5e1 with SMTP id 5b1f17b1804b1-490a2963b8emr1048865e9.22.1780068268627;
        Fri, 29 May 2026 08:24:28 -0700 (PDT)
X-Received: by 2002:a05:600d:11:b0:490:3d62:f5e1 with SMTP id 5b1f17b1804b1-490a2963b8emr1047575e9.22.1780068268015;
        Fri, 29 May 2026 08:24:28 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909caa7e17sm56228165e9.9.2026.05.29.08.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:24:27 -0700 (PDT)
Date: Fri, 29 May 2026 11:24:23 -0400
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
Subject: [PATCH v9 24/37] mm: page_reporting: add per-page zeroed bitmap for
 host feedback
Message-ID: <217e59b7f6693a0cddd62158be80dcfb12cb879a.1780067978.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: Gfs8G_Lba2UuAj1_3nMf5KNUsfIi-F5DqMCLmydAflU_1780068269
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The host may skip zeroing some reported pages (e.g., due to alignment
constraints or bounce buffer fallback in QEMU).  Currently, when
host_zeroes_pages is set, all reported pages are unconditionally
marked PG_zeroed - even ones the host did not actually zero.

Add a zeroed_bitmap to page_reporting_dev_info that the report()
callback can use to indicate which pages were actually zeroed.
The driver's report() callback is responsible for managing the
bitmap: zeroing it before sending pages to the host, then setting
bits for pages the host actually zeroed.

page_reporting_drain() checks the bitmap per-page in addition to the
global host_zeroes_pages flag.

No driver sets host_zeroes_pages yet, so the static key is
off and the bitmap is never read.  Behavior is unchanged.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 include/linux/page_reporting.h | 7 +++++++
 mm/page_reporting.c            | 8 ++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
index c331c6b36687..e2e6a487ddab 100644
--- a/include/linux/page_reporting.h
+++ b/include/linux/page_reporting.h
@@ -17,6 +17,13 @@ struct page_reporting_dev_info {
 	/* If true, host zeros reported pages on reclaim */
 	bool host_zeroes_pages;
 
+	/*
+	 * Per-page zeroed status, indexed by scatterlist position.
+	 * The driver's report() callback must clear the bitmap,
+	 * then set bits for pages that were actually zeroed.
+	 */
+	DECLARE_BITMAP(zeroed_bitmap, PAGE_REPORTING_CAPACITY);
+
 	/* work struct for processing reports */
 	struct delayed_work work;
 
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 8d52718be876..f68c79e57427 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -108,6 +108,7 @@ page_reporting_drain(struct page_reporting_dev_info *prdev,
 		     struct scatterlist *sgl, unsigned int nents, bool reported)
 {
 	struct scatterlist *sg = sgl;
+	unsigned int i = 0;
 
 	/*
 	 * Drain the now reported pages back into their respective
@@ -122,7 +123,7 @@ page_reporting_drain(struct page_reporting_dev_info *prdev,
 
 		/* If the pages were not reported due to error skip flagging */
 		if (!reported)
-			continue;
+			goto next;
 
 		/*
 		 * If page was not commingled with another page we can
@@ -133,9 +134,12 @@ page_reporting_drain(struct page_reporting_dev_info *prdev,
 		 */
 		if (PageBuddy(page) && buddy_order(page) == order) {
 			__SetPageReported(page);
-			if (page_reporting_host_zeroes_pages())
+			if (page_reporting_host_zeroes_pages() &&
+			    test_bit(i, prdev->zeroed_bitmap))
 				__SetPageZeroed(page);
 		}
+next:
+		i++;
 	} while ((sg = sg_next(sg)));
 
 	/* reinitialize scatterlist now that it is empty */
-- 
MST

