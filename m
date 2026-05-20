Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55273C1986
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 22:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315762; cv=none; b=DX+HnlsVZdWoPENS7zVTtIp0hmyEvdfVajbXd9GZhWQXViavInaNlOIsQwUq8XBM38x7nSd0nLBIWBRKBeh9wbqmkKxDHSiYwJVFWesOO0xiBrfl+Q4KCj9p+4B+b+E4WQ3V9o/cbvTEzKzZf9zjIV7fHMDYqZye1SYyNTYnUZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315762; c=relaxed/simple;
	bh=h05Q2nCn+o78fr2Uz8tfGJ7k+kZvskvt29CW+J/CzdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Iw5JoydIljCFbtag+ls1DkgiiYSGuJ0iezK4LdulT/3uonLSPgLUM69PhN0V+lSLtUZQhpamBUXIoOmke6lE+hR8D6eShcEjcXxB3NtQm4zKmE0nb0GKS1g0CM0cBxmMJapy1XB+kP9yN4os99LKrFRYIwnEk1KtxMzxHEQN9T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SnQIQfPe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SnQIQfPe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779315759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUJUQcTEBW8Gz9Bvs58sr0Q3FF0IZpsM1OCMvoStcIE=;
	b=SnQIQfPekwx3WUJI6XlVlApvTGuyUMTttq/3IgawxE57zhnwDz0C3YnytfaBwGwNkadWMA
	mWIvN8yC7IgHVuhsWj0rjaI3od+GL22tU1chEd1CA7f0yWxZk5I0gPE7av0gFx06vwmkY6
	EPhTJrndAgubRTWSNpSfWTPao5cG7aM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-39iFsJXrNhiumIFNlhcMKg-1; Wed, 20 May 2026 18:22:38 -0400
X-MC-Unique: 39iFsJXrNhiumIFNlhcMKg-1
X-Mimecast-MFC-AGG-ID: 39iFsJXrNhiumIFNlhcMKg_1779315757
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-447f2ce5556so4363726f8f.2
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 15:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779315757; x=1779920557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZUJUQcTEBW8Gz9Bvs58sr0Q3FF0IZpsM1OCMvoStcIE=;
        b=Mi27AbiaMOSyKrIuDcyicm3+X47rb8PSvyvWszmz14Wz/Thownx9a9Fc8jEqVuh+XQ
         csAPVoWsAJjJLHFz0yU+TTmtbxtqNUwuhHezmNwlZZVryFmTCGRR+rdkOyD+gyymrOSg
         Y2LG8Fq51gbGs/6CMsqRAmqmTKxXJVTOOPM0zpxywnnXhm7W9ACRCYlxAD960NzCN2+h
         mPEaeSpCO9rprrkWgTS6ETC4TkUxNjTvrGB8qz9mGRBYHJ/t3ZnLQAw7jeULVV3Y2kCl
         ndXYBj4UzVl4lR0mZjBHk2b3NUpmW06BrUEeQ+NwPcUplaufztFIz/cSFInuDKvpMehM
         0jGw==
X-Forwarded-Encrypted: i=1; AFNElJ8xwtOQAPaeaJ9i7o11bgYWUSX1fHWK7PHqBDJjhrMoT57YLVPgiWPVlF9ynpWk2PbdvO42wpI9N0By+vfGwQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzdkOgHFNp9uLUdEsSubxBT+pbrNwRDTre8867aQ/ML+pAlGXH6
	bTNLvV6oENYVN2JCA6v0kcjtIC9Ll3UnT2AwT6HPFXfi5q4vp7Jp2/dynvCgtj00QNSXePXg+VM
	R0De2y2u2ys8MvdIMhbF/ht/9oQn4ls1R/CSRF2LvYz48FEw8l2gEVfBBGY07z0reWi+r
X-Gm-Gg: Acq92OHvY56/GWStCj4Fjjiftup3sjVDoODkGyT/MDcbJwZiWoE0+WKQLeKHGOaTFFu
	QNeGBphPjZqf8NjgAxe7b64gXUjJuAFr4rNS0rThVCYRfV3X6au5rYO8Ealenfbd9LHyLbxkS1Q
	yI9CuYmBXQ1XEGV/FU2uwjyfrmn+pbwp3UULhQ1ZdJQgwr3NBB7RkFYeXa5DEBBKreRhCY0wibm
	aZ63F/xs6qRB9fz0OyEcHUnBKqdu0irEqFANd1UjOayKg0zfZaDzqOwqCwM7J7ekOMNVshaYwKS
	EGUhGXMwThT5ik5XyT+Ud3ZvHrIubdygpbvYNEA61JILBgjAf5+coSrK9zAoyEnVcaC8Fc22Ai7
	rKLTx+rGoA4zT/0oNEn3jmzCtgo72VnRNC7vh0fBmR1g=
X-Received: by 2002:a05:6000:2883:b0:43d:67d1:2022 with SMTP id ffacd0b85a97d-45ea38be3aemr335081f8f.19.1779315756990;
        Wed, 20 May 2026 15:22:36 -0700 (PDT)
X-Received: by 2002:a05:6000:2883:b0:43d:67d1:2022 with SMTP id ffacd0b85a97d-45ea38be3aemr335047f8f.19.1779315756519;
        Wed, 20 May 2026 15:22:36 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6454sm58643722f8f.34.2026.05.20.15.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:22:36 -0700 (PDT)
Date: Wed, 20 May 2026 18:22:31 -0400
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
Subject: [PATCH v8 24/37] mm: page_reporting: add per-page zeroed bitmap for
 host feedback
Message-ID: <56b8f941ffcdef444d8c2aee62846bb8ad53ed14.1779315441.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: L9l-GhfzyZXmgjY4FwAAtdhcrYt26yZ2Etw3WJlnO6M_1779315757
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
index e42f857485ce..691a9e66aa5b 100644
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

