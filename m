Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7278C423164
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068271; cv=none; b=dwU7E0IyyjAiblp0bWRg2WEVcjGMeCc5EgZAYhFy/RNO4CVZiE0kp+ZQm63kLHrLhpXOaMgCcv0wutSyFiO2RL01yLD5+7h/NFzXc8ZaioSmsUhRUvV8r3qbo/NrWGCYZC3DL4YoXyFkIaGWG8LoPOSQD9IZfcto62TJZ+9PMyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068271; c=relaxed/simple;
	bh=9yxmheTwtEMdpXjxhcMq1i9/4nCbH4yqJLWMjAN8B0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=t/C5ojlQjpQKMxegaNGi/G4xCVi5Slh6yQhzo4ucGSLVFe/nlxdweL7FIb1arJtHjxME2uy+E67AzSNTN/O8xwrtZMXb52cRXs2sL4NexDm0draGyiGGZHGqR932tfLhyvXOJ9c6slOOZ7ZNB403NSLK01bucpEdkEwPSZgYDOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c+JpZ81L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+JpZ81L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780068267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8dg7l+XMBUZMVnB4+qTLsym8fNCo7JvPxwQL0Jq5Z3w=;
	b=c+JpZ81LIvP0qgDnz/QYWb8+vAS4c7FijKF1xgtvSsch9zleXlo08cFxMbwtTV/wlXGgK1
	+/avlr6aGHJ4f+UEtis1MFMuSBgdhXmO8cWYtd9AsyMzJCapgdLWG7TAjeFuzSSPZhRTyq
	P7NTryoUmajd5+XaBFRCdjHxOKysOfY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-4UdH3L2XM8moVvY312VJHA-1; Fri, 29 May 2026 11:24:25 -0400
X-MC-Unique: 4UdH3L2XM8moVvY312VJHA-1
X-Mimecast-MFC-AGG-ID: 4UdH3L2XM8moVvY312VJHA_1780068264
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45eee3f9f03so1365412f8f.1
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068264; x=1780673064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8dg7l+XMBUZMVnB4+qTLsym8fNCo7JvPxwQL0Jq5Z3w=;
        b=q5mtA3pH6GNuGi6aDBvC5rrKTy765et4y7xQcjqMPtp5bmf02Fv/LLw+cy6luf4az4
         0lLXCgNQmlYIPgqOBlp9ij4SE1mBKr824fax9I0/53bjVtYXpayfi86S5vFt40fpeKlj
         aHJYV5mSZaDdqWf0V99RazkgY7uXANsy1wOiBtmeSj1H+m+3Y4d9zvTT83hd+1iRrIca
         w8jKu5wzEklTUgGQYc8OWpgbcIx7qPsKX0JcFq/GvWKrQVSqr7vh00W9yO3mjZ2kGv60
         uBPtZ0MjwA7HBg+JQJif5IPIX/rOngzwrLwwpR2EQ3yuzlsHpBelzddNFlBVBcn6GbA0
         YM3A==
X-Forwarded-Encrypted: i=1; AFNElJ84sa+L3CCT/zDLwRwv6Xfsk/0PKrBv2cMA/xPMW4L2XMuNnquBvOxsBPkSV1Oq8EsUodSiHvy+qUmgZXonAg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzRw2K8+GleEjbaBOqi5FZV7fFNgEY+nz1a1E5Aoy6O792Htbht
	3EVqe82+s81XfIntl9gP2FfymyjXUo8kuSb/S/uAH2pBiK97HnuXDJ4J4TTgGsHaBg70+Uh6HP/
	eYDRFCLrBW/GWXFf+/NSY+zI4gJT9mhW3xWSlNIqfdGSd0M+4AswjhfLYUkLZmmNhbyjj
X-Gm-Gg: Acq92OGvY5RlCnCPySicKQ7FWCEacMOT1j8XiKMArC4M5rw/iuIresGk4WZYvqqQVdN
	E9UXQIAsISBrWiTNEsJ7P2pcfpQ/l5pzeWW13Z7CUQ3IE+bXukwuf2bNdfDY3KaaXTxmV1MLOsQ
	SzHZdPP190+t1EENb4d2gbIu+doCtHflN+2cPdsQOl+PKv+Bdxf5+hN300OuWMA+vbGz3945iFR
	2yvo0DOqfxS5Pck7MtjyxGbT4NhZm0AxpF39N/Km11Hw0lg2WVOKTG+2Je+J5HwwjWzPh16u2Je
	EtsGUjp8uku0Z0YW8Evo79DOA4Wc0cJ/w/VQCvbSjinlC3mnNxlRXFDNNVs5f0Prhjy8ZftKxiV
	hNb6xec3n+leZf2gFZhB/Jo9bCfhZQUCDxelnKONvIdTmbtRqeVzdEQ==
X-Received: by 2002:adf:ea85:0:b0:45e:eec6:5023 with SMTP id ffacd0b85a97d-45ef6b8831dmr324571f8f.37.1780068263575;
        Fri, 29 May 2026 08:24:23 -0700 (PDT)
X-Received: by 2002:adf:ea85:0:b0:45e:eec6:5023 with SMTP id ffacd0b85a97d-45ef6b8831dmr324493f8f.37.1780068262980;
        Fri, 29 May 2026 08:24:22 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34b834esm4139592f8f.11.2026.05.29.08.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:24:22 -0700 (PDT)
Date: Fri, 29 May 2026 11:24:18 -0400
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
Subject: [PATCH v9 23/37] mm: page_alloc: use aliasing checks instead of
 user_alloc_needs_zeroing
Message-ID: <8229023108f900d50b47bd85b5a8f8eb5f95ef03.1780067977.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: KPz0Hm8BpAThwvbepvvUTFpnBSDuX3LYMg1zotqIyUw_1780068264
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Replace user_alloc_needs_zeroing() with the direct aliasing checks
(cpu_dcache_is_aliasing() || cpu_icache_is_aliasing()) in the
post_alloc_hook aliasing guard.

user_alloc_needs_zeroing() includes a !init_on_alloc term that
means "allocator didn't zero this page."  But in this guard's
context (!zeroed && !init && __GFP_ZERO), we already know the page
is zero; init incorporates init_on_alloc via want_init_on_alloc().
The only question left is whether the cache architecture needs
the data re-zeroed through a congruent mapping, which is purely
cpu_dcache_is_aliasing() || cpu_icache_is_aliasing().

On non-aliasing architectures with init_on_free=true and
init_on_alloc=false, this avoids a redundant re-zero of an
already-zero page.

Note on PowerPC: PowerPC overrides clear_user_page to call
flush_dcache_page after clear_page, but on freshly allocated
pages PG_dcache_clean is already clear (cleared by
__free_pages_prepare), so flush_dcache_page is a no-op.
Skipping this here thus has no effect.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5158f7e23d18..4cb7e779a6c5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1883,7 +1883,7 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 	 */
 	if (!zeroed && !init && (gfp_flags & __GFP_ZERO) &&
 	    user_addr != USER_ADDR_NONE &&
-	    user_alloc_needs_zeroing())
+	    (cpu_dcache_is_aliasing() || cpu_icache_is_aliasing()))
 		init = true;
 	/*
 	 * If memory is still not initialized, initialize it now.
-- 
MST

